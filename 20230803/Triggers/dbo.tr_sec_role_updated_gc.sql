SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_sec_role_updated_gc] ON [dbo].[TB_SEC_ROLE]
    FOR UPDATE
AS
    BEGIN 
        SET XACT_ABORT OFF;
        SET NOCOUNT ON;

        IF NOT EXISTS ( SELECT  1
                        FROM    [Inserted] )
            OR ( UPDATE([msrepl_tran_version])
                 AND SESSIONPROPERTY('REPLICATION_AGENT') = 0
               )
        BEGIN 
            RETURN;
        END;

        DECLARE @ErrorMessage AS NVARCHAR(500),
            @ErrorCode AS [INTEGER],
            @InitialTransactionCount AS [INTEGER],
            @TableGenerationCount AS BIGINT,
            @TableGenerationCountUrn AS INTEGER,
            @UpdatedRowCount AS INTEGER,
            @DataGenUpdateCount AS INTEGER;
            
        SET @InitialTransactionCount = @@TRANCOUNT;
        SET @ErrorMessage = '';
        SET @ErrorCode = 0;
    
        BEGIN TRANSACTION;
        BEGIN TRY
            -- Increment table generation count by 1
            SELECT  @TableGenerationCount = [GENERATION_COUNT],
                    @TableGenerationCountUrn = [TABLE_GENERATION_COUNT_URN]
            FROM    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] WITH ( UPDLOCK )
            WHERE   [TABLE_NAME] = 'TB_SEC_ROLE';
        
            SET @TableGenerationCount = @TableGenerationCount + 1;
        
            UPDATE  [dbo].[TS_ADM_TABLE_GENERATION_COUNT]
            SET     [GENERATION_COUNT] = @TableGenerationCount,
                    [MODIFIED_DATE] = GETUTCDATE()
            WHERE   [TABLE_GENERATION_COUNT_URN] = @TableGenerationCountUrn;
        
            SELECT  @ErrorCode = @@ERROR;
        
            IF @ErrorCode <> 0
            BEGIN 
                RAISERROR('An error occured while attempting to update item. Error = [%d]', 16, 1, @ErrorCode);
            END;
        
            SELECT  @UpdatedRowCount = COUNT(*)
            FROM    [Inserted];

            -- Update the generation counts for existing items
            UPDATE  [dbo].[TS_ADM_DATA_GENERATION_COUNT]
            SET     [GENERATION_COUNT] = @TableGenerationCount,
                    [LAST_OPERATION] = 'U',
                    [MODIFIED_DATE] = GETUTCDATE()
            FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] AS [datagc]
            JOIN    [Inserted] AS [d] ON [d].[ROLE_ID] = [datagc].[GUID_KEY]
            WHERE   [datagc].[TABLE_GENERATION_COUNT_URN] = @TableGenerationCountUrn;
    
            SELECT  @ErrorCode = @@ERROR,
                    @DataGenUpdateCount = @@ROWCOUNT;
    
            IF @ErrorCode <> 0
            BEGIN 
                RAISERROR('An error occured while attempting to update item. Error = [%d]', 16, 1, @ErrorCode);
            END;
        
            -- If some rows are not updated, then they are missing from data generation count, so insert them...
            IF @DataGenUpdateCount < @UpdatedRowCount
            BEGIN 
                -- Add the generation counts for non existent items
                INSERT  INTO [dbo].[TS_ADM_DATA_GENERATION_COUNT]
                        ( [TABLE_GENERATION_COUNT_URN],
                          [GUID_KEY],
                          [GENERATION_COUNT],
                          [CREATE_GENERATION_COUNT],
                          [LAST_OPERATION]
                        )
                SELECT  @TableGenerationCountUrn,
                        [i].[ROLE_ID],
                        @TableGenerationCount,
                        @TableGenerationCount,
                        'U'
                FROM    [Inserted] AS [i]
                WHERE   NOT EXISTS ( SELECT [d].[ROLE_ID]
                                     FROM   [dbo].[TS_ADM_DATA_GENERATION_COUNT] AS [datagc]
                                     JOIN   [Inserted] AS [d] ON [d].[ROLE_ID] = [datagc].[GUID_KEY]
                                     WHERE  [datagc].[TABLE_GENERATION_COUNT_URN] = @TableGenerationCountUrn
                                            AND [d].[ROLE_ID] = [i].[ROLE_ID] );
    
                SELECT  @ErrorCode = @@ERROR;
                IF @ErrorCode <> 0
                BEGIN 
                    RAISERROR('An error occured while attempting to update item. Error = [%d]', 16, 1, @ErrorCode);
                END;
            END;
            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION;
            END;
            ELSE
            BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            RETURN;
        END TRY
        BEGIN CATCH
            SET @ErrorMessage = ERROR_MESSAGE();
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
        END CATCH;
    END;
GO
