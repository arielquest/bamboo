SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_rep01_get_default_parameter_set] (@AuditUser NVARCHAR(50) = 'System', @Path NVARCHAR(450) = '', @ResourceType NVARCHAR(50) = 'IT_ALL')
    --WITH ENCRYPTION
AS
SET NOCOUNT ON;

DECLARE @error AS INT;

SET @error = 0;

DECLARE @itemtypeid UNIQUEIDENTIFIER;

SELECT @itemtypeid = ITEM_TYPE_ID
FROM dbo.TE_DIM_ITEM_TYPE
WHERE INTERNAL_NAME = @ResourceType;

/*    Uncomment this section to override security.

    SELECT PARAMETER_SET_ID, NAME
    FROM dbo.TB_REP_PARAMETER_SET s
    WHERE s.ITEM_TYPE_ID = @itemtypeid
    OR @ResourceType = 'IT_ALL'
    ORDER BY NAME
        
    SELECT @error = @@ERROR
    IF @error <> 0
    BEGIN
        RAISERROR(50100, 16, 2, @error, 'ap_rep01_get_default_parameter_set', '')
        GOTO EXIT_SPROC
    END

    RETURN @error
*/
IF LOWER(@AuditUser) = 'system'
BEGIN 
    SELECT TOP 1 PARAMETER_SET_ID, NAME
    FROM dbo.TB_REP_PARAMETER_SET s
    WHERE s.ITEM_TYPE_ID = @itemtypeid
        OR @ResourceType = 'IT_ALL'
    ORDER BY NAME;

    SELECT @error = @@ERROR;

    IF @error <> 0
    BEGIN 
        RAISERROR (50100, 16, 2, @error, 'ap_rep01_get_default_parameter_set', '');
        GOTO EXIT_SPROC;
    END;
END;
ELSE BEGIN 
    DECLARE @userid UNIQUEIDENTIFIER;

    SELECT @userid = USER_ID
    FROM dbo.TB_SEC_USER
    WHERE LOWER(LOGIN_NAME) = LOWER(@AuditUser);

    SELECT @error = @@ERROR;

    IF @error <> 0
    BEGIN 
        RAISERROR (50101, 16, 1, @error, 'ap_rep01_get_default_parameter_set', @AuditUser);
        GOTO EXIT_SPROC;
    END;

    SELECT TOP 1 PARAMETER_SET_ID, NAME
    FROM dbo.TB_REP_PARAMETER_SET s
    INNER JOIN dbo.fn_sec_get_items(@AuditUser, @Path, 'List Parameters') i ON i.FOLDER_ID = s.FOLDER_ID
    WHERE s.ITEM_TYPE_ID = @itemtypeid
        OR @ResourceType = 'IT_ALL'
    ORDER BY NAME;

    SELECT @error = @@ERROR;

    IF @error <> 0
    BEGIN 
        RAISERROR (50100, 16, 2, @error, 'ap_rep01_get_default_parameter_set', '');
        GOTO EXIT_SPROC;
    END;
END;

EXIT_SPROC:

RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_rep01_get_default_parameter_set]
	TO [portalapp_role]
GO
