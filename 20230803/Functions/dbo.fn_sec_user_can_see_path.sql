SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_sec_user_can_see_path]
    (
      @AuditUser AS VARCHAR(50) ,
      @Path AS VARCHAR(450)
    )
RETURNS BIT
--WITH ENCRYPTION
AS
    BEGIN 

        RETURN 1;
    
    END;
GO
