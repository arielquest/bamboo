SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_sec_user_group_member_deleted_gc] ON [dbo].[TB_SEC_GROUP_MEMBER] FOR DELETE
AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    IF NOT EXISTS(SELECT 1 FROM deleted)
    BEGIN 
        RETURN;
    END;

    DECLARE @ErrorMessage AS NVARCHAR(500),    
            @ErrorCode        AS [INTEGER],
            @InitialTransactionCount    AS [INTEGER],
            @TableGenerationCount AS BIGINT,
            @TableGenerationCountUrn AS INTEGER;
            
       SET @InitialTransactionCount = @@TRANCOUNT;
       SET @ErrorMessage = '';
    SET @ErrorCode = 0;
    
    IF EXISTS(SELECT MEMBER_ID FROM deleted JOIN TB_SEC_USER secUser ON secUser.USER_ID = deleted.CHILD_ID WHERE secUser.USER_TYPE = 'U')
    BEGIN 
        BEGIN TRANSACTION;
            -- Increment table generation count by 1
            SELECT @TableGenerationCount = GENERATION_COUNT, @TableGenerationCountUrn =  TABLE_GENERATION_COUNT_URN 
            FROM dbo.TS_ADM_TABLE_GENERATION_COUNT WITH (UPDLOCK) 
            WHERE TABLE_NAME = 'TB_SEC_USER_GROUP_MEMBER';
            
            SET @TableGenerationCount = @TableGenerationCount + 1;
            
            UPDATE dbo.TS_ADM_TABLE_GENERATION_COUNT 
            SET GENERATION_COUNT = @TableGenerationCount, MODIFIED_DATE = GETUTCDATE() 
            WHERE TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;
            
            SELECT @ErrorCode = @@ERROR;
            
            IF @ErrorCode <> 0
            BEGIN 
                SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
                GOTO EXIT_WITH_ROLLBACK;
            END;
            
            -- Update the generation counts for existing items
            UPDATE dbo.TS_ADM_DATA_GENERATION_COUNT 
            SET GENERATION_COUNT = @TableGenerationCount, 
                LAST_OPERATION = 'D', 
                MODIFIED_DATE = GETUTCDATE() 
            FROM dbo.TS_ADM_DATA_GENERATION_COUNT AS datagc
            JOIN TS_ADM_TABLE_GENERATION_COUNT AS tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
            INNER JOIN deleted AS d ON d.MEMBER_ID = datagc.GUID_KEY
            WHERE datagc.TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;
            
            SELECT @ErrorCode = @@ERROR;
            
            IF @ErrorCode <> 0
            BEGIN 
                SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
                GOTO EXIT_WITH_ROLLBACK;
            END;
            
        COMMIT TRANSACTION;
    END;
    
    RETURN
    
    EXIT_WITH_ROLLBACK:        
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
        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+@ErrorMessage;
        -- Raise error should be the last statement in the trigger if the error is to be raised and caught outside the trigger.
        RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
END;
GO
