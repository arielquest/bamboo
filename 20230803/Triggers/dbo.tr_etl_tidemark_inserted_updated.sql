SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[tr_etl_tidemark_inserted_updated] ON [dbo].[TB_ETL_TIDEMARK]
    FOR INSERT, UPDATE
AS
    BEGIN
        SET XACT_ABORT OFF;
        SET NOCOUNT ON;

        DECLARE @ErrorMessage NVARCHAR(500) = N'',
            @ErrorCode INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @NewTableGenerationCount BIGINT,
            @IsUpdate AS [BIT];

        SELECT  @IsUpdate = CASE WHEN EXISTS ( SELECT   1
                                               FROM     [Deleted] ) THEN 1
                                 ELSE 0
                            END;

    -- Return early if no rows or if it is an update is by replication on the msrepl_tran_version column
        IF NOT EXISTS ( SELECT  1
                        FROM    [Inserted] )
            OR ( @IsUpdate = 1
                 AND UPDATE([msrepl_tran_version])
                 AND SESSIONPROPERTY('REPLICATION_AGENT') = 0
               )
        BEGIN
            RETURN;
        END;

        BEGIN TRANSACTION [TR_queryrTran];
        BEGIN TRY;
            WITH    [CTE]
                      AS ( SELECT   [tide].[TIDEMARK_ID],
                                    [tide].[DATE_TIME]
                           FROM     [dbo].[TB_ETL_TIDEMARK] [tide]
                           INNER JOIN [Inserted] [ins] ON [ins].[TIDEMARK_ID] = [tide].[TIDEMARK_ID]
                         )
                UPDATE  [CTE]
                SET     [CTE].[DATE_TIME] = GETUTCDATE();

            IF @InitialTransactionCount = 0
            BEGIN
                COMMIT TRANSACTION [TR_queryrTran];
            END;
            ELSE
            BEGIN
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN
                    COMMIT TRANSACTION;
                END;
            END;
        END TRY
        BEGIN CATCH;
            SET @ErrorCode = ERROR_NUMBER();    

            ROLLBACK TRANSACTION;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': An error occured while attempting to insert item. Error = [%d]';
        END CATCH;

        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN
            ROLLBACK;
        END;

        IF @ErrorMessage = ''
        BEGIN
            RETURN;
        END;
        ELSE
        BEGIN
            IF @InitialTransactionCount = 0
                AND @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END;
            ELSE
            BEGIN
                IF @InitialTransactionCount <> 0
                    AND @@TRANCOUNT > @InitialTransactionCount
                BEGIN
                    IF ( XACT_STATE() ) = -1
                    BEGIN
                        SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
                        ROLLBACK TRANSACTION;
                        -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                        DECLARE @transactionFake INT = @@TRANCOUNT;
                        WHILE @transactionFake < @InitialTransactionCount
                        BEGIN
                            BEGIN TRANSACTION;
                            SET @transactionFake = @transactionFake + 1;
                        END;
                    END;
                    ELSE
                    BEGIN
                        WHILE @@TRANCOUNT > @InitialTransactionCount
                        BEGIN
                            COMMIT TRANSACTION;
                        END;
                    END;
                    SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
                END;
                RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
            END;
        END;
    END;
GO
