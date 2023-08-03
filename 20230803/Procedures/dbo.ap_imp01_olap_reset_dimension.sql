SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- Resets the processing state for the specified OLAP dimension
------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ap_imp01_olap_reset_dimension] 
(
    @dimensionName AS [NVARCHAR](30) = null
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER];

    UPDATE [dbo].[TS_IMP_OLAP_DIMENSION_STATE]
    SET [LAST_GENERATION_COUNT] = - 1
    WHERE [OLAP_OBJECT_CLUSTER_MAP_URN] IN (
            SELECT [OLAP_OBJECT_CLUSTER_MAP_URN]
            FROM [dbo].[TB_ADM_OLAP_OBJECT] o
            INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] m ON o.[OLAP_OBJECT_URN] = m.[OLAP_OBJECT_URN]
            WHERE UPPER([OLAP_OBJECT_NAME]) = UPPER(@dimensionName)
                AND [OLAP_OBJECT_TYPE] = 'D'
            );

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_reset_dimension: Failed to update dimension state. Error: [%d]', 16, 1, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_reset_dimension]
	TO [portalapp_role]
GO
