SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_TENANT_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[ITEM_URN],
        it.[ITEM_BIZ_URN],
        CAST('00007800-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        it.[ITEM_SUBTYPE_ID],
        it.[OWNER_ID],
        it.[FOLDER_ID],
        fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [FOLDER_DEPTH],
        fl.[NAME] AS [FOLDER_NAME],
        fl.[FOLDER_URN],
        it.[NAME],
        
        COALESCE(icmTenant.[INTERNAL_NAME], '') AS [ICM_TENANT_INTERNAL_NAME],
        COALESCE(icmTenant.[PKEY1], '') AS [ICM_TENANT_ID],
        COALESCE(egainTenant.[INTERNAL_NAME], '') AS [EGAIN_TENANT_INTERNAL_NAME],
        COALESCE(egainTenant.[PKEY1], '') AS [EGAIN_TENANT_ID],
        COALESCE(notifyTenant.[INTERNAL_NAME], '') AS [NOTIFY_TENANT_INTERNAL_NAME],
        COALESCE(notifyTenant.[PKEY1], '') AS [NOTIFY_TENANT_ID],
        
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
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
FROM    [dbo].[TB_DIM_TENANT] it
OUTER APPLY ( SELECT TOP 1 icmTenantPkey.[PKEY1] AS [PKEY1],
                           icmTenantPkey.[INTERNAL_NAME] AS [INTERNAL_NAME]
              FROM [dbo].[TB_DIM_TENANT_PKEY_MAP] icmTenantPkey
              JOIN [dbo].[TB_CLU_RESOURCE] r ON icmTenantPkey.[CLUSTER_RESOURCE_ID] = r.[RESOURCE_ID]
              JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] crt ON r.[RESOURCE_TYPE_ID] = crt.[CLUSTER_RESOURCE_TYPE_ID]
              WHERE icmTenantPkey.[ITEM_BIZ_URN] = it.[ITEM_URN]
              AND crt.[INTERNAL_NAME] = 'CRT_CISCO_CICM'
              ORDER BY icmTenantPkey.[ITEM_BIZ_URN]
            ) icmTenant
OUTER APPLY ( SELECT TOP 1 egainTenantPkey.[PKEY1] AS [PKEY1],
                           egainTenantPkey.[INTERNAL_NAME] AS [INTERNAL_NAME]
              FROM [dbo].[TB_DIM_TENANT_PKEY_MAP] egainTenantPkey
              JOIN [dbo].[TB_CLU_RESOURCE] r ON egainTenantPkey.[CLUSTER_RESOURCE_ID] = r.[RESOURCE_ID]
              JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] crt ON r.[RESOURCE_TYPE_ID] = crt.[CLUSTER_RESOURCE_TYPE_ID]
              WHERE egainTenantPkey.[ITEM_BIZ_URN] = it.[ITEM_URN]
              AND crt.[INTERNAL_NAME] = 'CRT_EGAIN_SERVER'
              ORDER BY egainTenantPkey.[ITEM_BIZ_URN]
            ) egainTenant
OUTER APPLY ( SELECT TOP 1 notifyTenantPkey.[PKEY1] AS [PKEY1],
                           notifyTenantPkey.[INTERNAL_NAME] AS [INTERNAL_NAME]
              FROM [dbo].[TB_DIM_TENANT_PKEY_MAP] notifyTenantPkey
              JOIN [dbo].[TB_CLU_RESOURCE] r ON notifyTenantPkey.[CLUSTER_RESOURCE_ID] = r.[RESOURCE_ID]
              JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] crt ON r.[RESOURCE_TYPE_ID] = crt.[CLUSTER_RESOURCE_TYPE_ID]
              WHERE notifyTenantPkey.[ITEM_BIZ_URN] = it.[ITEM_URN]
              AND crt.[INTERNAL_NAME] = 'CRT_EGAIN_NOTIFY_SERVER'
              ORDER BY notifyTenantPkey.[ITEM_BIZ_URN]
            ) notifyTenant
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
        'Deleted Tenant ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        
        'Deleted Notify Tenant ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [ICM_TENANT_INTERNAL_NAME],
        '' AS [ICM_TENANT_ID],
        'Deleted Notify Tenant ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [EGAIN_TENANT_INTERNAL_NAME],
        '' AS [EGAIN_TENANT_ID],
        'Deleted Notify Tenant ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NOTIFY_TENANT_INTERNAL_NAME],
        '' AS [NOTIFY_TENANT_ID],
        
        'This dimension does not exist in VIM anymore.' AS [DESCRIPTION],
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
WHERE   e.[ITEM_TYPE_URN] = 97;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_TENANT_CUBE]
	TO [portalapp_role]
GO
