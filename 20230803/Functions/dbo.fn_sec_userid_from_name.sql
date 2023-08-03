SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION dbo.fn_sec_userid_from_name ( @name NVARCHAR(50) )
RETURNS UNIQUEIDENTIFIER
AS
    BEGIN 
        DECLARE @id UNIQUEIDENTIFIER;

        SELECT  @id = USER_ID
        FROM    dbo.TB_SEC_USER
        WHERE   LOGIN_NAME = @name
                AND DELETED = 0;

        RETURN @id;
    END;
GO
