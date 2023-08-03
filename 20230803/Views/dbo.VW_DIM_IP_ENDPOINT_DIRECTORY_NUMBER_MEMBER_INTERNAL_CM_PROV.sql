SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_INTERNAL_CM_PROV]
AS
SELECT  ipEndpointDirectoryNumberMember.CLUSTER_RESOURCE_ID,
        ipEndpoint.ITEM_URN AS IP_ENDPOINT_URN,
        ipEndpointDirectoryNumberMember.MEMBER_URN,
        ipEndpointDirectoryNumberMember.PKEY_MAP_URN,
        ipEndpointDirectoryNumberMember.PKEY_CHANGE_STAMP,
        ipEndpointDirectoryNumberMember.LINE_INDEX,
        ipEndpointDirectoryNumberMember.PKEY1,
        pkeyMap.XML_DATA,
        directoryNumber.ITEM_BIZ_URN AS DIRECTORY_NUMBER_BUSINESS_URN,
        directoryNumber.PKEY1 AS DIRECTORY_NUMBER_ID,
        CASE WHEN (
                    ipEndpointDirectoryNumberMember.STATUS NOT IN ( 'D', 'E' )
                    AND GETUTCDATE() > ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_TO
                  ) THEN 'P'
             ELSE ipEndpointDirectoryNumberMember.STATUS
        END AS STATUS,
        CASE WHEN (
                    ipEndpointDirectoryNumberMember.STATUS NOT IN ( 'D', 'E' )
                    AND GETUTCDATE() > ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_TO
                  ) THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        resourceTemplate.TEMPLATE_DATA AS TEMPLATE_DATA
FROM    VW_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY ipEndpointDirectoryNumberMember
JOIN    TB_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY_MAP pkeyMap ON ipEndpointDirectoryNumberMember.PKEY_MAP_URN = pkeyMap.PKEY_MAP_URN
JOIN    VW_DIM_IP_ENDPOINT_PKEY ipEndpoint ON ipEndpoint.ITEM_URN = ipEndpointDirectoryNumberMember.CHILD_ITEM_BIZ_URN
                                              AND ipEndpoint.CLUSTER_RESOURCE_ID = ipEndpointDirectoryNumberMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIRECTORY_NUMBER_PKEY directoryNumber ON directoryNumber.ITEM_URN = ipEndpointDirectoryNumberMember.PARENT_ITEM_BIZ_URN
                                              AND directoryNumber.CLUSTER_RESOURCE_ID = ipEndpointDirectoryNumberMember.CLUSTER_RESOURCE_ID
LEFT JOIN TB_ADM_RESOURCE_TEMPLATE resourceTemplate ON resourceTemplate.ID = ipEndpointDirectoryNumberMember.RESOURCE_TEMPLATE_ID
                                              AND resourceTemplate.DELETED = 0
WHERE   (
          ipEndpointDirectoryNumberMember.STATUS = 'R'
          OR ipEndpointDirectoryNumberMember.STATUS = 'P'
          OR (
               ipEndpointDirectoryNumberMember.STATUS = 'S'
               AND ( GETUTCDATE() BETWEEN ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_FROM
                                  AND     ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_TO )
             )
          OR (
               ipEndpointDirectoryNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ipEndpointDirectoryNumberMember.PKEY_EFFECTIVE_TO
             )
        );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_INTERNAL_CM_PROV]
	TO [portalapp_role]
GO
