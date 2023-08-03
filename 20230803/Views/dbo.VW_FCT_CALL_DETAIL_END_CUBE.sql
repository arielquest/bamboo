SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_CALL_DETAIL_END_CUBE]
--WITH ENCRYPTION
AS
SELECT  [CALL_DETAIL_END_URN] AS [PARTITION_URN],
    
            -- Links to other CDRs
        [CALL_DETAIL_URN] AS [CALL_DETAIL_URN],
        [CALL_DETAIL_LEG_URN] AS [CALL_DETAIL_LEG_URN],
        [SEQUENCE_NUMBER] AS [SEQUENCE_NUMBER],
            
            -- Date/Time Dimensions
        [STARTDATE_URN] AS [STARTDATE_URN],
        [STARTTIME_URN] AS [STARTTIME_URN],
        [STARTDATE_UTC_URN] AS [STARTDATE_UTC_URN],
        [STARTTIME_UTC_URN] AS [STARTTIME_UTC_URN],
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
        [NETWORK_TIME_TIMEBAND_URN] AS [NETWORK_TIME_TIMEBAND_URN],
        [DURATION_TIMEBAND_URN] AS [DURATION_TIMEBAND_URN],
        [RING_TIME_TIMEBAND_URN] AS [RING_TIME_TIMEBAND_URN],
        [DELAY_TIME_TIMEBAND_URN] AS [DELAY_TIME_TIMEBAND_URN],
        [ABANDON_TIME_TIMEBAND_URN] AS [ABANDON_TIME_TIMEBAND_URN],
        [HOLD_TIME_TIMEBAND_URN] AS [HOLD_TIME_TIMEBAND_URN],
        [TALK_TIME_TIMEBAND_URN] AS [TALK_TIME_TIMEBAND_URN],
        [WORK_TIME_TIMEBAND_URN] AS [WORK_TIME_TIMEBAND_URN],
        [LOCAL_Q_TIME_TIMEBAND_URN] AS [LOCAL_Q_TIME_TIMEBAND_URN],
        [CONFERENCE_TIME_TIMEBAND_URN] AS [CONFERENCE_TIME_TIMEBAND_URN],
        [SEGMENT_TIME_TIMEBAND_URN] AS [SEGMENT_TIME_TIMEBAND_URN],
            
            -- Additional Dimensions
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
            
        [SUPERVISOR_AGENT_URN] AS [SUPERVISOR_AGENT_URN],
        [ORIGINATING_AGENT_URN] AS [ORIGINATING_AGENT_URN],
        
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
            
        [ROUTE_URN] AS [ROUTE_URN],
        
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
            
        [CLI_NNG_URN] AS [CLI_NNG_URN],
        [CLI_URN] AS [CLI_URN],
        [TRUNK_GROUP_URN] AS [TRUNK_GROUP_URN],
        [CALL_DISPOSITION_URN] AS [CALL_DISPOSITION_URN],
        [TASK_DISPOSITION_URN] AS [TASK_DISPOSITION_URN],
        [VALUE_URN] AS [Value],
        [SATISFACTION_URN] AS [Satisfaction],
        [RATING_PERIOD_URN] AS [RATING_PERIOD_URN],
        [PERIPHERAL_CALL_TYPE_URN] AS [PERIPHERAL_CALL_TYPE_URN],
        
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
            
        [MEDIA_ROUTING_DOMAIN_URN] AS [MEDIA_ROUTING_DOMAIN_URN],
        [CLUSTER_RESOURCE_URN] AS [CLUSTER_RESOURCE_URN],
        x.PRECISION_QUEUE_URN AS [PRECISION_QUEUE_URN],
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
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
                                            
            -- Call Flags                    
        [DEVICE_NUMBER] AS [Device Number],
        [AGENT_PERIPHERAL_NUMBER] AS [Agent Peripheral Number],
        [PERIPHERAL_CALL_TYPE] AS [PERIPHERAL_CALL_TYPE],
        [BAD_CALL] AS [Bad Call],
        [CALL_PRIORITY] AS [Call Priority],
        [NEW_TRANSACTION] AS [New Transaction],
        [SERVICE_LEVEL_MET] AS [Service Level Met],
        [PERIPHERAL_TRUNK_NUMBER] AS [Peripheral Trunk Number],
        CAST(-1 AS INTEGER) AS [Precision Queue Step Order],
            
            -- Call data
        [START_DATE_TIME] AS [Date Time],
        [OUTBOUND_DIGITS] AS [Outbound Digits],
        [WRAPUP_DATA] AS [Wrapup Data],
        CAST(NULL AS VARCHAR(1000)) AS [Attributes],
        
        -1 AS [ROUTED_AGENT_URN],
        -1 AS [ROUTED_SERVICE_URN],
        -1 AS [ROUTED_SKILLGROUP_URN],
        -1 AS [PRECISION_ATTRIBUTE_URN_0],
        -1 AS [PRECISION_ATTRIBUTE_URN_1],
        -1 AS [PRECISION_ATTRIBUTE_URN_2],
        -1 AS [PRECISION_ATTRIBUTE_URN_3],
        -1 AS [PRECISION_ATTRIBUTE_URN_4],
        -1 AS [PRECISION_ATTRIBUTE_URN_5],
        -1 AS [PRECISION_ATTRIBUTE_URN_6],
        -1 AS [PRECISION_ATTRIBUTE_URN_7],
        -1 AS [PRECISION_ATTRIBUTE_URN_8],
        -1 AS [PRECISION_ATTRIBUTE_URN_9],
        [PRECISION_QUEUE_STEP_ORDER],
            
            -- Call Measures
        [Row Count],        
        CAST([ENTERPRISE_QUEUE_DURATION] AS BIGINT) AS [Enterprise Queue Duration],
        CAST([NETWORK_SKILLGROUP_QUEUE_DURATION] AS BIGINT) AS [Network Skillgroup Queue Duration],
        CAST([NETWORK_TIME] AS BIGINT) AS [Network Time],
        CAST([DURATION] AS BIGINT) AS [DURATION],
        CAST([RING_TIME] AS BIGINT) AS [Ring Time],
        CAST([DELAY_TIME] AS BIGINT) AS [Delay Time],
        CAST([ABANDON_TIME] AS BIGINT) AS [Abandon Time],
        CAST([HOLD_TIME] AS BIGINT) AS [Hold Time],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([WORK_TIME] AS BIGINT) AS [Work Time],
        CAST([BILL_RATE] AS BIGINT) AS [Bill Rate],
        CAST([LOCAL_Q_TIME] AS BIGINT) AS [Local Queue Time],
        CAST([CONFERENCE_TIME] AS BIGINT) AS [Conference Time],
        CAST([SEGMENT_TIME] AS BIGINT) AS [Segment Time],
        [COST] AS [COST],
        CAST(( [RING_TIME] + [DELAY_TIME] + [LOCAL_Q_TIME] + [NET_Q_TIME] ) AS BIGINT) AS [Wait Time],
        CAST([CUSTOM_MEASURE_0] AS BIGINT) AS [CUSTOM_MEASURE_0],
        CAST([CUSTOM_MEASURE_1] AS BIGINT) AS [CUSTOM_MEASURE_1],
        CAST([CUSTOM_MEASURE_2] AS BIGINT) AS [CUSTOM_MEASURE_2],
        CAST([CUSTOM_MEASURE_3] AS BIGINT) AS [CUSTOM_MEASURE_3],
        CAST([CUSTOM_MEASURE_4] AS BIGINT) AS [CUSTOM_MEASURE_4],
        CAST([CUSTOM_MEASURE_5] AS BIGINT) AS [CUSTOM_MEASURE_5],
        CAST([CUSTOM_MEASURE_6] AS BIGINT) AS [CUSTOM_MEASURE_6],
        CAST([CUSTOM_MEASURE_7] AS BIGINT) AS [CUSTOM_MEASURE_7],
        CAST([CUSTOM_MEASURE_8] AS BIGINT) AS [CUSTOM_MEASURE_8],
        CAST([CUSTOM_MEASURE_9] AS BIGINT) AS [CUSTOM_MEASURE_9],
        [PARTITION_ID] AS [PARTITION_ID],
        CAST([NET_Q_TIME] AS BIGINT) AS [Network Queue Time],
        COALESCE([WRAP_CODE_1_URN], -1) AS [WRAP_CODE_1_URN],
        COALESCE([WRAP_CODE_2_URN], -1) AS [WRAP_CODE_2_URN],
        COALESCE([WRAP_CODE_3_URN], -1) AS [WRAP_CODE_3_URN],
        COALESCE([WRAP_CODE_4_URN], -1) AS [WRAP_CODE_4_URN],
        COALESCE([WRAP_CODE_5_URN], -1) AS [WRAP_CODE_5_URN]
FROM    [dbo].[VW_FCT_CALL_DETAIL_END] x
INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] t ON [STARTTIME_UTC_URN] = t.[TIME_URN]
INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[STARTDATE_UTC_URN]
                                                AND tzd.[TIME_UTC_URN] = t.[QUARTER_HOUR_URN]
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
                        AND i.[ITEM_TYPE_URN] IN ( 1, 3, 12, 73, 74, 94, 95 )
            ) hierarchyType
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
                ) [serHier]
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
	ON [dbo].[VW_FCT_CALL_DETAIL_END_CUBE]
	TO [portalapp_role]
GO
