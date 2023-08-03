SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CODE_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[ITEM_URN],
        it.[ITEM_BIZ_URN],
        CAST('00002110-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        it.[ITEM_SUBTYPE_ID],
        it.[OWNER_ID],
        it.[FOLDER_ID],
        fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [FOLDER_DEPTH],
        fl.[NAME] AS [FOLDER_NAME],
        fl.[FOLDER_URN],
        it.[NAME],
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
        it.[INTERNAL_NAME],
        cg.[ITEM_BIZ_URN] AS [CODE_GROUP_URN],
        COALESCE(cg.[NAME], cg.[INTERNAL_NAME]) AS [CODE_GROUP_NAME],
        cg.[INTERNAL_NAME] AS [CODE_GROUP_INTERNAL_NAME],
        cg.[DESCRIPTION] AS [CODE_GROUP_DESCRIPTION],
        COALESCE(cg.[NAME], cg.[INTERNAL_NAME]) + ' - ' + COALESCE(it.[NAME],
                                                              it.[INTERNAL_NAME]) AS [CODE_GROUP_CODE_NAME],
        it.[STRING_VAL],
        it.[INT_VAL],
        it.[BIGINT_VAL],
        it.[DATETIME_VAL],
        it.[EFFECTIVE_FROM],
        it.[EFFECTIVE_TO],
        it.[HIERARCHY_PARENT_URN],
        it.[TIME_ZONE_URN],
        it.[SKIP_LEVEL],
        it.[DELETED],
        it.[HIDDEN],
        it.[SYSTEM],
        it.[LATEST],
        it.[CHANGE_STAMP]
FROM    [dbo].[TB_DIM_CODE] it
JOIN    [dbo].[TB_DIM_CODE_CODE_GROUP_MEMBER] cm ON it.[ITEM_BIZ_URN] = cm.[CHILD_ITEM_BIZ_URN]
JOIN    [dbo].[TB_DIM_CODE_GROUP] cg ON cm.[PARENT_ITEM_BIZ_URN] = cg.[ITEM_BIZ_URN]
JOIN    [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
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
        'Deleted Code ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        'This dimension does not exist in VIM anymore.' AS [DESCRIPTION],
        'Deleted Code ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [INTERNAL_NAME],
        -1 AS [CODE_GROUP_URN],
        '' AS [CODE_GROUP_NAME],
        '' [CODE_GROUP_INTERNAL_NAME],
        '' AS [CODE_GROUP_DESCRIPTION],
        '' AS [CODE_GROUP_CODE_NAME],
        NULL AS [STRING_VAL],
        NULL AS [INT_VAL],
        NULL AS [BIGINT_VAL],
        NULL AS [DATETIME_VAL],
        '1900-01-01 00:00:00.000' AS [EFFECTIVE_FROM],
        '2079-06-06 00:00:00.000' AS [EFFECTIVE_TO],
        NULL AS [HIERARCHY_PARENT_URN],
        2 AS [TIME_ZONE_URN],
        NULL AS [SKIP_LEVEL],
        CAST(0 AS BIT) AS [DELETED],
        CAST(0 AS BIT) AS [HIDDEN],
        CAST(0 AS BIT) AS [SYSTEM],
        CAST(0 AS BIT) AS [LATEST],
        0 AS [CHANGE_STAMP]
FROM    [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] AS e
WHERE   e.[ITEM_TYPE_URN] = 17;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CODE_CUBE]
	TO [portalapp_role]
GO
