SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_CM_PROV]
AS
SELECT DISTINCT
        callingSearchSpace.CLUSTER_RESOURCE_ID,
        callingSearchSpace.ITEM_URN AS CALLING_SEARCH_SPACE_URN,
        callingSearchSpace.ITEM_BIZ_URN AS CALLING_SEARCH_SPACE_BUSINESS_URN,
        callingSearchSpace.PKEY_MAP_URN AS CALLING_SEARCH_SPACE_PKEY_MAP_URN,
        callingSearchSpace.PKEY1 AS CALLING_SEARCH_SPACE_ID,
        callingSearchSpace.INTERNAL_NAME
FROM    VW_DIM_CALLING_SEARCH_SPACE_PKEY callingSearchSpace
JOIN    TB_DIM_CALLING_SEARCH_SPACE_PKEY_MAP map ON map.PKEY_MAP_URN = callingSearchSpace.PKEY_MAP_URN
JOIN    VW_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY routePartitionCallingSearchSpaceMember ON routePartitionCallingSearchSpaceMember.PARENT_ITEM_BIZ_URN = callingSearchSpace.ITEM_BIZ_URN
                                                              AND routePartitionCallingSearchSpaceMember.CLUSTER_RESOURCE_ID = callingSearchSpace.CLUSTER_RESOURCE_ID
                                                              AND routePartitionCallingSearchSpaceMember.PURGED = 0
JOIN    VW_DIM_ROUTE_PARTITION_PKEY dp ON dp.ITEM_BIZ_URN = routePartitionCallingSearchSpaceMember.CHILD_ITEM_BIZ_URN
                                          AND dp.CLUSTER_RESOURCE_ID = routePartitionCallingSearchSpaceMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            routePartitionCallingSearchSpaceMember.STATUS = 'S'
            AND GETUTCDATE() BETWEEN routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_FROM
                             AND     routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
          )
          OR ( routePartitionCallingSearchSpaceMember.STATUS = 'P' )
          OR (
               routePartitionCallingSearchSpaceMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > routePartitionCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
             )
        )
        AND callingSearchSpace.LATEST = 1
        AND callingSearchSpace.PKEY_LATEST = 1
        AND routePartitionCallingSearchSpaceMember.LATEST = 1
        AND routePartitionCallingSearchSpaceMember.PKEY_LATEST = 1
        AND dp.LATEST = 1
        AND dp.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
