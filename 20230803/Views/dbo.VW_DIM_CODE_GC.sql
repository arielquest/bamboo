SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CODE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[ITEM_URN] AS [RESOURCE_ID],
        item.[ITEM_BIZ_URN],
        item.[TIME_ZONE_URN],
        item.[HIERARCHY_PARENT_URN],
        item.[FOLDER_ID] AS CONTAINER_ID,
        item.[OWNER_ID],
        item.[ITEM_SUBTYPE_ID],
        item.[NAME],
        item.[DESCRIPTION],
        item.[EFFECTIVE_FROM],
        item.[EFFECTIVE_TO],
        item.[INTERNAL_NAME],
        item.[STRING_VAL],
        item.[INT_VAL],
        item.[BIGINT_VAL],
        item.[DATETIME_VAL],
        ISNULL(groupMember.[PARENT_ITEM_BIZ_URN], -1) AS [CODE_GROUP_BUSINESS_URN],
        item.[MODIFIED_DATE],
        item.[DELETED],
        item.[HIDDEN],
        item.[SYSTEM],
        item.[LATEST],
        item.[CHANGE_STAMP],
        item.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_DIM_CODE_GC] datagc
LEFT JOIN [dbo].[TB_DIM_CODE] item ON item.ITEM_URN = datagc.ITEM_URN
LEFT JOIN [dbo].[TB_DIM_CODE_CODE_GROUP_MEMBER] groupMember ON groupMember.CHILD_ITEM_BIZ_URN = item.ITEM_BIZ_URN
                                                              AND groupMember.LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CODE_GC]
	TO [portalapp_role]
GO
