SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_get_int_property]
    (
      @PropertyKey [NVARCHAR](50) ,
      @DefaultValue [INT] = NULL
    )
RETURNS INT
--WITH ENCRYPTION
AS
    BEGIN 
        DECLARE @value INT;
    
        SELECT  @value = CAST(PROPERTY_VALUE AS INT)
        FROM    dbo.TB_ADM_PROPERTY
        WHERE   PROPERTY_KEY = @PropertyKey;
    
        IF @value IS NULL
            SET @value = @DefaultValue;

        RETURN @value;
    END;
GO
