SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_SKILLGROUP_INTERVAL_CUBE]
AS
SELECT  [SUMMARIZED_URN] AS [PARTITION_URN],
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
            
        [CLUSTER_RESOURCE_URN] AS [CLUSTER_RESOURCE_URN],
        [CAMPAIGN_URN],
        x.PRECISION_QUEUE_URN AS [PRECISION_QUEUE_URN],
        CAST(-1 AS INTEGER) AS [BUCKET_INTERVAL_URN],
        x.[MEDIA_CLASS_URN],
        x.[MEDIA_ROUTING_DOMAIN_URN],
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
        CAST([ABANDON_HOLD_CALLS] AS BIGINT) AS [Abandon Hold Call],
        CAST([ABANDON_RING_CALLS] AS BIGINT) AS [Abandon Ring Call],
        CAST([ABANDON_RING_TIME] AS BIGINT) AS [Abandon Ring Call Time],
        CAST([AGENT_OUT_CALLS] AS BIGINT) AS [Agent Out Call],
        CAST([AGENT_OUT_CALLS_TIME] AS BIGINT) AS [Agent Out Call Time],
        CAST([AGENT_OUT_CALLS_ON_HOLD] AS BIGINT) AS [Agent Out Call Held],
        CAST([AGENT_OUT_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Agent Out Call Held Time],
        CAST([AGENT_OUT_CALLS_TALK_TIME] AS BIGINT) AS [Agent Out Call Talk Time],
        CAST([AGENT_TERMINATED_CALLS] AS BIGINT) AS [Agent Terminated Call],
        CAST([ANSWER_WAIT_TIME] AS BIGINT) AS [Answer Wait Time],
        CAST([AVAIL_TIME] AS BIGINT) AS [Available Time],
        CAST([AVG_HANDLED_CALLS_TIME] AS BIGINT) AS [Avg Handled Call Time],
        CAST([AVG_HANDLED_CALLS_TALK_TIME] AS BIGINT) AS [Avg Handled Call Talk Time],
        CAST([BUSY_OTHER_TIME] AS BIGINT) AS [Busy Other Time],
        CAST([CALLBACK_MESSAGES] AS BIGINT) AS [Callback Messages],
        CAST([CALLBACK_MESSAGES_TIME] AS BIGINT) AS [Callback Messages Time],
        CAST([CALLS_ANSWERED] AS BIGINT) AS [Call Answered],
        CAST([CALLS_HANDLED] AS BIGINT) AS [Call Handled],
        CAST([CONFERENCED_IN_CALLS] AS BIGINT) AS [Conferenced In Call],
        CAST([CONFERENCED_IN_CALLS_TIME] AS BIGINT) AS [Conferenced In Call Time],
        CAST([CONFERENCED_OUT_CALLS] AS BIGINT) AS [Conferenced Out Call],
        CAST([CONFERENCED_OUT_CALLS_TIME] AS BIGINT) AS [Conferenced Out Call Time],
        CAST([CONSULTATIVE_CALLS] AS BIGINT) AS [Consultative Call],
        CAST([CONSULTATIVE_CALLS_TIME] AS BIGINT) AS [Consultative Call Time],
        CAST([HANDLED_CALLS_TIME] AS BIGINT) AS [Handled Call Time],
        CAST([HANDLED_CALLS_TALK_TIME] AS BIGINT) AS [Handled Call Talk Time],
        CAST([HOLD_TIME] AS BIGINT) AS [Hold Time],
        CAST([INCOMING_CALLS_ON_HOLD] AS BIGINT) AS [Incoming Call Held],
        CAST([INCOMING_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Incoming Call Held Time],
        CAST([INTERNAL_CALLS] AS BIGINT) AS [Internal Call],
        CAST([INTERNAL_CALLS_TIME] AS BIGINT) AS [Internal Call Time],
        CAST([INTERNAL_CALLS_ON_HOLD] AS BIGINT) AS [Internal Call Held],
        CAST([INTERNAL_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Internal Call Held Time],
        CAST([INTERNAL_CALLS_RCVD] AS BIGINT) AS [Internal Call Received],
        CAST([INTERNAL_CALLS_RCVD_TIME] AS BIGINT) AS [Internal Call Received Time],
        CAST([LOGGED_ON_TIME] AS BIGINT) AS [Logged On Time],
        CAST([NOT_READY_TIME] AS BIGINT) AS [Not Ready Time],
        CAST([PERCENT_UTILIZATION] AS BIGINT) AS [Percent Utilization],
        CAST([REDIRECT_NO_ANS_CALLS] AS BIGINT) AS [Redirect No Answer Call],
        CAST([REDIRECT_NO_ANS_CALLS_TIME] AS BIGINT) AS [Redirect No Answer Call Time],
        CAST([RESERVED_STATE_TIME] AS BIGINT) AS [Reserved State Time],
        CAST([ROUTER_CALLS_ABAND_Q] AS BIGINT) AS [Router Call Abandon Queue],
        CAST([ROUTER_QUEUE_CALLS] AS BIGINT) AS [Router Queue Call],
        CAST([SHORT_CALLS] AS BIGINT) AS [Short Call],
        CAST([SUPERV_ASSIST_CALLS] AS BIGINT) AS [Supervisor Assisted Call],
        CAST([SUPERV_ASSIST_CALLS_TIME] AS BIGINT) AS [Supervisor Assisted Call Time],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([TALK_IN_TIME] AS BIGINT) AS [Talk In Time],
        CAST([TALK_OTHER_TIME] AS BIGINT) AS [Talk Other Time],
        CAST([TALK_OUT_TIME] AS BIGINT) AS [Talk Out Time],
        CAST([TRANSFER_IN_CALLS] AS BIGINT) AS [Transfer In Call],
        CAST([TRANSFER_IN_CALLS_TIME] AS BIGINT) AS [Transfer In Call Time],
        CAST([TRANSFER_OUT_CALLS] AS BIGINT) AS [Transfer Out Call],
        CAST([WORK_READY_TIME] AS BIGINT) AS [Work Ready Time],
        CAST([WORK_NOT_READY_TIME] AS BIGINT) AS [Work Not Ready Time],
        CAST([AUTO_OUT_CALLS] AS BIGINT) AS [Auto Out Call],
        CAST([AUTO_OUT_CALLS_TIME] AS BIGINT) AS [Auto Out Call Time],
        CAST([AUTO_OUT_CALLS_TALK_TIME] AS BIGINT) AS [Auto Out Call Talk Time],
        CAST([AUTO_OUT_CALLS_ON_HOLD] AS BIGINT) AS [Auto Out Call On Hold],
        CAST([AUTO_OUT_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Auto Out Call On Hold Time],
        CAST([PREVIEW_CALLS] AS BIGINT) AS [Preview Call],
        CAST([PREVIEW_CALLS_TIME] AS BIGINT) AS [Preview Call Time],
        CAST([PREVIEW_CALLS_TALK_TIME] AS BIGINT) AS [Preview Call Talk Time],
        CAST([PREVIEW_CALLS_ON_HOLD] AS BIGINT) AS [Preview Call On Hold],
        CAST([PREVIEW_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Preview Call On Hold Time],
        CAST([RESERVE_CALLS] AS BIGINT) AS [Reserve Call],
        CAST([RESERVE_CALLS_TIME] AS BIGINT) AS [Reserve Call Time],
        CAST([RESERVE_CALLS_TALK_TIME] AS BIGINT) AS [Reserve Call Talk Time],
        CAST([RESERVE_CALLS_ON_HOLD] AS BIGINT) AS [Reserve Call On Hold],
        CAST([RESERVE_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Reserve Call On Hold Time],
        CAST([TALK_AUTO_OUT_TIME] AS BIGINT) AS [Talk Auto Out Time],
        CAST([TALK_PREVIEW_TIME] AS BIGINT) AS [Talk Preview Time],
        CAST([TALK_RESERVE_TIME] AS BIGINT) AS [Talk Reserve Time],
        CAST([BARGE_IN_CALLS] AS BIGINT) AS [Barge In Call],
        CAST([INTERCEPT_CALLS] AS BIGINT) AS [Intercept Call],
        CAST([MONITOR_CALLS] AS BIGINT) AS [Monitor Call],
        CAST([WHISPER_CALLS] AS BIGINT) AS [Whisper Call],
        CAST([EMERGENCY_ASSISTS] AS BIGINT) AS [Emergency Assists],
        CAST([CALLS_OFFERED] AS BIGINT) AS [Call Offered],
        CAST([CALLS_QUEUED] AS BIGINT) AS [Call Queued],
        CAST([ABANDON_HOLD_CALLS_OUT] AS BIGINT) AS [Abandon Hold Call Out],
        CAST([NET_CONSULTATIVE_CALLS] AS BIGINT) AS [Net Consultative Call],
        CAST([NET_CONSULTATIVE_CALLS_TIME] AS BIGINT) AS [Net Consultative Call Time],
        CAST([NET_CONFERENCED_OUT_CALLS] AS BIGINT) AS [Net Conferenced Out Call],
        CAST([NET_CONFERENCED_OUT_CALLS_TIME] AS BIGINT) AS [Net Conferenced Out Call Time],
        CAST([NET_TRANSFER_OUT_CALLS] AS BIGINT) AS [Net Transfer Out Call],
        CAST([ROUTER_CALLS_OFFERED] AS BIGINT) AS [Router Call Offered],
        CAST([ROUTER_CALLS_ABANDON_TO_AGENT] AS BIGINT) AS [Router Call Abandon To Agent],
        CAST([ROUTER_CALLS_DEQUEUED] AS BIGINT) AS [Router Call Dequeued],
        CAST([ROUTER_ERROR] AS BIGINT) AS [Router Error],
        CAST([SERVICE_LEVEL] AS BIGINT) AS [Service Level],
        CAST([SERVICE_LEVEL_CALLS] AS BIGINT) AS [Service Level Call],
        CAST([SERVICE_LEVEL_CALLS_ABANDON] AS BIGINT) AS [Service Level Call Abandon],
        CAST([SERVICE_LEVEL_CALLS_DEQUEUED] AS BIGINT) AS [Service Level Call Dequeued],
        CAST([SERVICE_LEVEL_ERROR] AS BIGINT) AS [Service Level Error],
        CAST([SERVICE_LEVEL_RONA] AS BIGINT) AS [Service Level RONA],
        CAST([SERVICE_LEVEL_CALLS_OFFERED] AS BIGINT) AS [Service Level Call Offered],
        CAST([SERVICE_LEVEL_TYPE] AS INT) AS [SERVICE_LEVEL_TYPE],
        CAST([CONSULT_OUT_CALLS] AS BIGINT) AS [Consult Out Calls],
        CAST([CONSULT_OUT_CALLS_TIME] AS BIGINT) AS [Consult Out Calls Time],
        CAST([INTERRUPTED_TIME] AS BIGINT) AS [Interrupted Time],
        CAST([ROUTER_DELAY_Q_ABAND_TIME] AS BIGINT) AS [Router Delay Q Aband Time],
        CAST([ROUTER_MAX_CALLS_QUEUED] AS BIGINT) AS [Router Max Calls Queued],
        CAST([ROUTER_MAX_CALL_WAIT_TIME] AS BIGINT) AS [Router Max Call Wait Time],
        CAST([ROUTER_CALLS_ABAND_DEQUEUED] AS BIGINT) AS [Router Calls Aband Dequeued],
        CAST([ROUTER_ABAND_INTERVAL_1] AS BIGINT) AS [Router Aband Interval 1],
        CAST([ROUTER_ABAND_INTERVAL_2] AS BIGINT) AS [Router Aband Interval 2],
        CAST([ROUTER_ABAND_INTERVAL_3] AS BIGINT) AS [Router Aband Interval 3],
        CAST([ROUTER_ABAND_INTERVAL_4] AS BIGINT) AS [Router Aband Interval 4],
        CAST([ROUTER_ABAND_INTERVAL_5] AS BIGINT) AS [Router Aband Interval 5],
        CAST([ROUTER_ABAND_INTERVAL_6] AS BIGINT) AS [Router Aband Interval 6],
        CAST([ROUTER_ABAND_INTERVAL_7] AS BIGINT) AS [Router Aband Interval 7],
        CAST([ROUTER_ABAND_INTERVAL_8] AS BIGINT) AS [Router Aband Interval 8],
        CAST([ROUTER_ABAND_INTERVAL_9] AS BIGINT) AS [Router Aband Interval 9],
        CAST([ROUTER_ABAND_INTERVAL_10] AS BIGINT) AS [Router Aband Interval 10],
        CAST([ROUTER_ANS_INTERVAL_1] AS BIGINT) AS [Router Ans Interval 1],
        CAST([ROUTER_ANS_INTERVAL_2] AS BIGINT) AS [Router Ans Interval 2],
        CAST([ROUTER_ANS_INTERVAL_3] AS BIGINT) AS [Router Ans Interval 3],
        CAST([ROUTER_ANS_INTERVAL_4] AS BIGINT) AS [Router Ans Interval 4],
        CAST([ROUTER_ANS_INTERVAL_5] AS BIGINT) AS [Router Ans Interval 5],
        CAST([ROUTER_ANS_INTERVAL_6] AS BIGINT) AS [Router Ans Interval 6],
        CAST([ROUTER_ANS_INTERVAL_7] AS BIGINT) AS [Router Ans Interval 7],
        CAST([ROUTER_ANS_INTERVAL_8] AS BIGINT) AS [Router Ans Interval 8],
        CAST([ROUTER_ANS_INTERVAL_9] AS BIGINT) AS [Router Ans Interval 9],
        CAST([ROUTER_ANS_INTERVAL_10] AS BIGINT) AS [Router Ans Interval 10],
        CAST([PHONE_TIME_IN] AS BIGINT) AS [Phone Time In],
        CAST([PHONE_TIME_OUT] AS BIGINT) AS [Phone Time Out],
        CAST([PHONE_TIME_TOTAL] AS BIGINT) AS [Phone Time Total],
        CAST([CALLS_HANDLED_TOTAL] AS BIGINT) AS [Calls Handled Total],
        [Row Count] AS [Row Count],
        [PARTITION_ID]
FROM    [dbo].[VW_SUM_SKILLGROUP_INTERVAL] x
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
                        AND i.[ITEM_TYPE_URN] = 95
            ) hierarchyType
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
                ) [skgHier];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_SKILLGROUP_INTERVAL_CUBE]
	TO [portalapp_role]
GO
