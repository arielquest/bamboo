SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_set_fact_partition_tidemark]
    (
      @FactPartitionID UNIQUEIDENTIFIER,
      @HighWaterBefore INT,
      @HighWaterAfter INT,
      @PartitionTidemarkID UNIQUEIDENTIFIER OUTPUT,
      @ClusterResourceID UNIQUEIDENTIFIER = NULL,
      @MaxGlobalPartitionUrn BIGINT = NULL,
      @MinGlobalPartitionUrn BIGINT = NULL
    )
AS
    SET NOCOUNT ON;

    DECLARE @error INT = 0,
        @InitialTransactionCount INT = @@TRANCOUNT,
        @ErrorMessage VARCHAR(200);

    BEGIN TRANSACTION [SetPartTideTransaction];

    BEGIN TRY;
        SET @PartitionTidemarkID = NEWID();
        
        INSERT  INTO [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
                ( [PARTITION_TIDEMARK_ID],
                  [FACT_PARTITION_ID],
                  [HIGH_WATER_BEFORE],
                  [HIGH_WATER_AFTER],
                  [IMPORT_COMPLETE_DATE],
                  [CLUSTER_RESOURCE_ID],
                  [MAX_GLOBAL_PARTITION_URN],
                  [MIN_GLOBAL_PARTITION_URN]
                )
        VALUES  ( @PartitionTidemarkID,
                  @FactPartitionID,
                  @HighWaterBefore,
                  @HighWaterAfter,
                  GETUTCDATE(),
                  @ClusterResourceID,
                  ISNULL(@MaxGlobalPartitionUrn, 0),
                  ISNULL(@MinGlobalPartitionUrn, 0)
                );

        IF @InitialTransactionCount = 0
        BEGIN 
            COMMIT TRANSACTION [SetPartTideTransaction];
        END;
        ELSE
        BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT  @error = @@ERROR,
                @ErrorMessage = '[' + OBJECT_NAME(@@PROCID) + ']' + ISNULL(': ' + ERROR_MESSAGE(), '');
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
            END;
        SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;

    RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_set_fact_partition_tidemark]
	TO [portalapp_role]
GO
