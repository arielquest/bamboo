SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_dim_translation_route_inserted_updated_gc] ON [dbo].[TB_DIM_TRANSLATION_ROUTE] FOR INSERT, UPDATE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    
    DECLARE @ErrorMessage NVARCHAR(500) = N'', 
            @ErrorCode INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @NewTableGenerationCount BIGINT,
            @deadlockRetry TINYINT = 0,
            @WaitDelay CHAR(9),
            @IsUpdate AS [BIT];
            
    SELECT @IsUpdate = CASE WHEN EXISTS (
                    SELECT 1
                    FROM deleted
                    ) THEN 1 ELSE 0 END;

    -- Return early if no rows or if it is an update is by replication on the msrepl_tran_version column
    IF NOT EXISTS (
            SELECT 1
            FROM inserted
            )
        OR (
            @IsUpdate = 1
            AND UPDATE (msrepl_tran_version)
                AND SESSIONPROPERTY('REPLICATION_AGENT') = 0
            )
    BEGIN 
        RETURN;
    END;
    
    BEGIN TRANSACTION TR_translationroTran;
    WHILE @deadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION deadlockSavePoint;
        BEGIN TRY;
            -- Update and Get Table Generation Count
            EXEC [dbo].[ap_adm01_increment_table_generation_count] @TableName = 'TB_DIM_TRANSLATION_ROUTE', @NewTableGenerationCount = @NewTableGenerationCount OUTPUT;

            -- Update Data Generation Counts
            MERGE INTO dbo.TS_DIM_TRANSLATION_ROUTE_GC dgc
            USING (SELECT ITEM_URN, CASE @IsUpdate WHEN 1 THEN 'U' ELSE 'I' END FROM inserted) correctValues(ITEM_URN, LAST_OPERATION)
            ON (dgc.ITEM_URN = correctValues.ITEM_URN)
            WHEN MATCHED THEN
                UPDATE SET dgc.GENERATION_COUNT = @NewTableGenerationCount,
                           dgc.LAST_OPERATION = correctValues.LAST_OPERATION
            WHEN NOT MATCHED THEN 
                INSERT (ITEM_URN, GENERATION_COUNT, CREATE_GENERATION_COUNT, LAST_OPERATION)
                VALUES (correctValues.ITEM_URN, @NewTableGenerationCount, @NewTableGenerationCount, correctValues.LAST_OPERATION);

            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION TR_translationroTran;
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
        BEGIN CATCH;
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

                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = @deadlockRetry + 1;
                        
                        --Random wait between 50ms and 999ms
                        SELECT @WaitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                        FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);                        
                        WAITFOR DELAY @WaitDelay;

                        CONTINUE;
                    END;
                END;
                ELSE BEGIN 
                    ROLLBACK TRANSACTION;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': An error occured while attempting to insert item. Error = [%d]';
                    
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
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
    END;
END;
GO
