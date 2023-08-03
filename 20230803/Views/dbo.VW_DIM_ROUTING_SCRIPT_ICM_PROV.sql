SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ROUTING_SCRIPT_ICM_PROV]
AS
SELECT  routingScript.CLUSTER_RESOURCE_ID,
        routingScript.MODIFIED_DATE,
        routingScript.ITEM_BIZ_URN AS ROUTING_SCRIPT_BUSINESS_URN,
        routingScript.PKEY_MAP_URN,
        routingScript.PKEY_CHANGE_STAMP,
        routingScript.PKEY1 AS ROUTING_SCRIPT_ID,
        COALESCE(routingScript.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        CASE WHEN routingScript.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > routingScript.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE routingScript.STATUS
        END AS STATUS,
        CASE WHEN routingScript.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > routingScript.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        routingScript.INTERNAL_NAME,
        routingScript.DESCRIPTION,
        map.XML_DATA AS XML_DATA,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID
FROM    VW_DIM_ROUTING_SCRIPT_PKEY routingScript
JOIN    TB_DIM_ROUTING_SCRIPT_PKEY_MAP map ON map.PKEY_MAP_URN = routingScript.PKEY_MAP_URN
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenant.ITEM_BIZ_URN = routingScript.TENANT_BIZ_URN
                                       AND tenant.CLUSTER_RESOURCE_ID = routingScript.CLUSTER_RESOURCE_ID
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
WHERE   (
          (
            routingScript.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN routingScript.PKEY_EFFECTIVE_FROM
                               AND     routingScript.PKEY_EFFECTIVE_TO )
          )
          OR ( routingScript.STATUS = 'P' )
          OR (
               routingScript.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > routingScript.PKEY_EFFECTIVE_TO
             )
        )
        AND routingScript.LATEST = 1
        AND routingScript.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ROUTING_SCRIPT_ICM_PROV]
	TO [portalapp_role]
GO
