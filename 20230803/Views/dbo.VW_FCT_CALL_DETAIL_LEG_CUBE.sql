SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_FCT_CALL_DETAIL_LEG_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  [CALL_DETAIL_LEG_URN] AS [PARTITION_URN],
        [SEQUENCE_NUMBER],
        [DIALED_NUMBER_URN],
            CASE WHEN [dnHier].[DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_0_EXISTS] = 1 THEN 35 * CAST(4294967296 AS BIGINT) + CAST([x].[DIALED_NUMBER_URN] AS BIGINT)
                 ELSE -1
            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_0],
            CASE WHEN [dnHier].[DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_1_EXISTS] = 1 THEN 35 * CAST(4294967296 AS BIGINT) + CAST([x].[DIALED_NUMBER_URN] AS BIGINT)
                 ELSE -1
            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_1],
            CASE WHEN [dnHier].[DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_2_EXISTS] = 1 THEN 35 * CAST(4294967296 AS BIGINT) + CAST([x].[DIALED_NUMBER_URN] AS BIGINT)
                 ELSE -1
            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_2],
            CASE WHEN [dnHier].[DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_3_EXISTS] = 1 THEN 35 * CAST(4294967296 AS BIGINT) + CAST([x].[DIALED_NUMBER_URN] AS BIGINT)
                 ELSE -1
            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_3],
            CASE WHEN [dnHier].[DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_4_EXISTS] = 1 THEN 35 * CAST(4294967296 AS BIGINT) + CAST([x].[DIALED_NUMBER_URN] AS BIGINT)
                 ELSE -1
            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_4],
            
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
            
        [CALL_OUTCOME_URN],
        [CALL_DETAIL_URN],
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
        [DURATION_TIMEBAND_URN],
        [SEGMENT_TIME_TIMEBAND_URN],
        [NETWORK_Q_TIME_TIMEBAND_URN],
        [IVR_TALK_TIME_TIMEBAND_URN], 
 
            -- Optional foreign keys 
        [ROUTE_URN],
        [LABEL_URN],
        [FINAL_LABEL_URN],
        [CLI_NNG_URN],
        [CLI_NNG_URN] AS [FRANCE_CLI_NNG_URN],
        [CLI_NNG_URN] AS [UK_CLI_NNG_URN],
        [CLI_NNG_URN] AS [US_CLI_NNG_URN],
        [CLI_URN],
        [SCRIPT_URN],
        [VALUE_URN] AS [Value],                  -- Assuming a 5 point Value system 
        [SATISFACTION_URN] AS [Satisfaction],    -- Assuming a 5 point Satisfaction system 
        [RATING_PERIOD_URN],
        [CHARGEBAND_URN],
        [CLI_STRING],
        [MEDIA_ROUTING_DOMAIN_URN],
        [REQUEST_TYPE_URN],
        [ORIGINATOR_TYPE_URN],
        [TARGET_TYPE_URN],
        [MESSAGE_ORIGIN_URN],
        [CLUSTER_RESOURCE_URN],
        [FINAL_SCRIPT_NODE],
        [SOURCE_ERROR_CODE],
        [CUSTOM_DIMENSION_0],
        [CUSTOM_DIMENSION_1],
        [CUSTOM_DIMENSION_2],
        [CUSTOM_DIMENSION_3],
        [CUSTOM_DIMENSION_4],
        [CUSTOM_DIMENSION_5],
        [CUSTOM_DIMENSION_6],
        [CUSTOM_DIMENSION_7],
        [CUSTOM_DIMENSION_8],
        [CUSTOM_DIMENSION_9],
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
 
            -- Measures 
        CAST([DURATION] AS BIGINT) AS [Duration],
        CAST([SCRIPT_COUNT] AS BIGINT) AS [Script Count],
        CAST([SEGMENT_TIME] AS BIGINT) AS [Segment Time],
        CAST([NETWORK_Q_TIME] AS BIGINT) AS [Network Queue Time],
        CAST(COALESCE([IVR_TALK_TIME], 0) AS BIGINT) AS [IVR Duration Total],
        [COST] AS [COST],
        [Row Count],
        CASE [CALL_OUTCOME_URN]
          WHEN 1 THEN 1
          ELSE 0
        END AS [Effective Total],
        CASE [CALL_OUTCOME_URN]
          WHEN 0 THEN 1
          ELSE 0
        END AS [Ineffective Total],
        CASE WHEN [CALL_OUTCOME_URN] = 1
                  AND [IVR_TALK_TIME] IS NOT NULL THEN 1
             ELSE 0
        END AS [IVR Effective Total],
        CASE WHEN [CALL_OUTCOME_URN] = 0
                  AND [IVR_TALK_TIME] IS NOT NULL THEN 1
             ELSE 0
        END AS [IVR Ineffective Total],
        CASE WHEN [IVR_TALK_TIME] IS NOT NULL THEN 1
             ELSE 0
        END AS [IVR Call Volume Total],
        CASE WHEN [CALL_OUTCOME_URN] = 1
                  AND [IVR_TALK_TIME] IS NOT NULL THEN [IVR_TALK_TIME]
             ELSE 0
        END AS [IVR Effective Duration],
        CASE WHEN [CALL_OUTCOME_URN] = 0
                  AND [IVR_TALK_TIME] IS NOT NULL THEN [IVR_TALK_TIME]
             ELSE 0
        END AS [IVR Ineffective Duration],
        CAST([ROUTER_Q_TIME] AS BIGINT) AS [Router Queue Time],
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
        [PARTITION_ID]
FROM    [dbo].[VW_FCT_CALL_DETAIL_LEG] x
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
                        AND i.[ITEM_TYPE_URN] IN ( 12, 35 )
            ) hierarchyType
    OUTER APPLY ( SELECT    CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_0] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_0] = 1 THEN 1
                                 ELSE 0
                            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_0_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_1] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_1] = 1 THEN 1
                                 ELSE 0
                            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_1_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_2] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_2] = 1 THEN 1
                                 ELSE 0
                            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_2_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_3] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_3] = 1 THEN 1
                                 ELSE 0
                            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_3_EXISTS],
                            CASE WHEN [hierarchyType].[ST_CUSTOM_HIERARCHY_4] = 1
                                      AND [a].[ST_CUSTOM_HIERARCHY_4] = 1 THEN 1
                                 ELSE 0
                            END AS [DIALED_NUMBER_URN_BY_CUSTOM_HIERARCHY_4_EXISTS]
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
                              WHERE     [a].[ITEM_TYPE_URN] = 35
                                        AND [c].[ITEM_SUBTYPE_ID] IN ( '00000070-0000-0000-0000-000000000001', '00000070-0000-0000-0000-000000000002',
                                                                       '00000070-0000-0000-0000-000000000003', '00000070-0000-0000-0000-000000000004',
                                                                       '00000070-0000-0000-0000-000000000005' )
                              GROUP BY  [a].[ITEM_URN]
                            ) [a]
                  WHERE     [a].[ITEM_URN] = [x].[DIALED_NUMBER_URN]
                ) [dnHier]
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
                ) [ctHier];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CALL_DETAIL_LEG_CUBE]
	TO [portalapp_role]
GO
