SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_KB_ARTICLE_GC]
AS
    SELECT 
        datagc.[ITEM_URN] AS [RESOURCE_ID], 
        item.[ITEM_BIZ_URN],
        item.[TIME_ZONE_URN],
        item.[TENANT_BIZ_URN],
        item.[HIERARCHY_PARENT_URN],
        item.[FOLDER_ID] AS CONTAINER_ID,
        item.[OWNER_ID],    
        item.[ITEM_SUBTYPE_ID],
        item.[NAME],
        item.[DESCRIPTION],
        item.[EFFECTIVE_FROM],
        item.[EFFECTIVE_TO],        
        item.[ARTICLE_CREATION_CULTURE_URN],
        item.[ARTICLE_COMMIT_STATE],
        item.[ARTICLE_PUBLISH_STATE],
        item.[ARTICLE_OWNER_AGENT_BIZ_URN],
        item.[ARTICLE_CREATED_BY_AGENT_BIZ_URN],
        item.[ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN],
        item.[ARTICLE_CREATION_DATE_TIME],
        item.[ARTICLE_LAST_MODIFIED_DATE_TIME],
        item.[ARTICLE_VERSION],
        item.[ARTICLE_AVAILABLE_FROM],
        item.[ARTICLE_EXPIRES_ON],
        item.[KB_FOLDER_BIZ_URN],
        item.[MODIFIED_DATE],
        item.[MODIFIED_BY_ID],
        item.[CREATION_DATE],
        item.[CREATED_BY_ID],
        item.[DELETED],
        item.[HIDDEN],
        item.[SYSTEM],
        item.[LATEST],
        item.[CHANGE_STAMP],
        item.[XML_DATA],
        item.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
        
    FROM [dbo].[TS_DIM_KB_ARTICLE_GC] datagc 
        
    LEFT JOIN [dbo].[TB_DIM_KB_ARTICLE] item
    ON item.ITEM_URN = datagc.ITEM_URN

    WHERE datagc.[ITEM_URN] > 0;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ARTICLE_GC]
	TO [portalapp_role]
GO
