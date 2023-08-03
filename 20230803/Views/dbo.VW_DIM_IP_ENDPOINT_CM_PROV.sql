SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_IP_ENDPOINT_CM_PROV]
AS
SELECT  ipEndpoint.CLUSTER_RESOURCE_ID,
        ipEndpoint.MODIFIED_DATE,
        ipEndpoint.ITEM_BIZ_URN AS IP_ENDPOINT_BUSINESS_URN,
        ipEndpoint.PKEY_MAP_URN,
        ipEndpoint.PKEY_CHANGE_STAMP,
        ipEndpoint.PKEY1 AS IP_ENDPOINT_ID,
        CASE WHEN ipEndpoint.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpoint.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE ipEndpoint.STATUS
        END AS STATUS,
        CASE WHEN ipEndpoint.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > ipEndpoint.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        ipEndpoint.INTERNAL_NAME AS PHONE_INTERNAL_NAME,
        ipEndpoint.DESCRIPTION,
        pkeyMap.XML_DATA,
        CAST(CASE WHEN preemptionFeature.CLUSTER_RESOURCE_ID IS NOT NULL
                  THEN 1
                  ELSE 0
             END AS BIT) AS SUPPORTS_PREEMPTION,
        ipEndpointDevicePoolMember.MEMBER_URN AS IP_ENDPOINT_DEVICE_POOL_MEMBER_URN,
        ipEndpointDevicePoolMember.PKEY_MAP_URN AS IP_ENDPOINT_DEVICE_POOL_PKEY_MAP_URN,
        ipEndpointDevicePoolMember.PKEY_CHANGE_STAMP AS IP_ENDPOINT_DEVICE_POOL_CHANGE_STAMP,
        ipEndpointDevicePoolMember.STATUS AS IP_ENDPOINT_DEVICE_POOL_STATUS,
        devicePool.ITEM_BIZ_URN AS DEVICE_POOL_BUSINESS_URN,
        devicePool.PKEY1 AS DEVICE_POOL_ID,
        devicePool.NAME AS DEVICE_POOL_NAME,
        ipEndpointButtonTemplateMember.MEMBER_URN AS IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_URN,
        ipEndpointButtonTemplateMember.PKEY_MAP_URN AS IP_ENDPOINT_BUTTON_TEMPLATE_PKEY_MAP_URN,
        ipEndpointButtonTemplateMember.PKEY_CHANGE_STAMP AS IP_ENDPOINT_BUTTON_TEMPLATE_CHANGE_STAMP,
        ipEndpointButtonTemplateMember.STATUS AS IP_ENDPOINT_BUTTON_TEMPLATE_STATUS,
        buttonTemplate.ITEM_BIZ_URN AS BUTTON_TEMPLATE_BUSINESS_URN,
        buttonTemplate.PKEY1 AS BUTTON_TEMPLATE_ID,
        buttonTemplate.NAME AS BUTTON_TEMPLATE_NAME,
        ipEndpointPeripheralMember.MEMBER_URN AS IP_ENDPOINT_PERIPHERAL_MEMBER_URN,
        ipEndpointPeripheralMember.PKEY_MAP_URN AS IP_ENDPOINT_PERIPHERAL_PKEY_MAP_URN,
        ipEndpointPeripheralMember.PKEY_CHANGE_STAMP AS IP_ENDPOINT_PERIPHERAL_CHANGE_STAMP,
        ipEndpointPeripheralMember.STATUS AS IP_ENDPOINT_PERIPHERAL_STATUS,
        ipEndpointPeripheralMember.PKEY1 AS IP_ENDPOINT_PERIPHERAL_PKEY,
        peripheral.ITEM_BIZ_URN AS PERIPHERAL_BUSINESS_URN,
        peripheral.PKEY1 AS PERIPHERAL_ID,
        appUser.INTERNAL_NAME AS PG_USER,
        productCode.NAME AS PRODUCT_NAME,
        protocolCode.NAME AS PROTOCOL_NAME,
        codeHierarchy.PARENT_CODE_NAME AS MODEL_NAME,
        resourceTemplate.TEMPLATE_DATA AS TEMPLATE_DATA,
        person.LOGIN_NAME AS OWNER_USER_NAME,
        person.PKEY1 as OWNER_USER_ID,
        ipEndpoint.USER_CONTROLS_DEVICE
FROM    VW_DIM_IP_ENDPOINT_PKEY ipEndpoint
LEFT JOIN ( SELECT  features.CLUSTER_RESOURCE_ID,
                    features.PRODUCT_CODE_URN,
                    features.PROTOCOL_CODE_URN
            FROM    TB_CCM_PRODUCT_FEATURE_MAP features
            JOIN    TB_CLU_RESOURCE cluster ON cluster.RESOURCE_ID = features.CLUSTER_RESOURCE_ID
            JOIN    VW_DIM_DEVICE_FEATURE_CODE_PKEY featureCode ON featureCode.CLUSTER_RESOURCE_TYPE_ID = featureCode.CLUSTER_RESOURCE_TYPE_ID
                                                              AND featureCode.CLUSTER_VERSION = cluster.VERSION
                                                              AND featureCode.ITEM_BIZ_URN = features.FEATURE_CODE_URN
            WHERE   featureCode.INTERNAL_NAME = 'CALL_PRE-EMPTION_(FOR_MLPP)'
          ) preemptionFeature ON preemptionFeature.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                 AND preemptionFeature.PRODUCT_CODE_URN = ipEndpoint.PRODUCT_CODE_BIZ_URN
                                 AND preemptionFeature.PROTOCOL_CODE_URN = ipEndpoint.PROTOCOL_CODE_BIZ_URN
JOIN    TB_DIM_IP_ENDPOINT_PKEY_MAP pkeyMap ON ipEndpoint.PKEY_MAP_URN = pkeyMap.PKEY_MAP_URN
LEFT JOIN VW_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY ipEndpointDevicePoolMember ON ipEndpointDevicePoolMember.CHILD_ITEM_BIZ_URN = ipEndpoint.ITEM_BIZ_URN
                                                              AND ipEndpointDevicePoolMember.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                                              AND ipEndpointDevicePoolMember.LATEST = 1
                                                              AND ipEndpointDevicePoolMember.PKEY_LATEST = 1
                                                              AND ipEndpointDevicePoolMember.PURGED = 0
LEFT JOIN VW_DIM_DEVICE_POOL_PKEY devicePool ON devicePool.ITEM_BIZ_URN = ipEndpointDevicePoolMember.PARENT_ITEM_BIZ_URN
                                                AND devicePool.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                                AND devicePool.LATEST = 1
                                                AND devicePool.PKEY_LATEST = 1
LEFT JOIN VW_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY ipEndpointButtonTemplateMember ON ipEndpointButtonTemplateMember.CHILD_ITEM_BIZ_URN = ipEndpoint.ITEM_BIZ_URN
                                                              AND ipEndpointButtonTemplateMember.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                                              AND ipEndpointButtonTemplateMember.LATEST = 1
                                                              AND ipEndpointButtonTemplateMember.PKEY_LATEST = 1
                                                              AND ipEndpointButtonTemplateMember.PURGED = 0
LEFT JOIN VW_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY buttonTemplate ON buttonTemplate.ITEM_BIZ_URN = ipEndpointButtonTemplateMember.PARENT_ITEM_BIZ_URN
                                                              AND buttonTemplate.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                                              AND buttonTemplate.LATEST = 1
                                                              AND buttonTemplate.PKEY_LATEST = 1
LEFT JOIN VW_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_PKEY ipEndpointPeripheralMember ON ipEndpointPeripheralMember.CHILD_ITEM_BIZ_URN = ipEndpoint.ITEM_BIZ_URN
                                                              AND ipEndpointPeripheralMember.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                                              AND ipEndpointPeripheralMember.LATEST = 1
                                                              AND ipEndpointPeripheralMember.PKEY_LATEST = 1
                                                              AND ipEndpointPeripheralMember.PURGED = 0
LEFT JOIN VW_DIM_PERIPHERAL_PKEY peripheral ON peripheral.ITEM_BIZ_URN = ipEndpointPeripheralMember.PARENT_ITEM_BIZ_URN
                                               AND peripheral.LATEST = 1
                                               AND peripheral.PKEY_LATEST = 1
LEFT JOIN VW_DIM_APPLICATION_USER_PKEY appUser ON appUser.ITEM_BIZ_URN = peripheral.APPLICATION_USER_BIZ_URN
                                                  AND appUser.DELETED = 0
LEFT JOIN TB_ADM_RESOURCE_TEMPLATE resourceTemplate ON resourceTemplate.ID = ipEndpoint.RESOURCE_TEMPLATE_ID
                                                    AND resourceTemplate.DELETED = 0
LEFT JOIN TB_DIM_PERSON_PKEY_MAP person ON person.ITEM_BIZ_URN = ipEndpoint.OWNER_PERSON_BIZ_URN
                                                    AND person.CLUSTER_RESOURCE_ID = ipEndpoint.CLUSTER_RESOURCE_ID
                                                    AND person.LATEST = 1
                                                    AND person.PURGED = 0
JOIN    TB_DIM_CODE productCode ON productCode.ITEM_BIZ_URN = ipEndpoint.PRODUCT_CODE_BIZ_URN
                                   AND productCode.LATEST = 1
JOIN    TB_DIM_CODE protocolCode ON protocolCode.ITEM_BIZ_URN = ipEndpoint.PROTOCOL_CODE_BIZ_URN
                                    AND protocolCode.LATEST = 1
JOIN    VW_DIM_CODE_HIERARCHY codeHierarchy ON codeHierarchy.CHILD_CODE_URN = productCode.ITEM_BIZ_URN
                                               AND PARENT_CODE_GROUP_INTERNAL_NAME = 'CG_DEVICE_MODEL'
                                               AND CHILD_CODE_GROUP_INTERNAL_NAME = 'CG_DEVICE_PRODUCT'
WHERE   (
          (
            ipEndpoint.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN ipEndpoint.PKEY_EFFECTIVE_FROM
                               AND     ipEndpoint.PKEY_EFFECTIVE_TO )
          )
          OR ( ipEndpoint.STATUS = 'P' )
          OR (
               ipEndpoint.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > ipEndpoint.PKEY_EFFECTIVE_TO
             )
        )
        AND ipEndpoint.LATEST = 1
        AND ipEndpoint.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IP_ENDPOINT_CM_PROV]
	TO [portalapp_role]
GO
