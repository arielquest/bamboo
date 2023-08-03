SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*
USAGE:
DECLARE @Return BIGINT;
EXEC [ap_sec01_get_user_path_code] @UserId = '00000002-0000-0000-0000-000000000006', @Path = '', @Return = @Return OUTPUT;
SELECT @Return;
*/
CREATE   PROCEDURE [dbo].[ap_sec01_get_user_path_code]
    (
      @UserId UNIQUEIDENTIFIER,
      @Path NVARCHAR(450),
      @Return BIGINT OUTPUT
    )
AS
    BEGIN
        SET NOCOUNT ON;
        SET @Return = 0;

        SELECT  @Return |= [CODE]
        FROM    [dbo].[VW_SEC_USER_PATH_TASKS]
        WHERE   [USER_ID] = @UserId
                AND [PATH] = @Path;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_get_user_path_code]
	TO [portalapp_role]
GO
