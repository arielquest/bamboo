SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_sec_get_folder_owner]
    (
      @FolderId UNIQUEIDENTIFIER
    )
RETURNS UNIQUEIDENTIFIER
AS
    BEGIN 
        DECLARE @OwnerId UNIQUEIDENTIFIER;
        DECLARE @FolderPath NVARCHAR(500);
        SELECT  @FolderPath = PATH
        FROM    dbo.TB_SEC_FOLDER
        WHERE   FOLDER_ID = @FolderId;

        SELECT TOP 1
                @OwnerId = FOLDER_ID
        FROM    dbo.TB_SEC_FOLDER
        WHERE   LEFT(@FolderPath, LEN(PATH)) = PATH
                AND FOLDER_TYPE = 'T'
        ORDER BY PATH DESC;
    
        RETURN @OwnerId;
    END;
GO
GRANT EXECUTE
	ON [dbo].[fn_sec_get_folder_owner]
	TO [portalapp_role]
GO
