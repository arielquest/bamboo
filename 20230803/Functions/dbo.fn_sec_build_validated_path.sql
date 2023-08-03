SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_sec_build_validated_path]
    (
      @ParentPath AS VARCHAR(450) ,
      @Name AS VARCHAR(50)
    )
RETURNS VARCHAR(450)
--WITH ENCRYPTION
AS
    BEGIN 

        DECLARE @NewPath AS VARCHAR(500) ,
            @ValidPath AS SMALLINT;
    
        IF CHARINDEX('/', REVERSE(@ParentPath)) <> 1
            SET @ParentPath = @ParentPath + '/';
    
        SELECT  @NewPath = @ParentPath + @Name;
    
        IF LEN(@NewPath) > 450
            RETURN NULL;
    
        SELECT  @ValidPath = [dbo].[fn_sec_valid_path](@NewPath,
                                            'A');
        IF ( @ValidPath = 1 )
            RETURN @NewPath;
     
        RETURN NULL;
    
    END;
GO
