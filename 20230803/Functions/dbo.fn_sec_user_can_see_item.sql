SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_sec_user_can_see_item]
    (
      @AuditUser AS VARCHAR(50) ,
      @SecID AS UNIQUEIDENTIFIER
    )
RETURNS BIT
--WITH ENCRYPTION
AS
    BEGIN 
        RETURN 1;
    END;
GO
