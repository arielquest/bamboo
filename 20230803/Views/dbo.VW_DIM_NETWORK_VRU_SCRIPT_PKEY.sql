SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_NETWORK_VRU_SCRIPT_PKEY]
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
           CAST('aaf3357b-5222-416d-887f-2e6678c73910' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
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
           pk.[VRU_SCRIPT_NAME],
           pk.[INTERRUPTIBLE],
           pk.[OVERRIDABLE],
           pk.[CONFIG_PARAM],
           pk.[TIMEOUT],
           di.[DEPARTMENT_BIZ_URN],
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
    FROM [dbo].[TB_DIM_NETWORK_VRU_SCRIPT] di
    JOIN [dbo].[TB_DIM_NETWORK_VRU_SCRIPT_PKEY_MAP] pk ON di.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN]
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = di.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NETWORK_VRU_SCRIPT_PKEY]
	TO [portalapp_role]
GO
