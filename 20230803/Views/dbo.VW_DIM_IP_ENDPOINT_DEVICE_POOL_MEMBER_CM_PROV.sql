SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_CM_PROV]
AS
SELECT  ipEndpointDevicePoolMember.CLUSTER_RESOURCE_ID,
        ipEndpointDevicePoolMember.MODIFIED_DATE,
        ipEndpointDevicePoolMember.MEMBER_URN,
        ipEndpointDevicePoolMember.PKEY_MAP_URN,
        ipEndpointDevicePoolMember.PKEY_CHANGE_STAMP,
        CASE WHEN ipEndpointDevicePoolMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpointDevicePoolMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE ipEndpointDevicePoolMember.STATUS
        END AS STATUS,
        CASE WHEN ipEndpointDevicePoolMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpointDevicePoolMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        ipEndpointDevicePoolMember.PKEY1,
        ipEndpoint.ITEM_BIZ_URN AS IP_ENDPOINT_BUSINESS_URN,
        ipEndpoint.PKEY1 AS IP_ENDPOINT_ID,
        devicePool.ITEM_BIZ_URN AS DEVICE_POOL_BUSINESS_URN,
        devicePool.PKEY1 AS DEVICE_POOL_ID
FROM    VW_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY ipEndpointDevicePoolMember
JOIN    VW_DIM_IP_ENDPOINT_PKEY ipEndpoint ON ipEndpoint.ITEM_BIZ_URN = ipEndpointDevicePoolMember.CHILD_ITEM_BIZ_URN
                                              AND ipEndpoint.CLUSTER_RESOURCE_ID = ipEndpointDevicePoolMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DEVICE_POOL_PKEY AS devicePool ON devicePool.ITEM_BIZ_URN = ipEndpointDevicePoolMember.PARENT_ITEM_BIZ_URN
                                                 AND ipEndpoint.CLUSTER_RESOURCE_ID = ipEndpointDevicePoolMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            ipEndpointDevicePoolMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN ipEndpointDevicePoolMember.PKEY_EFFECTIVE_FROM
                               AND     ipEndpointDevicePoolMember.PKEY_EFFECTIVE_TO )
          )
          OR ( ipEndpointDevicePoolMember.STATUS = 'P' )
          OR (
               ipEndpointDevicePoolMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ipEndpointDevicePoolMember.PKEY_EFFECTIVE_TO
             )
        )
        AND ipEndpointDevicePoolMember.LATEST = 1
        AND ipEndpointDevicePoolMember.PKEY_LATEST = 1
        AND ipEndpoint.LATEST = 1
        AND ipEndpoint.PKEY_LATEST = 1
        AND devicePool.LATEST = 1
        AND devicePool.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
