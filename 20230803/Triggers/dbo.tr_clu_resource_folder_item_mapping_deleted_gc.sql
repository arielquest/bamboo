SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_clu_resource_folder_item_mapping_deleted_gc] ON [dbo].[TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING]
    FOR DELETE
AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
 
    IF NOT EXISTS ( SELECT  1
                    FROM    deleted )
    BEGIN 
        RETURN;
    END;
 
    DECLARE @ErrorMessage AS NVARCHAR(500),
        @ErrorCode AS INT,
        @InitialTransactionCount AS INT,
        @TableGenerationCount AS BIGINT,
        @TableGenerationCountUrn AS INT;
 
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
        
            -- Update the generation counts for existing items
        UPDATE  dbo.TS_ADM_DATA_GENERATION_COUNT
        SET     GENERATION_COUNT = @TableGenerationCount,
                LAST_OPERATION = 'D',
                MODIFIED_DATE = GETUTCDATE()
        FROM    dbo.TS_ADM_DATA_GENERATION_COUNT AS datagc
        INNER JOIN deleted AS d ON d.RESOURCE_FOLDER_ITEM_MAPPING_ID = datagc.GUID_KEY
        WHERE   datagc.TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;
            
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
        ELSE BEGIN 
            IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                IF (XACT_STATE()) = - 1
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
        END;
        SET @ErrorMessage = ISNULL(@ErrorMessage,QUOTENAME(OBJECT_NAME(@@PROCID)));
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
END;
GO
