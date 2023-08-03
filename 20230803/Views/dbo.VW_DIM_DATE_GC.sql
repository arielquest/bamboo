SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DATE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        dimDate.[STD_WEEK_ID],
        dimDate.[STD_MONTH_ID],
        dimDate.[FISCAL_YEAR_URN],
        dimDate.[FISCAL_QUARTER_URN],
        dimDate.[FISCAL_MONTH_URN],
        dimDate.[FISCAL_WEEK_URN],
        dimDate.[YEAR],
        dimDate.[MONTH],
        dimDate.[DAY],
        dimDate.[NAME],
        dimDate.[INTERNAL_NAME],
        dimDate.[HOLIDAY],
        dimDate.[DATE_VALUE],
        dimDate.[DATE_FORMULA],
        dimDate.[DATE_OPTIONS],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_DIM_DATE] dimDate ON dimDate.DATE_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_DIM_DATE';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DATE_GC]
	TO [portalapp_role]
GO
