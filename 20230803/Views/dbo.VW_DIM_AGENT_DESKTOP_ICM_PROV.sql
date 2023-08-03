SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_DESKTOP_ICM_PROV]
AS
SELECT  ad.CLUSTER_RESOURCE_ID,
        ad.MODIFIED_DATE,
        ad.ITEM_BIZ_URN AS AGENT_DESKTOP_BUSINESS_URN,
        ad.PKEY1 AS AGENT_DESKTOP_ID,
        ad.PKEY_MAP_URN,
        ad.PKEY_CHANGE_STAMP,
        CASE WHEN ad.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ad.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE ad.STATUS
        END AS STATUS,
        CASE WHEN ad.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ad.PKEY_EFFECTIVE_TO THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(ad.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        ad.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        ad.AVAILABLE_AFTER_INCOMING,
        ad.AVAILABLE_AFTER_OUTGOING,
        ad.WRAPUP_DATA_INCOMING_MODE,
        ad.WRAPUP_DATA_OUTGOING_MODE,
        ad.AUTO_ANSWER_ENABLED,
        ad.IDLE_REASON_REQUIRED,
        ad.LOGOUT_NON_ACTIVITY_TIME,
        ad.LOGOUT_REASON_REQUIRED,
        ad.SUPERVISOR_CALLS_ALLOWED,
        ad.SUPERVISOR_ASSIST_CALL_METHOD,
        ad.EMERGENCY_CALL_METHOD,
        CAST(ad.AUTO_RECORD_ON_EMERGENCY AS INT) AS AUTO_RECORD_ON_EMERGENCY,
        ad.AGENT_TO_AGENT_CALLS_ALLOWED,
        ad.OUTBOUND_ACCESS_INTERNATIONAL,
        ad.OUTBOUND_ACCESS_PUBLIC_NETWORK,
        ad.OUTBOUND_ACCESS_PRIVATE_NETWORK,
        ad.OUTBOUND_ACCESS_OPERATOR_ASSISTED,
        ad.OUTBOUND_ACCESS_PBX,
        ad.NON_ACD_CALLS_ALLOWED,
        ad.QUALITY_RECORDING_RATE,
        ad.RECORDING_MODE,
        ad.REMOTE_AGENT_TYPE,
        ad.REMOTE_LOGIN_WITHOUT_DESKTOP,
        ad.WORK_MODE_TIMER,
        ad.RING_NO_ANSWER_TIME,
        CAST(ad.SILENT_MONITOR_WARNING_MESSAGE AS INT) AS SILENT_MONITOR_WARNING_MESSAGE,
        CAST(ad.SILENT_MONITOR_AUDIBLE_INDICATION AS INT) AS SILENT_MONITOR_AUDIBLE_INDICATION,
        ad.DEFAULT_DEVICE_PORT_ADDRESS,
        ad.AGENT_CAN_SELECT_GROUP,
        ad.ACD_SHARED_LINE_USAGE,
        ad.PLAY_ZIP_TONE,
        ad.DESCRIPTION,
        ad.INTERNAL_NAME
FROM    VW_DIM_AGENT_DESKTOP_PKEY ad
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = ad.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = ad.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            ad.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN ad.PKEY_EFFECTIVE_FROM
                               AND     ad.PKEY_EFFECTIVE_TO )
          )
          OR ( ad.STATUS = 'P' )
          OR (
               ad.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ad.PKEY_EFFECTIVE_TO
             )
        )
        AND ad.LATEST = 1
        AND ad.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_DESKTOP_ICM_PROV]
	TO [portalapp_role]
GO
