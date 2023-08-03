SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_sec_policy_user_role_inserted_gc] ON [dbo].[TB_SEC_POLICY_USER_ROLE]
    FOR INSERT
AS
    BEGIN 
        SET XACT_ABORT OFF;
        SET NOCOUNT ON;

        IF NOT EXISTS ( SELECT  1
                        FROM    [Inserted] )
        BEGIN 
            RETURN;
        END;

        DECLARE @ErrorMessage AS NVARCHAR(500),
            @ErrorCode AS [INTEGER],
            @InitialTransactionCount AS [INTEGER],
            @TableGenerationCount AS BIGINT,
            @TableGenerationCountUrn AS INTEGER;
            
        SET @InitialTransactionCount = @@TRANCOUNT;
        SET @ErrorMessage = '';
        SET @ErrorCode = 0;
    
        BEGIN TRANSACTION;
    
        -- Increment table generation count by 1
        SELECT  @TableGenerationCount = [GENERATION_COUNT],
                @TableGenerationCountUrn = [TABLE_GENERATION_COUNT_URN]
        FROM    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] WITH ( UPDLOCK )
        WHERE   [TABLE_NAME] = 'TB_SEC_POLICY_USER_ROLE';
        
        SET @TableGenerationCount = @TableGenerationCount + 1;
        
        UPDATE  [dbo].[TS_ADM_TABLE_GENERATION_COUNT]
        SET     [GENERATION_COUNT] = @TableGenerationCount,
                [MODIFIED_DATE] = GETUTCDATE()
        WHERE   [TABLE_GENERATION_COUNT_URN] = @TableGenerationCountUrn;
        
        SELECT  @ErrorCode = @@ERROR;
        
        IF @ErrorCode = 0
        BEGIN            
            -- Ensure rows in TS_ADM_DATA_GENERATION_COUNT
            MERGE [dbo].[TS_ADM_DATA_GENERATION_COUNT] AS [target]
            USING
                ( SELECT    @TableGenerationCountUrn,
                            [i].[ID],
                            @TableGenerationCount,
                            'I'
                  FROM      [Inserted] AS [i]
                ) AS [source] ( [TABLE_GENERATION_COUNT_URN], [GUID_KEY], [GENERATION_COUNT], [LAST_OPERATION] )
            ON ( [target].[TABLE_GENERATION_COUNT_URN] = [source].[TABLE_GENERATION_COUNT_URN]
                 AND [target].[GUID_KEY] = [source].[GUID_KEY]
               )
            WHEN MATCHED THEN
                UPDATE SET
                         [target].[GENERATION_COUNT] = [source].[GENERATION_COUNT],
                         [target].[LAST_OPERATION] = 'I',
                         [target].[MODIFIED_DATE] = GETUTCDATE()
            WHEN NOT MATCHED THEN
                INSERT ( [TABLE_GENERATION_COUNT_URN],
                         [GUID_KEY],
                         [GENERATION_COUNT],
                         [CREATE_GENERATION_COUNT],
                         [LAST_OPERATION]
                       )
                VALUES ( [source].[TABLE_GENERATION_COUNT_URN],
                         [source].[GUID_KEY],
                         [source].[GENERATION_COUNT],
                         [source].[GENERATION_COUNT],
                         [source].[LAST_OPERATION]
                       );
        
            SELECT  @ErrorCode = @@ERROR;
        
            IF @ErrorCode = 0
            BEGIN    
                COMMIT TRANSACTION;
                RETURN;
            END;
            ELSE
            BEGIN
                SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
            END;
        END;
        ELSE
        BEGIN
            SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
        END;   
        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE
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
        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + @ErrorMessage;
        -- Raise error should be the last statement in the trigger if the error is to be raised and caught outside the trigger.
        RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
    END;
GO
