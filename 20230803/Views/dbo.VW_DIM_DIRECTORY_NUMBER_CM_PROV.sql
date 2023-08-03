SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DIRECTORY_NUMBER_CM_PROV]
AS
SELECT  directoryNumber.CLUSTER_RESOURCE_ID,
        directoryNumber.MODIFIED_DATE,
        directoryNumber.ITEM_BIZ_URN AS DIRECTORY_NUMBER_BUSINESS_URN,
        directoryNumber.PKEY_MAP_URN,
        directoryNumber.PKEY_CHANGE_STAMP,
        CASE WHEN directoryNumber.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > directoryNumber.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE directoryNumber.STATUS
        END AS STATUS,
        CASE WHEN directoryNumber.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > directoryNumber.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        directoryNumber.PKEY1 AS DIRECTORY_NUMBER_ID,
        directoryNumber.DIRECTORY_NUMBER_OR_PATTERN,
        directoryNumber.DESCRIPTION,
        directoryNumber.IPCC_ENABLED,
        tenantMapping.RESOURCE_ID AS CICM_CLUSTER_RESOURCE_ID,
        tenant.PKEY1 AS CUSTOMER_DEFINITION_ID,
        routePartition.PKEY1 AS ROUTE_PARTITION_ID,
        routePartition.INTERNAL_NAME AS ROUTE_PARTITION_NAME,
        directoryNumber.PKEY_XML_DATA,
        resourceTemplate.TEMPLATE_DATA AS TEMPLATE_DATA
FROM    VW_DIM_DIRECTORY_NUMBER_PKEY directoryNumber
LEFT JOIN VW_CLU_FOLDER_TENANT_MAPPING tenantMapping ON tenantMapping.FOLDER_ID = directoryNumber.FOLDER_ID
LEFT JOIN VW_DIM_TENANT_PKEY tenant ON tenantMapping.REMOTE_TENANT_BUSINESS_URN = tenant.ITEM_BIZ_URN
                                       AND tenant.LATEST = 1
                                       AND tenant.PKEY_LATEST = 1
LEFT JOIN VW_DIM_ROUTE_PARTITION_PKEY routePartition ON directoryNumber.ROUTE_PARTITION_BIZ_URN = routePartition.ITEM_BIZ_URN
                                                        AND routePartition.LATEST = 1
                                                        AND routePartition.PKEY_LATEST = 1
LEFT JOIN TB_ADM_RESOURCE_TEMPLATE resourceTemplate ON resourceTemplate.ID = directoryNumber.RESOURCE_TEMPLATE_ID
                                                    AND resourceTemplate.DELETED = 0
WHERE   (
          (
            directoryNumber.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN directoryNumber.PKEY_EFFECTIVE_FROM
                               AND     directoryNumber.PKEY_EFFECTIVE_TO )
          )
          OR ( directoryNumber.STATUS = 'P' )
          OR (
               directoryNumber.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > directoryNumber.PKEY_EFFECTIVE_TO
             )
        )
        AND directoryNumber.LATEST = 1
        AND directoryNumber.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DIRECTORY_NUMBER_CM_PROV]
	TO [portalapp_role]
GO
