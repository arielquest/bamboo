SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_REPORT_CHART_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        report.[REPORT_CHART_ID],
        report.[REPORT_ID],
        report.[NAME],
        report.[REPORT_CHART_JSON],
        report.[DELETED],
        report.[SYSTEM],
        report.[CREATED_BY_ID],
        report.[MODIFIED_BY_ID],
        report.[CREATION_DATE],
        report.[MODIFIED_DATE],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_REP_REPORT_CHART] report ON report.REPORT_CHART_ID = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_REPORT_CHART';
GO
GRANT SELECT
	ON [dbo].[VW_REP_REPORT_CHART_GC]
	TO [portalapp_role]
GO
