SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_datetime_to_string] ( @DateTime DATETIME )
RETURNS NVARCHAR(23)
AS
    BEGIN 
        DECLARE @IsoDateString AS NVARCHAR(23);
    
        SET @IsoDateString = CASE WHEN CHARINDEX('.',
                                            CONVERT(NVARCHAR(50), @DateTime, 126)) = 0
                                  THEN CONVERT(NVARCHAR(50), @DateTime, 126)
                                       + '.000'
                                  ELSE CONVERT(NVARCHAR(50), @DateTime, 126)
                             END;
    
    --RETURN LEFT(CONVERT(varchar(23), CAST(GETUTCDATE() AS DATETIME2(3)), 126)+'.000',23) 
    
        RETURN @IsoDateString;
    END;
GO
GRANT EXECUTE
	ON [dbo].[fn_adm_datetime_to_string]
	TO [portalapp_role]
GO
GRANT EXECUTE
	ON [dbo].[fn_adm_datetime_to_string]
	TO [portal_database_configuration_role]
GO
