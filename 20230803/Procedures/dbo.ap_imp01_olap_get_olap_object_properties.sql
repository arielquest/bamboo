SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_olap_object_properties] 
( 
    @I_ParentOlapObjectName AS [NVARCHAR](50),
    @I_ObjectName AS [VARCHAR](128) 
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER];
    
    If(@I_ParentOlapObjectName = '')
    BEGIN
        SELECT '' AS SLICE_DIMENSION_NAME, *
        FROM TB_ADM_OLAP_OBJECT ob
        INNER JOIN TB_ADM_OLAP_OBJECT_CLUSTER_MAP oc ON ob.OLAP_OBJECT_URN = oc.OLAP_OBJECT_URN
        WHERE ob.PARENT_OLAP_OBJECT_NAME = @I_ParentOlapObjectName
            AND ob.OLAP_OBJECT_NAME = @I_ObjectName;
    END;
    ELSE
    BEGIN
        SELECT od.OLAP_OBJECT_NAME AS SLICE_DIMENSION_NAME, *
        FROM TB_ADM_OLAP_OBJECT ob
        INNER JOIN TB_ADM_OLAP_OBJECT od ON ob.SLICE_DIMENSION = od.OLAP_OBJECT_URN
        INNER JOIN TB_ADM_OLAP_OBJECT_CLUSTER_MAP oc ON ob.OLAP_OBJECT_URN = oc.OLAP_OBJECT_URN
        WHERE ob.PARENT_OLAP_OBJECT_NAME = @I_ParentOlapObjectName
            AND ob.OLAP_OBJECT_NAME = @I_ObjectName;    
    END;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_get_olap_object_properties: Failed to get the olap object properties for object [%s]. Error: [%d]', 16, 1, @I_ObjectName, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_olap_object_properties]
	TO [portalapp_role]
GO
