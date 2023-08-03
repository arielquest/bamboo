SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CLU_FOLDER_EQUIPMENT_MAPPING]
AS
SELECT  allFolders.FOLDER_ID,
        closestMappingPerCluster.MAPPING_FOLDER_ID,
        closestMappingPerCluster.RESOURCE_ID,
        closestMappingPerCluster.MAPPING_TYPE,
        closestMappingPerCluster.VERSION,
        closestMappingPerCluster.RESOURCE_TYPE_ID,
        closestMappingPerCluster.RESOURCE_TYPE_INTERNAL_NAME,
        closestMappingPerCluster.RESOURCE_XML_DATA,
        closestMappingPerCluster.REMOTE_TENANT_BUSINESS_URN,
        closestMappingPerCluster.DEFAULT_IMPORT_LOCATION,
        closestMappingPerCluster.XML_DATA
FROM    TB_SEC_FOLDER allFolders
OUTER APPLY ( SELECT    closestMappings.*
              FROM      dbo.TB_CLU_RESOURCE cluster
              CROSS APPLY ( SELECT TOP 1
                                    cfm.FOLDER_ID AS MAPPING_FOLDER_ID,
                                    cfm.RESOURCE_ID,
                                    cfm.MAPPING_TYPE,
                                    clu.VERSION,
                                    clu.RESOURCE_TYPE_ID,
                                    clu.XML_DATA AS RESOURCE_XML_DATA,
                                    clt.INTERNAL_NAME AS RESOURCE_TYPE_INTERNAL_NAME,
                                    cfm.REMOTE_TENANT_BUSINESS_URN,
                                    cfm.DEFAULT_IMPORT_LOCATION,
                                    cfm.XML_DATA
                            FROM    dbo.TB_CLU_RESOURCE_FOLDER_MAPPING cfm
                            JOIN    dbo.TB_CLU_RESOURCE clu ON cfm.RESOURCE_ID = clu.RESOURCE_ID
                            JOIN    dbo.TE_ADM_CLUSTER_RESOURCE_TYPE clt ON clt.CLUSTER_RESOURCE_TYPE_ID = clu.RESOURCE_TYPE_ID
                            JOIN    dbo.TB_SEC_FOLDER f ON f.FOLDER_ID = cfm.FOLDER_ID
                            JOIN    dbo.TB_SEC_FOLDER sf ON sf.PATH = f.PATH
                                                            OR sf.PATH LIKE f.PATH
                                                            + '/%'
                            WHERE   sf.FOLDER_ID = allFolders.FOLDER_ID
                                    AND cluster.RESOURCE_ID = cfm.RESOURCE_ID
                            ORDER BY f.DEPTH DESC
                          ) closestMappings
            ) closestMappingPerCluster;
GO
GRANT SELECT
	ON [dbo].[VW_CLU_FOLDER_EQUIPMENT_MAPPING]
	TO [portalapp_role]
GO
