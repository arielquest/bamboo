SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_get_string_property]
    (
      @PropertyKey [NVARCHAR](50) ,
      @DefaultValue [NVARCHAR](50) = NULL
    )
RETURNS NVARCHAR(500)
--WITH ENCRYPTION
AS
    BEGIN 
        DECLARE @value NVARCHAR(500);
    
        SELECT  @value = PROPERTY_VALUE
        FROM    dbo.TB_ADM_PROPERTY
        WHERE   PROPERTY_KEY = @PropertyKey;
    
        IF @value IS NULL
            SET @value = @DefaultValue;

        RETURN @value;
    END;
GO
