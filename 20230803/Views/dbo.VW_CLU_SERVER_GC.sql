SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_SERVER_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        clu.[SERVER_NAME],
        clu.[DEFAULT_ADDRESS],
        clu.[SYSTEM],
        clu.[XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_CLU_SERVER] clu ON clu.SERVER_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_CLU_SERVER';
GO
GRANT SELECT
	ON [dbo].[VW_CLU_SERVER_GC]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_SERVER_GC]
	TO [portal_database_configuration_read_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_SERVER_GC]
	TO [portal_database_configuration_role]
GO
