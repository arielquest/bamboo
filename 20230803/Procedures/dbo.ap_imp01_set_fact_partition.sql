SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_set_fact_partition] 
(
    @PartitionMetadataID AS UNIQUEIDENTIFIER,
    @ResourceInstanceID AS UNIQUEIDENTIFIER,
    @PartitionNumber AS INTEGER,
    @FactPartitionID UNIQUEIDENTIFIER OUTPUT,
    @StartDateTime AS [DATETIME] = NULL,
    @EndDateTime AS [DATETIME] = NULL,
    @PartitionTableName AS [NVARCHAR](255) = NULL,
    @ForceMetaDataUpdate AS BIT = 0
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @error INT, @existingDropDate AS DATETIME;

    SET @error = 0;
    SET @FactPartitionID = NULL;

    IF @ResourceInstanceID IS NULL
    BEGIN 
        SELECT @ResourceInstanceID = RESOURCE_INSTANCE_ID
        FROM dbo.fn_clu_get_exony_db_resource_instance(NULL);
    END;

    SET @existingDropDate = NULL;

    SELECT @FactPartitionID = FACT_PARTITION_ID, @existingDropDate = DROP_DATE
    FROM dbo.TB_IMP_FCT_PARTITION WITH (NOLOCK)
    WHERE RESOURCE_INSTANCE_ID = @ResourceInstanceID
        AND FACT_PARTITION_METADATA_ID = @PartitionMetadataID
        AND PARTITION_ID = @PartitionNumber;

    -- Purge partition meta data if partition id needs to be re-used
    IF @FactPartitionID IS NOT NULL
        AND @existingDropDate IS NOT NULL
    BEGIN 
        DELETE
        FROM dbo.TB_IMP_FCT_PARTITION
        WHERE FACT_PARTITION_ID = @FactPartitionID;

        SET @FactPartitionID = NULL;
    END;

    IF @FactPartitionID IS NOT NULL
    BEGIN 
        IF @ForceMetaDataUpdate = 1
        BEGIN 
            UPDATE dbo.TB_IMP_FCT_PARTITION
            SET START_DATE_TIME = @StartDateTime, END_DATE_TIME = @EndDateTime, PARTITION_TABLE_NAME = @PartitionTableName, FACT_PARTITION_METADATA_ID = @PartitionMetadataID
            WHERE FACT_PARTITION_ID = @FactPartitionID
                AND (
                        (
                        START_DATE_TIME IS NULL
                        OR START_DATE_TIME <> @StartDateTime
                        )
                    OR (
                        END_DATE_TIME IS NULL
                        OR END_DATE_TIME <> @EndDateTime
                        )
                    OR (
                        PARTITION_TABLE_NAME IS NULL
                        OR PARTITION_TABLE_NAME <> @PartitionTableName
                        )
                    OR (
                        FACT_PARTITION_METADATA_ID IS NULL
                        OR FACT_PARTITION_METADATA_ID <> @PartitionMetadataID
                        )
                    );
        END;
    END;
    ELSE BEGIN 
        SET @FactPartitionID = NEWID();

        INSERT INTO dbo.TB_IMP_FCT_PARTITION (FACT_PARTITION_ID, RESOURCE_INSTANCE_ID, FACT_PARTITION_METADATA_ID, PARTITION_ID, START_DATE_TIME, END_DATE_TIME, PARTITION_TABLE_NAME)
        VALUES (@FactPartitionID, @ResourceInstanceID, @PartitionMetadataID, @PartitionNumber, @StartDateTime, @EndDateTime, @PartitionTableName);
    END;

    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_set_fact_partition]
	TO [portalapp_role]
GO
