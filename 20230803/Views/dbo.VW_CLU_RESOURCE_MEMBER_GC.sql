SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_RESOURCE_MEMBER_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        clu.[PARENT_RESOURCE_ID],
        clu.[CHILD_RESOURCE_ID],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION],
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS CHILD_RESOURCE_TYPE_ID, -- IT_CLUSTER_RESOURCE
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS PARENT_RESOURCE_TYPE_ID -- IT_CLUSTER_RESOURCE
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_CLU_RESOURCE_MEMBER] clu ON clu.RESOURCE_MEMBER_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_CLU_RESOURCE_MEMBER';
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_MEMBER_GC]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_MEMBER_GC]
	TO [portal_database_configuration_read_role]
GO
GRANT SELECT
	ON [dbo].[VW_CLU_RESOURCE_MEMBER_GC]
	TO [portal_database_configuration_role]
GO
