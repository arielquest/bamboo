SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_SCL_ADAPTER]
WITH SCHEMABINDING
AS
    SELECT it.[ITEM_URN],
           it.[ITEM_BIZ_URN],
           CAST('9ce7c8c9-76f1-4ffc-b809-861517f609f2' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
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
           it.[ADAPTER_TYPE_CODE_BIZ_URN],
           it.[ADAPTER_TYPE_SUB_CODE_BIZ_URN],
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
    FROM [dbo].[TB_DIM_SCL_ADAPTER] it
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SCL_ADAPTER]
	TO [portalapp_role]
GO
