SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_REPORT_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        report.[REPORT_MODEL_ID],
        report.[LINKED_REPORT_ID],
        report.[FOLDER_ID] AS CONTAINER_ID,
        report.[CONTENT_PATH],
        report.[TIME_DIVISION],
        report.[FORMAT],
        report.[BASE_NAME],
        report.[NAME],
        report.[REPORT_QUESTION],
        report.[DESCRIPTION],
        report.[HELP_TEXT],
        report.[CREATED_BY_ID],
        report.[MODIFIED_BY_ID],
        report.[CREATION_DATE],
        report.[MODIFIED_DATE],
        report.[IS_CHART],
        report.[IS_VERTICAL],
        report.[FORCE_SYNC],
        report.[USE_MDX_BY_DEFAULT],
        report.[DRILLTHROUGH_LINK_TYPE_1],
        report.[DRILLTHROUGH_LINK_TYPE_2],
        report.[DRILLTHROUGH_LINK_TYPE_3],
        report.[ARCHIVED],
        report.[DELETED],
        report.[ENABLED],
        report.[HIDDEN],
        report.[SYSTEM],
        report.[TEMPLATE],
        report.[IS_DESIGNABLE],
        report.[REFRESH_TYPE],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_REP_REPORT] report ON report.REPORT_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_REPORT';
GO
GRANT SELECT
	ON [dbo].[VW_REP_REPORT_GC]
	TO [portalapp_role]
GO
