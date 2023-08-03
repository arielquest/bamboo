SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_FISCAL_QUARTER_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        dimFiscalQuarter.[FISCAL_YEAR_URN],
        dimFiscalQuarter.[QUARTER_NO],
        dimFiscalQuarter.[QUARTER_TEXT],
        dimFiscalQuarter.[START_DATE_TIME],
        dimFiscalQuarter.[END_DATE_TIME],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_DIM_FISCAL_QUARTER] dimFiscalQuarter ON dimFiscalQuarter.FISCAL_QUARTER_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_DIM_FISCAL_QUARTER';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_FISCAL_QUARTER_GC]
	TO [portalapp_role]
GO
