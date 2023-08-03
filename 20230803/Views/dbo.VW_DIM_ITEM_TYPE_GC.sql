SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ITEM_TYPE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        itemType.[NAME],
        itemType.[INTERNAL_NAME],
        itemType.[DESCRIPTION],
        itemType.[VIEW_NAME],
        itemType.[TABLE_NAME],
        itemType.[SMALL_ICON],
        itemType.[LARGE_ICON],
        itemType.[PREFIXED],
        itemType.[PROVISIONABLE],
        itemType.[DELETED],
        itemType.[ENABLED],
        itemType.[HIDDEN],
        itemType.[SYSTEM],        
        itemType.[TAXONOMY_ENABLED],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TE_DIM_ITEM_TYPE] itemType ON itemType.ITEM_TYPE_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TE_DIM_ITEM_TYPE';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ITEM_TYPE_GC]
	TO [portalapp_role]
GO
