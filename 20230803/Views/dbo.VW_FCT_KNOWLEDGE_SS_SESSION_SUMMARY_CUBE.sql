SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_CUBE]
AS
SELECT [PARTITION_URN],
       [CLUSTER_RESOURCE_URN],
       [TENANT_URN],
       [KB_PORTAL_URN],
       [AGENT_URN],
       [AGENT_TEAM_URN],
       [PERSON_URN],
       [CUSTOMER_URN],
       [LANGUAGE_URN],
       [MANAGER_AGENT_URN],
       [KB_ACCESS_TYPE] AS [KB_ACCESS_TYPE_URN],
       [KB_ACCESS_SUB_TYPE] AS [KB_ACCESS_SUB_TYPE_URN],
       [SESSION_OUTCOME] AS [SESSION_OUTCOME_URN],
       
       [SESSION_ID],
       [LAST_SESSION_ENTRY_ID],
       
       [START_DATE_UTC_URN],
       CAST([START_TIME_UTC_URN] AS SMALLINT) AS [START_TIME_UTC_URN],
       
       x.[END_DATE_UTC_URN],
       CAST(x.[END_TIME_UTC_URN] AS SMALLINT) AS [END_TIME_UTC_URN],
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
       
       CAST([ARTICLE_ACCESS_ANNOUNCEMENT_CNTR] AS BIGINT) AS [Article Access Announcement Counter],
       CAST([ARTICLE_ACCESS_BOOKMARKS_CNTR] AS BIGINT) AS [Article Access Bookmark Counter],
       CAST([ARTICLE_ACCESS_CALL_TRACK_CNTR] AS BIGINT) AS [Article Access Call Track Counter],
       CAST([ARTICLE_ACCESS_CNTR] AS BIGINT) AS [Article Access Counter],
       CAST([ARTICLE_ACCESS_DIRECT_CNTR] AS BIGINT) AS [Article Access Direct Counter],
       CAST([ARTICLE_ACCESS_GUIDED_HELP_CNTR] AS BIGINT) AS [Article Access Guided Help Counter],
       CAST([ARTICLE_ACCESS_GUIDED_HELP_INFO_CNTR] AS BIGINT) AS [Article Access Guided Help Info Counter],
       CAST([ARTICLE_ACCESS_LIST_CNTR] AS BIGINT) AS [Article Access List Counter],
       CAST([ARTICLE_ACCESS_MULTISEARCH_CNTR] AS BIGINT) AS [Article Access Multi Search Counter],
       CAST([ARTICLE_ACCESS_OFFERS_CNTR] AS BIGINT) AS [Article Access Offer Counter],
       CAST([ARTICLE_ACCESS_OTHER_CNTR] AS BIGINT) AS [Article Access Other Counter],
       CAST([ARTICLE_ACCESS_POPULAR_ARTICLE_CNTR] AS BIGINT) AS [Article Access Popular Article Counter],
       CAST([ARTICLE_ACCESS_RELATED_ARTICLES_CNTR] AS BIGINT) AS [Article Access Related Articles Counter],
       CAST([ARTICLE_ACCESS_SEARCH_CNTR] AS BIGINT) AS [Article Access Search Counter],
       CAST([ARTICLE_ACCESS_SUGGESTED_CNTR] AS BIGINT) AS [Article Access Suggested Counter],
       CAST([ARTICLE_ACCESS_TOPIC_CNTR] AS BIGINT) AS [Article Access Topic Counter],
       CAST([ARTICLE_ACCESS_TOPIC_TREE_CNTR] AS BIGINT) AS [Article Access Topic Tree Counter],
       CAST([ARTICLE_ACCESS_WIDGETS_CNTR] AS BIGINT) AS [Article Access Widgets Counter],
       CAST([ARTICLE_NOT_USEFUL_CNTR] AS BIGINT) AS [Article Not Useful Counter],
       CAST([ARTICLE_RATED_CNTR] AS BIGINT) AS [Article Rated Counter],
       CAST([ARTICLE_RATING_CNTR] AS BIGINT) AS [Article Rating Counter],
       CAST([ARTICLE_USEFUL_CNTR] AS BIGINT) AS [Article Useful Counter],
       CAST([ESCALATED_CNTR] AS BIGINT) AS [Escalated Counter],
       CAST([ESCALATION_ATTEMPTED_CNTR] AS BIGINT) AS [Escalation Attempted Counter],
       CAST([ESCALATION_AVERTED_CNTR] AS BIGINT) AS [Escalation Averted Counter],
       CAST([GUIDED_HELP_CNTR] AS BIGINT) AS [Guided Help Counter],
       CAST([GUIDED_HELP_QUESTION_CNTR] AS BIGINT) AS [Guided Help Question Counter],
       CAST([GUIDED_HELP_SOLUTION_ACCEPT_CNTR] AS BIGINT) AS [Guided Help Solution Accept Counter],
       CAST([GUIDED_HELP_SOLUTION_REJECT_CNTR] AS BIGINT) AS [Guided Help Solution Reject Counter],
       CAST([SEARCH_RESULTS_ARTICLE_COUNT] AS BIGINT) AS [Search Result Article Counter],
       CAST([SEARCH_SUCCESSFUL_CNTR] AS BIGINT) AS [Search Successful Counter],
       CAST([SEARCH_UNSUCCESSFUL_CNTR] AS BIGINT) AS [Search Unsuccessful Counter],       
       CAST([SESSION_ABANDONED] AS BIGINT) AS [Session Abandoned],
       CAST([SESSION_DURATION] AS BIGINT) AS [Session Duration],
       CAST([SESSION_ACTIVE] AS BIGINT) AS [Session Active],
       CAST([SESSION_ACTIVE_DURATION] AS BIGINT) AS [Session Active Duration],
       CAST([BOT_SESSION] AS BIGINT) AS [Bot Session],
       CAST([SESSION_SUBSCRIPTION_ACCESS] AS BIGINT) AS [Session Subscription Access],
       CAST([ARTICLE_ACCESS_SUBSCRIPTION_CNTR] AS BIGINT) AS [Article Access Subscription Counter],
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
FROM [dbo].[VW_FCT_KNOWLEDGE_SS_SESSION_SUMMARY] x
INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[START_TIME_UTC_URN] = tt.[TIME_URN]
INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[START_DATE_UTC_URN] AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_CUBE]
	TO [portalapp_role]
GO
