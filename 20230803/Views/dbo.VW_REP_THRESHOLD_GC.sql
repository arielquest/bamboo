SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_THRESHOLD_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        threshold.[REPORT_ID],
        threshold.[NAME],
        threshold.[ATTRIBUTE_ID],
        threshold.[DATA_TYPE],
        threshold.[META_TYPE],
        threshold.[THRESHOLD_TYPE],
        threshold.[RELATION_1],
        threshold.[LOW_VALUE_1],
        threshold.[HIGH_VALUE_1],
        threshold.[STYLE_BOLD_1],
        threshold.[STYLE_UNDERLINE_1],
        threshold.[STYLE_ITALIC_1],
        threshold.[STYLE_FORE_COLOR_1],
        threshold.[STYLE_BACK_COLOR_1],
        threshold.[RELATION_2],
        threshold.[LOW_VALUE_2],
        threshold.[HIGH_VALUE_2],
        threshold.[STYLE_BOLD_2],
        threshold.[STYLE_UNDERLINE_2],
        threshold.[STYLE_ITALIC_2],
        threshold.[STYLE_FORE_COLOR_2],
        threshold.[STYLE_BACK_COLOR_2],
        threshold.[RELATION_3],
        threshold.[LOW_VALUE_3],
        threshold.[HIGH_VALUE_3],
        threshold.[STYLE_BOLD_3],
        threshold.[STYLE_UNDERLINE_3],
        threshold.[STYLE_ITALIC_3],
        threshold.[STYLE_FORE_COLOR_3],
        threshold.[STYLE_BACK_COLOR_3],
        threshold.[RELATION_4],
        threshold.[LOW_VALUE_4],
        threshold.[HIGH_VALUE_4],
        threshold.[STYLE_BOLD_4],
        threshold.[STYLE_UNDERLINE_4],
        threshold.[STYLE_ITALIC_4],
        threshold.[STYLE_FORE_COLOR_4],
        threshold.[STYLE_BACK_COLOR_4],
        threshold.[RELATION_5],
        threshold.[LOW_VALUE_5],
        threshold.[HIGH_VALUE_5],
        threshold.[STYLE_BOLD_5],
        threshold.[STYLE_UNDERLINE_5],
        threshold.[STYLE_ITALIC_5],
        threshold.[STYLE_FORE_COLOR_5],
        threshold.[STYLE_BACK_COLOR_5],
        threshold.[ARCHIVED],
        threshold.[DELETED],
        threshold.[ENABLED],
        threshold.[HIDDEN],
        threshold.[SYSTEM],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_REP_THRESHOLD] threshold ON threshold.THRESHOLD_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_THRESHOLD';
GO
GRANT SELECT
	ON [dbo].[VW_REP_THRESHOLD_GC]
	TO [portalapp_role]
GO
