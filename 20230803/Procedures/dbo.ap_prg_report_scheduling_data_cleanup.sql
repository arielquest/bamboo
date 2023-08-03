SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_prg_report_scheduling_data_cleanup]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Error INT = 0,
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
            BEGIN TRANSACTION PrgRepCleanTransaction;

            --====== PURGE REPORT SCHEDULE HISTORY
            SELECT  @RetainDays = CAST(PROPERTY_VALUE AS INT)
            FROM    [dbo].[TB_ADM_PROPERTY]
            WHERE   PROPERTY_KEY = 'PROP_REPORT_SCHEDULE_HISTORY_PURGE_RETENTION_DAYS';

            -- Default 60 days
            SET @RetainDays = COALESCE(@RetainDays, 60);

            DELETE  hist
            FROM    [dbo].[TB_SCH_TASK_HISTORY] hist
            INNER JOIN [dbo].[TB_SCH_TASK] task ON [task].[TASK_ID] = [hist].[TASK_ID]
            WHERE   [task].[TYPE] = 'R'
                    AND DATEDIFF(dd, [hist].[FIRETIME], GETUTCDATE()) >= @RetainDays;

            --====== PURGE REPORT SCHEDULE TASK
            SELECT  @RetainDays = CAST(PROPERTY_VALUE AS INT)
            FROM    [dbo].[TB_ADM_PROPERTY]
            WHERE   PROPERTY_KEY = 'PROP_REPORT_SCHEDULE_PURGE_RETENTION_DAYS';

            -- Default 60 days
            SET @RetainDays = COALESCE(@RetainDays, 60);

            DELETE  FROM [dbo].[TB_SCH_TASK]
            WHERE   TYPE = 'R'
                    AND [DELETED] = 1
                    AND DATEDIFF(dd, [MODIFIED_DATE_TIME], GETUTCDATE()) >= @RetainDays;

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION PrgRepCleanTransaction;
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
