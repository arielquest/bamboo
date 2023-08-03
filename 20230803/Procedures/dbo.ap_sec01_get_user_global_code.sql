SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*
USAGE:
DECLARE @Return BIGINT;
EXEC [ap_sec01_get_user_global_code] @UserId = '00000002-0000-0000-0000-000000000006', @Return = @Return OUTPUT;
SELECT @Return;
*/
CREATE   PROCEDURE [dbo].[ap_sec01_get_user_global_code]
    (
      @UserId UNIQUEIDENTIFIER,
      @Return BIGINT OUTPUT
    )
AS
    BEGIN
        SET NOCOUNT ON;
        SET @Return = 0;

        SELECT  @Return |= [CODE]
        FROM    [dbo].[VW_SEC_USER_GLOBAL_TASKS]
        WHERE   [USER_ID] = @UserId;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_get_user_global_code]
	TO [portalapp_role]
GO
