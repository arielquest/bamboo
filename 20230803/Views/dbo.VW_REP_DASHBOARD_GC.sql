SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_DASHBOARD_GC]
WITH SCHEMABINDING
AS
SELECT
        --From [dbo].[TS_ADM_DATA_GENERATION_COUNT]
        datagc.[GUID_KEY] AS RESOURCE_ID, 
        --From [dbo].[TB_REP_DASHBOARD]
        dashboard.DASHBOARD_LAYOUT_ID,
        dashboard.FOLDER_ID AS CONTAINER_ID,
        dashboard.NAME,
        dashboard.DESCRIPTION,
        dashboard.CREATED_DATE AS CREATION_DATE,
        dashboard.CREATED_BY_ID,
        dashboard.LAST_MODIFIED_DATE AS MODIFIED_DATE,
        dashboard.LAST_MODIFIED_BY_ID AS MODIFIED_BY_ID,
        dashboard.ENABLED,
        --From [dbo].[TS_ADM_DATA_GENERATION_COUNT]
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_REP_DASHBOARD] dashboard ON dashboard.DASHBOARD_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_DASHBOARD';
GO
GRANT SELECT
	ON [dbo].[VW_REP_DASHBOARD_GC]
	TO [portalapp_role]
GO
