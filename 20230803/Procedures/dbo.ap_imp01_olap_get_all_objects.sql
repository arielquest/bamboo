SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_all_objects] (@OlapClusterResourceId AS UNIQUEIDENTIFIER, @OlapClusterResourceInstanceId AS UNIQUEIDENTIFIER) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER];

    SELECT [OLAP_OBJECT_NAME], [OLAP_OBJECT_TYPE], [PRIMARY_TABLE]
    FROM [dbo].[TB_ADM_OLAP_OBJECT] o
    INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] m ON o.[OLAP_OBJECT_URN] = m.[OLAP_OBJECT_URN]
    WHERE m.[ENABLED] = 1
        AND m.[OLAP_CLUSTER_RESOURCE_ID] IN (@OlapClusterResourceId, @OlapClusterResourceInstanceId)
    ORDER BY [OLAP_OBJECT_TYPE] DESC, [OLAP_OBJECT_NAME];

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_get_all_objects: Failed to read the OLAP objects configuration table. Error: [%d]', 16, 1, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_all_objects]
	TO [portalapp_role]
GO
