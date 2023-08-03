SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_code_group_names] AS
BEGIN 
    
    -- This procedure retreives all code group names that are present in [TB_DIM_CODE_GROUP]. These Code Groups will always have Codes that are of type IT_CODE.
    -- The fact columns where the Codes are used usually share these Code Group names. 
    -- The column names will not always be like for like
    -- for example: 
    --         CALL_DISPOSITION_URN column in TB_FCT_CALL_DETAIL_END corresponds to CG_CALL_DISPOSITION in [TB_DIM_CODE_GROUP] (CODE_GROUP_NAME returned is CALL_DISPOSITION)
    --        Value column in TB_FCT_CALL_DETAIL_END corresponds to CG_VALUE in [TB_DIM_CODE_GROUP] (CODE_GROUP_NAME returned is VALUE)
    -- There may be a column in the fact table that my be named differently to the INTERNAL_NAME in [TB_DIM_CODE_GROUP]
    -- for example: LOGOUT_REASON_URN column in TB_FCT_AGENT_LOGOUT corresponds to CG_AGENT_LOGOUT_REASON in [TB_DIM_CODE_GROUP]. Hence we have to union LOGOUT_REASON with the result set since it is of type IT_CODE.
    
    SET NOCOUNT ON;

    DECLARE @v_Error AS INT;

    SELECT SUBSTRING(INTERNAL_NAME, 4, LEN(INTERNAL_NAME)) AS [CODE_GROUP_NAME] 
    FROM [dbo].[TB_DIM_CODE_GROUP]
    WHERE [ITEM_URN] NOT IN (-1, -2)
    UNION 
    SELECT 'LOGOUT_REASON' AS [CODE_GROUP_NAME] 
    ;

    SELECT @v_Error = @@ERROR;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_imp01_get_code_group_names: Failed to read the INTERNAL_NAME from TB_DIM_CODE_GROUP table. Error: [%d]', 16, 1, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_code_group_names]
	TO [portalapp_role]
GO
