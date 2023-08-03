SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_purge_info] 
(
    @OlapClusterResourceId    AS uniqueidentifier
) AS
BEGIN 
    SET NOCOUNT ON;

    SELECT [PARENT_OLAP_OBJECT_NAME], [OLAP_OBJECT_NAME], [PRIMARY_TABLE], [OLAP_OBJECT_TYPE], [CHECK_MEASURE], [RETAIN_DAYS]
    FROM [dbo].[TB_ADM_OLAP_OBJECT] o
    INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] m ON m.[OLAP_OBJECT_URN] = o.[OLAP_OBJECT_URN]
    WHERE o.[OLAP_OBJECT_TYPE] = 'C'
        AND m.[RETAIN_DAYS] > 0
        AND m.[ENABLED] = 1
        AND m.[OLAP_CLUSTER_RESOURCE_ID] = @OlapClusterResourceId;

    RETURN @@ERROR;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_purge_info]
	TO [portalapp_role]
GO
