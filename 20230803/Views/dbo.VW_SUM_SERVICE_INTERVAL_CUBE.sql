SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_SERVICE_INTERVAL_CUBE]
AS
SELECT  [SUMMARIZED_URN] AS [PARTITION_URN],
        [SERVICE_URN],
            CASE WHEN [serHier].[SERVICE_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 94 * CAST(4294967296 AS BIGINT) + CAST([x].[SERVICE_URN] AS BIGINT)
                 ELSE -1
            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [serHier].[SERVICE_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 94 * CAST(4294967296 AS BIGINT) + CAST([x].[SERVICE_URN] AS BIGINT)
                 ELSE -1
            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [serHier].[SERVICE_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 94 * CAST(4294967296 AS BIGINT) + CAST([x].[SERVICE_URN] AS BIGINT)
                 ELSE -1
            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [serHier].[SERVICE_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 94 * CAST(4294967296 AS BIGINT) + CAST([x].[SERVICE_URN] AS BIGINT)
                 ELSE -1
            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [serHier].[SERVICE_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 94 * CAST(4294967296 AS BIGINT) + CAST([x].[SERVICE_URN] AS BIGINT)
                 ELSE -1
            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_4],
            
        [CLUSTER_RESOURCE_URN] AS [CLUSTER_RESOURCE_URN],
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
        CAST([CALLS_OUT] AS BIGINT) AS [Calls Out],
        CAST([CALLS_TERMINATED_OTHER] AS BIGINT) AS [Calls Terminated Other],
        CAST([CALLS_OFFERED] AS BIGINT) AS [Calls Offered],
        CAST([PERIPH_SERVICE_LEVEL_OFFER] AS BIGINT) AS [Perip Service Level Offered],
        CAST([CALLS_INCOMING] AS BIGINT) AS [Calls Incoming],
        CAST([TRANSFER_IN_CALLS] AS BIGINT) AS [Transferred In Calls],
        CAST([CALLS_HANDLED] AS BIGINT) AS [Calls Handled],
        CAST([TRANSFER_OUT_CALLS] AS BIGINT) AS [Transferred Out Calls],
        CAST([CALLS_ROUTED] AS BIGINT) AS [Calls Routed],
        CAST([CALLS_ABAND_Q] AS BIGINT) AS [Calls Abandoned In Queue],
        CAST([PERIPH_SERVICE_LEVEL] AS BIGINT) AS [Perip Service Level],
        CAST([PERIPH_SERVICE_LEVEL_CALLS] AS BIGINT) AS [Perip Service Level Calls],
        CAST([SERVICE_LEVEL] AS BIGINT) AS [Service Level],
        CAST([SERVICE_LEVEL_CALLS] AS BIGINT) AS [Service Level Calls],
        CAST([SERVICE_LEVEL_ABAND] AS BIGINT) AS [Service Level Calls Abandoned],
        CAST([SERVICE_LEVEL_CALLS_OFFERED] AS BIGINT) AS [Service Level Calls Offered],
        CAST([AVG_DELAY_Q_TIME] AS BIGINT) AS [Avg Delay Queue Time],
        CAST([DELAY_Q_TIME] AS BIGINT) AS [Delay Queue Time],
        CAST([CALLS_Q] AS BIGINT) AS [Calls Queued],
        CAST([AVG_DELAY_Q_ABAND_TIME] AS BIGINT) AS [Avg Delay Queue Abandon Time],
        CAST([DELAY_Q_ABAND_TIME] AS BIGINT) AS [Delay Queue Abandon Time],
        CAST([AVG_SPEED_ANSWER_TIME] AS BIGINT) AS [Avg Speed Answer Time],
        CAST([ANSWER_WAIT_TIME] AS BIGINT) AS [Answer Wait Time],
        CAST([AVG_TALK_TIME] AS BIGINT) AS [Avg Talk Time],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([AVG_HANDLE_TIME] AS BIGINT) AS [Avg Handle Time],
        CAST([HANDLE_TIME] AS BIGINT) AS [Handle Time],
        CAST([SHORT_CALLS] AS BIGINT) AS [Short Calls],
        CAST([CALLS_ANSWERED] AS BIGINT) AS [Calls Answered],
        CAST([LONGEST_CALL_ABAND_TIME] AS BIGINT) AS [Longest Call Abandon Time],
        CAST([LONGEST_CALL_DELAY_Q_TIME] AS BIGINT) AS [Longest Call Delay Queue Time],
        CAST([SHORT_CALLS_TIME] AS BIGINT) AS [Short Calls Time],
        CAST([FORCED_CLOSED_CALLS] AS BIGINT) AS [Forced Closed Call],
        CAST([OVERFLOW_IN] AS BIGINT) AS [Overflow In],
        CAST([OVERFLOW_OUT] AS BIGINT) AS [Overflow Out],
        CAST([AUTO_OUT_CALLS] AS BIGINT) AS [Auto Out Calls],
        CAST([AUTO_OUT_CALLS_TIME] AS BIGINT) AS [Auto Out Calls Time],
        CAST([AUTO_OUT_CALLS_TALK_TIME] AS BIGINT) AS [Auto Out Calls Talk Time],
        CAST([AUTO_OUT_CALLS_ON_HOLD] AS BIGINT) AS [Auto Out Calls On Hold],
        CAST([AUTO_OUT_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Auto Out Calls On Hold Time],
        CAST([PREVIEW_CALLS] AS BIGINT) AS [Preview Calls],
        CAST([PREVIEW_CALLS_TIME] AS BIGINT) AS [Preview Calls Time],
        CAST([PREVIEW_CALLS_TALK_TIME] AS BIGINT) AS [Preview Calls Talk Time],
        CAST([PREVIEW_CALLS_ON_HOLD] AS BIGINT) AS [Preview Calls On Hold],
        CAST([PREVIEW_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Preview Calls On Hold Time],
        CAST([RESERVE_CALLS] AS BIGINT) AS [Reserve Calls],
        CAST([RESERVE_CALLS_TIME] AS BIGINT) AS [Reserve Calls Time],
        CAST([RESERVE_CALLS_TALK_TIME] AS BIGINT) AS [Reserve Calls Talk Time],
        CAST([RESERVE_CALLS_ON_HOLD] AS BIGINT) AS [Reserve Calls On Hold],
        CAST([RESERVE_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Reserve Calls On Hold Time],
        CAST([HOLD_TIME] AS BIGINT) AS [Hold Time],
        CAST([BLIND_TRANSFERS_OUT] AS BIGINT) AS [Blind Transfers Out],
        CAST([REDIRECT_NO_ANS_CALLS] AS BIGINT) AS [Redirect No Answer Calls],
        CAST([NUM_MISSING_TASKS] AS BIGINT) AS [Number Missing Tasks],
        [Row Count] AS [Row Count],
        [PARTITION_ID]
FROM    [dbo].[VW_SUM_SERVICE_INTERVAL] x
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
                        AND i.[ITEM_TYPE_URN] = 94
            ) hierarchyType
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [SERVICE_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 94
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[SERVICE_URN]
                ) [serHier];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_SERVICE_INTERVAL_CUBE]
	TO [portalapp_role]
GO
