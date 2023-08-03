SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_fct_slice_keys_legacy] 
( 
    @I_ParentObjectName AS [VARCHAR](50),
    @I_ObjectName AS [VARCHAR](128)
) AS 
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER], @v_OlapObjectURN AS [INTEGER], @v_PrimaryTable AS [VARCHAR] (128), @v_SliceFactKey AS [VARCHAR] (128), @v_Sql AS [NVARCHAR] (4000);

    SELECT @v_OlapObjectURN = [OLAP_OBJECT_URN], @v_PrimaryTable = [PRIMARY_TABLE], @v_SliceFactKey = [SLICE_FACT_KEY]
    FROM [dbo].[TB_ADM_OLAP_OBJECT]
    WHERE [PARENT_OLAP_OBJECT_NAME] = @I_ParentObjectName
        AND [OLAP_OBJECT_NAME] = @I_ObjectName;

    SET @v_Sql = 'SELECT [' + @v_SliceFactKey + '] AS [SLICE_KEYS], [ROW_URN] FROM [dbo].[TS_IMP_SUMMARIZED]  AS ts '+CHAR(13)+CHAR(10);
    SET @v_Sql = @v_Sql + 'JOIN [dbo].[' + @v_PrimaryTable + '] AS pt ON ts.[ROW_URN] = pt.[FACT_URN] '+CHAR(13)+CHAR(10);
    SET @v_Sql = @v_Sql + 'WHERE ts.[OLAP_OBJECT_URN] = @e_OlapObjectURN'+CHAR(13)+CHAR(10);
    SET @v_Sql = @v_Sql + ' AND ts.[ACTION] = '+CHAR(39)+'I'+CHAR(39)+' ORDER BY 1 DESC;';

    EXECUTE sp_executesql @v_Sql, N'@e_OlapObjectURN INT', @e_OlapObjectURN = @v_OlapObjectURN;

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_get_fct_slice_keys_legacy: Failed to get the fact slice keys for object [%s]. Error: [%d]', 16, 1, @I_ObjectName, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_fct_slice_keys_legacy]
	TO [portalapp_role]
GO
