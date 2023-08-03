SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_CAMPAIGN_PKEY_MAP_GC]
AS
   SELECT 
        datagc.[PKEY_MAP_URN] AS [RESOURCE_ID],
        pkey.[ITEM_BIZ_URN] AS [CHILD_RESOURCE_ID],
        pkey.[CLUSTER_RESOURCE_ID] AS [PARENT_RESOURCE_ID],
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID], -- IT_CLUSTER_RESOURCE
        CAST('00001600-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [CHILD_RESOURCE_TYPE_ID],
        pkey.[STATUS],
        pkey.[CHANGE_STAMP],
        pkey.[PKEY1],
        pkey.[PKEY2],
        pkey.[EFFECTIVE_FROM],
        pkey.[EFFECTIVE_TO],
        pkey.[INTERNAL_NAME],
        pkey.[DESCRIPTION],
        pkey.[ABANDON_ENABLED],
        pkey.[ABANDON_PERCENT],
        pkey.[NO_ANSWER_CALLBACK],
        pkey.[BUSY_CALLBACK],
        pkey.[NO_ANSWER_RING_LIMIT],
        pkey.[MAXIMUM_LINE_AGENT],
        pkey.[LINES_PER_AGENT],
        pkey.[LEAVE_MESSAGE_ENABLED],
        pkey.[MAXIMUM_ATTEMPTS],
        pkey.[WORK_START_HOURS],
        pkey.[WORK_START_MINUTES],
        pkey.[WORK_END_HOURS],
        pkey.[WORK_END_MINUTES],
        pkey.[HOME_START_HOURS],
        pkey.[HOME_START_MINUTES],
        pkey.[HOME_END_HOURS],
        pkey.[HOME_END_MINUTES],
        pkey.[HOME_ENABLED],
        pkey.[WORK_ENABLED],
        pkey.[BUSY_RETRY_ENABLED],
        pkey.[MAXIMUM_BUSY_ATTEMPTS],
        pkey.[ANSWER_DETECT_ENABLED],
        pkey.[CALLBACK_TIME_LIMIT],
        pkey.[MINIMUM_CALL_DURATION],
        pkey.[EXHAUSTED_CALLS_ENABLED],
        pkey.[EDGE_DETECT_ENABLED],
        pkey.[QUICK_DETECT_ENABLED],
        pkey.[SP_CLOSED_RECORD_ENABLED],
        pkey.[SP_CLOSED_RECORD_COUNT],
        pkey.[PERSONALIZED_CALLBACK_ENABLED],
        pkey.[RELEASE_CALLBACK_ENABLED],
        pkey.[RESCHEDULE_CALLBACK_MODE],
        pkey.[IP_TERMINATING_BEEP_DETECT],
        pkey.[CAMPAIGN_PURPOSE_TYPE],
        pkey.[IPAMD_ENABLED],
        pkey.[AMD_TREATMENT_MODE],
        pkey.[USE_GMT_FROM_REGION_PREFIX],
        pkey.[CONFIG_PARAM],
        pkey.[ABANDON_CUSTOMER_CALLBACK],
        pkey.[ABANDONED_DIALER_CALLBACK],
        pkey.[CUSTOMER_NOT_HOME_CALLBACK],
        pkey.[ANSWERING_MACHINE_CALLBACK],
        pkey.[PREFIX_DIGITS],
        pkey.[WAIT_FOR_BUSY_RETRY],
        pkey.[DISABLE_CPA],
        pkey.[DST_LOCATION],
        pkey.[ICM_ENABLED],
        
        pkey.[MODIFIED_DATE],
        pkey.[MODIFIED_BY_ID],
        pkey.[CREATION_DATE],
        pkey.[CREATED_BY_ID],
        pkey.[PURGED],
        pkey.[SYSTEM],
        pkey.[LATEST],
        pkey.[XML_DATA],
        pkey.[CUSTOM_XML_DATA],        
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]

    FROM [dbo].[TS_DIM_CAMPAIGN_PKEY_MAP_GC] datagc
    
    LEFT JOIN [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] pkey
    ON pkey.PKEY_MAP_URN = datagc.PKEY_MAP_URN;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CAMPAIGN_PKEY_MAP_GC]
	TO [portalapp_role]
GO
