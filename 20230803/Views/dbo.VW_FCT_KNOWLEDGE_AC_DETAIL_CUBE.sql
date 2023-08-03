SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_KNOWLEDGE_AC_DETAIL_CUBE]
--WITH ENCRYPTION
AS
SELECT  [PARTITION_URN],
        [CASE_ID],
        [ACTIVITY_ID],
        [SS_SESSION_ID],
        [CLUSTER_RESOURCE_URN],
        [TENANT_URN],
        [CUSTOMER_URN],
        [AGENT_URN],
        [PERSON_URN],
        [AGENT_TEAM_URN],
        [QUEUE_URN],
        [ALIAS_URN],
        [ENTRY_POINT_URN],
        [LANGUAGE_URN],
        [KB_FOLDER_URN],
        [KB_ARTICLE_URN],
        [ACTIVITY_TYPE_CODE_URN],
        [IS_USAGE_DATA],
        [MANAGER_AGENT_URN],
        [KB_ARTICLE_TYPE_URN],
        [ARTICLE_TYPE_URN],
        [KB_OWNER_URN],

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

        CAST([ARTICLE_ACCESS_PHONE_CNTR] AS BIGINT) AS [Article Access Call Track Counter],
        CAST([ARTICLE_ACCESS_CHAT_CNTR] AS BIGINT) AS [Article Access Chat Counter],
        CAST([ARTICLE_ACCESS_CNTR] AS BIGINT) AS [Article Access Counter],
        CAST([ARTICLE_ACCESS_EMAIL_CNTR] AS BIGINT) AS [Article Access Email Counter],
        CAST([ARTICLE_ACCESS_KB_PORTAL_CNTR] AS BIGINT) AS [Article Access KB Portal Counter],
        CAST([ARTICLE_ACCESS_OTHER_CNTR] AS BIGINT) AS [Article Access Other Counter],
        CAST([ARTICLE_ACCESS_QL_CNTR] AS BIGINT) AS [Article Access QL Counter],
        CAST([ARTICLE_ACCESS_QR_CNTR] AS BIGINT) AS [Article Access QR Counter],
        CAST([ARTICLE_ACCESS_RULES_CNTR] AS BIGINT) AS [Article Access Rules Counter],
        CAST([ARTICLE_ACCESS_TASK_CNTR] AS BIGINT) AS [Article Access Task Counter],
        CAST([ARTICLE_APPROVED_CNTR] AS BIGINT) AS [Article Approved Counter],
        CAST([ARTICLE_AUTO_SUGGESTED_CNTR] AS BIGINT) AS [Article Auto Suggested Counter],
        CAST([ARTICLE_CHECKED_IN_CNTR] AS BIGINT) AS [Article Checked In Counter],
        CAST([ARTICLE_CHECKED_OUT_CNTR] AS BIGINT) AS [Article Checked Out Counter],
        CAST([ARTICLE_CREATED_CNTR] AS BIGINT) AS [Article Created Counter],
        CAST([ARTICLE_DELETED_CNTR] AS BIGINT) AS [Article Deleted Counter],
        CAST([ARTICLE_FEEDBACK_CNTR] AS BIGINT) AS [Article Feedback Counter],
        CAST([ARTICLE_PUBLISHED_CNTR] AS BIGINT) AS [Article Published Counter],
        CAST([ARTICLE_REJECTED_CNTR] AS BIGINT) AS [Article Rejected Counter],
        CAST([ARTICLE_SUGGESTED_CNTR] AS BIGINT) AS [Article Suggested Counter],
        CAST(0 AS BIGINT) AS [Article Suggested Reply Counter],
        CAST([ARTICLE_UPDATED_CNTR] AS BIGINT) AS [Article Updated Counter],
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
    FROM [dbo].[VW_FCT_KNOWLEDGE_AC_DETAIL] x
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN] AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_KNOWLEDGE_AC_DETAIL_CUBE]
	TO [portalapp_role]
GO
