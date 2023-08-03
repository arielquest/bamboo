SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ITEM_SUBTYPE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        itemSubType.[ITEM_TYPE_ID],
        itemSubType.[NAME],
        itemSubType.[INTERNAL_NAME],
        itemSubType.[DESCRIPTION],
        itemSubType.[DELETED],
        itemSubType.[HIDDEN],
        itemSubType.[SYSTEM],
        itemSubType.[ENABLED],
        itemSubType.[IS_HIERARCHY_FIXED_LEVEL],
        itemSubType.[TOTAL_HIERARCHY_LEVELS],
        itemSubType.[HIERARCHY_MAX_PRECEDENCE],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TE_DIM_ITEM_SUBTYPE] itemSubType ON itemSubType.ITEM_SUBTYPE_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TE_DIM_ITEM_SUBTYPE';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ITEM_SUBTYPE_GC]
	TO [portalapp_role]
GO
