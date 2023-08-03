SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_PRECISION_ATTRIBUTE_ICM_PROV]
AS
SELECT  pqAttribute.CLUSTER_RESOURCE_ID,
        pqAttribute.MODIFIED_DATE,
        pqAttribute.ITEM_URN AS ATTRIBUTE_ITEM_URN,
        pqAttribute.ITEM_BIZ_URN AS ATTRIBUTE_BUSINESS_URN,
        pqAttribute.PKEY_MAP_URN AS ATTRIBUTE_PKEY_MAP_URN,
        pqAttribute.PKEY_CHANGE_STAMP AS ATTRIBUTE_PKEY_CHANGE_STAMP,
        CASE WHEN pqAttribute.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > pqAttribute.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE pqAttribute.STATUS
        END AS ATTRIBUTE_STATUS,
        CASE WHEN pqAttribute.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > pqAttribute.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS ATTRIBUTE_EXPIRED,
        COALESCE(pqAttribute.SOURCE_CHANGE_STAMP, 0) AS ATTRIBUTE_SOURCE_CHANGE_STAMP,
        pqAttribute.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        pqAttribute.PKEY1 AS ATTRIBUTE_PKEY1,
        pqAttribute.PKEY2 AS ATTRIBUTE_PKEY2,
        pqAttribute.ATTRIBUTE_DATA_TYPE,
        pqAttribute.MINIMUM_VALUE AS ATTRIBUTE_MINIMUM_VALUE,
        pqAttribute.MAXIMUM_VALUE AS ATTRIBUTE_MAXIMUM_VALUE,
        pqAttribute.DEFAULT_VALUE AS ATTRIBUTE_DEFAULT_VALUE,
        pqAttribute.APPEARS_ON_DESKTOP AS ATTRIBUTE_APPEARS_ON_DESKTOP,
        pqAttribute.SETTABLE_BY_AGENT AS ATTRIBUTE_SETTABLE_BY_AGENT,
        pqAttribute.DESCRIPTION AS ATTRIBUTE_DESCRIPTION,
        pqAttribute.INTERNAL_NAME AS ATTRIBUTE_INTERNAL_NAME
FROM    VW_DIM_PRECISION_ATTRIBUTE_PKEY pqAttribute
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = pqAttribute.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = pqAttribute.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            pqAttribute.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN pqAttribute.PKEY_EFFECTIVE_FROM
                               AND     pqAttribute.PKEY_EFFECTIVE_TO )
          )
          OR ( pqAttribute.STATUS = 'P' )
          OR (
               pqAttribute.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > pqAttribute.PKEY_EFFECTIVE_TO
             )
        )
        AND pqAttribute.LATEST = 1
        AND pqAttribute.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_PRECISION_ATTRIBUTE_ICM_PROV]
	TO [portalapp_role]
GO
