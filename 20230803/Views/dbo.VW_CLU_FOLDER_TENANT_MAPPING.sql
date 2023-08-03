SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_CLU_FOLDER_TENANT_MAPPING
AS
SELECT  allFolders.FOLDER_ID,
        deepestRemoteTenants.RESOURCE_ID,
        deepestRemoteTenants.REMOTE_TENANT_BUSINESS_URN
FROM    TB_SEC_FOLDER allFolders
OUTER APPLY (
              -- The deepest folder-tenant mapping for each cluster resource
              SELECT    *
              FROM      ( SELECT    cfm.RESOURCE_ID,
                                    cfm.REMOTE_TENANT_BUSINESS_URN,
                                    ROW_NUMBER() OVER ( PARTITION BY cfm.RESOURCE_ID ORDER BY f.DEPTH DESC ) AS INVERSE_FOLDER_DEPTH
                          FROM      dbo.TB_CLU_RESOURCE_FOLDER_MAPPING cfm
                          INNER JOIN dbo.TB_SEC_FOLDER f ON f.FOLDER_ID = cfm.FOLDER_ID
                          INNER JOIN dbo.TB_SEC_FOLDER sf ON sf.PATH = f.PATH
                                                             OR sf.PATH LIKE f.PATH
                                                             + '/%'
                          WHERE     REMOTE_TENANT_BUSINESS_URN IS NOT NULL
                                    AND allFolders.FOLDER_ID = sf.FOLDER_ID
                        ) remoteTenants
              WHERE     remoteTenants.INVERSE_FOLDER_DEPTH = 1
            ) deepestRemoteTenants;
GO
GRANT SELECT
	ON [dbo].[VW_CLU_FOLDER_TENANT_MAPPING]
	TO [portalapp_role]
GO
