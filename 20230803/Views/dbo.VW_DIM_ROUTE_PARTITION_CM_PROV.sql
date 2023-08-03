SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ROUTE_PARTITION_CM_PROV]
AS
SELECT  routePartition.CLUSTER_RESOURCE_ID,
        routePartition.MODIFIED_DATE,
        routePartition.ITEM_BIZ_URN AS ROUTE_PARTITION_BUSINESS_URN,
        routePartition.PKEY_MAP_URN,
        routePartition.PKEY_CHANGE_STAMP,
        CASE WHEN routePartition.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > routePartition.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE routePartition.STATUS
        END AS STATUS,
        CASE WHEN routePartition.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > routePartition.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        routePartition.PKEY1 AS ROUTE_PARTITION_ID,
        routePartition.DESCRIPTION,
        routePartition.INTERNAL_NAME
FROM    VW_DIM_ROUTE_PARTITION_PKEY routePartition
WHERE   (
          (
            routePartition.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN routePartition.PKEY_EFFECTIVE_FROM
                               AND     routePartition.PKEY_EFFECTIVE_TO )
          )
          OR ( routePartition.STATUS = 'P' )
          OR (
               routePartition.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > routePartition.PKEY_EFFECTIVE_TO
             )
        )
        AND routePartition.LATEST = 1
        AND routePartition.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ROUTE_PARTITION_CM_PROV]
	TO [portalapp_role]
GO
