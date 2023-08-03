SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_clu_connection_deleted_gc] ON [dbo].[TB_CLU_CONNECTION] FOR DELETE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    DECLARE @ErrorMessage NVARCHAR(500) = N'', @ErrorCode INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, @NewTableGenerationCount BIGINT, @deadlockRetry TINYINT = 0;

    BEGIN TRANSACTION triggerTransaction;

    WHILE @deadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION deadlockSavePoint;

        BEGIN TRY;
            -- Update and Get Table Generation Count
            EXEC dbo.ap_adm01_increment_table_generation_count @TableName = 'TB_CLU_CONNECTION', @NewTableGenerationCount = @NewTableGenerationCount OUTPUT;

            -- Update Data Generation Counts
            UPDATE dbo.TS_CLU_CONNECTION_GC
            SET LAST_OPERATION = 'D', GENERATION_COUNT = @NewTableGenerationCount
            FROM dbo.TS_CLU_CONNECTION_GC AS datagc
            INNER JOIN deleted AS d ON d.CONNECTION_ID = datagc.CONNECTION_ID;

            COMMIT TRANSACTION triggerTransaction;

            BREAK;
        END TRY
        BEGIN CATCH;
            SET @ErrorCode = ERROR_NUMBER();
            IF @ErrorCode <> 0
            BEGIN 
                IF @ErrorCode = 1205
                BEGIN 
                    ROLLBACK TRANSACTION deadlockSavePoint;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + 'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                    SET @deadlockRetry = @deadlockRetry + 1;

                    --Random wait between 50ms and 999ms
                    DECLARE @waitDelay CHAR(9);
                    
                    SELECT @waitDelay = '0:0:0.' + RIGHT('0' + CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END + 50 AS VARCHAR(3)), 3)
                    FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);

                    WAITFOR DELAY @waitDelay;
                    CONTINUE;
                END;
                ELSE BEGIN 
                    ROLLBACK TRANSACTION deadlockSavePoint;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + 'An error occured while attempting to insert item. Error = [%d]';
                    SET @deadlockRetry = 3;
                    BREAK;
                END;
            END;
        END CATCH;
    END;
    IF @InitialTransactionCount = 0
        AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK;
    END;

    IF @ErrorMessage = ''
    BEGIN 
        RETURN;
    END;
    ELSE BEGIN 
        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE BEGIN 
            IF @InitialTransactionCount <> 0
                AND @@TRANCOUNT > @InitialTransactionCount
            BEGIN
                IF (XACT_STATE()) = - 1
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
                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
            END;
        END;
        RAISERROR (@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
    END;
END;
GO
