SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_CUCM_CODES]
AS
SELECT  resource.RESOURCE_ID AS CALLMANAGER_RESOURCE_ID,
        resource.VERSION AS CALLMANAGER_VERSION,
        productCode.NAME AS PRODUCT_NAME,
        productCode.INTERNAL_NAME AS PRODUCT_INTERNAL_NAME,
        productCode.ITEM_BIZ_URN AS PRODUCT_URN,
        productModelHierarchy.PARENT_CODE_NAME AS MODEL_NAME,
        productModelHierarchy.PARENT_CODE_INTERNAL_NAME AS MODEL_INTERNAL_NAME,
        productModelHierarchy.PARENT_CODE_URN AS MODEL_URN,
        modelClassHierarchy.PARENT_CODE_NAME AS CLASS_NAME,
        modelClassHierarchy.PARENT_CODE_INTERNAL_NAME AS CLASS_INTERNAL_NAME,
        modelClassHierarchy.PARENT_CODE_URN AS CLASS_URN,
        protocolCode.NAME AS PROTOCOL_NAME,
        protocolCode.INTERNAL_NAME AS PROTOCOL_INTERNAL_NAME,
        protocolCode.ITEM_BIZ_URN AS PROTOCOL_URN,
        CAST(CASE WHEN extensionMobilityEnabled.ITEM_BIZ_URN IS NULL THEN 0
                  ELSE 1
             END AS BIT) AS EXTENSION_MOBILITY_ENABLED,
        CAST(CASE productCode.INTERNAL_NAME
               WHEN 'CTI_PORT' THEN 0
               ELSE 1
             END AS BIT) AS REQUIRES_BUTTON_TEMPLATE,
        CASE WHEN CAST(productCodePkey.[XML_DATA].query('/Columns/Column[@Name="SHOW_IN_DROPDOWN"]/text()') AS NVARCHAR(5)) = 'True'
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS SHOW_IN_DROPDOWN,
        CASE WHEN CAST(productCodePkey.[XML_DATA].query('/Columns/Column[@Name="DEVICE_NAME_STRING"]/text()') AS NVARCHAR(50)) LIKE '%\[mac]%'
                  ESCAPE '\' THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS REQUIRES_MAC_ADDRESS
FROM    TB_CLU_RESOURCE resource
INNER JOIN TE_ADM_CLUSTER_RESOURCE_TYPE clusterType ON resource.RESOURCE_TYPE_ID = clusterType.CLUSTER_RESOURCE_TYPE_ID
                                                       AND clusterType.INTERNAL_NAME = 'CRT_CISCO_CALL_MANAGER'
INNER JOIN VW_DIM_DEVICE_PRODUCT_CODE_PKEY productCode ON productCode.CLUSTER_RESOURCE_TYPE_ID = clusterType.CLUSTER_RESOURCE_TYPE_ID
                                                          AND productCode.CLUSTER_VERSION = resource.VERSION
INNER JOIN TB_DIM_CODE_PKEY_MAP productCodePkey ON productCodePkey.ITEM_BIZ_URN = productCode.ITEM_BIZ_URN
                                                   AND productCodePkey.CLUSTER_RESOURCE_TYPE_ID = productCode.CLUSTER_RESOURCE_TYPE_ID
                                                   AND productCodePkey.CLUSTER_VERSION = productCode.CLUSTER_VERSION
INNER JOIN VW_DIM_CODE_HIERARCHY productModelHierarchy ON productModelHierarchy.CHILD_CODE_URN = productCode.ITEM_BIZ_URN
                                                          AND productModelHierarchy.PARENT_CODE_GROUP_INTERNAL_NAME = 'CG_DEVICE_MODEL'
INNER JOIN VW_DIM_CODE_HIERARCHY modelClassHierarchy ON modelClassHierarchy.CHILD_CODE_URN = productModelHierarchy.PARENT_CODE_URN
                                                        AND modelClassHierarchy.PARENT_CODE_GROUP_INTERNAL_NAME = 'CG_DEVICE_CLASS'
LEFT OUTER JOIN TB_CCM_DEFAULTS defaults ON defaults.MODEL_CODE_URN = productModelHierarchy.PARENT_CODE_URN
                                            AND defaults.CLUSTER_RESOURCE_ID = resource.RESOURCE_ID
CROSS APPLY ( SELECT    NAME,
                        INTERNAL_NAME,
                        ITEM_BIZ_URN,
                        CLUSTER_RESOURCE_TYPE_ID,
                        CLUSTER_VERSION,
                        MAX(CASE WHEN PKEY1 = 0
                                      AND CLUSTER_RESOURCE_TYPE_ID = clusterType.CLUSTER_RESOURCE_TYPE_ID
                                      AND CLUSTER_VERSION = resource.VERSION
                                 THEN ITEM_BIZ_URN
                                 ELSE NULL
                            END) OVER ( PARTITION BY CLUSTER_RESOURCE_TYPE_ID ) AS PROTOCOL_CODE_URN
              FROM      VW_DIM_DEVICE_PROTOCOL_CODE_PKEY
            ) protocolCode
OUTER APPLY ( SELECT TOP 1
                        ITEM_BIZ_URN
              FROM      ( SELECT    ITEM_BIZ_URN
                          FROM      TB_CCM_PRODUCT_FEATURE_MAP features
                          INNER JOIN VW_DIM_DEVICE_FEATURE_CODE_PKEY featureCode ON featureCode.CLUSTER_RESOURCE_TYPE_ID = featureCode.CLUSTER_RESOURCE_TYPE_ID
                                                              AND featureCode.CLUSTER_VERSION = resource.VERSION
                                                              AND featureCode.ITEM_BIZ_URN = features.FEATURE_CODE_URN
                                                              AND featureCode.INTERNAL_NAME = 'EXTENSION_MOBILITY'
                          WHERE     features.CLUSTER_RESOURCE_ID = resource.RESOURCE_ID
                                    AND features.PRODUCT_CODE_URN = productCode.ITEM_BIZ_URN
                                    AND features.PROTOCOL_CODE_URN = protocolCode.ITEM_BIZ_URN
                        ) extensionMobility
              ORDER BY  ITEM_BIZ_URN
            ) extensionMobilityEnabled
WHERE   protocolCode.CLUSTER_RESOURCE_TYPE_ID = clusterType.CLUSTER_RESOURCE_TYPE_ID
        AND protocolCode.CLUSTER_VERSION = resource.VERSION
        AND protocolCode.ITEM_BIZ_URN = COALESCE(defaults.PROTOCOL_CODE_URN,
                                                 protocolCode.PROTOCOL_CODE_URN);
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CUCM_CODES]
	TO [portalapp_role]
GO
