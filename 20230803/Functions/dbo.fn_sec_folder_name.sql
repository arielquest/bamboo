SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION dbo.fn_sec_folder_name ( @id UNIQUEIDENTIFIER )
RETURNS NVARCHAR(50)
AS
    BEGIN 
        DECLARE @name NVARCHAR(260);

        SELECT  @name = NAME
        FROM    dbo.TB_SEC_FOLDER
        WHERE   FOLDER_ID = @id;

        RETURN @name;
    END;
GO
