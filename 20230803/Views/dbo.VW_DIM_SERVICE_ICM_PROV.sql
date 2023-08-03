SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SERVICE_ICM_PROV]
AS
SELECT  service.CLUSTER_RESOURCE_ID,
        service.MODIFIED_DATE,
        service.ITEM_BIZ_URN AS SERVICE_BUSINESS_URN,
        service.PKEY_MAP_URN,
        service.PKEY_CHANGE_STAMP,
        service.PKEY1 AS SERVICE_ID,
        COALESCE(service.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        CASE WHEN service.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > service.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE service.STATUS
        END AS STATUS,
        CASE WHEN service.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > service.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        service.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        service.INTERNAL_NAME AS ENTERPRISE_NAME,
        service.PERIPHERAL_NUMBER AS PERIPHERAL_NUMBER,
        service.PERIPHERAL_NAME AS PERIPHERAL_NAME,
        service.PERIPHERAL_SERVICE_LEVEL_TYPE AS PERIPHERAL_SERVICE_LEVEL_TYPE,
        service.SERVICE_LEVEL_THRESHOLD AS SERVICE_LEVEL_THRESHOLD,
        service.SERVICE_LEVEL_TYPE AS SERVICE_LEVEL_TYPE,
        service.EXTENSION AS EXTENSION,
        service.DESCRIPTION AS DESCRIPTION,
        peripheral.PKEY1 AS PERIPHERAL_ID,
        peripheral.ITEM_BIZ_URN AS PERIPHERAL_BUSINESS_URN,
        mrd.PKEY1 AS MEDIA_ROUTING_DOMAIN_ID,
        mrd.ITEM_BIZ_URN AS MEDIA_ROUTING_DOMAIN_BUSINESS_URN,
        servicePeripheralMember.MEMBER_URN AS SERVICE_PERIPHERAL_MEMBER_URN,
        servicePeripheralMember.PKEY_MAP_URN AS SERVICE_PERIPHERAL_PKEY_MAP_URN,
        servicePeripheralMember.PKEY_CHANGE_STAMP AS SERVICE_PERIPHERAL_CHANGE_STAMP,
        servicePeripheralMember.STATUS AS SERVICE_PERIPHERAL_STATUS,
        serviceMRDMember.MEMBER_URN AS SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_URN,
        serviceMRDMember.PKEY_MAP_URN AS SERVICE_MEDIA_ROUTING_DOMAIN_PKEY_MAP_URN,
        serviceMRDMember.PKEY_CHANGE_STAMP AS SERVICE_MEDIA_ROUTING_DOMAIN_CHANGE_STAMP,
        serviceMRDMember.STATUS AS SERVICE_MEDIA_ROUTING_DOMAIN_STATUS
FROM    VW_DIM_SERVICE_PKEY service
JOIN    VW_DIM_SERVICE_PERIPHERAL_MEMBER_PKEY servicePeripheralMember ON service.ITEM_BIZ_URN = servicePeripheralMember.CHILD_ITEM_BIZ_URN
                                                              AND servicePeripheralMember.CLUSTER_RESOURCE_ID = service.CLUSTER_RESOURCE_ID
                                                              AND servicePeripheralMember.PURGED = 0
JOIN    VW_DIM_PERIPHERAL_PKEY peripheral ON servicePeripheralMember.PARENT_ITEM_BIZ_URN = peripheral.ITEM_BIZ_URN
                                             AND peripheral.CLUSTER_RESOURCE_ID = service.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY serviceMRDMember ON service.ITEM_BIZ_URN = serviceMRDMember.CHILD_ITEM_BIZ_URN
                                                              AND serviceMRDMember.CLUSTER_RESOURCE_ID = service.CLUSTER_RESOURCE_ID
                                                              AND serviceMRDMember.PURGED = 0
JOIN    VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY mrd ON serviceMRDMember.PARENT_ITEM_BIZ_URN = mrd.ITEM_BIZ_URN
                                                AND mrd.CLUSTER_RESOURCE_ID = service.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = service.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = service.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            service.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN service.PKEY_EFFECTIVE_FROM
                               AND     service.PKEY_EFFECTIVE_TO )
          )
          OR ( service.STATUS = 'P' )
          OR (
               service.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > service.PKEY_EFFECTIVE_TO
             )
        )
        AND service.LATEST = 1
        AND service.PKEY_LATEST = 1
        AND servicePeripheralMember.LATEST = 1
        AND servicePeripheralMember.PKEY_LATEST = 1
        AND peripheral.LATEST = 1
        AND peripheral.PKEY_LATEST = 1
        AND serviceMRDMember.LATEST = 1
        AND serviceMRDMember.PKEY_LATEST = 1
        AND mrd.LATEST = 1
        AND mrd.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SERVICE_ICM_PROV]
	TO [portalapp_role]
GO
