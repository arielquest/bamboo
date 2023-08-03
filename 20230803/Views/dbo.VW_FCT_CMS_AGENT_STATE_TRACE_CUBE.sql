SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CMS_AGENT_STATE_TRACE_CUBE]
AS
SELECT  [PARTITION_URN],
        [PARTITION_GLOBAL_URN],
        [PARTITION_ID],
        [AGENT_URN],
        [ACD_URN],
        [SKILLGROUP_URN],
        [LOGOUT_REASONCODE_URN],
        [CLUSTER_RESOURCE_URN],
        [DIGITS_DIALED_URN],
        [LOC_ID_URN],
        x.[DATE_UTC_URN],
        x.[TIME_UTC_URN],
        tzd.[OLAP_DATETIME_UTC] AS [DATETIME_UTC_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_0] AS [TIME_ZONE_0_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_1] AS [TIME_ZONE_1_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_2] AS [TIME_ZONE_2_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_3] AS [TIME_ZONE_3_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_4] AS [TIME_ZONE_4_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_5] AS [TIME_ZONE_5_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_6] AS [TIME_ZONE_6_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_7] AS [TIME_ZONE_7_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_8] AS [TIME_ZONE_8_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_9] AS [TIME_ZONE_9_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_10] AS [TIME_ZONE_10_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_11] AS [TIME_ZONE_11_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_12] AS [TIME_ZONE_12_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_13] AS [TIME_ZONE_13_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_14] AS [TIME_ZONE_14_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_15] AS [TIME_ZONE_15_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_16] AS [TIME_ZONE_16_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_17] AS [TIME_ZONE_17_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_18] AS [TIME_ZONE_18_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_19] AS [TIME_ZONE_19_URN],
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
        CAST(CASE LOWER(CALLER_HOLD)
               WHEN 'y' THEN 1
               ELSE 0
             END AS BIGINT) AS [caller_Hold],
        CAST(CASE LOWER(CONFERENCE)
               WHEN 'y' THEN 1
               ELSE 0
             END AS BIGINT) AS [Conference],
        CAST(DURATION AS BIGINT) AS [Duration],
        CAST(EVENT_TIME AS BIGINT) AS [Event_Time],
        CAST(CASE LOWER(INTERRUPTED)
               WHEN 'y' THEN 1
               ELSE 0
             END AS BIGINT) AS [Interrupted],
        CAST(CASE LOWER(RECONNECT)
               WHEN 'y' THEN 1
               ELSE 0
             END AS BIGINT) AS [Reconnect],
        CAST(CASE LOWER(TRANSFERRED)
               WHEN 'y' THEN 1
               ELSE 0
             END AS BIGINT) AS [Transferred],
        [Row Count] AS [Row Count]
FROM    [dbo].[VW_FCT_CMS_AGENT_STATE_TRACE] x
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] t ON x.[TIME_UTC_URN] = t.[TIME_URN]
JOIN    [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                             AND tzd.[TIME_UTC_URN] = t.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CMS_AGENT_STATE_TRACE_CUBE]
	TO [portalapp_role]
GO
