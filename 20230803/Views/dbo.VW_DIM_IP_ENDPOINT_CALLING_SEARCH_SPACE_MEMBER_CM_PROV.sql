SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_CM_PROV]
AS
SELECT  ipEndpointCallingSearchSpaceMember.CLUSTER_RESOURCE_ID,
        ipEndpointCallingSearchSpaceMember.MODIFIED_DATE,
        ipEndpointCallingSearchSpaceMember.MEMBER_URN,
        ipEndpointCallingSearchSpaceMember.PKEY_MAP_URN,
        ipEndpointCallingSearchSpaceMember.PKEY_CHANGE_STAMP,
        CASE WHEN ipEndpointCallingSearchSpaceMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpointCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE ipEndpointCallingSearchSpaceMember.STATUS
        END AS STATUS,
        CASE WHEN ipEndpointCallingSearchSpaceMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpointCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        ipEndpointCallingSearchSpaceMember.PKEY1,
        ipEndpoint.ITEM_BIZ_URN AS IP_ENDPOINT_BUSINESS_URN,
        ipEndpoint.PKEY1 AS IP_ENDPOINT_ID,
        callingSearchSpace.ITEM_BIZ_URN AS CALLING_SEARCH_SPACE_BUSINESS_URN,
        callingSearchSpace.PKEY1 AS CALLING_SEARCH_SPACE_ID
FROM    VW_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_PKEY ipEndpointCallingSearchSpaceMember
JOIN    VW_DIM_IP_ENDPOINT_PKEY ipEndpoint ON ipEndpoint.ITEM_BIZ_URN = ipEndpointCallingSearchSpaceMember.CHILD_ITEM_BIZ_URN
                                              AND ipEndpoint.CLUSTER_RESOURCE_ID = ipEndpointCallingSearchSpaceMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_CALLING_SEARCH_SPACE_PKEY AS callingSearchSpace ON callingSearchSpace.ITEM_BIZ_URN = ipEndpointCallingSearchSpaceMember.PARENT_ITEM_BIZ_URN
                                                              AND ipEndpoint.CLUSTER_RESOURCE_ID = ipEndpointCallingSearchSpaceMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            ipEndpointCallingSearchSpaceMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN ipEndpointCallingSearchSpaceMember.PKEY_EFFECTIVE_FROM
                               AND     ipEndpointCallingSearchSpaceMember.PKEY_EFFECTIVE_TO )
          )
          OR ( ipEndpointCallingSearchSpaceMember.STATUS = 'P' )
          OR (
               ipEndpointCallingSearchSpaceMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ipEndpointCallingSearchSpaceMember.PKEY_EFFECTIVE_TO
             )
        )
        AND ipEndpointCallingSearchSpaceMember.LATEST = 1
        AND ipEndpointCallingSearchSpaceMember.PKEY_LATEST = 1
        AND ipEndpoint.LATEST = 1
        AND ipEndpoint.PKEY_LATEST = 1
        AND callingSearchSpace.LATEST = 1
        AND callingSearchSpace.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
