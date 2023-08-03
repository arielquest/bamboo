SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- Retrieves the OLAP dimension names for any dimensions where the underlying table data has changed
------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_partition_to_processIndex] (@MeasureGroupUrns AS NVARCHAR(MAX), @OLAPResourceInstanceId AS UNIQUEIDENTIFIER) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER];

    SELECT o.[OLAP_OBJECT_URN], p.[OLAP_PARTITION_NAME]
    FROM [dbo].[TB_ADM_OLAP_OBJECT] o
    JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION] p ON o.[OLAP_OBJECT_URN] = p.[OLAP_OBJECT_URN]
    WHERE o.[OLAP_OBJECT_URN] in (SELECT Item FROM fn_adm_string_split(@MeasureGroupUrns, ','))
    AND o.[OLAP_OBJECT_TYPE] = 'C'
    AND p.[RESOURCE_INSTANCE_ID] = @OLAPResourceInstanceId

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_olap_get_partition_to_processIndex: Failed to get partition information from TB_IMP_FCT_OLAP_PARTITION. Error: [%d]', 16, 1, @v_Error) WITH LOG;
        RETURN - 1;
    END;
    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_partition_to_processIndex]
	TO [portalapp_role]
GO
