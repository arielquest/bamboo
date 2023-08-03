SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CATEGORY_MAP_GC]
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        member.[CATEGORY_BIZ_URN] AS PARENT_RESOURCE_ID,
        member.[ITEM_BIZ_URN] AS CHILD_RESOURCE_ID,
        CAST('00001700-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID], -- IT_CATEGORY
        childItemType.[ITEM_TYPE_ID] AS [CHILD_RESOURCE_TYPE_ID],
        member.[PRIORITY],
        member.[RELATIONSHIP],
        member.[EFFECTIVE_FROM],
        member.[EFFECTIVE_TO],
        member.[CREATED_BY_ID],
        member.[MODIFIED_BY_ID],
        member.[CREATION_DATE],
        member.[MODIFIED_DATE],
        member.[DELETED],
        member.[ENABLED],
        member.[HIDDEN],
        member.[SYSTEM],
        member.[CHANGE_STAMP],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_DIM_CATEGORY_MAP] member ON member.CATEGORY_MAP_URN = datagc.INT_KEY
LEFT JOIN [dbo].[TE_DIM_ITEM_TYPE] childItemType ON member.ITEM_TYPE_URN = childItemType.ITEM_TYPE_URN
WHERE   tablegc.TABLE_NAME = 'TB_DIM_CATEGORY_MAP'
        AND datagc.[INT_KEY] > 0
        AND childItemType.ENABLED = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CATEGORY_MAP_GC]
	TO [portalapp_role]
GO
