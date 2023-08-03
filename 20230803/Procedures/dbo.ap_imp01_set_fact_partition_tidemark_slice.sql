SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_set_fact_partition_tidemark_slice] (@PartitionTidemarkID UNIQUEIDENTIFIER, @SliceColumn NVARCHAR(100), 
@SliceKeys NVARCHAR(3800), @PartitionTidemarkSliceID UNIQUEIDENTIFIER OUTPUT) AS

SET NOCOUNT ON;

DECLARE @error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT;

SET @PartitionTidemarkSliceID = NULL;

SELECT @PartitionTidemarkSliceID = PARTITION_TIDEMARK_SLICE_ID
FROM dbo.TB_IMP_FCT_PARTITION_TIDEMARK_SLICE WITH (NOLOCK)
WHERE PARTITION_TIDEMARK_ID = @PartitionTidemarkID AND SLICE_COLUMN = @SliceColumn;

IF @PartitionTidemarkSliceID IS NULL
BEGIN 
    BEGIN TRANSACTION SetPartTideTransaction;
    
        BEGIN TRY;
            SET @PartitionTidemarkSliceID = NEWID();

            INSERT INTO dbo.TB_IMP_FCT_PARTITION_TIDEMARK_SLICE (PARTITION_TIDEMARK_SLICE_ID, PARTITION_TIDEMARK_ID, SLICE_COLUMN, SLICE_KEYS)
            VALUES (@PartitionTidemarkSliceID, @PartitionTidemarkID, @SliceColumn, @SliceKeys);

            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION SetPartTideTransaction;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END TRY
        BEGIN CATCH;
            DECLARE @ErrorMessage VARCHAR(200) = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(': ' + ERROR_MESSAGE(),'');
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
                RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
            END;
        END CATCH;
END;

RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_set_fact_partition_tidemark_slice]
	TO [portalapp_role]
GO
