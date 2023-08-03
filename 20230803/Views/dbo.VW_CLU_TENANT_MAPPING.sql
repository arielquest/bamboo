SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_CLU_TENANT_MAPPING
AS
SELECT DISTINCT
        RESOURCE_ID,
        dbo.fn_sec_get_folder_owner(FOLDER_ID) AS OWNER_ID
FROM    TB_CLU_RESOURCE_FOLDER_MAPPING;
GO
GRANT SELECT
	ON [dbo].[VW_CLU_TENANT_MAPPING]
	TO [portalapp_role]
GO
