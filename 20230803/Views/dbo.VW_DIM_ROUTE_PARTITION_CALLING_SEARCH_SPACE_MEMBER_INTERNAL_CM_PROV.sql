SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_INTERNAL_CM_PROV]
AS
SELECT  routePartitionCallingSearchSpaceMember.CLUSTER_RESOURCE_ID,
        callingSearchSpace.ITEM_URN AS CALLING_SEARCH_SPACE_URN,
        routePartitionCallingSearchSpaceMember.MEMBER_URN,
        routePartitionCallingSearchSpaceMember.PKEY_MAP_URN,
        routePartitionCallingSearchSpaceMember.PKEY_CHANGE_STAMP,
        routePartitionCallingSearchSpaceMember.PKEY1,
        routePartition.PKEY1 AS ROUTE_PARTITION_ID,
        routePartition.ITEM_BIZ_URN AS ROUTE_PARTITION_BUSINESS_URN,
        CASE WHEN (
                    routePartitionCallingSearchSpaceMember.STATUS NOT IN ( 'D',
                                                              'E' )
                    AND GETUTCDATE() > routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
                  ) THEN 'P'
             ELSE routePartitionCallingSearchSpaceMember.STATUS
        END AS STATUS,
        CASE WHEN (
                    routePartitionCallingSearchSpaceMember.STATUS NOT IN ( 'D',
                                                              'E' )
                    AND GETUTCDATE() > routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
                  ) THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        routePartitionCallingSearchSpaceMember.SEQUENCE
FROM    VW_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY routePartitionCallingSearchSpaceMember
JOIN    VW_DIM_ROUTE_PARTITION_PKEY routePartition ON routePartition.ITEM_URN = routePartitionCallingSearchSpaceMember.CHILD_ITEM_BIZ_URN
                                                      AND routePartition.CLUSTER_RESOURCE_ID = routePartitionCallingSearchSpaceMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_CALLING_SEARCH_SPACE_PKEY callingSearchSpace ON callingSearchSpace.ITEM_URN = routePartitionCallingSearchSpaceMember.PARENT_ITEM_BIZ_URN
                                                              AND callingSearchSpace.CLUSTER_RESOURCE_ID = routePartitionCallingSearchSpaceMember.CLUSTER_RESOURCE_ID
WHERE   (
          routePartitionCallingSearchSpaceMember.STATUS = 'R'
          OR routePartitionCallingSearchSpaceMember.STATUS = 'P'
          OR (
               routePartitionCallingSearchSpaceMember.STATUS = 'S'
               AND ( GETUTCDATE() BETWEEN routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_FROM
                                  AND     routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_TO )
             )
          OR (
               routePartitionCallingSearchSpaceMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
             )
        );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_INTERNAL_CM_PROV]
	TO [portalapp_role]
GO
