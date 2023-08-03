SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_AGENT_DESKTOP_PKEY_MAP_GC]
AS
   SELECT 
        datagc.[PKEY_MAP_URN] AS [RESOURCE_ID],
        pkey.[ITEM_BIZ_URN] AS [CHILD_RESOURCE_ID],
        pkey.[CLUSTER_RESOURCE_ID] AS [PARENT_RESOURCE_ID],
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID], -- IT_CLUSTER_RESOURCE
        CAST('00009100-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [CHILD_RESOURCE_TYPE_ID],
        pkey.[STATUS],
        pkey.[CHANGE_STAMP],
        pkey.[PKEY1],
        pkey.[PKEY2],
        pkey.[EFFECTIVE_FROM],
        pkey.[EFFECTIVE_TO],
        pkey.[INTERNAL_NAME],
        pkey.[DESCRIPTION],
        pkey.[AVAILABLE_AFTER_INCOMING],
        pkey.[AVAILABLE_AFTER_OUTGOING],
        pkey.[WRAPUP_DATA_INCOMING_MODE],
        pkey.[WRAPUP_DATA_OUTGOING_MODE],
        pkey.[AUTO_ANSWER_ENABLED],
        pkey.[IDLE_REASON_REQUIRED],
        pkey.[LOGOUT_NON_ACTIVITY_TIME],
        pkey.[LOGOUT_REASON_REQUIRED],
        pkey.[SUPERVISOR_CALLS_ALLOWED],
        pkey.[SUPERVISOR_ASSIST_CALL_METHOD],
        pkey.[EMERGENCY_CALL_METHOD],
        pkey.[AUTO_RECORD_ON_EMERGENCY],
        pkey.[AGENT_TO_AGENT_CALLS_ALLOWED],
        pkey.[OUTBOUND_ACCESS_INTERNATIONAL],
        pkey.[OUTBOUND_ACCESS_PUBLIC_NETWORK],
        pkey.[OUTBOUND_ACCESS_PRIVATE_NETWORK],
        pkey.[OUTBOUND_ACCESS_OPERATOR_ASSISTED],
        pkey.[OUTBOUND_ACCESS_PBX],
        pkey.[NON_ACD_CALLS_ALLOWED],
        pkey.[QUALITY_RECORDING_RATE],
        pkey.[RECORDING_MODE],
        pkey.[WORK_MODE_TIMER],
        pkey.[RING_NO_ANSWER_TIME],
        pkey.[SILENT_MONITOR_WARNING_MESSAGE],
        pkey.[SILENT_MONITOR_AUDIBLE_INDICATION],
        pkey.[DEFAULT_DEVICE_PORT_ADDRESS],
        pkey.[AGENT_CAN_SELECT_GROUP],
        pkey.[REMOTE_AGENT_TYPE],
        pkey.[REMOTE_LOGIN_WITHOUT_DESKTOP],
        pkey.[PLAY_ZIP_TONE],
        pkey.[ACD_SHARED_LINE_USAGE],
        
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

    FROM [dbo].[TS_DIM_AGENT_DESKTOP_PKEY_MAP_GC] datagc
    
    LEFT JOIN [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] pkey
    ON pkey.PKEY_MAP_URN = datagc.PKEY_MAP_URN;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_DESKTOP_PKEY_MAP_GC]
	TO [portalapp_role]
GO
