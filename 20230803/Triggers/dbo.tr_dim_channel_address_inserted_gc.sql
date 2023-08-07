SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[tr_dim_channel_address_inserted_gc] ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
    FOR INSERT
AS
BEGIN
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    IF NOT EXISTS ( SELECT  1
                    FROM    inserted )
        RETURN;

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
    SELECT  @TableGenerationCount = GENERATION_COUNT,
            @TableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
    FROM    dbo.TS_ADM_TABLE_GENERATION_COUNT WITH ( UPDLOCK )
    WHERE   TABLE_NAME = 'TB_DIM_CHANNEL_ADDRESS';
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
        
        -- Ensure rows in TS_ADM_DATA_GENERATION_COUNT
    MERGE TS_ADM_DATA_GENERATION_COUNT AS target
    USING
        ( SELECT    @TableGenerationCountUrn,
                    i.ITEM_URN,
                    @TableGenerationCount,
                    'I'
          FROM      inserted AS i
        ) AS source ( TABLE_GENERATION_COUNT_URN, INT_KEY, GENERATION_COUNT,
                      LAST_OPERATION )
    ON (
         target.TABLE_GENERATION_COUNT_URN = source.TABLE_GENERATION_COUNT_URN
         AND target.INT_KEY = source.INT_KEY
       )
    WHEN MATCHED THEN
        UPDATE SET
               GENERATION_COUNT = source.GENERATION_COUNT,
               LAST_OPERATION = 'I',
               MODIFIED_DATE = GETUTCDATE()
    WHEN NOT MATCHED THEN
        INSERT (
                 TABLE_GENERATION_COUNT_URN,
                 INT_KEY,
                 GENERATION_COUNT,
                 CREATE_GENERATION_COUNT,
                 LAST_OPERATION
               )
        VALUES (
                 source.TABLE_GENERATION_COUNT_URN,
                 source.INT_KEY,
                 source.GENERATION_COUNT,
                 source.GENERATION_COUNT,
                 source.LAST_OPERATION
               );
        
    SELECT  @ErrorCode = @@ERROR;
    IF @ErrorCode <> 0
    BEGIN
        SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
        GOTO EXIT_WITH_ROLLBACK;
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