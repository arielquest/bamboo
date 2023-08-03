SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_olap_object_properties_by_urn] 
( 
    @I_OlapObjectUrn AS [INTEGER] 
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER];

    SELECT *
    FROM TB_ADM_OLAP_OBJECT ob
    INNER JOIN TB_ADM_OLAP_OBJECT_CLUSTER_MAP oc ON ob.OLAP_OBJECT_URN = oc.OLAP_OBJECT_URN
    WHERE ob.OLAP_OBJECT_URN = @I_OlapObjectUrn;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_get_olap_object_properties_by_urn: Failed to get the olap object properties for olap object urn [%s]. Error: [%d]', 16, 1, @I_OlapObjectUrn, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_olap_object_properties_by_urn]
	TO [portalapp_role]
GO
