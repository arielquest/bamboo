SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_CM_PROV]
AS
SELECT  ipEndpointButtonTemplateMember.CLUSTER_RESOURCE_ID,
        ipEndpointButtonTemplateMember.MODIFIED_DATE,
        ipEndpointButtonTemplateMember.MEMBER_URN,
        ipEndpointButtonTemplateMember.PKEY_MAP_URN,
        ipEndpointButtonTemplateMember.PKEY_CHANGE_STAMP,
        CASE WHEN ipEndpointButtonTemplateMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpointButtonTemplateMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE ipEndpointButtonTemplateMember.STATUS
        END AS STATUS,
        CASE WHEN ipEndpointButtonTemplateMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpointButtonTemplateMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        ipEndpointButtonTemplateMember.PKEY1,
        ipEndpointButtonTemplateMember.PKEY2,
        ipEndpoint.ITEM_BIZ_URN AS IP_ENDPOINT_BUSINESS_URN,
        ipEndpoint.PKEY1 AS IP_ENDPOINT_ID,
        buttonTemplate.ITEM_BIZ_URN AS BUTTON_TEMPLATE_BUSINESS_URN,
        buttonTemplate.PKEY1 AS BUTTON_TEMPLATE_ID
FROM    VW_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY ipEndpointButtonTemplateMember
JOIN    VW_DIM_IP_ENDPOINT_PKEY ipEndpoint ON ipEndpoint.ITEM_BIZ_URN = ipEndpointButtonTemplateMember.CHILD_ITEM_BIZ_URN
                                              AND ipEndpoint.CLUSTER_RESOURCE_ID = ipEndpointButtonTemplateMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY AS buttonTemplate ON buttonTemplate.ITEM_BIZ_URN = ipEndpointButtonTemplateMember.PARENT_ITEM_BIZ_URN
                                                              AND buttonTemplate.CLUSTER_RESOURCE_ID = ipEndpointButtonTemplateMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            ipEndpointButtonTemplateMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN ipEndpointButtonTemplateMember.PKEY_EFFECTIVE_FROM
                               AND     ipEndpointButtonTemplateMember.PKEY_EFFECTIVE_TO )
          )
          OR ( ipEndpointButtonTemplateMember.STATUS = 'P' )
          OR (
               ipEndpointButtonTemplateMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ipEndpointButtonTemplateMember.PKEY_EFFECTIVE_TO
             )
        )
        AND ipEndpointButtonTemplateMember.LATEST = 1
        AND ipEndpointButtonTemplateMember.PKEY_LATEST = 1
        AND ipEndpoint.LATEST = 1
        AND ipEndpoint.PKEY_LATEST = 1
        AND buttonTemplate.LATEST = 1
        AND buttonTemplate.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
