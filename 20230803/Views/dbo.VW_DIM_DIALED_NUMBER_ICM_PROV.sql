SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DIALED_NUMBER_ICM_PROV]
AS
SELECT  dialedNumber.CLUSTER_RESOURCE_ID,
        dialedNumber.MODIFIED_DATE,
        dialedNumber.ITEM_BIZ_URN AS DIALED_NUMBER_BUSINESS_URN,
        dialedNumber.PKEY_MAP_URN,
        dialedNumber.PKEY_CHANGE_STAMP,
        CASE WHEN dialedNumber.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > dialedNumber.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE dialedNumber.STATUS
        END AS STATUS,
        CASE WHEN dialedNumber.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > dialedNumber.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(dialedNumber.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        dialedNumber.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        dialedNumber.PKEY1 AS DIALED_NUMBER_ID,
        dialedNumber.INTERNAL_NAME AS ENTERPRISE_NAME,
        dialedNumber.DESCRIPTION,
        dialedNumber.DIALEDNUMBER AS DIALED_NUMBER_STRING,
        dialedNumber.PERMIT_APPLICATION_ROUTING,
        dnRoutingClientMember.MEMBER_URN AS DIALED_NUMBER_ROUTING_CLIENT_MEMBER_URN,
        dnRoutingClientMember.PKEY_MAP_URN AS DIALED_NUMBER_ROUTING_CLIENT_PKEY_MAP_URN,
        dnRoutingClientMember.PKEY_CHANGE_STAMP AS DIALED_NUMBER_ROUTING_CLIENT_CHANGE_STAMP,
        dnRoutingClientMember.STATUS AS DIALED_NUMBER_ROUTING_CLIENT_STATUS,
        routingClient.ITEM_BIZ_URN AS ROUTING_CLIENT_BUSINESS_URN,
        routingClient.PKEY1 AS ROUTING_CLIENT_ID,
        routingClient.NETWORK_ROUTING_CLIENT AS NETWORK_ROUTING_CLIENT,
        dnMediaRoutingDomainMember.MEMBER_URN AS DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_URN,
        dnMediaRoutingDomainMember.PKEY_MAP_URN AS DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_PKEY_MAP_URN,
        dnMediaRoutingDomainMember.PKEY_CHANGE_STAMP AS DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_CHANGE_STAMP,
        dnMediaRoutingDomainMember.STATUS AS DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_STATUS,
        mediaRoutingDomain.ITEM_BIZ_URN AS MEDIA_ROUTING_DOMAIN_BUSINESS_URN,
        mediaRoutingDomain.PKEY1 AS MEDIA_ROUTING_DOMAIN_ID,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID,
        tenant.INTERNAL_NAME AS CUSTOMER_DEFINITION_ENTERPRISE_NAME
FROM    VW_DIM_DIALED_NUMBER_PKEY dialedNumber
JOIN    VW_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_PKEY dnRoutingClientMember ON dnRoutingClientMember.CHILD_ITEM_BIZ_URN = dialedNumber.ITEM_BIZ_URN
                                                              AND dialedNumber.CLUSTER_RESOURCE_ID = dnRoutingClientMember.CLUSTER_RESOURCE_ID
                                                              AND dnRoutingClientMember.PURGED = 0
JOIN    VW_DIM_ROUTING_CLIENT_PKEY routingClient ON dnRoutingClientMember.PARENT_ITEM_BIZ_URN = routingClient.ITEM_BIZ_URN
                                                    AND dialedNumber.CLUSTER_RESOURCE_ID = routingClient.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY dnMediaRoutingDomainMember ON dnMediaRoutingDomainMember.CHILD_ITEM_BIZ_URN = dialedNumber.ITEM_BIZ_URN
                                                              AND dialedNumber.CLUSTER_RESOURCE_ID = dnMediaRoutingDomainMember.CLUSTER_RESOURCE_ID
                                                              AND dnMediaRoutingDomainMember.PURGED = 0
JOIN    VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY mediaRoutingDomain ON dnMediaRoutingDomainMember.PARENT_ITEM_BIZ_URN = mediaRoutingDomain.ITEM_BIZ_URN
                                                              AND dialedNumber.CLUSTER_RESOURCE_ID = mediaRoutingDomain.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenant.ITEM_BIZ_URN = dialedNumber.TENANT_BIZ_URN
                                       AND tenant.CLUSTER_RESOURCE_ID = dialedNumber.CLUSTER_RESOURCE_ID
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = dialedNumber.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = dialedNumber.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            dialedNumber.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN dialedNumber.PKEY_EFFECTIVE_FROM
                               AND     dialedNumber.PKEY_EFFECTIVE_TO )
          )
          OR ( dialedNumber.STATUS = 'P' )
          OR (
               dialedNumber.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > dialedNumber.PKEY_EFFECTIVE_TO
             )
        )
        AND dialedNumber.LATEST = 1
        AND dialedNumber.PKEY_LATEST = 1
        AND dnRoutingClientMember.LATEST = 1
        AND dnRoutingClientMember.PKEY_LATEST = 1
        AND routingClient.LATEST = 1
        AND routingClient.PKEY_LATEST = 1
        AND dnMediaRoutingDomainMember.LATEST = 1
        AND dnMediaRoutingDomainMember.PKEY_LATEST = 1
        AND mediaRoutingDomain.LATEST = 1
        AND mediaRoutingDomain.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DIALED_NUMBER_ICM_PROV]
	TO [portalapp_role]
GO
