SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CLASSIFICATION_CUBE]
WITH SCHEMABINDING
AS


WITH [clcte] 
     AS (SELECT [c].[ITEM_URN]              AS [ROOT_URN], 
                [c].[ITEM_URN]              AS [ITEM_URN], 
                [c].[NAME]                  AS [ITEM_NAME], 
                [t].[ITEM_BIZ_URN]          AS [TENANT_BIZ_URN], 
                [t].[NAME]                  AS [TENANT_NAME], 
                [s].[NAME]                  AS [CLASSIFICATION_SUBTYPE_NAME], 
                [c].[PATH]                  AS [PATH],
                [c].[ITEM_URN]              AS [CATEGORY0_URN], 
                [c].[NAME]                  AS [CATEGORY0_NAME], 
                CAST('/'+REPLACE([c].[NAME], '/', '|')+'/'  AS NVARCHAR(4000)) AS [CATEGORY0_PATH],
                -1 AS [CATEGORY1_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY1_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY1_PATH],
                -1 AS [CATEGORY2_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY2_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY2_PATH],
                -1 AS [CATEGORY3_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY3_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY3_PATH],
                -1 AS [CATEGORY4_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY4_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY4_PATH],
                -1 AS [CATEGORY5_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY5_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY5_PATH],
                -1 AS [CATEGORY6_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY6_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY6_PATH],
                -1 AS [CATEGORY7_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY7_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY7_PATH],
                -1 AS [CATEGORY8_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY8_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY8_PATH],
                -1 AS [CATEGORY9_URN], CAST('NA' AS NVARCHAR(100)) AS [CATEGORY9_NAME], CAST('NA' AS NVARCHAR(4000)) AS [CATEGORY9_PATH], 
                 0 AS [LEVEL] 
        FROM   [dbo].[TB_DIM_CATEGORY] [c] 
        INNER JOIN [dbo].[TB_DIM_TENANT] [t] ON [c].[TENANT_BIZ_URN] = [t].[ITEM_BIZ_URN] 
                                              AND [t].[LATEST] = 1 
        INNER JOIN [dbo].[TE_DIM_ITEM_SUBTYPE] [s] ON [c].[ITEM_SUBTYPE_ID] = [s].[ITEM_SUBTYPE_ID] 
                                              AND [s].[ITEM_SUBTYPE_ID] IN ('41D7A72E-1489-430E-8FBF-9BBD6BC6EE74', -- Category Subtype (ST_CLASSIFICATION)    
                                                                            '39BB583E-81E4-414A-9A23-DAFDEA5B9E99' -- Resolution Code Subtype (ST_RESOLUTION_CODE)        
                                                                            ) 
        WHERE  [c].[ROOT_CATEGORY_BIZ_URN] = -1 
        UNION ALL 
        SELECT [clcte].[ROOT_URN], 
               [cN].[ITEM_URN], 
               [cN].[NAME], 
               [clcte].[TENANT_BIZ_URN], 
               [clcte].[TENANT_NAME], 
               [clcte].[CLASSIFICATION_SUBTYPE_NAME], 
               [cN].[PATH], 
               CASE 
                 WHEN [clcte].[LEVEL] = 0 
                      AND [clcte].[ROOT_URN] = [cN].[ITEM_URN] THEN 
                 [cN].[ITEM_URN] 
                 ELSE [clcte].[CATEGORY0_URN] 
               END AS [CATEGORY0_URN],                
               CASE 
                 WHEN [clcte].[LEVEL] = 0 
                      AND [clcte].[ROOT_URN] = [cN].[ITEM_URN] THEN [cN].[NAME] 
                 ELSE [clcte].[CATEGORY0_NAME] 
                END AS [CATEGORY0_NAME], 
                [clcte].[CATEGORY0_PATH],
                CASE 
                  WHEN [clcte].[LEVEL] = 0 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY1_URN] 
                END AS [CATEGORY1_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 0 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [cN].[NAME] 
                  ELSE [clcte].[CATEGORY1_NAME] 
                END AS [CATEGORY1_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 0 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY0_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY1_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY1_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 1 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY2_URN] 
                END AS [CATEGORY2_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 1 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY2_NAME] 
                END AS [CATEGORY2_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 1 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY1_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY2_PATH] 
                END  AS NVARCHAR(4000)) AS [CATEGORY2_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 2 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY3_URN] 
                END AS [CATEGORY3_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 2 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY3_NAME] 
                END AS [CATEGORY3_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 2 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY2_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY3_PATH] 
                END  AS NVARCHAR(4000)) AS [CATEGORY3_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 3 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY4_URN] 
                END AS [CATEGORY4_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 3 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY4_NAME] 
                END AS [CATEGORY4_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 3 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY3_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY4_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY4_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 4 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY5_URN] 
                END AS [CATEGORY5_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 4 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY5_NAME] 
                END AS [CATEGORY5_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 4 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY4_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY5_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY5_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 5 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY6_URN] 
                END AS [CATEGORY6_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 5 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY6_NAME] 
                END AS [CATEGORY6_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 5 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY5_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY6_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY6_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 6 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY7_URN] 
                END AS [CATEGORY7_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 6 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY7_NAME] 
                END AS [CATEGORY7_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 6 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY6_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY7_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY7_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 7 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY8_URN] 
                END AS [CATEGORY8_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 7 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY8_NAME] 
                END AS [CATEGORY8_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 7 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY7_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY8_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY8_PATH], 
                CASE 
                  WHEN [clcte].[LEVEL] = 8 THEN [cN].[ITEM_URN] 
                  ELSE [clcte].[CATEGORY9_URN] 
                END AS [CATEGORY9_URN], 
                CASE 
                  WHEN [clcte].[LEVEL] = 8 THEN [cN].[NAME] 
                  ELSE [clcte].[CATEGORY9_NAME] 
                END AS [CATEGORY9_NAME], 
                CAST(CASE 
                  WHEN [clcte].[LEVEL] = 8 
                       AND [clcte].[ROOT_URN] <> [cN].[ITEM_URN] THEN 
                  [clcte].[CATEGORY8_PATH] + REPLACE([cN].[NAME], '/', '|')  + '/'
                  ELSE [clcte].[CATEGORY9_PATH] 
                END AS NVARCHAR(4000)) AS [CATEGORY9_PATH], 
                [clcte].[LEVEL] + 1 
         FROM   [dbo].[TB_DIM_CATEGORY] AS [cN] 
                INNER JOIN [clcte]                        ON [cN].[HIERARCHY_PARENT_URN] = [clcte].[ITEM_URN] 
         WHERE  [cN].[ROOT_CATEGORY_BIZ_URN] > -1 
                AND ( [clcte].[LEVEL] + 1 ) < 10) 
SELECT [base].[ITEM_URN] AS [CLASSIFICATION_URN], 
       [base].[ITEM_NAME] AS [CLASSIFICATION_NAME], 
       [base].[TENANT_BIZ_URN], [base].[TENANT_NAME], 
       [base].[CLASSIFICATION_SUBTYPE_NAME], [base].[PATH], 
       [base].[CATEGORY0_URN], [base].[CATEGORY0_NAME], [base].[CATEGORY0_PATH],
       [base].[CATEGORY1_URN], [base].[CATEGORY1_NAME], [base].[CATEGORY1_PATH],
       [base].[CATEGORY2_URN], [base].[CATEGORY2_NAME], [base].[CATEGORY2_PATH],
       [base].[CATEGORY3_URN], [base].[CATEGORY3_NAME], [base].[CATEGORY3_PATH],
       [base].[CATEGORY4_URN], [base].[CATEGORY4_NAME], [base].[CATEGORY4_PATH],
       [base].[CATEGORY5_URN], [base].[CATEGORY5_NAME], [base].[CATEGORY5_PATH],
       [base].[CATEGORY6_URN], [base].[CATEGORY6_NAME], [base].[CATEGORY6_PATH],
       [base].[CATEGORY7_URN], [base].[CATEGORY7_NAME], [base].[CATEGORY7_PATH],
       [base].[CATEGORY8_URN], [base].[CATEGORY8_NAME], [base].[CATEGORY8_PATH],
       [base].[CATEGORY9_URN], [base].[CATEGORY9_NAME], [base].[CATEGORY9_PATH]
FROM   [clcte] [base] 
UNION 
SELECT  [static].[CLASSIFICATION_URN],
        [static].[CLASSIFICATION_NAME],
        [static].[TENANT_BIZ_URN],
        [static].[TENANT_NAME],
        [static].[CLASSIFICATION_SUBTYPE_NAME],
        [static].[PATH],
        [static].[CATEGORY0_URN], [static].[CATEGORY0_NAME], [static].[CATEGORY0_PATH],
        [static].[CATEGORY1_URN], [static].[CATEGORY1_NAME], [static].[CATEGORY1_PATH],
        [static].[CATEGORY2_URN], [static].[CATEGORY2_NAME], [static].[CATEGORY2_PATH],
        [static].[CATEGORY3_URN], [static].[CATEGORY3_NAME], [static].[CATEGORY3_PATH],
        [static].[CATEGORY4_URN], [static].[CATEGORY4_NAME], [static].[CATEGORY4_PATH],
        [static].[CATEGORY5_URN], [static].[CATEGORY5_NAME], [static].[CATEGORY5_PATH],
        [static].[CATEGORY6_URN], [static].[CATEGORY6_NAME], [static].[CATEGORY6_PATH],
        [static].[CATEGORY7_URN], [static].[CATEGORY7_NAME], [static].[CATEGORY7_PATH],
        [static].[CATEGORY8_URN], [static].[CATEGORY8_NAME], [static].[CATEGORY8_PATH],
        [static].[CATEGORY9_URN], [static].[CATEGORY9_NAME], [static].[CATEGORY9_PATH]
FROM    (VALUES (-2, 'None', 
                 -1, 'Unknown', 
                 'None', 'None', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA', 
                 -1, 'NA', 'NA'),
         (-1, 'Unknown', 
          -1, 'Unknown', 
          'None', 'None', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA', 
          -1, 'NA', 'NA') ) [static] 
         ([CLASSIFICATION_URN], [CLASSIFICATION_NAME], 
          [TENANT_BIZ_URN], [TENANT_NAME], 
          [CLASSIFICATION_SUBTYPE_NAME], [PATH], 
          [CATEGORY0_URN], [CATEGORY0_NAME], [CATEGORY0_PATH], 
          [CATEGORY1_URN], [CATEGORY1_NAME], [CATEGORY1_PATH], 
          [CATEGORY2_URN], [CATEGORY2_NAME], [CATEGORY2_PATH], 
          [CATEGORY3_URN], [CATEGORY3_NAME], [CATEGORY3_PATH], 
          [CATEGORY4_URN], [CATEGORY4_NAME], [CATEGORY4_PATH], 
          [CATEGORY5_URN], [CATEGORY5_NAME], [CATEGORY5_PATH], 
          [CATEGORY6_URN], [CATEGORY6_NAME], [CATEGORY6_PATH], 
          [CATEGORY7_URN], [CATEGORY7_NAME], [CATEGORY7_PATH], 
          [CATEGORY8_URN], [CATEGORY8_NAME], [CATEGORY8_PATH], 
          [CATEGORY9_URN], [CATEGORY9_NAME], [CATEGORY9_PATH]);
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CLASSIFICATION_CUBE]
	TO [portalapp_role]
GO
