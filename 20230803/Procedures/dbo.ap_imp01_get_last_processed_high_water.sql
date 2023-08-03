SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_last_processed_high_water]
(
    @FactResourceInstanceID AS UNIQUEIDENTIFIER,
    @OlapResourceInstanceID AS UNIQUEIDENTIFIER,
    @FactViewName AS NVARCHAR(100),
    @ParentOlapObjectName     AS NVARCHAR(50),
    @OlapObjectName         AS NVARCHAR(128),
    @OlapPartitionName AS NVARCHAR(250)
)
--WITH ENCRYPTION
AS
    SET NOCOUNT ON;
    
    DECLARE @error INTEGER,
            @olapObjectURN AS INTEGER;
    
    SET @error = 0;
    
    SELECT @olapObjectURN = [OLAP_OBJECT_URN] 
    FROM [dbo].[TB_ADM_OLAP_OBJECT]
    WHERE [PARENT_OLAP_OBJECT_NAME] = @ParentOlapObjectName 
    AND [OLAP_OBJECT_NAME] = @OlapObjectName
    AND [OLAP_OBJECT_TYPE] = 'C';
    
    
    SELECT [aa].[LAST_HIGH_WATER]
    FROM [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] aa
    JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION] op ON [op].[OLAP_PARTITION_ID] = [aa].[OLAP_PARTITION_ID]
    JOIN [dbo].[TB_IMP_FCT_PARTITION] bb ON [aa].[FACT_PARTITION_ID] = [bb].[FACT_PARTITION_ID]
    JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] pm ON [pm].[FACT_PARTITION_METADATA_ID] = [bb].[FACT_PARTITION_METADATA_ID]
    JOIN [dbo].[TB_ADM_OLAP_OBJECT] cc ON [op].[OLAP_OBJECT_URN] = [cc].[OLAP_OBJECT_URN]
    WHERE [bb].[RESOURCE_INSTANCE_ID] = @FactResourceInstanceID
    AND [op].[RESOURCE_INSTANCE_ID] = @OlapResourceInstanceID
    AND [pm].[CUBE_VIEW_NAME] = @FactViewName
    AND [op].[OLAP_PARTITION_NAME] = @OlapPartitionName
    AND [cc].[OLAP_OBJECT_URN] = @olapObjectURN;
            
    EXIT_SPROC:
        RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_last_processed_high_water]
	TO [portalapp_role]
GO
