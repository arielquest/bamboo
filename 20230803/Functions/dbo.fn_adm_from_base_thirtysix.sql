SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_from_base_thirtysix] ( @Base36 AS
                                            VARCHAR(10) )
RETURNS VARCHAR(5)
--WITH ENCRYPTION
AS
    BEGIN 
        DECLARE @Result AS INT ,
            @Multiplier AS INT ,
            @Chars AS CHAR(36) ,
            @OneChar AS CHAR(1);
            
        SET @Chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
        SET @Result = 0;
        SET @Multiplier = 1;
    
        WHILE ( LEN(@Base36) > 0 )
            BEGIN 
        
                SET @Result = @Result
                    + ( ( CHARINDEX(RIGHT(@Base36, 1),
                                    @Chars) - 1 )
                        * @Multiplier );
        
                SET @Base36 = LEFT(@Base36, LEN(@Base36) - 1);
        
                SET @Multiplier = @Multiplier * 36;
        
            END;
             
        RETURN @Result;
    END;
GO
