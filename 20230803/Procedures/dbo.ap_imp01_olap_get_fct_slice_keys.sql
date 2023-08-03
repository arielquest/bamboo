SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_fct_slice_keys] 
( 
    @I_ObjectName AS [VARCHAR](50),
    @I_ResourceInstanceID UNIQUEIDENTIFIER,    
    @I_OlapResourceID UNIQUEIDENTIFIER
) AS
BEGIN 
    SET NOCOUNT ON;

    SELECT ts.SLICE_KEYS, fp.PARTITION_ID
    FROM TB_IMP_FCT_PARTITION_TIDEMARK_SLICE AS ts
    INNER JOIN TB_IMP_FCT_PARTITION_TIDEMARK AS pt ON ts.PARTITION_TIDEMARK_ID = pt.PARTITION_TIDEMARK_ID
    INNER JOIN TB_IMP_FCT_PARTITION AS fp ON pt.FACT_PARTITION_ID = fp.FACT_PARTITION_ID
    INNER JOIN TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
    INNER JOIN TB_ADM_OLAP_OBJECT AS ob ON fpm.CUBE_VIEW_NAME = ob.PRIMARY_TABLE
    INNER JOIN TB_ADM_OLAP_OBJECT_CLUSTER_MAP mp ON mp.[OLAP_OBJECT_URN] = ob.[OLAP_OBJECT_URN]
    WHERE ob.OLAP_OBJECT_NAME = @I_ObjectName
        AND ob.[OLAP_OBJECT_TYPE] = 'C'
        AND mp.[ENABLED] = 1
        AND mp.[OLAP_CLUSTER_RESOURCE_ID] = @I_OlapResourceID
        AND fp.[RESOURCE_INSTANCE_ID] = @I_ResourceInstanceID
        AND fp.[ONLINE_DATE] IS NOT NULL
        AND fp.[OFFLINE_DATE] IS NULL
        ORDER BY CASE WHEN ob.OLAP_OBJECT_URN  = 351 THEN ts.SLICE_KEYS END ASC,
                 CASE WHEN ob.OLAP_OBJECT_URN  <> 351 THEN ts.SLICE_KEYS END DESC;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_fct_slice_keys]
	TO [portalapp_role]
GO
