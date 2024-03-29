SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CHAT_SURVEY_CUBE]
AS
SELECT  [PARTITION_URN],
        [CLUSTER_RESOURCE_URN],
        [ACTIVITY_ID],
        [CASE_ID],
        [TENANT_URN],
        [ENTRY_POINT_URN],
        [CUSTOMER_URN],
        [AGENT_URN],
        [PERSON_URN],
        [QUEUE_URN],
        [AGENT_TEAM_URN],
        [SKILLGROUP_URN],
        [ACTIVITY_TYPE_CODE_URN],
        [ACTIVITY_SUB_TYPE_CODE_URN],
        [ACTIVITY_ORIGIN],
        [LANGUAGE_URN],
        [CASE_URN],
        [CHAT_REFERRER_NAME_URN],
        [CHAT_REFERRER_URL_URN],
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
        
        CAST([IS_ACTIVITY_SURVEYED] AS BIGINT) AS [Activity Surveyed],
        CAST([IS_ANSWER_NUMERIC] AS BIGINT) AS [Answer Numeric],
        CAST([SURVEY_ANSWER_SCORE] AS BIGINT) AS [Survey Answer Score],
        
        [PARTITION_ID],
        [Row Count],
        
        [CUSTOM_DIMENSION_0],
        [CUSTOM_DIMENSION_1],
        [CUSTOM_DIMENSION_2],
        [CUSTOM_DIMENSION_3],
        [CUSTOM_DIMENSION_4],
        [CUSTOM_DIMENSION_5],
        [CUSTOM_DIMENSION_6],
        [CUSTOM_DIMENSION_7],
        [CUSTOM_DIMENSION_8],
        [CUSTOM_DIMENSION_9],
        [CUSTOM_MEASURE_0],
        [CUSTOM_MEASURE_1],
        [CUSTOM_MEASURE_2],
        [CUSTOM_MEASURE_3],
        [CUSTOM_MEASURE_4],
        [CUSTOM_MEASURE_5],
        [CUSTOM_MEASURE_6],
        [CUSTOM_MEASURE_7],
        [CUSTOM_MEASURE_8],
        [CUSTOM_MEASURE_9]
FROM    [dbo].[VW_FCT_CHAT_SURVEY] x
INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN] AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CHAT_SURVEY_CUBE]
	TO [portalapp_role]
GO
