SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_RESOURCE_ENTITY_TYPE_MAPPING_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        clu.[ENTITY_TYPE_ID] AS PARENT_RESOURCE_ID,
        clu.[CLUSTER_RESOURCE_ID] AS CHILD_RESOURCE_ID,
        clu.[IMPORT_ENABLED],
        clu.[PROVISIONING_ENABLED],
        clu.[CACHE_ENABLED],
        clu.[SOURCE_CLUSTER_RESOURCE_ID],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION],
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS CHILD_RESOURCE_TYPE_ID, -- IT_CLUSTER_RESOURCE_ID
        CASE WHEN mt.MEMBER_TYPE_ID IS NOT NULL
             THEN CAST('7CFA07C8-C907-4c31-BC4B-EA8541076BFE' AS UNIQUEIDENTIFIER)
             ELSE CAST('7EEE42BA-5688-4dc7-A3E6-014EF72DC7E9' AS UNIQUEIDENTIFIER)
        END AS PARENT_RESOURCE_TYPE_ID -- IT_ITEM_TYPE or IT_MEMBER_TYPE
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING] clu ON clu.ID = datagc.GUID_KEY
LEFT JOIN [dbo].[TE_DIM_ITEM_TYPE] it ON clu.ENTITY_TYPE_ID = it.ITEM_TYPE_ID
LEFT JOIN [dbo].[TE_DIM_MEMBER_TYPE] mt ON clu.ENTITY_TYPE_ID = mt.MEMBER_TYPE_ID
WHERE   tablegc.TABLE_NAME = 'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING';
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_ENTITY_TYPE_MAPPING_GC]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_ENTITY_TYPE_MAPPING_GC]
	TO [portal_database_configuration_read_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_ENTITY_TYPE_MAPPING_GC]
	TO [portal_database_configuration_role]
GO
