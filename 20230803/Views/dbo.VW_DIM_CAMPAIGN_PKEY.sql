SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_CAMPAIGN_PKEY]
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
           CAST('00001600-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
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
           pk.[ABANDON_ENABLED],
           pk.[ABANDON_PERCENT],
           pk.[NO_ANSWER_CALLBACK],
           pk.[BUSY_CALLBACK],
           pk.[NO_ANSWER_RING_LIMIT],
           pk.[MAXIMUM_LINE_AGENT],
           pk.[LINES_PER_AGENT],
           pk.[LEAVE_MESSAGE_ENABLED],
           pk.[MAXIMUM_ATTEMPTS],
           pk.[WORK_START_HOURS],
           pk.[WORK_START_MINUTES],
           pk.[WORK_END_HOURS],
           pk.[WORK_END_MINUTES],
           pk.[HOME_START_HOURS],
           pk.[HOME_START_MINUTES],
           pk.[HOME_END_HOURS],
           pk.[HOME_END_MINUTES],
           pk.[HOME_ENABLED],
           pk.[WORK_ENABLED],
           pk.[BUSY_RETRY_ENABLED],
           pk.[MAXIMUM_BUSY_ATTEMPTS],
           pk.[ANSWER_DETECT_ENABLED],
           pk.[CALLBACK_TIME_LIMIT],
           pk.[MINIMUM_CALL_DURATION],
           pk.[EXHAUSTED_CALLS_ENABLED],
           pk.[EDGE_DETECT_ENABLED],
           pk.[QUICK_DETECT_ENABLED],
           pk.[SP_CLOSED_RECORD_ENABLED],
           pk.[SP_CLOSED_RECORD_COUNT],
           pk.[PERSONALIZED_CALLBACK_ENABLED],
           pk.[RELEASE_CALLBACK_ENABLED],
           pk.[RESCHEDULE_CALLBACK_MODE],
           pk.[IP_TERMINATING_BEEP_DETECT],
           pk.[CAMPAIGN_PURPOSE_TYPE],
           pk.[IPAMD_ENABLED],
           pk.[AMD_TREATMENT_MODE],
           pk.[USE_GMT_FROM_REGION_PREFIX],
           pk.[CONFIG_PARAM],
           pk.[ABANDON_CUSTOMER_CALLBACK],
           pk.[ABANDONED_DIALER_CALLBACK],
           pk.[CUSTOMER_NOT_HOME_CALLBACK],
           pk.[ANSWERING_MACHINE_CALLBACK],
           pk.[PREFIX_DIGITS],
           pk.[WAIT_FOR_BUSY_RETRY],
           pk.[DISABLE_CPA],
           pk.[DST_LOCATION],
           pk.[ICM_ENABLED],
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
    FROM [dbo].[TB_DIM_CAMPAIGN] di
    JOIN [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] pk ON di.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN]
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = di.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CAMPAIGN_PKEY]
	TO [portalapp_role]
GO
