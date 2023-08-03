SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_TENANT_ICM_PROV]
AS
SELECT  tenant.CLUSTER_RESOURCE_ID,
        tenant.MODIFIED_DATE,
        tenant.ITEM_BIZ_URN AS TENANT_BUSINESS_URN,
        tenant.PKEY_MAP_URN,
        tenant.PKEY1 AS TENANT_ID,
        tenant.PKEY_CHANGE_STAMP,
        CASE WHEN tenant.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > tenant.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE tenant.STATUS
        END AS STATUS,
        CASE WHEN tenant.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > tenant.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(tenant.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        tenant.DESCRIPTION,
        tenant.INTERNAL_NAME
FROM    VW_DIM_TENANT_PKEY tenant
WHERE   (
          (
            tenant.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN tenant.PKEY_EFFECTIVE_FROM
                               AND     tenant.PKEY_EFFECTIVE_TO )
          )
          OR ( tenant.STATUS = 'P' )
          OR (
               tenant.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > tenant.PKEY_EFFECTIVE_TO
             )
        )
        AND tenant.LATEST = 1
        AND tenant.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_TENANT_ICM_PROV]
	TO [portalapp_role]
GO
