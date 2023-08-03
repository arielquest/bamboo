SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_MEMBER_TYPE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        memberType.[PARENT_ITEM_TYPE_ID],
        memberType.[CHILD_ITEM_TYPE_ID],
        memberType.[MEMBER_TYPE],
        memberType.[NAME],
        memberType.[INTERNAL_NAME],
        memberType.[DESCRIPTION],
        memberType.[TABLE_NAME],
        memberType.[SMALL_ICON],
        memberType.[LARGE_ICON],
        memberType.[ARCHIVED],
        memberType.[DELETED],
        memberType.[ENABLED],
        memberType.[HIDDEN],
        memberType.[SYSTEM],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TE_DIM_MEMBER_TYPE] memberType ON memberType.MEMBER_TYPE_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TE_DIM_MEMBER_TYPE';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_MEMBER_TYPE_GC]
	TO [portalapp_role]
GO
