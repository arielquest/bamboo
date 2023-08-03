SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_set_olap_partition_map] (@FactPartitionID UNIQUEIDENTIFIER, @OlapObjectName NVARCHAR(128), 
@OlapPartitionName NVARCHAR(250), @HighWater INT = 0, @Status AS INT = 0, @OlapPartitionID UNIQUEIDENTIFIER, 
@OlapPartitionMapID UNIQUEIDENTIFIER OUTPUT) AS

SET NOCOUNT ON;

DECLARE @error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, @olapObjectURN INT, @ErrorMessage VARCHAR(200);

BEGIN TRY;

    SELECT @olapObjectURN = OLAP_OBJECT_URN
    FROM dbo.TB_ADM_OLAP_OBJECT
    WHERE OLAP_OBJECT_NAME = @OlapObjectName AND OLAP_OBJECT_TYPE = 'C';

    IF @olapObjectURN IS NULL
    BEGIN 
        SET @error = -1;
        RAISERROR ('ap_imp01_set_olap_partition_map: @olapObjectURN cannot be NULL', 16, 1);
    END;

    SELECT @OlapPartitionID = OLAP_PARTITION_ID
    FROM dbo.TB_IMP_FCT_OLAP_PARTITION
    WHERE OLAP_OBJECT_URN = @olapObjectURN AND OLAP_PARTITION_NAME = @OlapPartitionName;

    IF @OlapPartitionID IS NOT NULL
    BEGIN 
        SELECT @OlapPartitionMapID = OLAP_PARTITION_MAP_ID
        FROM dbo.TB_IMP_FCT_OLAP_PARTITION_MAP
        WHERE FACT_PARTITION_ID = @FactPartitionID AND OLAP_PARTITION_ID = @OlapPartitionID;
    END;

    BEGIN TRANSACTION SetPartMapTransaction;
        IF @OlapPartitionID IS NOT NULL
        BEGIN 
            UPDATE dbo.TB_IMP_FCT_OLAP_PARTITION
            SET STATUS = @Status
            WHERE OLAP_PARTITION_ID = @OlapPartitionID;
        END;
        ELSE BEGIN 
            SET @OlapPartitionID = NEWID();

            INSERT INTO dbo.TB_IMP_FCT_OLAP_PARTITION (OLAP_PARTITION_ID, OLAP_OBJECT_URN, OLAP_PARTITION_NAME, STATUS)
            VALUES (@OlapPartitionID, @olapObjectURN, @OlapPartitionName, @Status);
        END;

        IF @OlapPartitionMapID IS NOT NULL
        BEGIN 
            UPDATE dbo.TB_IMP_FCT_OLAP_PARTITION_MAP
            SET LAST_HIGH_WATER = @HighWater
            WHERE OLAP_PARTITION_MAP_ID = @OlapPartitionMapID;
        END;
        ELSE BEGIN 
            SET @OlapPartitionMapID = NEWID();

            INSERT INTO dbo.TB_IMP_FCT_OLAP_PARTITION_MAP (OLAP_PARTITION_MAP_ID, FACT_PARTITION_ID, OLAP_PARTITION_ID, LAST_HIGH_WATER)
            VALUES (@OlapPartitionMapID, @FactPartitionID, @OlapPartitionID, @HighWater);
        END;

    IF @InitialTransactionCount = 0 
    BEGIN 
       COMMIT TRANSACTION SetPartMapTransaction;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;
END TRY
BEGIN CATCH;
    SELECT @error = CASE WHEN @error <> -1 THEN @@ERROR ELSE @error END,
    @ErrorMessage = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(': ' + ERROR_MESSAGE(),'');
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

RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_set_olap_partition_map]
	TO [portalapp_role]
GO
