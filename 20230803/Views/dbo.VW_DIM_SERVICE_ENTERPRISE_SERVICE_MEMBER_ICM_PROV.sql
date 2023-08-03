SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_ICM_PROV]
AS
SELECT  entServiceMember.CLUSTER_RESOURCE_ID,
        entServiceMember.MODIFIED_DATE,
        entServiceMember.MEMBER_URN,
        entServiceMember.PKEY_MAP_URN,
        entServiceMember.PKEY_CHANGE_STAMP,
        CASE WHEN entServiceMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > entServiceMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE entServiceMember.STATUS
        END AS STATUS,
        CASE WHEN entServiceMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > entServiceMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        entServiceMember.PKEY1,
        entServiceMember.PKEY2,
        service.ITEM_BIZ_URN AS SERVICE_BUSINESS_URN,
        service.PKEY1 AS SERVICE_ID,
        entService.ITEM_BIZ_URN AS ENTERPRISE_SERVICE_BUSINESS_URN,
        entService.PKEY1 AS ENTERPRISE_SERVICE_ID
FROM    VW_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_PKEY entServiceMember
JOIN    VW_DIM_SERVICE_PKEY service ON entServiceMember.CHILD_ITEM_BIZ_URN = service.ITEM_BIZ_URN
                                       AND service.CLUSTER_RESOURCE_ID = entServiceMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_ENTERPRISE_SERVICE_PKEY entService ON entServiceMember.PARENT_ITEM_BIZ_URN = entService.ITEM_BIZ_URN
                                                     AND entService.CLUSTER_RESOURCE_ID = entServiceMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            entServiceMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN entServiceMember.PKEY_EFFECTIVE_FROM
                               AND     entServiceMember.PKEY_EFFECTIVE_TO )
          )
          OR ( entServiceMember.STATUS = 'P' )
          OR (
               entServiceMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > entServiceMember.PKEY_EFFECTIVE_TO
             )
        )
        AND entServiceMember.LATEST = 1
        AND entServiceMember.PKEY_LATEST = 1
        AND service.LATEST = 1
        AND service.PKEY_LATEST = 1
        AND entService.LATEST = 1
        AND entService.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
