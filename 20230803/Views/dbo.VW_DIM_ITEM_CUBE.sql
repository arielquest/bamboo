SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ITEM_CUBE]
AS
SELECT  finalValues.[GLOBAL_ITEM_URN],
        finalValues.[ITEM_URN],
        finalValues.[FOLDER_URN],
        finalValues.[ITEM_NAME],
        COALESCE(finalValues.[FOLDER_NAME], '') AS [FOLDER_NAME],
        [DESCRIPTION],
        [ITEM_TYPE_ID],
        [ITEM_TYPE_URN],
        [ITEM_TYPE_NAME],
        finalValues.[GLOBAL_ITEM_BIZ_URN],
        finalValues.[ITEM_BIZ_URN]
FROM    ( SELECT    -f.[FOLDER_URN] AS [GLOBAL_ITEM_URN],
                    -f.[FOLDER_URN] AS [ITEM_URN],
                    -p.[FOLDER_URN] AS [FOLDER_URN],
                    f.[NAME] AS [ITEM_NAME],
                    NULL AS [FOLDER_NAME],
                    COALESCE(REPLACE(REPLACE(REPLACE(f.DESCRIPTION, CHAR(9),
                                                     ''), CHAR(13), ''),
                                     CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
                    NULL AS [ITEM_TYPE_ID],
                    -1 AS [ITEM_TYPE_URN],
                    NULL AS [ITEM_TYPE_NAME],
                    -1 AS [GLOBAL_ITEM_BIZ_URN],
                    -1 AS [ITEM_BIZ_URN],
                    f.[NAME],
                    f.[PATH]
          FROM      [dbo].[TB_SEC_FOLDER] f
          LEFT OUTER JOIN [dbo].[TB_SEC_FOLDER] p ON f.[PARENT_ID] = p.[FOLDER_ID]
        ) folderHierarchyStuff
CROSS APPLY ( SELECT    [GLOBAL_ITEM_URN],
                        [ITEM_URN],
                        [ITEM_NAME],
                        [GLOBAL_ITEM_BIZ_URN],
                        [ITEM_BIZ_URN],
                        NULL,
                        folderHierarchyStuff.[FOLDER_URN]
              UNION ALL
              SELECT    [GLOBAL_ITEM_URN],
                        [ITEM_URN],
                        [ITEM_NAME],
                        [GLOBAL_ITEM_BIZ_URN],
                        [ITEM_BIZ_URN],
                        folderHierarchyStuff.[NAME],
                        folderHierarchyStuff.[ITEM_URN]
              FROM      ( VALUES ( -2, -2, 'None', -2, -2),
                        ( -1, -1, 'Unknown', -1, -1) ) const ( [GLOBAL_ITEM_URN], [ITEM_URN], [ITEM_NAME], [GLOBAL_ITEM_BIZ_URN], [ITEM_BIZ_URN] )
              WHERE     folderHierarchyStuff.[PATH] = '/Shared'
            ) finalValues ( [GLOBAL_ITEM_URN], [ITEM_URN], [ITEM_NAME],
                            [GLOBAL_ITEM_BIZ_URN], [ITEM_BIZ_URN],
                            [FOLDER_NAME], [FOLDER_URN] )
UNION ALL
-- VW_DIM_ITEM excluding -2 and -1
SELECT  CAST(CAST(ty.[ITEM_TYPE_URN] AS BIGINT) * 4294967296
        + CAST(it.[ITEM_URN] AS BIGINT) AS BIGINT) AS [GLOBAL_ITEM_URN], --[HIERARCHY_URN],
        it.[ITEM_URN] AS [ITEM_URN],
        -fl.[FOLDER_URN] AS [FOLDER_URN], --[HIERARCHY_PARENT_URN],
        it.[NAME] AS [ITEM_NAME], --[HIERARCHY_NAME], AND -- [ITEM_NAME]
        fl.[NAME] AS [FOLDER_NAME],
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
        it.[ITEM_TYPE_ID] AS [ITEM_TYPE_ID],
        it.[ITEM_TYPE_URN] AS [ITEM_TYPE_URN],
        ty.[NAME] AS [ITEM_TYPE_NAME],
        CAST(ISNULL(CAST(ty.[ITEM_TYPE_URN] AS BIGINT) * 4294967296
                    + CAST(it.[ITEM_BIZ_URN] AS BIGINT), -1) AS BIGINT) AS [GLOBAL_ITEM_BIZ_URN],
        ISNULL(it.[ITEM_BIZ_URN], -1) AS [ITEM_BIZ_URN]
FROM    [dbo].[VW_DIM_ITEM] it
INNER JOIN [dbo].[TE_DIM_ITEM_TYPE] ty ON it.[ITEM_TYPE_ID] = ty.[ITEM_TYPE_ID]
INNER JOIN [dbo].[TB_SEC_FOLDER] fl ON it.[FOLDER_ID] = fl.[FOLDER_ID]
WHERE   it.[ITEM_URN] NOT IN ( -1, -2 )
        AND it.ITEM_TYPE_ID IN ( '00001100-1000-0000-0000-000000000010',
                                 '00001200-1000-0000-0000-000000000010',
                                 '00001500-1000-0000-0000-000000000010',
                                 '00001600-1000-0000-0000-000000000010',
                                 '00001700-1000-0000-0000-000000000010',
                                 '00002400-1000-0000-0000-000000000010',
                                 '00006200-1000-0000-0000-000000000010',
                                 '00007500-1000-0000-0000-000000000010',
                                 '00007600-1000-0000-0000-000000000010',
                                 '00003150-1000-0000-0000-000000000010' )
UNION ALL
SELECT  CAST(CAST(e.[ITEM_TYPE_URN] AS BIGINT) * 4294967296
        + CAST(e.[ITEM_BIZ_URN] AS BIGINT) AS BIGINT) AS [GLOBAL_ITEM_URN],
        e.[ITEM_BIZ_URN] AS [ITEM_URN],
        -1 AS [FOLDER_URN],
        'Deleted ' + CAST(t.[NAME] AS NVARCHAR(100)) + ' '
        + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [ITEM_NAME],
        'Deleted Dimensions' AS [FOLDER_NAME],
        'This dimension does not exist in VIM anymore.' AS [DESCRIPTION],
        e.[ITEM_TYPE_ID] AS [ITEM_TYPE_ID],
        e.[ITEM_TYPE_URN] AS [ITEM_TYPE_URN],
        t.[NAME] AS [ITEM_TYPE_NAME],
        CAST(ISNULL(CAST(e.[ITEM_TYPE_URN] AS BIGINT) * 4294967296
                    + CAST(e.[ITEM_BIZ_URN] AS BIGINT), -1) AS BIGINT) AS [GLOBAL_ITEM_BIZ_URN],
        ISNULL(e.[ITEM_BIZ_URN], -1) AS [ITEM_BIZ_URN]
FROM    [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] AS e
JOIN    [dbo].[TE_DIM_ITEM_TYPE] t ON e.[ITEM_TYPE_URN] = t.[ITEM_TYPE_URN];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ITEM_CUBE]
	TO [portalapp_role]
GO
