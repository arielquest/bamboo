SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_imp01_get_new_import_jobs]
(
    @FactResourceInstanceID AS UNIQUEIDENTIFIER,
    @OlapResourceInstanceID AS UNIQUEIDENTIFIER,
    @FactViewName AS NVARCHAR(100),
    @PartitionNumber AS INTEGER,
    @ParentOlapObjectName     AS NVARCHAR(50),
    @OlapObjectName         AS NVARCHAR(128),
    @OlapPartitionName AS NVARCHAR(250),
    @BoundaryTime AS DATETIME = NULL
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @error INT, @olapObjectURN AS INT;

    SET @error = 0;

    SELECT @olapObjectURN = OLAP_OBJECT_URN
    FROM dbo.TB_ADM_OLAP_OBJECT
    WHERE PARENT_OLAP_OBJECT_NAME = @ParentOlapObjectName
        AND OLAP_OBJECT_NAME = @OlapObjectName
        AND OLAP_OBJECT_TYPE = 'C';

    SELECT pt.FACT_PARTITION_ID, pt.HIGH_WATER_BEFORE, pt.HIGH_WATER_AFTER, pc.PARTITION_TIDEMARK_ID, pc.SLICE_COLUMN, pc.SLICE_KEYS
    FROM dbo.TB_IMP_FCT_OLAP_PARTITION_MAP pm
    INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION op ON op.OLAP_PARTITION_ID = pm.OLAP_PARTITION_ID
    INNER JOIN dbo.TB_IMP_FCT_PARTITION AS p ON p.FACT_PARTITION_ID = pm.FACT_PARTITION_ID
    INNER JOIN dbo.TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = p.FACT_PARTITION_METADATA_ID
    INNER JOIN dbo.TB_IMP_FCT_PARTITION_TIDEMARK AS pt ON pt.FACT_PARTITION_ID = p.FACT_PARTITION_ID
    INNER JOIN dbo.TB_IMP_FCT_PARTITION_TIDEMARK_SLICE AS pc ON pc.PARTITION_TIDEMARK_ID = pt.PARTITION_TIDEMARK_ID
    WHERE (
            pt.HIGH_WATER_BEFORE >= pm.LAST_HIGH_WATER
            OR (
                pm.LAST_HIGH_WATER > pt.HIGH_WATER_BEFORE
                AND pm.LAST_HIGH_WATER < pt.HIGH_WATER_AFTER
                )
            )
        AND p.RESOURCE_INSTANCE_ID = @FactResourceInstanceID
        AND op.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID
        AND fpm.CUBE_VIEW_NAME = @FactViewName
        AND p.PARTITION_ID = @PartitionNumber
        AND op.OLAP_OBJECT_URN = @olapObjectURN
        AND op.OLAP_PARTITION_NAME = @OlapPartitionName
        AND (@BoundaryTime IS NULL OR pt.IMPORT_COMPLETE_DATE <= @BoundaryTime);

    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_new_import_jobs]
	TO [portalapp_role]
GO
