SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_CUBE]
AS
SELECT  [PARTITION_URN],
        [CALL_TYPE_URN],
            CASE WHEN [ctHier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [ctHier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [ctHier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [ctHier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [ctHier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_4],
            
        [SKILLGROUP_URN],
            CASE WHEN [skgHier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [skgHier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [skgHier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [skgHier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [skgHier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_4],
            
        [PERIPHERAL_URN],
            CASE WHEN [peripheralHier].[PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1
                 THEN 73 * CAST(4294967296 AS BIGINT) + CAST([x].[PERIPHERAL_URN] AS BIGINT)
                 ELSE -1
            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [peripheralHier].[PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1
                 THEN 73 * CAST(4294967296 AS BIGINT) + CAST([x].[PERIPHERAL_URN] AS BIGINT)
                 ELSE -1
            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [peripheralHier].[PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1
                 THEN 73 * CAST(4294967296 AS BIGINT) + CAST([x].[PERIPHERAL_URN] AS BIGINT)
                 ELSE -1
            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [peripheralHier].[PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1
                 THEN 73 * CAST(4294967296 AS BIGINT) + CAST([x].[PERIPHERAL_URN] AS BIGINT)
                 ELSE -1
            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [peripheralHier].[PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1
                 THEN 73 * CAST(4294967296 AS BIGINT) + CAST([x].[PERIPHERAL_URN] AS BIGINT)
                 ELSE -1
            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_4],
            
        x.[PRECISION_QUEUE_URN] AS [PRECISION_QUEUE_URN],
        x.[PRECISION_ATTRIBUTE_URN_1] AS [PRECISION_ATTRIBUTE_URN_1],
        x.[PRECISION_ATTRIBUTE_URN_2] AS [PRECISION_ATTRIBUTE_URN_2],
        x.[PRECISION_ATTRIBUTE_URN_3] AS [PRECISION_ATTRIBUTE_URN_3],
        x.[PRECISION_ATTRIBUTE_URN_4] AS [PRECISION_ATTRIBUTE_URN_4],
        x.[PRECISION_ATTRIBUTE_URN_5] AS [PRECISION_ATTRIBUTE_URN_5],
        x.[PRECISION_ATTRIBUTE_URN_6] AS [PRECISION_ATTRIBUTE_URN_6],
        x.[PRECISION_ATTRIBUTE_URN_7] AS [PRECISION_ATTRIBUTE_URN_7],
        x.[PRECISION_ATTRIBUTE_URN_8] AS [PRECISION_ATTRIBUTE_URN_8],
        x.[PRECISION_ATTRIBUTE_URN_9] AS [PRECISION_ATTRIBUTE_URN_9],
        x.[PRECISION_ATTRIBUTE_URN_10] AS [PRECISION_ATTRIBUTE_URN_10],
        [BUCKET_INTERVAL_URN],
        [MEDIA_ROUTING_DOMAIN_URN],
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
        CAST([ANSWER_WAIT_TIME] AS BIGINT) AS [Answer Wait Time],
        CAST([CALL_DELAY_ABAND_TIME] AS BIGINT) AS [Call Delay Abandon Time], --Abandon Call Time
        CAST([CALLS_ANSWERED] AS BIGINT) AS [Calls Answered],
        CAST([CALLS_HANDLED] AS BIGINT) AS [Calls Handled],
        CAST([CALLS_REPORT_AGAINST_OTHER] AS BIGINT) AS [Calls Report Against Other],
        CAST([CALLS_Q_HANDLED] AS BIGINT) AS [Calls Queue Handled],
        CAST([CALLS_RONA] AS BIGINT) AS [Calls RONA],
        CAST([CALLS_REQUERIED] AS BIGINT) AS [Calls Requeried],
        CAST([CALLS_ROUTED_NON_AGENT] AS BIGINT) AS [Calls Routed Non Agent],
        CAST([CALLS_HANDLED_NOT_ROUTED] AS BIGINT) AS [Calls Handled Not Routed],
        CAST([CALLS_ON_HOLD] AS BIGINT) AS [Calls On Hold],
        CAST([DELAY_AGENT_ABAND_TIME] AS BIGINT) AS [Delay Agent Abandon Time], --Agent Abandon Call Time
        CAST([DELAY_Q_ABAND_TIME] AS BIGINT) AS [Delay Queue Abandon Time], --Router Queue Abandon Delay Time
        CAST([HANDLED_TIME] AS BIGINT) AS [Handled Time],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([HOLD_TIME] AS BIGINT) AS [Hold Time],
        CAST([INCOMPLETE_CALLS] AS BIGINT) AS [Incomplete Calls], --Incomplete Tasks
        CAST([CALLS_OFFERED_ROUTED] AS BIGINT) AS [Calls Offered Routed],
        CAST([CALLS_OFFERED_NOT_ROUTED] AS BIGINT) AS [Calls Offered Not Routed],
        CAST([ROUTER_CALLS_ABAND_Q] AS BIGINT) AS [Router Calls Abandon Queue],
        CAST([ROUTER_CALLS_ABAND_TO_AGENT] AS BIGINT) AS [Router Calls Abandon To Agent],
        CAST([ROUTER_QUEUE_WAIT_TIME] AS BIGINT) AS [Router Queue Wait Time],
        CAST([ROUTER_QUEUE_CALLS] AS BIGINT) AS [Router Queue Calls],
        CAST([ROUTER_CALLS_DEQUEUED] AS BIGINT) AS [Router Calls Dequeued],
        CAST([ROUTER_CALLS_ABAND_DEQUEUED] AS BIGINT) AS [Router Calls Abandon Dequeued],
        CAST([SHORT_CALLS] AS BIGINT) AS [Short Calls],
        CAST([AGENT_ERROR_COUNT] AS BIGINT) AS [Agent Error Count],
        CAST([ERROR_COUNT] AS BIGINT) AS [Error Count],
        CAST([SERVICE_LEVEL_ABAND] AS BIGINT) AS [Service Level Abandon],
        CAST([SERVICE_LEVEL_CALLS] AS BIGINT) AS [Service Level Calls],
        CAST([SERVICE_LEVEL_CALLS_OFFERED] AS BIGINT) AS [Service Level Calls Offered],
        CAST([SERVICE_LEVEL_ERROR] AS BIGINT) AS [Service Level Error],
        CAST([SERVICE_LEVEL_RONA] AS BIGINT) AS [Service Level RONA],
        [SERVICE_LEVEL_TYPE] AS [SERVICE_LEVEL_TYPE],
        CAST([SERVICE_LEVEL_CALLS_DEQUEUE] AS BIGINT) AS [Service Level Calls Dequeue],
        CAST([MAX_HOLD_TIME] AS BIGINT) AS [Max Hold Time],
        CAST([MAX_CALL_WAIT_TIME] AS BIGINT) AS [Max Call Wait Time],
        CAST([MAX_CALLS_QUEUED] AS BIGINT) AS [Max Calls Queued],
        CAST([OVERFLOW_OUT] AS BIGINT) AS [Overflow Out],
        CAST([RESERVATION_CALLS] AS BIGINT) AS [Reservation Calls],
        CAST([ABAND_INTERVAL_1] AS BIGINT) AS [Abandon Interval 1],
        CAST([ABAND_INTERVAL_2] AS BIGINT) AS [Abandon Interval 2],
        CAST([ABAND_INTERVAL_3] AS BIGINT) AS [Abandon Interval 3],
        CAST([ABAND_INTERVAL_4] AS BIGINT) AS [Abandon Interval 4],
        CAST([ABAND_INTERVAL_5] AS BIGINT) AS [Abandon Interval 5],
        CAST([ABAND_INTERVAL_6] AS BIGINT) AS [Abandon Interval 6],
        CAST([ABAND_INTERVAL_7] AS BIGINT) AS [Abandon Interval 7],
        CAST([ABAND_INTERVAL_8] AS BIGINT) AS [Abandon Interval 8],
        CAST([ABAND_INTERVAL_9] AS BIGINT) AS [Abandon Interval 9],
        CAST([ABAND_INTERVAL_10] AS BIGINT) AS [Abandon Interval 10],
        CAST([ANS_INTERVAL_1] AS BIGINT) AS [Answer Interval 1],
        CAST([ANS_INTERVAL_2] AS BIGINT) AS [Answer Interval 2],
        CAST([ANS_INTERVAL_3] AS BIGINT) AS [Answer Interval 3],
        CAST([ANS_INTERVAL_4] AS BIGINT) AS [Answer Interval 4],
        CAST([ANS_INTERVAL_5] AS BIGINT) AS [Answer Interval 5],
        CAST([ANS_INTERVAL_6] AS BIGINT) AS [Answer Interval 6],
        CAST([ANS_INTERVAL_7] AS BIGINT) AS [Answer Interval 7],
        CAST([ANS_INTERVAL_8] AS BIGINT) AS [Answer Interval 8],
        CAST([ANS_INTERVAL_9] AS BIGINT) AS [Answer Interval 9],
        CAST([ANS_INTERVAL_10] AS BIGINT) AS [Answer Interval 10],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] x
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
                        AND i.[ITEM_TYPE_URN] IN ( 12, 73, 95 )
            ) hierarchyType
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 12
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[CALL_TYPE_URN]
                ) [ctHier]
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 95
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[SKILLGROUP_URN]
                ) [skgHier]
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [PERIPHERAL_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 73
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[PERIPHERAL_URN]
                ) [peripheralHier];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_CUBE]
	TO [portalapp_role]
GO
