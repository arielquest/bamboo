SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_clu01_get_exony_db_resource_instance] (@ServerName AS NVARCHAR(50) = NULL) AS
SET NOCOUNT ON;

SELECT *
FROM dbo.fn_clu_get_exony_db_resource_instance(@ServerName);

RETURN 0;
GO
GRANT EXECUTE
	ON [dbo].[ap_clu01_get_exony_db_resource_instance]
	TO [portalapp_role]
GO
