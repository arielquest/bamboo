SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_AGENT_SKILLGROUP_INTERVAL_CUBE]
AS
SELECT  [SUMMARIZED_URN] AS [PARTITION_URN],
        [AGENT_URN],
            CASE WHEN [agentHier].[AGENT_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [agentHier].[AGENT_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [agentHier].[AGENT_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [agentHier].[AGENT_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [agentHier].[AGENT_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_4],
        
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
            
        [AGENT_TEAM_URN],
            CASE WHEN [agentTeamHier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1
                 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [agentTeamHier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1
                 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [agentTeamHier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1
                 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [agentTeamHier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1
                 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [agentTeamHier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1
                 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_4],
            
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
            
        [PERSON_URN],
            CASE WHEN [personHier].[PERSON_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 74 * CAST(4294967296 AS BIGINT) + CAST([x].[PERSON_URN] AS BIGINT)
                 ELSE -1
            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [personHier].[PERSON_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 74 * CAST(4294967296 AS BIGINT) + CAST([x].[PERSON_URN] AS BIGINT)
                 ELSE -1
            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [personHier].[PERSON_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 74 * CAST(4294967296 AS BIGINT) + CAST([x].[PERSON_URN] AS BIGINT)
                 ELSE -1
            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [personHier].[PERSON_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 74 * CAST(4294967296 AS BIGINT) + CAST([x].[PERSON_URN] AS BIGINT)
                 ELSE -1
            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [personHier].[PERSON_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 74 * CAST(4294967296 AS BIGINT) + CAST([x].[PERSON_URN] AS BIGINT)
                 ELSE -1
            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_4],
        x.PRECISION_QUEUE_URN AS [PRECISION_QUEUE_URN],
        x.PRECISION_ATTRIBUTE_URN_1 AS [PRECISION_ATTRIBUTE_URN_1],
        x.PRECISION_ATTRIBUTE_URN_2 AS [PRECISION_ATTRIBUTE_URN_2],
        x.PRECISION_ATTRIBUTE_URN_3 AS [PRECISION_ATTRIBUTE_URN_3],
        x.PRECISION_ATTRIBUTE_URN_4 AS [PRECISION_ATTRIBUTE_URN_4],
        x.PRECISION_ATTRIBUTE_URN_5 AS [PRECISION_ATTRIBUTE_URN_5],
        x.PRECISION_ATTRIBUTE_URN_6 AS [PRECISION_ATTRIBUTE_URN_6],
        x.PRECISION_ATTRIBUTE_URN_7 AS [PRECISION_ATTRIBUTE_URN_7],
        x.PRECISION_ATTRIBUTE_URN_8 AS [PRECISION_ATTRIBUTE_URN_8],
        x.PRECISION_ATTRIBUTE_URN_9 AS [PRECISION_ATTRIBUTE_URN_9],
        x.PRECISION_ATTRIBUTE_URN_10 AS [PRECISION_ATTRIBUTE_URN_10],
        [SUPERVISOR_AGENT_URN] AS [SUPERVISOR_AGENT_URN],
        [CLUSTER_RESOURCE_URN] AS [CLUSTER_RESOURCE_URN],
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
        CAST([ABANDON_RING_CALLS] AS BIGINT) AS [Abandon Ring Call],
        CAST([ABANDON_RING_TIME] AS BIGINT) AS [Abandon Ring Time],
        CAST([ABANDON_HOLD_CALLS] AS BIGINT) AS [Abandon Hold Call],
        CAST([AGENT_OUT_CALLS_TIME] AS BIGINT) AS [Agent Out Call Time],
        CAST([AGENT_OUT_CALLS_TALK_TIME] AS BIGINT) AS [Agent Out Call Talk Time],
        CAST([AGENT_OUT_CALLS] AS BIGINT) AS [Agent Out Call],
        CAST([AGENT_OUT_CALLS_ON_HOLD] AS BIGINT) AS [Agent Out Call Held],
        CAST([AGENT_OUT_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Agent Out Call Held Time],
        CAST([AGENT_TERMINATED_CALLS] AS BIGINT) AS [Agent Terminated Call],
        CAST([ANSWER_WAIT_TIME] AS BIGINT) AS [Answer Wait Time],
        CAST([AVAIL_TIME] AS BIGINT) AS [Available Time],
        CAST([BUSY_OTHER_TIME] AS BIGINT) AS [Busy Other Time],
        CAST([CALLBACK_MESSAGES_TIME] AS BIGINT) AS [Callback Messages Time],
        CAST([CALLBACK_MESSAGES] AS BIGINT) AS [Callback Messages],
        CAST([CALLS_ANSWERED] AS BIGINT) AS [Call Answered],
        CAST([CALLS_HANDLED] AS BIGINT) AS [Call Handled],
        CAST([CONSULTATIVE_CALLS] AS BIGINT) AS [Consultative Call],
        CAST([CONSULTATIVE_CALLS_TIME] AS BIGINT) AS [Consultative Call Time],
        CAST([CONFERENCED_IN_CALLS] AS BIGINT) AS [Conferenced In Call],
        CAST([CONFERENCED_IN_CALLS_TIME] AS BIGINT) AS [Conferenced In Call Time],
        CAST([CONFERENCED_OUT_CALLS] AS BIGINT) AS [Conferenced Out Call],
        CAST([CONFERENCED_OUT_CALLS_TIME] AS BIGINT) AS [Conferenced Out Call Time],
        CAST([HANDLED_CALLS_TALK_TIME] AS BIGINT) AS [Handled Call Talk Time],
        CAST([HANDLED_CALLS_TIME] AS BIGINT) AS [Handled Call Time],
        CAST([HOLD_TIME] AS BIGINT) AS [Hold Time],
        CAST([INCOMING_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Incoming Call Held Time],
        CAST([INCOMING_CALLS_ON_HOLD] AS BIGINT) AS [Incoming Call Held],
        CAST([INTERNAL_CALLS_ON_HOLD_TIME] AS BIGINT) AS [Internal Call Held Time],
        CAST([INTERNAL_CALLS_ON_HOLD] AS BIGINT) AS [Internal Call Held],
        CAST([INTERNAL_CALLS_RCVD_TIME] AS BIGINT) AS [Internal Call Received Time],
        CAST([INTERNAL_CALLS_RCVD] AS BIGINT) AS [Internal Call Received],
        CAST([INTERNAL_CALLS_TIME] AS BIGINT) AS [Internal Call Time],
        CAST([INTERNAL_CALLS] AS BIGINT) AS [Internal Call],
        CAST([LOGGED_ON_TIME] AS BIGINT) AS [Logged On Time],
        CAST([NOT_READY_TIME] AS BIGINT) AS [Not Ready Time],
        CAST([REDIRECT_NO_ANS_CALLS] AS BIGINT) AS [Redirect No Answer Call],
        CAST([REDIRECT_NO_ANS_CALLS_TIME] AS BIGINT) AS [Redirect No Answer Call Time],
        CAST([RESERVED_STATE_TIME] AS BIGINT) AS [Reserved State Time],
        CAST([SHORT_CALLS] AS BIGINT) AS [Short Call],
        CAST([SUPERV_ASSIST_CALLS_TIME] AS BIGINT) AS [Supervisor Assisted Call Time],
        CAST([SUPERV_ASSIST_CALLS] AS BIGINT) AS [Supervisor Assisted Call],
        CAST([TALK_IN_TIME] AS BIGINT) AS [Talk In Time],
        CAST([TALK_OTHER_TIME] AS BIGINT) AS [Talk Other Time],
        CAST([TALK_OUT_TIME] AS BIGINT) AS [Talk Out Time],
        CAST([TRANSFERRED_IN_CALLS_TIME] AS BIGINT) AS [Transferred In Call Time],
        CAST([TRANSFERRED_IN_CALLS] AS BIGINT) AS [Transferred In Call],
        CAST([TRANSFERRED_OUT_CALLS] AS BIGINT) AS [Transferred Out Call],
        CAST([WORK_NOT_READY_TIME] AS BIGINT) AS [Work Not Ready Time],
        CAST([WORK_READY_TIME] AS BIGINT) AS [Work Ready Time],
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
        CAST([TALK_AUTO_OUT_TIME] AS BIGINT) AS [Talk Auto Out Time],
        CAST([TALK_PREVIEW_TIME] AS BIGINT) AS [Talk Preview Time],
        CAST([TALK_RESERVE_TIME] AS BIGINT) AS [Talk Reserve Time],
        CAST([BARGE_IN_CALLS] AS BIGINT) AS [Barge In Calls],
        CAST([INTERCEPT_CALLS] AS BIGINT) AS [Intercept Calls],
        CAST([MONITOR_CALLS] AS BIGINT) AS [Monitor Calls],
        CAST([WHISPER_CALLS] AS BIGINT) AS [Whisper Calls],
        CAST([EMERGENCY_ASSISTS] AS BIGINT) AS [Emergency Assists],
        CAST([INTERRUPTED_TIME] AS BIGINT) AS [Interrupted Time],
        CAST([ABANDON_HOLD_OUT_CALLS] AS BIGINT) AS [Abandon Hold Out Calls],
        CAST([NET_CONFERENCED_OUT_CALLS_TIME] AS BIGINT) AS [Net Conferenced Out Calls Time],
        CAST([NET_CONFERENCED_OUT_CALLS] AS BIGINT) AS [Net Conferenced Out Calls],
        CAST([NET_CONSULTATIVE_CALLS_TIME] AS BIGINT) AS [Net Consultative Calls Time],
        CAST([NET_CONSULTATIVE_CALLS] AS BIGINT) AS [Net Consultative Calls],
        CAST([NET_TRANSFERED_OUT_CALLS] AS BIGINT) AS [Net Transfered Out Calls],
        CAST([CONSULT_OUT_CALLS] AS BIGINT) AS [Consult Out Calls],
        CAST([CONSULT_OUT_CALLS_TIME] AS BIGINT) AS [Consult Out Calls Time],
        CAST([CALL_TIME_TOTAL] AS BIGINT) AS [Call Time Total],
        CAST([OCCUPANCY_TIME] AS BIGINT) AS [Occupancy Time],
        CAST([PHONE_TIME_IN] AS BIGINT) AS [Phone Time In],
        CAST([PHONE_TIME_OUT] AS BIGINT) AS [Phone Time Out],
        CAST([PHONE_TIME_TOTAL] AS BIGINT) AS [Phone Time Total],
        CAST([CALL_HANDLED_TOTAL] AS BIGINT) AS [Call Handled Total],
        CAST([TRANSFERRED_OUT_TOTAL] AS BIGINT) AS [Transferred Out Total],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([WRAP_TIME] AS BIGINT) AS [Wrap Time],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_AGENT_SKILLGROUP_INTERVAL] x
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
                        AND i.[ITEM_TYPE_URN] IN ( 1, 3, 73, 74, 95 )
            ) hierarchyType
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 1
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[AGENT_URN]
                ) [agentHier]
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
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 3
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[AGENT_TEAM_URN]
                ) [agentTeamHier]
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
                ) [peripheralHier]
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [PERSON_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 74
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[PERSON_URN]
                ) [personHier];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_AGENT_SKILLGROUP_INTERVAL_CUBE]
	TO [portalapp_role]
GO
