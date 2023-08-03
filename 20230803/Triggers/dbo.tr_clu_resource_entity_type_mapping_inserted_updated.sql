SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_clu_resource_entity_type_mapping_inserted_updated]  ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING] FOR INSERT, UPDATE NOT FOR REPLICATION AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    
    DECLARE @ErrorMessage NVARCHAR(500) = N'', 
            @ErrorCode INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @DeadlockRetry TINYINT = 0,
            @WaitDelay CHAR(9);
    
    BEGIN TRANSACTION tr_clu_resource_entity_type_tran;
    WHILE @DeadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION deadlockSavePoint;
        BEGIN TRY;
            -- Enforce foreign key constraint on ENTITY_TYPE_ID
            IF UPDATE(ENTITY_TYPE_ID)
            BEGIN 
                IF EXISTS(SELECT 1 FROM inserted WHERE ENTITY_TYPE_ID NOT IN
                                (
                                    SELECT ITEM_TYPE_ID FROM dbo.TE_DIM_ITEM_TYPE
                                    UNION ALL
                                    SELECT MEMBER_TYPE_ID FROM dbo.TE_DIM_MEMBER_TYPE
                                ))
                BEGIN                 
                    SET @ErrorMessage = 'Invalid Entity Type ID.';
                    ROLLBACK TRANSACTION;
                END;
            END;
                        
            -- Create a new Cache Engine Persistance Token
            IF (UPDATE (CACHE_ENABLED))
            BEGIN 
                UPDATE [dbo].[TB_ADM_LOCAL_PROPERTY]
                SET [PROPERTY_VALUE] = NEWID(), MODIFIED_DATE = GETUTCDATE()
                WHERE [PROPERTY_KEY] = 'PROP_CACHE_ENGINE_PERSISTANCE_TOKEN';
            END;
            
            IF @InitialTransactionCount = 0 
            BEGIN 
                COMMIT TRANSACTION tr_clu_resource_entity_type_tran;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @DeadlockRetry = 3;
            BREAK;
        END TRY 
        BEGIN CATCH;
            SET @ErrorCode = ERROR_NUMBER();
            IF @ErrorCode <> 0
            BEGIN 
                IF @ErrorCode = 1205 
                BEGIN 
                    IF XACT_STATE() = -1
                    BEGIN 
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @DeadlockRetry = 3;
                        BREAK;
                    END;
                    ELSE BEGIN 
                        ROLLBACK TRANSACTION deadlockSavePoint;

                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @DeadlockRetry = @DeadlockRetry + 1;
                        
                        --Random wait between 50ms and 999ms
                        SELECT @WaitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                        FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);                        
                        WAITFOR DELAY @WaitDelay;

                        CONTINUE;
                    END;
                END;
                ELSE BEGIN 
                    ROLLBACK TRANSACTION;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': An error occured while attempting to insert or update row. Error = [%d]';
                    
                    SET @DeadlockRetry = 3;
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
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
    END;
END;
GO
