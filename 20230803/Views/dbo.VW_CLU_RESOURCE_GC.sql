SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_RESOURCE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        crt.[INTERNAL_NAME] AS RESOURCE_TYPE_INTERNAL_NAME,
        clu.[RESOURCE_TYPE_ID],
        clu.[VERSION],
        clu.[NAME],
        clu.[DESCRIPTION],
        clu.[CREATED_DATE] AS CREATION_DATE,
        clu.[DELETED],
        clu.[PROVISIONABLE],
        clu.[SYSTEM],
        clu.[XML_DATA],
        clu.[RESOURCE_URN],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_CLU_RESOURCE] clu ON clu.RESOURCE_ID = datagc.GUID_KEY
LEFT JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] crt ON clu.RESOURCE_TYPE_ID = crt.CLUSTER_RESOURCE_TYPE_ID
WHERE   tablegc.TABLE_NAME = 'TB_CLU_RESOURCE';
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_GC]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_GC]
	TO [portal_database_configuration_read_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_GC]
	TO [portal_database_configuration_role]
GO
