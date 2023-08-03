SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_NETWORK_VRU_SCRIPT_ICM_PROV]
AS
SELECT  vruScript.CLUSTER_RESOURCE_ID,
        vruScript.MODIFIED_DATE,
        vruScript.ITEM_BIZ_URN AS NETWORK_VRU_SCRIPT_BUSINESS_URN,
        vruScript.PKEY1 AS NETWORK_VRU_SCRIPT_ID,
        vruScript.PKEY_MAP_URN,
        vruScript.PKEY_CHANGE_STAMP,
        CASE WHEN vruScript.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > vruScript.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE vruScript.STATUS
        END AS STATUS,
        CASE WHEN vruScript.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > vruScript.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        vruScript.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        vruScript.INTERNAL_NAME AS ENTERPRISE_NAME,
        vruScript.DESCRIPTION,
        vruScript.VRU_SCRIPT_NAME,
        vruScript.INTERRUPTIBLE,
        vruScript.OVERRIDABLE,
        vruScript.CONFIG_PARAM,
        vruScript.TIMEOUT,
        COALESCE(vruScript.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID,
        vruMember.PKEY_MAP_URN AS NETWORK_VRU_MEMBER_PKEY_MAP_URN,
        vruMember.PKEY_CHANGE_STAMP AS NETWORK_VRU_MEMBER_CHANGE_STAMP,
        vruMember.STATUS AS NETWORK_VRU_MEMBER_STATUS,
        vru.ITEM_BIZ_URN AS NETWORK_VRU_BUSINESS_URN,
        vru.PKEY1 AS NETWORK_VRU_ID
FROM    VW_DIM_NETWORK_VRU_SCRIPT_PKEY vruScript
JOIN    VW_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY vruMember ON vruMember.CHILD_ITEM_BIZ_URN = vruScript.ITEM_BIZ_URN
                                                              AND vruMember.CLUSTER_RESOURCE_ID = vruScript.CLUSTER_RESOURCE_ID
                                                              AND vruMember.PURGED = 0
JOIN    VW_DIM_NETWORK_VRU_PKEY vru ON vru.ITEM_BIZ_URN = vruMember.PARENT_ITEM_BIZ_URN
                                       AND vru.CLUSTER_RESOURCE_ID = vruMember.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenant.ITEM_BIZ_URN = vruScript.TENANT_BIZ_URN
                                       AND tenant.CLUSTER_RESOURCE_ID = vruScript.CLUSTER_RESOURCE_ID
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = vruScript.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = vruScript.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            vruScript.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN vruScript.PKEY_EFFECTIVE_FROM
                               AND     vruScript.PKEY_EFFECTIVE_TO )
          )
          OR ( vruScript.STATUS = 'P' )
          OR (
               vruScript.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > vruScript.PKEY_EFFECTIVE_TO
             )
        )
        AND vruScript.LATEST = 1
        AND vruScript.PKEY_LATEST = 1
        AND vruMember.LATEST = 1
        AND vruMember.PKEY_LATEST = 1
        AND vru.LATEST = 1
        AND vru.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NETWORK_VRU_SCRIPT_ICM_PROV]
	TO [portalapp_role]
GO
