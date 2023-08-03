SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_CUBE]
AS
SELECT  [SUMMARIZED_URN] AS [PARTITION_URN],
        [CAMPAIGN_URN],
            CASE WHEN [ctHier].[CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 13 * CAST(4294967296 AS BIGINT) + CAST([x].[CAMPAIGN_URN] AS BIGINT)
                 ELSE -1
            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [ctHier].[CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 13 * CAST(4294967296 AS BIGINT) + CAST([x].[CAMPAIGN_URN] AS BIGINT)
                 ELSE -1
            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [ctHier].[CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 13 * CAST(4294967296 AS BIGINT) + CAST([x].[CAMPAIGN_URN] AS BIGINT)
                 ELSE -1
            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [ctHier].[CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 13 * CAST(4294967296 AS BIGINT) + CAST([x].[CAMPAIGN_URN] AS BIGINT)
                 ELSE -1
            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [ctHier].[CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 13 * CAST(4294967296 AS BIGINT) + CAST([x].[CAMPAIGN_URN] AS BIGINT)
                 ELSE -1
            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_4],
            
        [QUERY_RULE_URN],
        [CLUSTER_RESOURCE_URN],
        [DATE_URN],
        x.[TIME_URN],
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
        CAST([ABANDON_DETECT] AS BIGINT) AS [Total Abandon Detect],
        CAST([ABANDON_TO_IVR] AS BIGINT) AS [Total Abandon To IVR],
        CAST([AGENT_CLOSED_DETECT] AS BIGINT) AS [Total Agent Closed],
        CAST([AGENT_REJECTED_DETECT] AS BIGINT) AS [Total Agent Rejected],
        CAST([ANSWERING_MACHINE_DETECT] AS BIGINT) AS [Total Answering Machine Detect],
        CAST([BUSY_DETECT] AS BIGINT) AS [Total Busy Detect],
        CAST([CALLBACK_COUNT] AS BIGINT) AS [Total Callback Count],
        CAST([CANCELLED_DETECT] AS BIGINT) AS [Total Cancelled Detect],
        CAST([CONTACTS_ATTEMPTED] AS BIGINT) AS [Total Contacts Attempted],
        CAST([CUSTOMER_ABANDON_DETECT] AS BIGINT) AS [Total Customer Abandoned],
        CAST([CUSTOMER_NOT_HOME] AS BIGINT) AS [Total Customer Not Available],
        CAST([FAX_DETECT] AS BIGINT) AS [Total Fax Detect],
        CAST([NETWORK_ANS_MACHINE_DETECT] AS BIGINT) AS [Total Net Answering Machine Detect],
        CAST([NO_ANSWER_DETECT] AS BIGINT) AS [Total No Answer],
        CAST([NO_DIAL_TONE_DETECT] AS BIGINT) AS [Total No Dial Tone],
        CAST([NO_RINGBACK_DETECT] AS BIGINT) AS [Total No Ringback],
        CAST([PERSONAL_CALLBACK_COUNT] AS BIGINT) AS [Total Personal Callback],
        CAST([WRONG_NUMBER_COUNT] AS BIGINT) AS [Total Wrong Number],
        CAST([VOICE_DETECT] AS BIGINT) AS [Total Voice Detect],
        CAST([SIT_TONE_DETECT] AS BIGINT) AS [Total SIT Detect],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([WRAPUP_TIME] AS BIGINT) AS [Wrapup Time],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_CAMPAIGN_QUERY_RULE_INTERVAL] x
INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                                AND tzd.[TIME_UTC_URN] = x.[TIME_UTC_URN]
OUTER APPLY ( SELECT    MAX(CASE WHEN b.[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_0'
                                      AND a.[LATEST] = 1 THEN 1
                            END) AS ST_CUSTOM_HIERARCHY_0,
                        MAX(CASE WHEN b.[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_1'
                                      AND a.[LATEST] = 1 THEN 1
                            END) AS ST_CUSTOM_HIERARCHY_1,
                        MAX(CASE WHEN b.[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_2'
                                      AND a.[LATEST] = 1 THEN 1
                            END) AS ST_CUSTOM_HIERARCHY_2,
                        MAX(CASE WHEN b.[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_3'
                                      AND a.[LATEST] = 1 THEN 1
                            END) AS ST_CUSTOM_HIERARCHY_3,
                        MAX(CASE WHEN b.[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_4'
                                      AND a.[LATEST] = 1 THEN 1
                            END) AS ST_CUSTOM_HIERARCHY_4
              FROM      [dbo].[TB_DIM_HIERARCHY] a
              INNER JOIN [dbo].[TE_DIM_ITEM_SUBTYPE] b ON a.[ITEM_SUBTYPE_ID] = b.[ITEM_SUBTYPE_ID]
              INNER JOIN [dbo].[TB_DIM_HIERARCHY_NODE] n ON a.[ITEM_URN] = n.[HIERARCHY_BUSINESS_URN]
              INNER JOIN [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] i ON n.[ITEM_URN] = i.[HIERARCHY_NODE_URN]
              WHERE     b.[INTERNAL_NAME] IN ( 'ST_CUSTOM_HIERARCHY_0',
                                               'ST_CUSTOM_HIERARCHY_1',
                                               'ST_CUSTOM_HIERARCHY_2',
                                               'ST_CUSTOM_HIERARCHY_3',
                                               'ST_CUSTOM_HIERARCHY_4' )
                        AND a.[LATEST] = 1
                        AND i.[ITEM_TYPE_URN] = 13
            ) hierarchyType
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [CAMPAIGN_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
                  FROM      ( SELECT    [a].[ITEM_URN],
                                        MAX(CASE WHEN [c].[ITEM_SUBTYPE_ID] = '00000070-0000-0000-0000-000000000001' THEN 1
                                                 ELSE 0
                                            END) AS [ST_CUSTOM_HIERARCHY_0],
                                        MAX(CASE WHEN [c].[ITEM_SUBTYPE_ID] = '00000070-0000-0000-0000-000000000002' THEN 1
                                                 ELSE 0
                                            END) AS [ST_CUSTOM_HIERARCHY_1],
                                        MAX(CASE WHEN [c].[ITEM_SUBTYPE_ID] = '00000070-0000-0000-0000-000000000003' THEN 1
                                                 ELSE 0
                                            END) AS [ST_CUSTOM_HIERARCHY_2],
                                        MAX(CASE WHEN [c].[ITEM_SUBTYPE_ID] = '00000070-0000-0000-0000-000000000004' THEN 1
                                                 ELSE 0
                                            END) AS [ST_CUSTOM_HIERARCHY_3],
                                        MAX(CASE WHEN [c].[ITEM_SUBTYPE_ID] = '00000070-0000-0000-0000-000000000005' THEN 1
                                                 ELSE 0
                                            END) AS [ST_CUSTOM_HIERARCHY_4]
                              FROM      [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] [a]
                              JOIN      [dbo].[TB_DIM_HIERARCHY_NODE] [b] ON [a].[HIERARCHY_NODE_URN] = [b].[ITEM_URN]
                              JOIN      [dbo].[TB_DIM_HIERARCHY] [c] ON [b].[HIERARCHY_BUSINESS_URN] = [c].[ITEM_URN]
                              WHERE     [a].[ITEM_TYPE_URN] = 13
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[CAMPAIGN_URN]
                ) [ctHier];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_CUBE]
	TO [portalapp_role]
GO
