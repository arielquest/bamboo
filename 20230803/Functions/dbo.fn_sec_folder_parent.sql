SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION dbo.fn_sec_folder_parent ( @path NVARCHAR(500) )
RETURNS UNIQUEIDENTIFIER
AS
    BEGIN 
        DECLARE @parent UNIQUEIDENTIFIER;

        SELECT  @parent = FOLDER_ID
        FROM    dbo.TB_SEC_FOLDER
        WHERE   PATH + '/' = LEFT(@path,
                                  LEN(@path)
                                  - LEN(dbo.fn_path_name(@path)));

        RETURN @parent;
    END;
GO
