SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_prg_hierarchy_scheduling_data_cleanup]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Error INT = 0,
        @UtcNow DATETIME = GETUTCDATE(),
        @InitialTransactionCount INT = @@TRANCOUNT,
        @IsPurgeActive BIT,
        @RetainDays INT,
        @ErrorMessage VARCHAR(1000);

    BEGIN TRY;
    --Check if purge is active
        SELECT  @IsPurgeActive = CASE WHEN CAST([ri].[XML_DATA].query('/Columns/Column[@Name="PURGE_ENABLED"]/text()') AS NVARCHAR(5)) = 'True'
                                      THEN 1
                                      ELSE 0
                                 END
        FROM    [dbo].[fn_clu_get_exony_db_resource_instance](NULL) AS exDb
        INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] ri ON [ri].[RESOURCE_INSTANCE_ID] = [exDb].[RESOURCE_INSTANCE_ID];

        IF @IsPurgeActive = 1
        BEGIN 
            BEGIN TRANSACTION PrgSchCleanTransaction;
        

            SELECT  @RetainDays = CAST(PROPERTY_VALUE AS INT)
            FROM    [dbo].[TB_ADM_PROPERTY]
            WHERE   PROPERTY_KEY = 'PROP_HIERARCHY_CHANGE_RETAIN_DAYS';

            SET @RetainDays = COALESCE(@RetainDays, 14); -- Default 14 days

            -- Hierarchy Change scheduling data
            -- Delete the hierarchy change tasks which had effective date >= 30 days and have been completed
            -- and that they do not have any fact data update pending.
            -- This will cascade delete all referencing data.
            DELETE  [dbo].[TB_SCH_TASK]
            FROM    [dbo].[TB_SCH_TASK] AS t
            INNER JOIN [dbo].[TB_SCH_HIERARCHY_CHANGE] AS h ON [h].[HIERARCHY_CHANGE_ID] = [t].[TASK_ID]
            WHERE   [h].[STATUS] = 'C'
                    AND DATEDIFF(dd, [h].[EFFECTIVE_FROM], GETUTCDATE()) >= @RetainDays
                    AND NOT EXISTS ( SELECT [r].[HIERARCHY_CHANGE_RESULT_ID],
                                            SUM(CASE WHEN [cri].[RESOURCE_INSTANCE_ID] IS NULL
                                                     THEN 0
                                                     ELSE 1
                                                END)
                                     FROM   [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
                                            AS r
                                     LEFT JOIN [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
                                            AS fr ON [fr].[HIERARCHY_CHANGE_RESULT_ID] = [r].[HIERARCHY_CHANGE_RESULT_ID]
                                     LEFT JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] AS cri ON [cri].[RESOURCE_INSTANCE_ID] = [fr].[RESOURCE_INSTANCE_ID]
                                     WHERE  [r].[HIERARCHY_CHANGE_ID] = [h].[HIERARCHY_CHANGE_ID]
                                            AND COALESCE([fr].[FACT_UPDATE_STATUS],
                                                         'C') = 'C'
                                     GROUP BY [r].[HIERARCHY_CHANGE_RESULT_ID]
                                     HAVING COUNT([cri].[RESOURCE_INSTANCE_ID]) <> ( SELECT
                                                              COUNT([cri].[RESOURCE_INSTANCE_ID])
                                                              FROM
                                                              [dbo].[TB_CLU_RESOURCE_INSTANCE]
                                                              AS cri
                                                              INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT]
                                                              AS comp ON [comp].[RESOURCE_INSTANCE_ID] = [cri].[RESOURCE_INSTANCE_ID]
                                                              INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE]
                                                              AS rict ON [rict].[COMPONENT_TYPE_ID] = [comp].[COMPONENT_TYPE_ID]
                                                              INNER JOIN [dbo].[TB_CLU_RESOURCE]
                                                              AS cr ON [cr].[RESOURCE_ID] = [cri].[RESOURCE_ID]
                                                              INNER JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
                                                              AS crt ON [crt].[CLUSTER_RESOURCE_TYPE_ID] = [cr].[RESOURCE_TYPE_ID]
                                                              WHERE
                                                              [crt].[INTERNAL_NAME] = 'CRT_EXONY_RELATIONAL_DB'
                                                              AND [rict].[INTERNAL_NAME] = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
                                                              ) );

            -- Delete all the triggers if there are any for the jobs we have deleted in the previous step
            DELETE  [dbo].[TB_SCH_QRTZ_TRIGGERS]
            WHERE   JOB_NAME IN (
                    SELECT  [j].[JOB_NAME]
                    FROM    [dbo].[TB_SCH_QRTZ_JOB_DETAILS] AS j
                    WHERE   NOT EXISTS ( SELECT 1
                                         FROM   [dbo].[TB_SCH_TASK] AS tsk
                                         WHERE  LOWER(CONVERT(NVARCHAR(36), [tsk].[TASK_ID])) = LOWER(REPLACE(REPLACE([j].[JOB_NAME],
                                                              '{', ''), '}',
                                                              ''))
                                                AND [tsk].[TYPE] = [j].[JOB_GROUP] )
                            AND [j].[JOB_GROUP] = 'H' );

            -- delete the quartz tasks where a scheduled task which were deleted earlier
            DELETE  [dbo].[TB_SCH_QRTZ_JOB_DETAILS]
            FROM    [dbo].[TB_SCH_QRTZ_JOB_DETAILS] AS j
            WHERE   NOT EXISTS ( SELECT 1
                                 FROM   [dbo].[TB_SCH_TASK] AS tsk
                                 WHERE  LOWER(CONVERT(NVARCHAR(36), [tsk].[TASK_ID])) = LOWER(REPLACE(REPLACE([j].[JOB_NAME],
                                                              '{', ''), '}',
                                                              ''))
                                        AND [tsk].[TYPE] = [j].[JOB_GROUP] )
                    AND [j].[JOB_GROUP] = 'H';

            SET @RetainDays = NULL;

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION PrgSchCleanTransaction;
            END;  
            ELSE
            BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT @Error = @@ERROR, @ErrorMessage = ERROR_MESSAGE();
        
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    END CATCH;

    RETURN @Error;
END;
GO
