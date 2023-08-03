SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_RESOURCE_TYPE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        clu.[NAME],
        clu.[INTERNAL_NAME],
        clu.[DESCRIPTION],
        clu.[RESOURCE_TYPE_GROUP_ID],
        clu.[SYSTEM],
        clu.[DELETED],
        clu.[MIN_RESOURCES],
        clu.[MAX_RESOURCES],
        clu.[MIN_RESOURCE_INSTANCES],
        clu.[MAX_RESOURCE_INSTANCES],
        clu.[IMPORT_SUPPORTED],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] clu ON clu.CLUSTER_RESOURCE_TYPE_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TE_ADM_CLUSTER_RESOURCE_TYPE';
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_TYPE_GC]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_TYPE_GC]
	TO [portal_database_configuration_read_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_TYPE_GC]
	TO [portal_database_configuration_role]
GO
