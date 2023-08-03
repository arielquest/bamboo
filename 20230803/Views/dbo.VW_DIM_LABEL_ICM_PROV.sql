SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_LABEL_ICM_PROV]
AS
SELECT  label.CLUSTER_RESOURCE_ID,
        label.MODIFIED_DATE,
        label.ITEM_BIZ_URN AS LABEL_BUSINESS_URN,
        label.PKEY_MAP_URN,
        label.PKEY_CHANGE_STAMP,
        CASE WHEN label.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > label.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE label.STATUS
        END AS STATUS,
        CASE WHEN label.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > label.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(label.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        label.PKEY1 AS LABEL_ID,
        label.LABEL_TYPE,
        label.INTERNAL_NAME AS LABEL,
        label.DESCRIPTION,
        labelRoutingClientMember.MEMBER_URN AS LABEL_ROUTING_CLIENT_MEMBER_URN,
        labelRoutingClientMember.PKEY_MAP_URN AS LABEL_ROUTING_CLIENT_PKEY_MAP_URN,
        labelRoutingClientMember.PKEY_CHANGE_STAMP AS LABEL_ROUTING_CLIENT_CHANGE_STAMP,
        labelRoutingClientMember.STATUS AS LABEL_ROUTING_CLIENT_STATUS,
        routingClient.ITEM_BIZ_URN AS ROUTING_CLIENT_BUSINESS_URN,
        routingClient.PKEY1 AS ROUTING_CLIENT_ID,
        routingClient.NETWORK_ROUTING_CLIENT AS NETWORK_ROUTING_CLIENT,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID,
        tenant.INTERNAL_NAME AS CUSTOMER_DEFINITION_ENTERPRISE_NAME
FROM    VW_DIM_LABEL_PKEY label
JOIN    VW_DIM_LABEL_ROUTING_CLIENT_MEMBER_PKEY labelRoutingClientMember ON labelRoutingClientMember.CHILD_ITEM_BIZ_URN = label.ITEM_BIZ_URN
                                                              AND labelRoutingClientMember.CLUSTER_RESOURCE_ID = label.CLUSTER_RESOURCE_ID
                                                              AND labelRoutingClientMember.PURGED = 0
JOIN    VW_DIM_ROUTING_CLIENT_PKEY routingClient ON labelRoutingClientMember.PARENT_ITEM_BIZ_URN = routingClient.ITEM_BIZ_URN
                                                    AND routingClient.CLUSTER_RESOURCE_ID = label.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenant.ITEM_BIZ_URN = label.TENANT_BIZ_URN
                                       AND tenant.CLUSTER_RESOURCE_ID = label.CLUSTER_RESOURCE_ID
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
WHERE   (
          (
            label.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN label.PKEY_EFFECTIVE_FROM
                               AND     label.PKEY_EFFECTIVE_TO )
          )
          OR ( label.STATUS = 'P' )
          OR (
               label.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > label.PKEY_EFFECTIVE_TO
             )
        )
        AND label.LATEST = 1
        AND label.PKEY_LATEST = 1
        AND labelRoutingClientMember.LATEST = 1
        AND labelRoutingClientMember.PKEY_LATEST = 1
        AND routingClient.LATEST = 1
        AND routingClient.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_LABEL_ICM_PROV]
	TO [portalapp_role]
GO
