SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION dbo.fn_sec_folder_path ( @id UNIQUEIDENTIFIER )
RETURNS NVARCHAR(500)
AS
    BEGIN 
        DECLARE @path NVARCHAR(450);

        SELECT  @path = PATH
        FROM    dbo.TB_SEC_FOLDER
        WHERE   FOLDER_ID = @id;

        RETURN @path;
    END;
GO
