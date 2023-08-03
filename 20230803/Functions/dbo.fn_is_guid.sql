SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.fn_is_guid ( @Input AS NVARCHAR(MAX) )
RETURNS BIT
--WITH ENCRYPTION
AS
    BEGIN 
        DECLARE @isGuid AS BIT ,
            @guidValue AS UNIQUEIDENTIFIER ,
            @error AS INT;  

        SELECT  @isGuid = 0 ,
                @Input = REPLACE(REPLACE(@Input, '{', ''),
                                 '}', '');
        IF LEN(ISNULL(@Input, '')) = 36
            AND @Input NOT LIKE '%[^0-9A-FA-F-]%'
            AND
       -- CHECK FOR PROPER POSITIONS OF HYPHENS (-)  
            CHARINDEX('-', @Input) = 9
            AND CHARINDEX('-', @Input, 10) = 14
            AND CHARINDEX('-', @Input, 15) = 19
            AND CHARINDEX('-', @Input, 20) = 24
            AND CHARINDEX('-', @Input, 25) = 0
            SET @isGuid = 1;

        RETURN @isGuid;
    END;
GO
