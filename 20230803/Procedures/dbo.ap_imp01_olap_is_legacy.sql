SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_is_legacy] 
( 
    @I_ParentObjectName AS [VARCHAR](50),
    @I_ObjectName AS [VARCHAR](128),
    @O_Legacy AS [BIT] OUTPUT   
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS [INTEGER], @v_OlapObjectURN AS [INTEGER];

    SET @O_Legacy = 0;

    SELECT @v_OlapObjectURN = [OLAP_OBJECT_URN]
    FROM [dbo].[TB_ADM_OLAP_OBJECT]
    WHERE [PARENT_OLAP_OBJECT_NAME] = @I_ParentObjectName
        AND [OLAP_OBJECT_NAME] = @I_ObjectName;

    -- OLAP_OBJECT_URN 210 = [Outbound] cube's [Form Response] measure group.
    -- OLAP_OBJECT_URN 218 = [Call Experience] cube's [Form Response] measure group.
    -- OLAP_OBJECT_URN 219 = [Agent] cube's [Form Response] measure group.
    -- OLAP_OBJECT_URN 401 = [Form Response] cube's [Form Response] measure group.
    -- OLAP_OBJECT_URN 220 = [Agent] cube's [Skillgroup Enterprise Skillgroup Member] measure group.
    -- OLAP_OBJECT_URN 221 = [Call Experience] cube's [Skillgroup Enterprise Skillgroup Member] measure group.
    IF (@v_OlapObjectURN = 210 OR @v_OlapObjectURN = 218 OR @v_OlapObjectURN = 219 OR @v_OlapObjectURN = 401 OR @v_OlapObjectURN = 220 OR @v_OlapObjectURN = 221) 
    BEGIN 
        SET @O_Legacy = 1;
    END;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_is_legacy]
	TO [portalapp_role]
GO
