SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_USER_ICM_PROV]
AS
SELECT  u.MODIFIED_DATE,
        u.CLUSTER_RESOURCE_ID,
        u.USER_ID,
        u.PKEY_MAP_URN,
        u.PKEY_CHANGE_STAMP,
        CASE WHEN u.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > u.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE u.STATUS
        END AS STATUS,
        CASE WHEN u.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > u.PKEY_EFFECTIVE_TO THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(u.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        u.PKEY1,
        u.LOGIN_NAME,
        u.BASE_DESCRIPTION AS [DESCRIPTION],
        u.ROLE,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID,
        tenant.INTERNAL_NAME AS CUSTOMER_DEFINITION_ENTERPRISE_NAME
FROM    VW_SEC_USER_PKEY u
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenant.ITEM_BIZ_URN = u.TENANT_BIZ_URN
                                       AND tenant.CLUSTER_RESOURCE_ID = u.CLUSTER_RESOURCE_ID
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
WHERE   (
          (
            u.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN u.PKEY_EFFECTIVE_FROM
                               AND     u.PKEY_EFFECTIVE_TO )
          )
          OR ( u.STATUS = 'P' )
          OR (
               u.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > u.PKEY_EFFECTIVE_TO
             )
        )
        AND u.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_ICM_PROV]
	TO [portalapp_role]
GO
