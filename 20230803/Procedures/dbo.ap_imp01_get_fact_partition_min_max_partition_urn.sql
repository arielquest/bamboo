SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_fact_partition_min_max_partition_urn]
(
    @FactResourceInstanceID AS UNIQUEIDENTIFIER,
    @OlapResourceInstanceID     AS UNIQUEIDENTIFIER,
    @CubeName               AS NVARCHAR(100),
    @MeasureGroupName       AS NVARCHAR(100),
    @FactTableName          AS NVARCHAR(100),
    @FactPartitionNumber    AS INTEGER,
    @BoundaryTime AS DATETIME = NULL
) AS
BEGIN 
    SET NOCOUNT ON;
    
    DECLARE @v_FactPartitionID AS UNIQUEIDENTIFIER;
    
    -- Get the Fact Partition ID
    SELECT @v_FactPartitionID = p.[FACT_PARTITION_ID]
    FROM [dbo].[TB_IMP_FCT_PARTITION] AS p
    JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] AS m ON p.[FACT_PARTITION_METADATA_ID] = m.[FACT_PARTITION_METADATA_ID]
    WHERE m.[CUBE_VIEW_NAME] = @FactTableName
    AND p.[PARTITION_ID] = @FactPartitionNumber
    AND p.[RESOURCE_INSTANCE_ID] = @FactResourceInstanceID;
    
    -- Check the Last Processed High Water    
    SELECT COALESCE(MAX(o.[LAST_HIGH_WATER]), 0) + 1 AS [HIGH_WATER_BEFORE],
           MAX(t.[HIGH_WATER_AFTER]) AS [HIGH_WATER_AFTER]
    FROM [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] o
    JOIN [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] AS t ON o.[FACT_PARTITION_ID] = t.[FACT_PARTITION_ID]
    JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION] AS p ON o.[OLAP_PARTITION_ID] = p.[OLAP_PARTITION_ID]
    JOIN [dbo].[TB_ADM_OLAP_OBJECT] AS b ON p.[OLAP_OBJECT_URN] = b.OLAP_OBJECT_URN
    WHERE o.[FACT_PARTITION_ID] = @v_FactPartitionID
    AND p.[RESOURCE_INSTANCE_ID] = @OlapResourceInstanceID
    AND b.[PARENT_OLAP_OBJECT_NAME] = @CubeName
    AND b.[OLAP_OBJECT_NAME] = @MeasureGroupName
    AND (@BoundaryTime IS NULL OR t.IMPORT_COMPLETE_DATE <= @BoundaryTime);
    
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_fact_partition_min_max_partition_urn]
	TO [portalapp_role]
GO
