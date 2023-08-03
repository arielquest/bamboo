SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- Retrieves the OLAP dimension names for any dimensions where the underlying table data has changed
------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_enabled_dimensions] (@OlapClusterResourceInstanceId AS UNIQUEIDENTIFIER) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER];

    SELECT DISTINCT ([OLAP_OBJECT_NAME])
    FROM [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] AS ocm
    INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT] AS oo ON ocm.[OLAP_OBJECT_URN] = oo.[OLAP_OBJECT_URN]
    INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP] tm ON tm.[OLAP_OBJECT_URN] = oo.[OLAP_OBJECT_URN]
    WHERE oo.[OLAP_OBJECT_TYPE] = 'D'
    AND ocm.[ENABLED] = 1
    AND ocm.[OLAP_CLUSTER_RESOURCE_ID] = @OlapClusterResourceInstanceId;

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_get_enabled_dimensions: Failed to read the OLAP objects configuration table. Error: [%d]', 16, 1, @v_Error) WITH LOG;
        RETURN - 1;
    END;
    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_enabled_dimensions]
	TO [portalapp_role]
GO
