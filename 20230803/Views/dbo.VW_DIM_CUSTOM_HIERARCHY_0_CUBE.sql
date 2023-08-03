SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CUSTOM_HIERARCHY_0_CUBE]
AS
-- Common Table expression
WITH    hierarchy_CTE ( [HN_ITEM_URN], [HN_ITEM_BIZ_URN], [HN_ITEM_PARENT_URN], [HN_NAME], [HN_ITEM_TYPE_NAME], [HN_ITEM_TYPE_URN], [HN_ITEM_NAME] )
          AS ( SELECT   [hn].[ITEM_URN] AS [HN_ITEM_URN],
                        [hn].[ITEM_BIZ_URN] AS [HN_ITEM_BIZ_URN],
                        CAST([hn].[HIERARCHY_PARENT_URN] AS BIGINT) AS [HN_ITEM_PARENT_URN],
                        [hn].[NAME] AS [HN_NAME],
                        NULL AS [HN_ITEM_TYPE_NAME],
                        -1 AS [HN_ITEM_TYPE_URN],
                        NULL AS [HN_ITEM_NAME]
               FROM     [dbo].[VW_DIM_HIERARCHY] h
               INNER JOIN [dbo].[TE_DIM_ITEM_SUBTYPE] ts ON [h].[ITEM_TYPE_ID] = [ts].[ITEM_TYPE_ID]
                                                            AND [h].[ITEM_SUBTYPE_ID] = [ts].[ITEM_SUBTYPE_ID]
                                                            AND [ts].[INTERNAL_NAME] = 'ST_CUSTOM_HIERARCHY_0'
               INNER JOIN [dbo].[TB_DIM_HIERARCHY_NODE] hn ON [hn].[HIERARCHY_BUSINESS_URN] = [h].[ITEM_BIZ_URN]
                                                              AND [hn].[EFFECTIVE_FROM] BETWEEN [h].[EFFECTIVE_FROM]
                                                              AND
                                                              [h].[EFFECTIVE_TO]
             )
    SELECT  [innerQ].[ITEM_URN],
            [innerQ].[ITEM_BIZ_URN],
            [innerQ].[ITEM_PARENT_URN],
            [innerQ].[HIERARCHY_NAME],
            [innerQ].[ITEM_TYPE_NAME],
            [innerQ].[ITEM_TYPE_URN],
            [innerQ].[ITEM_NAME],
            -1 AS [FIELD02_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD02],
            -1 AS [FIELD03_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD03],
            -1 AS [FIELD04_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD04],
            -1 AS [FIELD05_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD05],
            -1 AS [FIELD06_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD06],
            -1 AS [FIELD07_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD07],
            -1 AS [FIELD08_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD08],
            -1 AS [FIELD09_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD09],
            -1 AS [FIELD10_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD10],
            -1 AS [FIELD11_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD11],
            -1 AS [FIELD12_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD12],
            -1 AS [FIELD13_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD13],
            -1 AS [FIELD14_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD14],
            -1 AS [FIELD15_URN],
            CAST(NULL AS VARCHAR(159)) AS [FIELD15]
    FROM    ( SELECT    -3 AS [ITEM_URN],
                        -3 AS [ITEM_BIZ_URN],
                        NULL AS [ITEM_PARENT_URN],
                        'None' AS [HIERARCHY_NAME],
                        NULL AS [ITEM_TYPE_NAME],
                        NULL AS [ITEM_TYPE_URN],
                        NULL AS [ITEM_NAME]
              UNION
              SELECT    [st].[ITEM_URN],
                        [st].[ITEM_BIZ_URN],
                        [st].[ITEM_PARENT_URN],
                        [st].[HIERARCHY_NAME],
                        [it].[ITEM_TYPE_NAME],
                        [it].[ITEM_TYPE_URN],
                        [it].[ITEM_NAME]
              FROM      ( SELECT    [ty].[NAME] AS [ITEM_TYPE_NAME],
                                    [ty].[ITEM_TYPE_URN] AS [ITEM_TYPE_URN],
                                    'None' AS [ITEM_NAME]
                          FROM      [dbo].[TE_DIM_ITEM_TYPE] ty
                          WHERE     [ty].[INTERNAL_NAME] = 'IT_ALL'
                        ) it
              CROSS JOIN ( SELECT   -2 AS [ITEM_URN],
                                    -2 AS [ITEM_BIZ_URN],
                                    -3 AS [ITEM_PARENT_URN],
                                    'None' AS [HIERARCHY_NAME]
                           UNION ALL
                           SELECT   -1 AS [ITEM_URN],
                                    -1 AS [ITEM_BIZ_URN],
                                    -3 AS [ITEM_PARENT_URN],
                                    'Unknown' AS [HIERARCHY_NAME]
                         ) st
              UNION
              SELECT    [hierarchy_CTE].[HN_ITEM_URN],
                        [hierarchy_CTE].[HN_ITEM_BIZ_URN],
                        [hierarchy_CTE].[HN_ITEM_PARENT_URN],
                        [hierarchy_CTE].[HN_NAME],
                        [hierarchy_CTE].[HN_ITEM_TYPE_NAME],
                        [hierarchy_CTE].[HN_ITEM_TYPE_URN],
                        [hierarchy_CTE].[HN_ITEM_NAME]
              FROM      [hierarchy_CTE]
              UNION
              SELECT    [i].[GLOBAL_ITEM_URN] AS [ITEM_URN],
                        [i].[GLOBAL_ITEM_BIZ_URN] AS [ITEM_BIZ_URN],
                        ISNULL(CAST([hn].[HN_ITEM_URN] AS BIGINT), -3) AS [ITEM_PARENT_URN],
                        [i].[ITEM_NAME] AS [HIERARCHY_NAME],
                        [it].[NAME] AS [ITEM_TYPE_NAME],
                        [it].[ITEM_TYPE_URN] AS [ITEM_TYPE_URN],
                        [i].[ITEM_NAME] AS [ITEM_NAME]
              FROM      [hierarchy_CTE] hn
              INNER JOIN [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] AS hnm ON [hn].[HN_ITEM_URN] = [hnm].[HIERARCHY_NODE_URN]
              INNER JOIN [dbo].[VW_DIM_ITEM_CUBE] AS i ON [hnm].[ITEM_URN] = [i].[ITEM_URN]
                                                          AND [hnm].[ITEM_TYPE_URN] = [i].[ITEM_TYPE_URN]
              INNER JOIN [dbo].[TE_DIM_ITEM_TYPE] AS it ON [i].[ITEM_TYPE_URN] = [it].[ITEM_TYPE_URN]
              WHERE     [it].[TAXONOMY_ENABLED] = 1
              UNION
      -- This union is used to get the ITEM_BIZ_URN (of a surrogate) that originally was not part of the Hierarchy but has been moved in later. This is to get that surrogate's parent to be set to -3
              SELECT    CAST(CAST([isur].[ITEM_TYPE_URN] AS BIGINT)
                        * 4294967296 + CAST([isur].[ITEM_BIZ_URN] AS BIGINT) AS BIGINT) AS [ITEM_URN],
                        CAST(CAST([isur].[ITEM_TYPE_URN] AS BIGINT)
                        * 4294967296 + CAST([isur].[ITEM_BIZ_URN] AS BIGINT) AS BIGINT) AS [ITEM_BIZ_URN],
                        -3 AS [ITEM_PARENT_URN],
                        [isur].[ITEM_NAME] AS [HIERARCHY_NAME],
                        [isur].[ITEM_TYPE_NAME] AS [ITEM_TYPE_NAME],
                        [isur].[ITEM_TYPE_URN] AS [ITEM_TYPE_URN],
                        [isur].[ITEM_NAME] AS [ITEM_NAME]
              FROM      [hierarchy_CTE] hn
              INNER JOIN [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] AS hnm ON [hn].[HN_ITEM_URN] = [hnm].[HIERARCHY_NODE_URN]
              INNER JOIN [dbo].[VW_DIM_ITEM_CUBE] AS isur ON [hnm].[ITEM_URN] = [isur].[ITEM_URN]
                                                             AND [hnm].[ITEM_TYPE_URN] = [isur].[ITEM_TYPE_URN]
                                                             AND [isur].[ITEM_URN] <> [isur].[ITEM_BIZ_URN]
              OUTER APPLY ( SELECT TOP 1
                                    1 AS [_EXISTS]
                            FROM    [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
                                    AS hnm2
                            INNER JOIN hierarchy_CTE AS hn2 ON [hn2].[HN_ITEM_URN] = [hnm2].[HIERARCHY_NODE_URN]
                            WHERE   [hnm2].[ITEM_URN] = [isur].[ITEM_BIZ_URN]
                                    AND [hnm2].[ITEM_TYPE_URN] = [isur].[ITEM_TYPE_URN]
                          ) AS b ( [_EXISTS] )
              WHERE     COALESCE([b].[_EXISTS], 0) = 0
            ) innerQ;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CUSTOM_HIERARCHY_0_CUBE]
	TO [portalapp_role]
GO
