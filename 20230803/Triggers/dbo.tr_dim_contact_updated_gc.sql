SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[tr_dim_contact_updated_gc] ON [dbo].[TB_DIM_CONTACT]
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
        RETURN;

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
    
        -- Increment table generation count by 1
    SELECT  @TableGenerationCount = GENERATION_COUNT,
            @TableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
    FROM    dbo.TS_ADM_TABLE_GENERATION_COUNT WITH ( UPDLOCK )
    WHERE   TABLE_NAME = 'TB_DIM_CONTACT';
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
    JOIN    inserted AS d ON d.ITEM_URN = datagc.INT_KEY
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
                  INT_KEY,
                  GENERATION_COUNT,
                  CREATE_GENERATION_COUNT,
                  LAST_OPERATION
                )
        SELECT  @TableGenerationCountUrn,
                i.ITEM_URN,
                @TableGenerationCount,
                @TableGenerationCount,
                'U'
        FROM    inserted AS i
        WHERE   NOT EXISTS ( SELECT d.ITEM_URN
                             FROM   dbo.TS_ADM_DATA_GENERATION_COUNT AS datagc
                             JOIN   inserted AS d ON d.ITEM_URN = datagc.INT_KEY
                             WHERE  datagc.TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn
                                    AND d.ITEM_URN = i.ITEM_URN );        
                
        SELECT  @ErrorCode = @@ERROR;
        IF @ErrorCode <> 0
        BEGIN
            SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
            GOTO EXIT_WITH_ROLLBACK;
        END;
    END;

    COMMIT TRANSACTION;
    
    RETURN;
    
    EXIT_WITH_ROLLBACK:        
    IF @InitialTransactionCount = 0
        AND @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;        
    ELSE
        IF @InitialTransactionCount <> 0
            AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN
            WHILE @@TRANCOUNT > @InitialTransactionCount
                COMMIT TRANSACTION;
        END;
    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + @ErrorMessage;
        -- Raise error should be the last statement in the trigger if the error is to be raised and caught outside the trigger.
    RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
END;
GO
