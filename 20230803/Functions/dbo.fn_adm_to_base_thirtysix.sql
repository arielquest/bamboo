SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_to_base_thirtysix]
    (
      @Number AS INT ,
      @PadTo AS INT
    )
RETURNS VARCHAR(3)
--WITH ENCRYPTION
AS
    BEGIN 
        DECLARE @Base36 AS VARCHAR(10) ,
            @Chars AS CHAR(36) ,
            @Result AS INT;
            
        SET @Chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
        SET @Base36 = '';
        SET @Result = @Number;
    
        WHILE ( @Result > 0 )
            BEGIN 
        
                SET @Base36 = SUBSTRING(@Chars,
                                        ( @Result % 36 ) + 1,
                                        1) + @Base36;
        
                SET @Result = @Result / 36;
        
            END;
        
        IF LEN(@Base36) = 0
            SET @Base36 = '0';
    
        IF LEN(@Base36) < @PadTo
            SET @Base36 = REPLICATE('0',
                                    @PadTo - LEN(@Base36))
                + @Base36;
             
        RETURN @Base36;
    END;
GO
