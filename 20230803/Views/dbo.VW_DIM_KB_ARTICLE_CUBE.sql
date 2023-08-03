SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_KB_ARTICLE_CUBE]
WITH SCHEMABINDING
AS
SELECT it.[ITEM_URN],
       it.[ITEM_BIZ_URN],
       CAST('e349b610-402f-4a1a-b555-ba26abdc6f30' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
       it.[ITEM_SUBTYPE_ID],
       it.[OWNER_ID],
       it.[FOLDER_ID],
       fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
       fl.[FOLDER_TYPE],
       fl.[DEPTH] AS [FOLDER_DEPTH],
       fl.[NAME] AS [FOLDER_NAME],
       fl.[FOLDER_URN],
       t.[NAME] AS [DEPARTMENT_NAME],
       f.[TENANT_BIZ_URN],
       f.NAME AS [KB_FOLDER_NAME],
       it.[KB_FOLDER_BIZ_URN],
       it.[NAME],
       
       COALESCE(NULLIF(RTRIM(LTRIM(pk.[INTERNAL_NAME])), ''), pk.[PKEY1], 'Not Known') AS [INTERNAL_NAME],
       COALESCE(pk.[PKEY1], '') AS [PKEY1],
       COALESCE(pk.[KEYWORDS], '') AS [KEYWORDS],
       COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
       COALESCE(pk.[ARTICLE_DISPLAY_ID], '') AS [ARTICLE_DISPLAY_ID],
       
       it.[ARTICLE_COMMIT_STATE],
       it.[ARTICLE_PUBLISH_STATE],
       it.[EFFECTIVE_FROM],
       it.[EFFECTIVE_TO],
       it.[TIME_ZONE_URN],
       it.[HIERARCHY_PARENT_URN],
       it.[SKIP_LEVEL],
       it.[DELETED],
       it.[HIDDEN],
       it.[SYSTEM],
       it.[LATEST],
       it.[CHANGE_STAMP]
FROM [dbo].[TB_DIM_KB_ARTICLE] it
LEFT JOIN [dbo].[TB_DIM_KB_ARTICLE_PKEY_MAP] pk ON it.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN]
                                              AND pk.[LATEST] = 1
JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
JOIN [dbo].[TB_DIM_KB_FOLDER] f on it.[KB_FOLDER_BIZ_URN] = f.[ITEM_URN]
JOIN [dbo].[TB_DIM_TENANT] t on f.[TENANT_BIZ_URN] = t.[ITEM_URN]

UNION ALL
SELECT  e.[ITEM_BIZ_URN] AS [ITEM_URN],
        e.[ITEM_BIZ_URN] AS [ITEM_BIZ_URN],
        e.[ITEM_TYPE_ID] AS [ITEM_TYPE_ID],
        NULL AS [ITEM_SUBTYPE_ID],
        NULL AS [OWNER_ID],
        NULL AS [FOLDER_ID],
        NULL AS [FOLDER_PARENT_ID],
        '' AS [FOLDER_TYPE],
        CAST(0 AS TINYINT) AS [FOLDER_DEPTH],
        'Deleted Dimensions' AS [FOLDER_NAME],
        -1 AS [FOLDER_URN],
        'Not Available' AS [DEPARTMENT_NAME],
        -1 AS [TENANT_BIZ_URN],
        'Not Available' AS [KB_FOLDER_NAME],
        -1 AS [KB_FOLDER_BIZ_URN],
        'Deleted KB Article ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        'Deleted KB Article ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [INTERNAL_NAME],
        '' AS [PKEY1],
        '' AS [KEYWORDS],
        'This dimension does not exist in VIM anymore.' AS [DESCRIPTION],
        '' AS [ARTICLE_DISPLAY_ID],
        -1 AS [ARTICLE_COMMIT_STATE], 
        '' AS [ARTICLE_PUBLISH_STATE], 
        '1900-01-01 00:00:00.000' AS [EFFECTIVE_FROM],
        '2079-06-06 00:00:00.000' AS [EFFECTIVE_TO],
        2 AS [TIME_ZONE_URN],
        NULL AS [HIERARCHY_PARENT_URN],
        NULL AS [SKIP_LEVEL],
        CAST(0 AS BIT) AS [DELETED],
        CAST(0 AS BIT) AS [HIDDEN],
        CAST(0 AS BIT) AS [SYSTEM],
        CAST(0 AS BIT) AS [LATEST],
        0 AS [CHANGE_STAMP]
FROM    [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] AS e
WHERE   e.[ITEM_TYPE_URN] = 123;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ARTICLE_CUBE]
	TO [portalapp_role]
GO
