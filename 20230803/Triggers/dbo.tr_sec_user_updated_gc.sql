SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_sec_user_updated_gc] ON [dbo].[TB_SEC_USER]
    FOR UPDATE
AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    IF NOT EXISTS ( SELECT  1
                    FROM    inserted )
        OR (
             UPDATE(msrepl_tran_version)
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
        @DataGenUpdateCount AS INTEGER,
        @UserRecordCount AS INTEGER;
            
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @ErrorMessage = '';
    SET @ErrorCode = 0;
    
    -- Check if any users have been inserted/updated
    SELECT  @UserRecordCount = COUNT(*)
    FROM    inserted i
    JOIN    deleted u ON i.USER_ID = u.USER_ID
    WHERE   i.USER_TYPE = 'U'
            AND (
                  (
                    u.LAST_LOGIN IS NULL
                    AND i.LAST_LOGIN IS NULL
                  )
                  OR u.LAST_LOGIN = i.LAST_LOGIN
                );

    IF @UserRecordCount > 0
    BEGIN 
        BEGIN TRANSACTION;
            -- Increment table generation count by 1
        SELECT  @TableGenerationCount = GENERATION_COUNT,
                @TableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
        FROM    dbo.TS_ADM_TABLE_GENERATION_COUNT WITH ( UPDLOCK )
        WHERE   TABLE_NAME = 'TB_SEC_USER';
            
        SET @TableGenerationCount = @TableGenerationCount + 1;
            
        UPDATE  dbo.TS_ADM_TABLE_GENERATION_COUNT
        SET     GENERATION_COUNT = @TableGenerationCount,
                MODIFIED_DATE = GETUTCDATE()
        WHERE   TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;
            
        SELECT  @ErrorCode = @@ERROR;
            
        IF @ErrorCode <> 0
        BEGIN 
            SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
            GOTO EXIT_WITH_ROLLBACK;
        END;
                
        SELECT  @UpdatedRowCount = COUNT(*)
        FROM    inserted;
    
        
            -- Update the generation counts for existing items
        UPDATE  dbo.TS_ADM_DATA_GENERATION_COUNT
        SET     GENERATION_COUNT = @TableGenerationCount,
                LAST_OPERATION = 'U',
                MODIFIED_DATE = GETUTCDATE()
        FROM    dbo.TS_ADM_DATA_GENERATION_COUNT AS datagc
        JOIN    inserted AS d ON d.USER_ID = datagc.GUID_KEY
        WHERE   datagc.TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;
            
        SELECT  @ErrorCode = @@ERROR,
                @DataGenUpdateCount = @@ROWCOUNT;
        IF @ErrorCode <> 0
        BEGIN 
            SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
            GOTO EXIT_WITH_ROLLBACK;
        END;

            -- If some rows are not updated, then they are missing from data generation count, so insert them...
        IF @DataGenUpdateCount < @UpdatedRowCount
        BEGIN 
                -- Add the generation counts for non existent items
            INSERT  INTO TS_ADM_DATA_GENERATION_COUNT
                    (
                      TABLE_GENERATION_COUNT_URN,
                      GUID_KEY,
                      GENERATION_COUNT,
                      CREATE_GENERATION_COUNT,
                      LAST_OPERATION
                    )
            SELECT  @TableGenerationCountUrn,
                    i.USER_ID,
                    @TableGenerationCount,
                    @TableGenerationCount,
                    'U'
            FROM    inserted AS i
            WHERE   NOT EXISTS ( SELECT d.USER_ID
                                 FROM   dbo.TS_ADM_DATA_GENERATION_COUNT AS datagc
                                 JOIN   inserted AS d ON d.USER_ID = datagc.GUID_KEY
                                 WHERE  datagc.TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn
                                        AND d.USER_ID = i.USER_ID )
                    AND i.USER_TYPE = 'U';
                
            SELECT  @ErrorCode = @@ERROR;
            IF @ErrorCode <> 0
            BEGIN 
                SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
                GOTO EXIT_WITH_ROLLBACK;
            END;
        END;
        COMMIT TRANSACTION;
    END;
    
    RETURN;
    
    EXIT_WITH_ROLLBACK:        
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
                SET @ErrorMessage = ISNULL(@ErrorMessage,
                                           OBJECT_NAME(@@PROCID))
                    + ' [Uncommittable Transaction!]';
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
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + @ErrorMessage;
        -- Raise error should be the last statement in the trigger if the error is to be raised and caught outside the trigger.
    RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
END;
GO
