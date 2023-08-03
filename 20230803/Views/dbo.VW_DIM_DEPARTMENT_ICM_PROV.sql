SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEPARTMENT_ICM_PROV]
AS
SELECT  department.CLUSTER_RESOURCE_ID,
        department.MODIFIED_DATE,
        department.ITEM_BIZ_URN AS DEPARTMENT_BUSINESS_URN,
        department.PKEY_MAP_URN,
        department.PKEY_CHANGE_STAMP,
        department.PKEY1 AS DEPARTMENT_ID,
        CASE WHEN department.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > department.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE department.STATUS
        END AS STATUS,
        CASE WHEN department.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > department.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(department.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        department.DESCRIPTION,
        department.INTERNAL_NAME,
        department.TENANT_BIZ_URN
FROM    VW_DIM_DEPARTMENT_PKEY department
WHERE   (
          (
            department.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN department.PKEY_EFFECTIVE_FROM
                               AND     department.PKEY_EFFECTIVE_TO )
          )
          OR ( department.STATUS = 'P' )
          OR (
               department.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > department.PKEY_EFFECTIVE_TO
             )
        )
        AND department.LATEST = 1
        AND department.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEPARTMENT_ICM_PROV]
	TO [portalapp_role]
GO
