SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SKILLGROUP_SERVICE_MEMBER_ICM_PROV]
AS
SELECT  serviceMember.CLUSTER_RESOURCE_ID,
        serviceMember.MODIFIED_DATE,
        serviceMember.MEMBER_URN,
        serviceMember.PKEY_MAP_URN,
        serviceMember.PKEY_CHANGE_STAMP,
        CASE WHEN serviceMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > serviceMember.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE serviceMember.STATUS
        END AS STATUS,
        CASE WHEN serviceMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > serviceMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        serviceMember.PKEY1,
        serviceMember.PKEY2,
        serviceMember.PRIORITY_LEVEL,
        skillgroup.ITEM_BIZ_URN AS SKILLGROUP_BUSINESS_URN,
        skillgroup.PKEY1 AS SKILLGROUP_ID,
        service.PKEY1 AS SERVICE_ID,
        service.ITEM_BIZ_URN AS SERVICE_BUSINESS_URN
FROM    VW_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY serviceMember
JOIN    VW_DIM_SKILLGROUP_PKEY skillgroup ON serviceMember.CHILD_ITEM_BIZ_URN = skillgroup.ITEM_BIZ_URN
                                             AND serviceMember.CLUSTER_RESOURCE_ID = skillgroup.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_SERVICE_PKEY service ON serviceMember.PARENT_ITEM_BIZ_URN = service.ITEM_BIZ_URN
                                       AND serviceMember.CLUSTER_RESOURCE_ID = service.CLUSTER_RESOURCE_ID
WHERE   (
          (
            serviceMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN serviceMember.PKEY_EFFECTIVE_FROM
                               AND     serviceMember.PKEY_EFFECTIVE_TO )
          )
          OR ( serviceMember.STATUS = 'P' )
          OR (
               serviceMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > serviceMember.PKEY_EFFECTIVE_TO
             )
        )
        AND serviceMember.LATEST = 1
        AND serviceMember.PKEY_LATEST = 1
        AND skillgroup.LATEST = 1
        AND skillgroup.PKEY_LATEST = 1
        AND service.LATEST = 1
        AND service.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SKILLGROUP_SERVICE_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
