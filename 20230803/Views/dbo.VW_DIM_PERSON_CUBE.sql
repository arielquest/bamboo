SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_PERSON_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[ITEM_URN],
        it.[ITEM_BIZ_URN],
        CAST('00003150-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        it.[ITEM_SUBTYPE_ID],
        it.[OWNER_ID],
        it.[FOLDER_ID],
        fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [FOLDER_DEPTH],
        fl.[NAME] AS [FOLDER_NAME],
        fl.[FOLDER_URN],
        it.[NAME],
        COALESCE(icmPerson.[PKEY1], '') AS [PKEY1],
        icmPerson.[FIRST_NAME],
        icmPerson.[LAST_NAME],
        icmPerson.[LOGIN_NAME],
        icmPerson.[PASS_PHRASE],
        icmPerson.[LOGIN_ENABLED],
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
        it.[USER_ID],
        it.[PERSON_IMAGE],
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
FROM    [dbo].[TB_DIM_PERSON] it
OUTER APPLY ( SELECT TOP 1
                        icmPersonPkey.[PKEY1],
                        icmPersonPkey.[FIRST_NAME],
                        icmPersonPkey.[LAST_NAME],
                        icmPersonPkey.[LOGIN_NAME],
                        icmPersonPkey.[PASS_PHRASE],
                        icmPersonPkey.[LOGIN_ENABLED]
              FROM      [dbo].[TB_DIM_PERSON_PKEY_MAP] icmPersonPkey
              JOIN      [dbo].[TB_CLU_RESOURCE] r ON icmPersonPkey.[CLUSTER_RESOURCE_ID] = r.[RESOURCE_ID]
              JOIN      [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] crt ON r.[RESOURCE_TYPE_ID] = crt.[CLUSTER_RESOURCE_TYPE_ID]
              WHERE     icmPersonPkey.[ITEM_BIZ_URN] = it.[ITEM_BIZ_URN]
                        AND crt.[INTERNAL_NAME] = 'CRT_CISCO_CICM'
              ORDER BY icmPersonPkey.[ITEM_BIZ_URN]
            ) icmPerson
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
        'Deleted Person ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        '' AS [PKEY1],
        NULL AS [FIRST_NAME],
        NULL AS [LAST_NAME],
        NULL AS [LOGIN_NAME],
        NULL AS [PASS_PHRASE],
        NULL AS [LOGIN_ENABLED],
        'This dimension does not exist in VIM anymore.' AS [DESCRIPTION],
        NULL AS [USER_ID],
        NULL AS [PERSON_IMAGE],
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
WHERE   e.[ITEM_TYPE_URN] = 74;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_PERSON_CUBE]
	TO [portalapp_role]
GO
