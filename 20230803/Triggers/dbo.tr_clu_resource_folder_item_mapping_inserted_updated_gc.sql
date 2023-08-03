SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_clu_resource_folder_item_mapping_inserted_updated_gc] ON [dbo].[TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING]
    FOR INSERT, UPDATE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
 
    DECLARE @ErrorMessage AS NVARCHAR(500),
        @ErrorCode AS INT,
        @InitialTransactionCount AS INT,
        @TableGenerationCount AS BIGINT,
        @TableGenerationCountUrn AS INT,
        @IsUpdate AS BIT,
        @LastOperation AS CHAR;
            
    SELECT  @IsUpdate = CASE WHEN EXISTS ( SELECT   1
                                           FROM     deleted ) THEN 1
                             ELSE 0
                        END;
    
    -- Return early if no rows or if it is an update is by replication on the msrepl_tran_version column
    IF NOT EXISTS(SELECT 1 FROM inserted) OR (@IsUpdate = 1 AND UPDATE(msrepl_tran_version) AND SESSIONPROPERTY('REPLICATION_AGENT') = 0)
    BEGIN 
        RETURN;
    END;
    
    SELECT  @LastOperation = CASE WHEN @IsUpdate = 1 THEN 'U'
                                  ELSE 'I'
                             END;
           
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @ErrorMessage = '';
    SET @ErrorCode = 0;
   
    BEGIN TRANSACTION;
   
    -- Increment table generation count by 1
    SELECT  @TableGenerationCount = GENERATION_COUNT,
            @TableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
    FROM    dbo.TS_ADM_TABLE_GENERATION_COUNT WITH ( UPDLOCK )
    WHERE   TABLE_NAME = 'TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING';
       
    SET @TableGenerationCount = @TableGenerationCount + 1;
       
    BEGIN TRY;   
        UPDATE  dbo.TS_ADM_TABLE_GENERATION_COUNT
        SET     GENERATION_COUNT = @TableGenerationCount,
                MODIFIED_DATE = GETUTCDATE()
        WHERE   TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;
       
        -- Ensure rows in TS_ADM_DATA_GENERATION_COUNT
        MERGE dbo.TS_ADM_DATA_GENERATION_COUNT AS target
        USING (SELECT @TableGenerationCountUrn, i.RESOURCE_FOLDER_ITEM_MAPPING_ID, @TableGenerationCount, @LastOperation
               FROM  inserted AS i
              ) AS source (TABLE_GENERATION_COUNT_URN, GUID_KEY, GENERATION_COUNT, LAST_OPERATION)
        ON    (target.TABLE_GENERATION_COUNT_URN = source.TABLE_GENERATION_COUNT_URN AND target.GUID_KEY = source.GUID_KEY)
        WHEN MATCHED THEN
                UPDATE SET GENERATION_COUNT = source.GENERATION_COUNT, LAST_OPERATION = source.LAST_OPERATION, MODIFIED_DATE = GETUTCDATE()
        WHEN NOT MATCHED THEN   
                INSERT (TABLE_GENERATION_COUNT_URN, GUID_KEY, GENERATION_COUNT, LAST_OPERATION)
                VALUES (source.TABLE_GENERATION_COUNT_URN, source.GUID_KEY, source.GENERATION_COUNT, source.LAST_OPERATION);
 
        COMMIT TRANSACTION;   
        RETURN;
    END TRY
    BEGIN CATCH;
        SELECT @ErrorCode = @@ERROR,
        @ErrorMessage = QUOTENAME(OBJECT_NAME(@@PROCID))+ISNULL(': '+ERROR_MESSAGE(),'An error occured while attempting to update item.')+ '  Error = [%d]';
       
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
    END CATCH;
END;
GO
