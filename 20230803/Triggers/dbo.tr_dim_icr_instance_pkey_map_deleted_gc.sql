SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_dim_icr_instance_pkey_map_deleted_gc] ON [dbo].[TB_DIM_ICR_INSTANCE_PKEY_MAP] FOR DELETE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    
    IF NOT EXISTS(SELECT 1 FROM deleted)
    BEGIN 
        RETURN;
    END;
    
    DECLARE @ErrorMessage NVARCHAR(500) = N'', @ErrorCode INT = 0, @InitialTransactionCount INT = @@TRANCOUNT,
    @NewTableGenerationCount BIGINT, @deadlockRetry TINYINT = 0, @waitDelay CHAR(9);
    
    BEGIN TRANSACTION TR_icrinstaPKEYTran;
    WHILE @deadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION deadlockSavePoint;
        BEGIN TRY;
            -- Update and Get Table Generation Count
            EXEC [dbo].[ap_adm01_increment_table_generation_count] @TableName = 'TB_DIM_ICR_INSTANCE_PKEY_MAP', @NewTableGenerationCount = @NewTableGenerationCount OUTPUT;

            -- Update Data Generation Counts
            UPDATE dbo.TS_DIM_ICR_INSTANCE_PKEY_MAP_GC
            SET LAST_OPERATION = 'D', GENERATION_COUNT = @NewTableGenerationCount
            FROM dbo.TS_DIM_ICR_INSTANCE_PKEY_MAP_GC AS datagc
            JOIN deleted AS d ON d.PKEY_MAP_URN = datagc.PKEY_MAP_URN;

            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION TR_icrinstaPKEYTran;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @deadlockRetry = 3;
            BREAK;
        END TRY
        BEGIN CATCH
            SET @ErrorCode = ERROR_NUMBER();
            IF @ErrorCode <> 0
            BEGIN 
                IF @ErrorCode = 1205 
                BEGIN 
                    IF XACT_STATE() = -1
                    BEGIN 
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = 3;
                        BREAK;
                    END;
                    ELSE BEGIN 
                        ROLLBACK TRANSACTION deadlockSavePoint;
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
                        'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = @deadlockRetry + 1;
                
                        --Random wait between 50ms and 999ms
                        SELECT @waitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                        FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);
                        
                        WAITFOR DELAY @waitDelay;
                        CONTINUE;
                    END;
                END;
                ELSE BEGIN 
                    ROLLBACK TRANSACTION deadlockSavePoint;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                    'An error occured while attempting to update item. Error = [%d]';
                    SET @deadlockRetry = 3;
                    BREAK;
                END;
            END;
        END CATCH;
    END;         
    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK;
    END;
    
    IF @ErrorMessage = ''
    BEGIN 
        RETURN;
    END;
    ELSE BEGIN 
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
        END
        RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
    END;
END;
GO
