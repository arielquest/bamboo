SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- SELECT * FROM TB_FCT_AGENT_EVENT
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_AGENT_EVENT_CUBE]
--WITH ENCRYPTION
AS
    SELECT  [x].[AGENT_EVENT_URN] AS [PARTITION_URN],
            
            [x].[EVENT_DATE_URN]            AS [EVENT_DATE_URN],
            [x].[EVENT_TIME_URN]            AS [EVENT_TIME_URN],
            [x].[EVENT_DATE_UTC_URN]        AS [EVENT_DATE_UTC_URN],
            [x].[EVENT_TIME_UTC_URN]        AS [EVENT_TIME_UTC_URN],
            [tzd].[OLAP_DATETIME_UTC]                 AS [EVENT_DATETIME_UTC_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_0]             AS [TIME_ZONE_0_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_1]             AS [TIME_ZONE_1_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_2]             AS [TIME_ZONE_2_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_3]             AS [TIME_ZONE_3_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_4]             AS [TIME_ZONE_4_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_5]             AS [TIME_ZONE_5_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_6]             AS [TIME_ZONE_6_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_7]             AS [TIME_ZONE_7_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_8]             AS [TIME_ZONE_8_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_9]             AS [TIME_ZONE_9_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_10]            AS [TIME_ZONE_10_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_11]            AS [TIME_ZONE_11_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_12]            AS [TIME_ZONE_12_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_13]            AS [TIME_ZONE_13_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_14]            AS [TIME_ZONE_14_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_15]            AS [TIME_ZONE_15_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_16]            AS [TIME_ZONE_16_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_17]            AS [TIME_ZONE_17_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_18]            AS [TIME_ZONE_18_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_19]            AS [TIME_ZONE_19_URN],
            
            [x].[LOGIN_DATE_URN]            AS [LOGIN_DATE_URN],
            [x].[LOGIN_TIME_URN]            AS [LOGIN_TIME_URN],
            [x].[LOGIN_DATE_UTC_URN]        AS [LOGIN_DATE_UTC_URN],
            [x].[LOGIN_TIME_UTC_URN]        AS [LOGIN_TIME_UTC_URN],
            [tzdd].[OLAP_DATETIME_UTC]     AS [LOGIN_DATETIME_UTC_URN],
            
            
            [x].[AGENT_URN],
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
            
            [x].[AGENT_TEAM_URN],
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
            
            [x].[PERIPHERAL_URN],
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
            
            [x].[PERSON_URN],
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
            
            
            [x].[REASON_CODE_URN]            AS [REASON_CODE_URN],
            [x].[DURATION_TIMEBAND_URN]        AS [DURATION_TIMEBAND_URN],
            [x].[MEDIA_CLASS_URN]             AS [MEDIA_CLASS_URN],
            [x].[MEDIA_ROUTING_DOMAIN_URN]    AS [MEDIA_ROUTING_DOMAIN_URN],
            [x].[SUPERVISOR_AGENT_URN]        AS [SUPERVISOR_AGENT_URN],
            [x].[CLUSTER_RESOURCE_URN]        AS [CLUSTER_RESOURCE_URN],
            [x].[EVENT]                        AS [EVENT],
            
            -1                            AS [FLEXIBLE_DIMENSION_0],
            -1                            AS [FLEXIBLE_DIMENSION_1],
            -1                            AS [FLEXIBLE_DIMENSION_2],
            -1                            AS [FLEXIBLE_DIMENSION_3],
            -1                            AS [FLEXIBLE_DIMENSION_4],
            
            CAST([x].[DURATION] AS BIGINT)                    AS [Duration],
            [x].[PARTITION_ID]                AS [PARTITION_ID],
            [x].[Row Count]                    AS [Row Count]
    FROM [dbo].[VW_FCT_AGENT_EVENT] x
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] t ON [x].[EVENT_TIME_UTC_URN] = [t].[TIME_URN]
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON [x].[LOGIN_TIME_UTC_URN] = [tt].[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON [tzd].[DATE_UTC_URN] = [x].[EVENT_DATE_UTC_URN] AND [tzd].[TIME_UTC_URN] = [t].[QUARTER_HOUR_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzdd ON [tzdd].[DATE_UTC_URN] = [x].[LOGIN_DATE_UTC_URN] AND [tzdd].[TIME_UTC_URN] = [tt].[QUARTER_HOUR_URN]
    OUTER APPLY (SELECT
                 MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_0' AND [a].[LATEST] = 1 THEN 1 END) AS ST_CUSTOM_HIERARCHY_0,
                 MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_1' AND [a].[LATEST] = 1 THEN 1 END) AS ST_CUSTOM_HIERARCHY_1,
                 MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_2' AND [a].[LATEST] = 1 THEN 1 END) AS ST_CUSTOM_HIERARCHY_2,
                 MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_3' AND [a].[LATEST] = 1 THEN 1 END) AS ST_CUSTOM_HIERARCHY_3,
                 MAX(CASE WHEN [b].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_4' AND [a].[LATEST] = 1 THEN 1 END) AS ST_CUSTOM_HIERARCHY_4
                 FROM [dbo].[TB_DIM_HIERARCHY] a
                 INNER JOIN [dbo].[TE_DIM_ITEM_SUBTYPE] b ON [a].[ITEM_SUBTYPE_ID] = [b].[ITEM_SUBTYPE_ID]
                 INNER JOIN [dbo].[TB_DIM_HIERARCHY_NODE] n on [a].[ITEM_URN] = [n].[HIERARCHY_BUSINESS_URN]
                 INNER JOIN [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] i on [n].[ITEM_URN] = [i].[HIERARCHY_NODE_URN]
                 WHERE [b].[INTERNAL_NAME] IN ('ST_CUSTOM_HIERARCHY_0','ST_CUSTOM_HIERARCHY_1','ST_CUSTOM_HIERARCHY_2','ST_CUSTOM_HIERARCHY_3','ST_CUSTOM_HIERARCHY_4') AND [a].[LATEST] = 1
                 AND [i].[ITEM_TYPE_URN] IN (1, 3, 73, 74)
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
	ON [dbo].[VW_FCT_AGENT_EVENT_CUBE]
	TO [portalapp_role]
GO
