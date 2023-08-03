SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_VA_SESSION_CUBE]
AS
    SELECT  [x].[PARTITION_URN],
            [x].[CLUSTER_RESOURCE_URN],
            [x].[SESSION_ID],
            [x].[TENANT_URN],
            [x].[VA_ASSISTANT_URN],
            [x].[VA_ATTRIBUTE_GROUP_URN],
            [x].[VA_CASE_GROUP_URN],
            [x].[VA_CASE_QUESTION_GROUP_URN],
            [x].[VA_CATEGORY_GROUP_URN],
            [x].[VA_DOMAIN_GROUP_URN],
            [x].[VA_KEYWORD_GROUP_URN],
            [x].[VA_URL_GROUP_URN],

            [x].[DATE_UTC_URN],
            [x].[TIME_UTC_URN],
            [tzd].[OLAP_DATETIME_UTC] AS [DATETIME_UTC_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_0] AS [TIME_ZONE_0_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_1] AS [TIME_ZONE_1_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_2] AS [TIME_ZONE_2_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_3] AS [TIME_ZONE_3_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_4] AS [TIME_ZONE_4_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_5] AS [TIME_ZONE_5_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_6] AS [TIME_ZONE_6_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_7] AS [TIME_ZONE_7_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_8] AS [TIME_ZONE_8_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_9] AS [TIME_ZONE_9_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_10] AS [TIME_ZONE_10_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_11] AS [TIME_ZONE_11_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_12] AS [TIME_ZONE_12_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_13] AS [TIME_ZONE_13_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_14] AS [TIME_ZONE_14_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_15] AS [TIME_ZONE_15_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_16] AS [TIME_ZONE_16_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_17] AS [TIME_ZONE_17_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_18] AS [TIME_ZONE_18_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_19] AS [TIME_ZONE_19_URN],

            CAST([x].[ABANDONED] AS BIGINT) AS [Abandoned],
            CAST([x].[DURATION] AS BIGINT) AS [Duration],
            CAST([x].[ESCALATED_SESSIONS] AS BIGINT) AS [Escalated Sessions],
            CAST([x].[EXCHANGES] AS BIGINT) AS [Exchanges],
            CAST([x].[RELEVANT_SESSIONS] AS BIGINT) AS [Relevant Sessions],
            CAST([x].[SERVICED] AS BIGINT) AS [Serviced],
            CAST([x].[SESSIONS] AS BIGINT) AS [Sessions],

            [x].[PARTITION_ID],
            [x].[Row Count]
    FROM    [dbo].[VW_FCT_VA_SESSION] [x]
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] [tt] ON [x].[TIME_UTC_URN] = [tt].[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] [tzd] ON [tzd].[DATE_UTC_URN] = [x].[DATE_UTC_URN]
                                                    AND [tzd].[TIME_UTC_URN] = [tt].[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_VA_SESSION_CUBE]
	TO [portalapp_role]
GO
