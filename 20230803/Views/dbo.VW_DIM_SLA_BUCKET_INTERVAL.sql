SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_SLA_BUCKET_INTERVAL]
WITH SCHEMABINDING
AS
    SELECT it.[ITEM_URN],
           it.[ITEM_BIZ_URN],
           CAST('2be66c38-5592-4dba-bc11-81d3395163b0' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
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
           it.[ACTIVITY_TYPE_CODE_BIZ_URN],
           it.[INTERVAL_UPPER_BOUND_1],
           it.[INTERVAL_UPPER_BOUND_2],
           it.[INTERVAL_UPPER_BOUND_3],
           it.[INTERVAL_UPPER_BOUND_4],
           it.[INTERVAL_UPPER_BOUND_5],
           it.[INTERVAL_UPPER_BOUND_6],
           it.[INTERVAL_UPPER_BOUND_7],
           it.[INTERVAL_UPPER_BOUND_8],
           it.[INTERVAL_UPPER_BOUND_9],
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
    FROM [dbo].[TB_DIM_SLA_BUCKET_INTERVAL] it
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SLA_BUCKET_INTERVAL]
	TO [portalapp_role]
GO
