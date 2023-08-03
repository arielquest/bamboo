SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_REPEAT_INTERACTION_EVENT_CUBE]
AS
    SELECT  [x].[PARTITION_URN],
            [x].[PARTITION_ID],
            [x].[FINAL_AGENT_URN],
            CASE WHEN [hier].[AGENT_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [hier].[AGENT_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [hier].[AGENT_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [hier].[AGENT_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [hier].[AGENT_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_URN_BY_CUSTOM_HIERARCHY_4],
            [x].[FINAL_AGENT_TEAM_URN],
            CASE WHEN [hier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [hier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [hier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [hier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [hier].[AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 3 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_AGENT_TEAM_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_4],
            [x].[FINAL_CALL_TYPE_URN],
            CASE WHEN [hier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [hier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [hier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [hier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [hier].[CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 12 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_CALL_TYPE_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_4],
            [x].[FINAL_SKILLGROUP_URN],
            CASE WHEN [hier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [hier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [hier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [hier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [hier].[SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 95 * CAST(4294967296 AS BIGINT) + CAST([x].[FINAL_SKILLGROUP_URN] AS BIGINT)
                 ELSE -1
            END AS [FINAL_SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_4],
            [x].[FINAL_PRECISION_QUEUE_URN],
            [x].[CLUSTER_RESOURCE_URN],
            [x].[FINAL_CALL_DRIVER_CATEGORY_URN],
            [x].[FINAL_WRAPUP_CODE_URN],
            [x].[FINAL_DISPOSITION_CODE_URN],
            [x].[CONTACT_URN],
            [x].[CHANNEL_ADDRESS_URN],
            [x].[EVENT_TYPE],
            [x].[TIMEBAND_URN],
            [x].[IS_REPEAT],
            [x].[CHAIN_ID],
            [x].[SEQUENCE],
            [x].[ORIGINAL_CONTACT_ID],
            [x].[CONTACT_ID],
            [x].[FINAL_QUEUE_URN],
            [x].[EVENT_DATE_URN_UTC],
            [x].[EVENT_TIME_URN_UTC],
            [tzd].[OLAP_DATETIME_UTC] AS [EVENT_DATETIME_UTC_URN],
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
            [x].[CALL_KEY] AS [Call Key],
            CAST([x].[DURATION] AS BIGINT) AS [Duration],
            CAST([x].[QUEUE_TIME] AS BIGINT) AS [Queue Time],
            CAST([x].[TRANSFER_COUNT] AS BIGINT) AS [Transfer Count],
            [x].[REPEAT_TRIGGERED] AS [Repeat Triggered],
            [x].[REPEAT_TRIGGERED_T1] AS [Repeat Triggered Timeband 1],
            [x].[REPEAT_TRIGGERED_T2] AS [Repeat Triggered Timeband 2],
            [x].[REPEAT_TRIGGERED_T3] AS [Repeat Triggered Timeband 3],
            [x].[REPEAT_TRIGGERED_T4] AS [Repeat Triggered Timeband 4],
            CAST(CASE WHEN [x].[NON_REPEAT_T1] = 1
                           AND [x].[REPEAT_TRIGGERED_T1] > 0 THEN [x].[REPEAT_TRIGGERED_T1]
                      ELSE 0
                 END AS BIGINT) AS [Unique Triggered Repeat Timeband 1],
            CAST(CASE WHEN [x].[NON_REPEAT_T2] = 1
                           AND [x].[REPEAT_TRIGGERED_T2] > 0 THEN [x].[REPEAT_TRIGGERED_T2]
                      ELSE 0
                 END AS BIGINT) AS [Unique Triggered Repeat Timeband 2],
            CAST(CASE WHEN [x].[NON_REPEAT_T3] = 1
                           AND [x].[REPEAT_TRIGGERED_T3] > 0 THEN [x].[REPEAT_TRIGGERED_T3]
                      ELSE 0
                 END AS BIGINT) AS [Unique Triggered Repeat Timeband 3],
            CAST(CASE WHEN [x].[NON_REPEAT_T4] = 1
                           AND [x].[REPEAT_TRIGGERED_T4] > 0 THEN [x].[REPEAT_TRIGGERED_T4]
                      ELSE 0
                 END AS BIGINT) AS [Unique Triggered Repeat Timeband 4],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T1] = 1
                           AND [x].[REPEAT_TRIGGERED_T1] > 0 THEN [x].[REPEAT_TRIGGERED_T1]
                      ELSE 0
                 END AS BIGINT) AS [Repeat Triggered Repeat Timeband 1],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T2] = 1
                           AND [x].[REPEAT_TRIGGERED_T2] > 0 THEN [x].[REPEAT_TRIGGERED_T2]
                      ELSE 0
                 END AS BIGINT) AS [Repeat Triggered Repeat Timeband 2],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T3] = 1
                           AND [x].[REPEAT_TRIGGERED_T3] > 0 THEN [x].[REPEAT_TRIGGERED_T3]
                      ELSE 0
                 END AS BIGINT) AS [Repeat Triggered Repeat Timeband 3],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T4] = 1
                           AND [x].[REPEAT_TRIGGERED_T4] > 0 THEN [x].[REPEAT_TRIGGERED_T4]
                      ELSE 0
                 END AS BIGINT) AS [Repeat Triggered Repeat Timeband 4],
            [x].[REPEAT_RECEIVED] AS [Repeat Received],
            [x].[REPEAT_RECEIVED_T1] AS [Repeat Received Timeband 1],
            [x].[REPEAT_RECEIVED_T2] AS [Repeat Received Timeband 2],
            [x].[REPEAT_RECEIVED_T3] AS [Repeat Received Timeband 3],
            [x].[REPEAT_RECEIVED_T4] AS [Repeat Received Timeband 4],
            [x].[NON_REPEAT] AS [Unique Received],
            ISNULL([UniqueReceived].[NON_REPEAT_T1], 0) AS [Unique Received Timeband 1],
            ISNULL([UniqueReceived].[NON_REPEAT_T2], 0) AS [Unique Received Timeband 2],
            ISNULL([UniqueReceived].[NON_REPEAT_T3], 0) AS [Unique Received Timeband 3],
            ISNULL([UniqueReceived].[NON_REPEAT_T4], 0) AS [Unique Received Timeband 4],
            CAST(CASE WHEN [x].[NON_REPEAT] = 1
                           AND [x].[REPEAT_TRIGGERED] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) AS [Unique Effective],
            CAST(CASE WHEN [x].[NON_REPEAT_T1] = 1
                           AND [x].[REPEAT_TRIGGERED_T1] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Effective Timeband 1],
            CAST(CASE WHEN [x].[NON_REPEAT_T2] = 1
                           AND [x].[REPEAT_TRIGGERED_T2] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Effective Timeband 2],
            CAST(CASE WHEN [x].[NON_REPEAT_T3] = 1
                           AND [x].[REPEAT_TRIGGERED_T3] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Effective Timeband 3],
            CAST(CASE WHEN [x].[NON_REPEAT_T4] = 1
                           AND [x].[REPEAT_TRIGGERED_T4] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Effective Timeband 4],
            CAST(CASE WHEN [x].[NON_REPEAT] = 1
                           AND [x].[REPEAT_TRIGGERED] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) AS [Unique Ineffective],
            CAST(CASE WHEN [x].[NON_REPEAT_T1] = 1
                           AND [x].[REPEAT_TRIGGERED_T1] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Ineffective Timeband 1],
            CAST(CASE WHEN [x].[NON_REPEAT_T2] = 1
                           AND [x].[REPEAT_TRIGGERED_T2] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Ineffective Timeband 2],
            CAST(CASE WHEN [x].[NON_REPEAT_T3] = 1
                           AND [x].[REPEAT_TRIGGERED_T3] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Ineffective Timeband 3],
            CAST(CASE WHEN [x].[NON_REPEAT_T4] = 1
                           AND [x].[REPEAT_TRIGGERED_T4] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Unique Ineffective Timeband 4],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED] = 1
                           AND [x].[REPEAT_TRIGGERED] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) AS [Repeat Effective],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T1] = 1
                           AND [x].[REPEAT_TRIGGERED_T1] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Effective Timeband 1],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T2] = 1
                           AND [x].[REPEAT_TRIGGERED_T2] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Effective Timeband 2],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T3] = 1
                           AND [x].[REPEAT_TRIGGERED_T3] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Effective Timeband 3],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T4] = 1
                           AND [x].[REPEAT_TRIGGERED_T4] = 0
                           AND NOT ( [x].[FINAL_AGENT_URN] = -1
                                     OR [x].[DURATION] <= 5
                                   ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Effective Timeband 4],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED] = 1
                           AND [x].[REPEAT_TRIGGERED] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) AS [Repeat Ineffective],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T1] = 1
                           AND [x].[REPEAT_TRIGGERED_T1] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Ineffective Timeband 1],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T2] = 1
                           AND [x].[REPEAT_TRIGGERED_T2] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Ineffective Timeband 2],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T3] = 1
                           AND [x].[REPEAT_TRIGGERED_T3] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Ineffective Timeband 3],
            CAST(CASE WHEN [x].[REPEAT_RECEIVED_T4] = 1
                           AND [x].[REPEAT_TRIGGERED_T4] = 0
                           AND ( [x].[FINAL_AGENT_URN] = -1
                                 OR [x].[DURATION] <= 5
                               ) THEN 1
                      ELSE 0
                 END AS BIGINT) [Repeat Ineffective Timeband 4],
            [x].[Row Count] AS [Row Count]
    FROM    [dbo].[VW_FCT_REPEAT_INTERACTION_EVENT] [x]
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] [t] ON [x].[EVENT_TIME_URN_UTC] = [t].[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] [tzd] ON [tzd].[DATE_UTC_URN] = [x].[EVENT_DATE_URN_UTC]
                                                      AND [tzd].[TIME_UTC_URN] = [t].[QUARTER_HOUR_URN]
    LEFT OUTER JOIN ( SELECT    [CALL_KEY],
                                [EVENT_TYPE],
                                MIN([PARTITION_GLOBAL_URN]) AS [MIN_PARTITION_GLOBAL_URN],
                                MAX([NON_REPEAT_T1]) AS [NON_REPEAT_T1],
                                MAX([NON_REPEAT_T2]) AS [NON_REPEAT_T2],
                                MAX([NON_REPEAT_T3]) AS [NON_REPEAT_T3],
                                MAX([NON_REPEAT_T4]) AS [NON_REPEAT_T4]
                      FROM      [dbo].[VW_FCT_REPEAT_INTERACTION_EVENT]
                      GROUP BY  [CALL_KEY],
                                [EVENT_TYPE]
                    ) [UniqueReceived] ON [UniqueReceived].[MIN_PARTITION_GLOBAL_URN] = [x].[PARTITION_GLOBAL_URN]
    OUTER APPLY ( SELECT    MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_0' THEN 1
                                END) AS [ST_CUSTOM_HIERARCHY_0],
                            MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_1' THEN 1
                                END) AS [ST_CUSTOM_HIERARCHY_1],
                            MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_2' THEN 1
                                END) AS [ST_CUSTOM_HIERARCHY_2],
                            MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_3' THEN 1
                                END) AS [ST_CUSTOM_HIERARCHY_3],
                            MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_4' THEN 1
                                END) AS [ST_CUSTOM_HIERARCHY_4]
                  FROM      [dbo].[TB_DIM_HIERARCHY] [a]
                  INNER JOIN [dbo].[TE_DIM_ITEM_SUBTYPE] [b] ON [a].[ITEM_SUBTYPE_ID] = [b].[ITEM_SUBTYPE_ID]
                  INNER JOIN [dbo].[TB_DIM_HIERARCHY_NODE] [n] ON [a].[ITEM_URN] = [n].[HIERARCHY_BUSINESS_URN]
                  INNER JOIN [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] [i] ON [n].[ITEM_URN] = [i].[HIERARCHY_NODE_URN]
                  WHERE     [b].[INTERNAL_NAME] IN ( 'ST_CUSTOM_HIERARCHY_0', 'ST_CUSTOM_HIERARCHY_1', 'ST_CUSTOM_HIERARCHY_2', 'ST_CUSTOM_HIERARCHY_3',
                                                     'ST_CUSTOM_HIERARCHY_4' )
                            AND [a].[LATEST] = 1
                            AND [i].[ITEM_TYPE_URN] IN ( 1, 3, 12, 95 )
                ) [hierarchyType]
    OUTER APPLY ( SELECT    CASE WHEN [ITEM_TYPE_URN] = 1
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 1
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 1
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 1
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 1
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_URN_BY_CUSTOM_HIERARCHY_4_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 3
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 3
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 3
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 3
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [ITEM_TYPE_URN] = 3
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [AGENT_TEAM_URN_BY_CUSTOM_HIERARCHY_4_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 12
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 12
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 12
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 12
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 12
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [CALL_TYPE_URN_BY_CUSTOM_HIERARCHY_4_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 95
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 95
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 95
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 95
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [a].[ITEM_TYPE_URN] = 95
                                      AND [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [SKILLGROUP_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
                  FROM      ( SELECT    [a].[ITEM_URN],
                                        [a].[ITEM_TYPE_URN],
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
                              WHERE     [a].[ITEM_TYPE_URN] IN ( 1, 3, 12, 95 )
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN],
                                        [a].[ITEM_TYPE_URN]
                            ) [a]
                  WHERE     ( [a].[ITEM_URN] = [x].[FINAL_AGENT_URN]
                              AND [ITEM_TYPE_URN] = 1
                            )
                            OR ( [ITEM_TYPE_URN] = 3
                                 AND [a].[ITEM_URN] = [x].[FINAL_AGENT_TEAM_URN]
                               )
                            OR ( [ITEM_TYPE_URN] = 12
                                 AND [a].[ITEM_URN] = [x].[FINAL_CALL_TYPE_URN]
                               )
                            OR ( [a].[ITEM_TYPE_URN] = 95
                                 AND [a].[ITEM_URN] = [x].[FINAL_SKILLGROUP_URN]
                               )
                ) [hier];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_REPEAT_INTERACTION_EVENT_CUBE]
	TO [portalapp_role]
GO
