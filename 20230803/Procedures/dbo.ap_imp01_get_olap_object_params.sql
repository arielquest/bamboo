SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_olap_object_params] (@PrimaryTable NVARCHAR(50)) AS
BEGIN 
    SET NOCOUNT ON;
    DECLARE @v_Error INT = 0;
    BEGIN TRY;
        SELECT [OLAP_OBJECT_NAME], [SLICE_FACT_KEY] AS SLICE_KEY
        FROM [dbo].[TB_ADM_OLAP_OBJECT]
        WHERE OBJECT_ID(PRIMARY_TABLE) = OBJECT_ID(@PrimaryTable)
            AND OLAP_OBJECT_TYPE = 'C';
    END TRY
    BEGIN CATCH;
        SET @v_Error = @@ERROR;
        RAISERROR ('ap_imp01_get_olap_object_params: Failed to read the OLAP object configuration table. Error: [%d]', 16, 1, @v_Error) WITH LOG;
    END CATCH;

    SET @v_Error = CASE WHEN @v_Error <> 0 THEN - 1 ELSE 0 END;

    RETURN @v_Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_olap_object_params]
	TO [portalapp_role]
GO
