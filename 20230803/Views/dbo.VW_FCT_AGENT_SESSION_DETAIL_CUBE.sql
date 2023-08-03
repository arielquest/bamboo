SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_AGENT_SESSION_DETAIL_CUBE]
AS
   SELECT   [PARTITION_URN],
            [CLUSTER_RESOURCE_URN],
            [TENANT_URN],
            [ACTIVITY_TYPE_CODE_URN],
            [AGENT_URN],
            [PERSON_URN],
            [AGENT_TEAM_URN],
            [REASON_CODE_URN],
            [ACTIVITY_SUB_TYPE_CODE_URN],
            [USER_SESSION_KEY],
            [MANAGER_AGENT_URN],
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
            
            CAST([AVAILABILITY_CNTR] AS BIGINT) AS[Availability Counter],
            CAST([AVAILABILITY_DURATION] AS BIGINT) [Availability Duration],
            CAST([LOGIN_CNTR] AS BIGINT) AS[Login Counter],
            CAST([LOGIN_DURATION] AS BIGINT) AS[Login Duration],
            CAST([LOGIN_DURATION_ON_LOGOUT] AS BIGINT) AS[Login Duration on Logout],
            CAST([LOGIN_DURATION_ON_TIMEOUT] AS BIGINT) AS[Login Duration on Timeout],
            CAST([LOGIN_IDLE_TIMEOUT_CNTR] AS BIGINT) AS[Login Idle Timeout Counter],
            CAST([LOGOUT_BY_SYSTEM_TIMEOUT_CNTR] AS BIGINT) AS[Logout by System Timeout Counter],
            CAST([LOGOUT_CNTR] AS BIGINT) AS[Logout Counter],
            CAST([UNAVAILABILITY_CNTR] AS BIGINT) AS[Unavailability Counter],
            
            CAST([UNAVAILABLE_DURATION_CHAT] AS BIGINT) AS[Unavailable Duration Chat],
            CAST([UNAVAILABLE_DURATION_VCHAT] AS BIGINT) AS[Unavailable Duration Video Chat],
            CAST([UNAVAILABLE_DURATION_EMAIL] AS BIGINT) AS[Unavailable Duration Email],
            CAST([UNAVAILABLE_DURATION_TASK] AS BIGINT) AS[Unavailable Duration Task],
            CAST([UNAVAILABLE_DURATION_SOCIAL] AS BIGINT) AS[Unavailable Duration Social],
            CAST([UNAVAILABLE_DURATION_CALLTRACK] AS BIGINT) AS[Unavailable Duration Calltrack],
                        
            [PARTITION_ID],
            [Row Count],
       
            -- Custom Dimension columns
            [CUSTOM_DIMENSION_0] AS [CUSTOM_DIMENSION_0],
            [CUSTOM_DIMENSION_1] AS [CUSTOM_DIMENSION_1],
            [CUSTOM_DIMENSION_2] AS [CUSTOM_DIMENSION_2],
            [CUSTOM_DIMENSION_3] AS [CUSTOM_DIMENSION_3],
            [CUSTOM_DIMENSION_4] AS [CUSTOM_DIMENSION_4],
            [CUSTOM_DIMENSION_5] AS [CUSTOM_DIMENSION_5],
            [CUSTOM_DIMENSION_6] AS [CUSTOM_DIMENSION_6],
            [CUSTOM_DIMENSION_7] AS [CUSTOM_DIMENSION_7],
            [CUSTOM_DIMENSION_8] AS [CUSTOM_DIMENSION_8],
            [CUSTOM_DIMENSION_9] AS [CUSTOM_DIMENSION_9],
            CAST([CUSTOM_MEASURE_0] AS BIGINT) AS [Custom Measure 0],
            CAST([CUSTOM_MEASURE_1] AS BIGINT) AS [Custom Measure 1],
            CAST([CUSTOM_MEASURE_2] AS BIGINT) AS [Custom Measure 2],
            CAST([CUSTOM_MEASURE_3] AS BIGINT) AS [Custom Measure 3],
            CAST([CUSTOM_MEASURE_4] AS BIGINT) AS [Custom Measure 4],
            CAST([CUSTOM_MEASURE_5] AS BIGINT) AS [Custom Measure 5],
            CAST([CUSTOM_MEASURE_6] AS BIGINT) AS [Custom Measure 6],
            CAST([CUSTOM_MEASURE_7] AS BIGINT) AS [Custom Measure 7],
            CAST([CUSTOM_MEASURE_8] AS BIGINT) AS [Custom Measure 8],
            CAST([CUSTOM_MEASURE_9] AS BIGINT) AS [Custom Measure 9]
    FROM [dbo].[VW_FCT_AGENT_SESSION_DETAIL] x
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN] AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AGENT_SESSION_DETAIL_CUBE]
	TO [portalapp_role]
GO
