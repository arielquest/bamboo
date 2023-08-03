SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_GC]
AS
    SELECT 
        datagc.[MEMBER_URN] AS [RESOURCE_ID], 
        member.[MEMBER_BIZ_URN],
        member.[PARENT_ITEM_BIZ_URN] AS [PARENT_RESOURCE_ID],
        member.[CHILD_ITEM_BIZ_URN] AS [CHILD_RESOURCE_ID],
        CAST('d82c0660-b9ee-4da4-8b19-2861120ca90a' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID],
        CAST('e349b610-402f-4a1a-b555-ba26abdc6f30' AS UNIQUEIDENTIFIER) AS [CHILD_RESOURCE_TYPE_ID],
        member.[EFFECTIVE_FROM],
        member.[EFFECTIVE_TO],        
        member.[MODIFIED_DATE],
        member.[MODIFIED_BY_ID],
        member.[CREATION_DATE],
        member.[CREATED_BY_ID],
        member.[DELETED],
        member.[HIDDEN],
        member.[SYSTEM],
        member.[LATEST],
        member.[CHANGE_STAMP],
        member.[XML_DATA],
        member.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
        
    FROM [dbo].[TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_GC] datagc 
    
    LEFT JOIN [dbo].[TB_DIM_KB_ARTICLE_KB_TOPIC_MEMBER] member
    ON member.MEMBER_URN = datagc.MEMBER_URN

    WHERE datagc.[MEMBER_URN] > 0;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_GC]
	TO [portalapp_role]
GO
