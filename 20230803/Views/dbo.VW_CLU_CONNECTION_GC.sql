SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_CONNECTION_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[CONNECTION_ID] AS RESOURCE_ID,
        clu.[SOURCE_COMPONENT_ID],
        clu.[SINK_COMPONENT_ID],
        cluStatus.[STATUS],
        cluStatus.[LAST_STATUS_CHANGE],
        cluStatus.[LAST_STATUS_CHECK],
        clu.[COST],
        clu.[OVERRIDE_SINK_SERVER_ADDRESS],
        clu.[ENABLED],
        clu.[SYSTEM],
        clu.[CONNECTION_TYPE_ID],
        clu.[XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_CLU_CONNECTION_GC] datagc
LEFT JOIN [dbo].[TB_CLU_CONNECTION] clu ON clu.CONNECTION_ID = datagc.CONNECTION_ID
LEFT JOIN [dbo].[TB_CLU_CONNECTION_STATUS] cluStatus ON clu.CONNECTION_ID = cluStatus.CONNECTION_ID;
GO
GRANT SELECT
	ON [dbo].[VW_CLU_CONNECTION_GC]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_CONNECTION_GC]
	TO [portal_database_configuration_read_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_CONNECTION_GC]
	TO [portal_database_configuration_role]
GO
