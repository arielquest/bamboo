SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_first_day_of_week] AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS INT;

    SELECT CAST([PROPERTY_VALUE] AS INT) AS [FIRSTWEEKDAY]
    FROM [dbo].[TB_ADM_PROPERTY]
    WHERE [PROPERTY_KEY] = 'PROP_FIRST_DAY_OF_WEEK';

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_get_first_day_of_week: Failed to read the PROP_FIRST_DAY_OF_WEEK from TB_ADM_PROPERTY table. Error: [%d]', 16, 1, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_first_day_of_week]
	TO [portalapp_role]
GO
