SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ROUTE_ICM_PROV]
AS
SELECT  route.CLUSTER_RESOURCE_ID,
        route.MODIFIED_DATE,
        route.ITEM_BIZ_URN AS ROUTE_BUSINESS_URN,
        route.PKEY1 AS ROUTE_ID,
        route.PKEY_MAP_URN,
        route.PKEY_CHANGE_STAMP,
        CASE WHEN route.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > route.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE route.STATUS
        END AS STATUS,
        CASE WHEN route.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > route.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        route.INTERNAL_NAME AS ENTERPRISE_NAME,
        route.DESCRIPTION,
        COALESCE(route.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        skillGroupMember.PKEY_MAP_URN AS SKILLGROUP_MEMBER_PKEY_MAP_URN,
        skillGroupMember.PKEY_CHANGE_STAMP AS SKILLGROUP_MEMBER_CHANGE_STAMP,
        skillGroupMember.STATUS AS SKILLGROUP_MEMBER_STATUS,
        skillGroup.ITEM_BIZ_URN AS SKILLGROUP_BUSINESS_URN,
        skillGroup.PKEY1 AS SKILLGROUP_ID
FROM    VW_DIM_ROUTE_PKEY route
JOIN    VW_DIM_ROUTE_SKILLGROUP_MEMBER_PKEY skillGroupMember ON skillGroupMember.CHILD_ITEM_BIZ_URN = route.ITEM_BIZ_URN
                                                              AND skillGroupMember.CLUSTER_RESOURCE_ID = route.CLUSTER_RESOURCE_ID
                                                              AND skillGroupMember.PURGED = 0
JOIN    VW_DIM_SKILLGROUP_PKEY skillGroup ON skillGroup.ITEM_BIZ_URN = skillGroupMember.PARENT_ITEM_BIZ_URN
                                             AND skillGroup.CLUSTER_RESOURCE_ID = skillGroupMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            route.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN route.PKEY_EFFECTIVE_FROM
                               AND     route.PKEY_EFFECTIVE_TO )
          )
          OR ( route.STATUS = 'P' )
          OR (
               route.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > route.PKEY_EFFECTIVE_TO
             )
        )
        AND route.LATEST = 1
        AND route.PKEY_LATEST = 1
        AND skillGroupMember.LATEST = 1
        AND skillGroupMember.PKEY_LATEST = 1
        AND skillGroup.LATEST = 1
        AND skillGroup.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ROUTE_ICM_PROV]
	TO [portalapp_role]
GO
