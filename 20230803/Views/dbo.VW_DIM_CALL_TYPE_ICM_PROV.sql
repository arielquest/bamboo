SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CALL_TYPE_ICM_PROV]
AS
SELECT  callType.CLUSTER_RESOURCE_ID,
        callType.MODIFIED_DATE,
        callType.ITEM_BIZ_URN AS CALL_TYPE_BUSINESS_URN,
        callType.PKEY1 AS CALL_TYPE_ID,
        callType.PKEY_MAP_URN,
        callType.PKEY_CHANGE_STAMP,
        CASE WHEN callType.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > callType.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE callType.STATUS
        END AS STATUS,
        CASE WHEN callType.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > callType.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        callType.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        callType.INTERNAL_NAME AS ENTERPRISE_NAME,
        callType.DESCRIPTION,
        callType.SERVICE_LEVEL_TYPE,
        callType.SERVICE_LEVEL_THRESHOLD,
        callType.CCAI_CONFIG_PARAMETER,
        COALESCE(callType.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID
FROM    VW_DIM_CALL_TYPE_PKEY callType
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenant.ITEM_BIZ_URN = callType.TENANT_BIZ_URN
                                       AND tenant.CLUSTER_RESOURCE_ID = callType.CLUSTER_RESOURCE_ID
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = callType.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = callType.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            callType.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN callType.PKEY_EFFECTIVE_FROM
                               AND     callType.PKEY_EFFECTIVE_TO )
          )
          OR ( callType.STATUS = 'P' )
          OR (
               callType.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > callType.PKEY_EFFECTIVE_TO
             )
        )
        AND callType.LATEST = 1
        AND callType.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALL_TYPE_ICM_PROV]
	TO [portalapp_role]
GO
