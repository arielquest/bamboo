SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_CM_PROV]
AS
SELECT DISTINCT
        ipEndpoint.CLUSTER_RESOURCE_ID,
        ipEndpoint.ITEM_URN AS IP_ENDPOINT_URN,
        ipEndpoint.ITEM_BIZ_URN AS IP_ENDPOINT_BUSINESS_URN,
        ipEndpoint.PKEY_MAP_URN AS IP_ENDPOINT_PKEY_MAP_URN,
        ipEndpoint.PKEY1 AS IP_ENDPOINT_ID,
        ipEndpoint.INTERNAL_NAME
FROM    VW_DIM_IP_ENDPOINT_PKEY ipEndpoint
JOIN    VW_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY ipEndpointDirectoryNumberMember ON ipEndpointDirectoryNumberMember.CHILD_ITEM_BIZ_URN = ipEndpoint.ITEM_BIZ_URN
                                                              AND ipEndpointDirectoryNumberMember.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIRECTORY_NUMBER_PKEY dn ON dn.ITEM_BIZ_URN = ipEndpointDirectoryNumberMember.PARENT_ITEM_BIZ_URN
                                           AND dn.CLUSTER_RESOURCE_ID = ipEndpointDirectoryNumberMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            ipEndpointDirectoryNumberMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_FROM
                               AND     ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_TO )
          )
          OR ( ipEndpointDirectoryNumberMember.STATUS = 'P' )
          OR (
               ipEndpointDirectoryNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_TO
             )
        )
        AND ipEndpoint.LATEST = 1
        AND ipEndpoint.PKEY_LATEST = 1
        AND ipEndpointDirectoryNumberMember.LATEST = 1
        AND ipEndpointDirectoryNumberMember.PKEY_LATEST = 1
        AND dn.LATEST = 1
        AND dn.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
