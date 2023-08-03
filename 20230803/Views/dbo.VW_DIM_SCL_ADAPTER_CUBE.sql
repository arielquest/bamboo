SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SCL_ADAPTER_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[ITEM_URN],
        it.[ITEM_BIZ_URN],
        CAST('9CE7C8C9-76F1-4FFC-B809-861517F609F2' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        it.[ITEM_SUBTYPE_ID],
        it.[OWNER_ID],
        it.[FOLDER_ID],
        fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [FOLDER_DEPTH],
        fl.[NAME] AS [FOLDER_NAME],
        fl.[FOLDER_URN],
        it.[ADAPTER_TYPE_CODE_BIZ_URN],
        it.[ADAPTER_TYPE_SUB_CODE_BIZ_URN],
        atc.[NAME] AS [ADAPTER_TYPE_CODE_NAME],
        ats.[NAME] AS [ADAPTER_TYPE_SUB_CODE_NAME],
        it.[NAME],
        COALESCE(NULLIF(RTRIM(LTRIM(pk.[INTERNAL_NAME])), ''), pk.[PKEY1],
                 'Not Known') AS [INTERNAL_NAME],
        COALESCE(pk.[PKEY1], '') AS [PKEY1],
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
        it.[EFFECTIVE_FROM],
        it.[EFFECTIVE_TO],
        it.[TIME_ZONE_URN],
        it.[TENANT_BIZ_URN],
        it.[HIERARCHY_PARENT_URN],
        it.[SKIP_LEVEL],
        it.[DELETED],
        it.[HIDDEN],
        it.[SYSTEM],
        it.[LATEST],
        it.[CHANGE_STAMP]
FROM    [dbo].[TB_DIM_SCL_ADAPTER] it
LEFT JOIN [dbo].[TB_DIM_SCL_ADAPTER_PKEY_MAP] pk ON it.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN] AND pk.[LATEST] = 1
JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
JOIN [dbo].[TB_DIM_CODE] atc ON it.[ADAPTER_TYPE_CODE_BIZ_URN] = atc.[ITEM_URN]
JOIN [dbo].[TB_DIM_SUB_CODE] ats ON it.[ADAPTER_TYPE_SUB_CODE_BIZ_URN] = ats.[ITEM_URN]
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
        -1 AS [ADAPTER_TYPE_CODE_BIZ_URN],
        -1 AS [ADAPTER_TYPE_SUB_CODE_BIZ_URN],
        'Unknown' AS [ADAPTER_TYPE_CODE_NAME],
        'Unknown' AS [ADAPTER_TYPE_SUB_CODE_NAME],        
        'Deleted Social Adapter ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        'Deleted Social Adapter ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [INTERNAL_NAME],
        '' AS [PKEY1],
        'This dimension does not exist anymore.' AS [DESCRIPTION],
        '1900-01-01 00:00:00.000' AS [EFFECTIVE_FROM],
        '2079-06-06 00:00:00.000' AS [EFFECTIVE_TO],
        2 AS [TIME_ZONE_URN],
        -1 AS [TENANT_BIZ_URN],
        NULL AS [HIERARCHY_PARENT_URN],
        NULL AS [SKIP_LEVEL],
        CAST(0 AS BIT) AS [DELETED],
        CAST(0 AS BIT) AS [HIDDEN],
        CAST(0 AS BIT) AS [SYSTEM],
        CAST(0 AS BIT) AS [LATEST],
        0 AS [CHANGE_STAMP]
FROM    [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] AS e
WHERE   e.[ITEM_TYPE_URN] = 142;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SCL_ADAPTER_CUBE]
	TO [portalapp_role]
GO
