SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_sec_valid_path]
    (
      @Path AS VARCHAR(450) ,
      @Type AS CHAR(1) = NULL -- I.e Ignore Type checking
    )
RETURNS BIT
--WITH ENCRYPTION
AS
    BEGIN 
        DECLARE @ParentType AS CHAR(1) ,
            @PathDepth AS INT ,
            @ParentID AS UNIQUEIDENTIFIER;
      
    -- Check that Path is the root or starts with '$/' 
        IF ( LEN(@Path) > 1
             AND LEFT(@Path, 1) <> '/'
           )
            RETURN 0;
    
    -- Check that Path does not contain '$' symbol other than as Root
    --IF CHARINDEX('$', @Path, 2) <> 0
    --    RETURN 0
    
    -- Not Allow Trailing Spaces
        IF NOT ( LEN(@Path) = LEN(REPLACE(@Path, ' ', '_')) )
            RETURN 0;
        
    -- Does the parent exist?
        SET @ParentID = [dbo].[fn_sec_folder_parent](@Path);

        IF @ParentID IS NULL
            RETURN 0;

    --Commented now because Tenants can now be under other tenants, just like folders.
    -- Tenants must go at under root
--    IF @Type IS NOT NULL AND @Type = 'T'
--    BEGIN
--        SET @PathDepth = dbo.fn_path_depth(@Path)
--
--        IF @PathDepth <> 1
--            RETURN 0
--    END
             
        RETURN 1;
    END;
GO
