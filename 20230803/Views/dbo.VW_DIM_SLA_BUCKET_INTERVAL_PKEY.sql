SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_SLA_BUCKET_INTERVAL_PKEY]
WITH SCHEMABINDING
AS
    SELECT di.[ITEM_URN],
           di.[ITEM_BIZ_URN],
           di.[FOLDER_ID],
           fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
           fl.[FOLDER_TYPE],
           fl.[DEPTH] AS [FOLDER_DEPTH],
           fl.[NAME] AS [FOLDER_NAME],
           fl.[PATH] AS [FOLDER_PATH],
           fl.[FOLDER_URN],
           di.[OWNER_ID],
           CAST('2be66c38-5592-4dba-bc11-81d3395163b0' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
           di.[ITEM_SUBTYPE_ID],
           di.[NAME],    
           di.[DESCRIPTION] AS [BASE_DESCRIPTION],           
           di.[EFFECTIVE_FROM],
           di.[EFFECTIVE_TO],
           di.[XML_DATA],
           pk.[EFFECTIVE_FROM] AS [PKEY_EFFECTIVE_FROM],
           pk.[EFFECTIVE_TO] AS [PKEY_EFFECTIVE_TO],          
           pk.[INTERNAL_NAME],
           pk.[DESCRIPTION],
           di.[ACTIVITY_TYPE_CODE_BIZ_URN],
           di.[INTERVAL_UPPER_BOUND_1],
           di.[INTERVAL_UPPER_BOUND_2],
           di.[INTERVAL_UPPER_BOUND_3],
           di.[INTERVAL_UPPER_BOUND_4],
           di.[INTERVAL_UPPER_BOUND_5],
           di.[INTERVAL_UPPER_BOUND_6],
           di.[INTERVAL_UPPER_BOUND_7],
           di.[INTERVAL_UPPER_BOUND_8],
           di.[INTERVAL_UPPER_BOUND_9],
           di.[TIME_ZONE_URN],
           di.[TENANT_BIZ_URN],
           di.[HIERARCHY_PARENT_URN],
           di.[DELETED],
           di.[HIDDEN],
           di.[SYSTEM],
           di.[LATEST],
           di.[CHANGE_STAMP] AS [BASE_CHANGE_STAMP],
           pk.[PKEY_MAP_URN],
           pk.[CLUSTER_RESOURCE_ID],
           pk.[STATUS],
           pk.[PKEY1],
           pk.[PKEY2], 
           pk.[SOURCE_CHANGE_STAMP],
           pk.[PURGED],
           pk.[LATEST] AS [PKEY_LATEST],
           pk.[MODIFIED_DATE],
           pk.[CHANGE_STAMP] AS [PKEY_CHANGE_STAMP],
           pk.[XML_DATA] AS [PKEY_XML_DATA]
    FROM [dbo].[TB_DIM_SLA_BUCKET_INTERVAL] di
    JOIN [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_PKEY_MAP] pk ON di.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN]
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = di.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SLA_BUCKET_INTERVAL_PKEY]
	TO [portalapp_role]
GO
