SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_CODE_GROUP]
WITH SCHEMABINDING
AS
    SELECT it.[ITEM_URN],
           it.[ITEM_BIZ_URN],
           CAST('00010550-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
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
           it.[INTERNAL_NAME],
           it.[CODE_CONSTRAINT_TYPE_ID],
           it.[CONSTRAINT_DEFINITION],
           it.[CONSTRAINT_MIN_VALUE],
           it.[CONSTRAINT_MAX_VALUE],
           it.[DEFAULT_VALUE],
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
    FROM [dbo].[TB_DIM_CODE_GROUP] it
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CODE_GROUP]
	TO [portalapp_role]
GO
