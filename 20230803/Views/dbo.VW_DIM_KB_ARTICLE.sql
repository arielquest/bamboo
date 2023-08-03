SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_KB_ARTICLE]
WITH SCHEMABINDING
AS
    SELECT it.[ITEM_URN],
           it.[ITEM_BIZ_URN],
           CAST('e349b610-402f-4a1a-b555-ba26abdc6f30' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
           it.[ITEM_SUBTYPE_ID],
           it.[OWNER_ID],
           it.[FOLDER_ID],
           fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
           fl.[FOLDER_TYPE],
           fl.[DEPTH] AS [FOLDER_DEPTH],
           fl.[NAME] AS [FOLDER_NAME],
           fl.[PATH] AS [FOLDER_PATH],
           fl.[FOLDER_URN],
           it.[NAME],
           it.[DESCRIPTION],            
           it.[ARTICLE_CREATION_CULTURE_URN],
           it.[ARTICLE_COMMIT_STATE],
           it.[ARTICLE_PUBLISH_STATE],
           it.[ARTICLE_OWNER_AGENT_BIZ_URN],
           it.[ARTICLE_CREATED_BY_AGENT_BIZ_URN],
           it.[ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN],
           it.[ARTICLE_CREATION_DATE_TIME],
           it.[ARTICLE_LAST_MODIFIED_DATE_TIME],
           it.[ARTICLE_VERSION],
           it.[ARTICLE_AVAILABLE_FROM],
           it.[ARTICLE_EXPIRES_ON],
           it.[KB_FOLDER_BIZ_URN],
           it.[EFFECTIVE_FROM],
           it.[EFFECTIVE_TO],    
           it.[TIME_ZONE_URN],
           it.[TENANT_BIZ_URN],
           it.[HIERARCHY_PARENT_URN],
           it.[SKIP_LEVEL],
           it.[DELETED],
           it.[HIDDEN],
           it.[SYSTEM],
           it.[LATEST],
           it.[CHANGE_STAMP]
    FROM [dbo].[TB_DIM_KB_ARTICLE] it
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ARTICLE]
	TO [portalapp_role]
GO
