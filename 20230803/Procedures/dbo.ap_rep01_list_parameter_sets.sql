SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_rep01_list_parameter_sets] (@AuditUser NVARCHAR(50) = 'System', @Path NVARCHAR(450) = '', @ResourceType NVARCHAR(50) = 'IT_ALL') AS
SET NOCOUNT ON;

DECLARE @error AS INT, @userpath AS NVARCHAR(100);

SET @error = 0;
SET @userpath = '';

DECLARE @itemtypeid UNIQUEIDENTIFIER;

SELECT @itemtypeid = ITEM_TYPE_ID
FROM dbo.TE_DIM_ITEM_TYPE
WHERE INTERNAL_NAME = @ResourceType;

/*    Uncomment this section to override security.

    SELECT '{' + CAST(PARAMETER_SET_ID as varchar(200)) + '}' AS PARAMETER_SET_ID, NAME
    FROM dbo.TB_REP_PARAMETER_SET s
    WHERE s.ITEM_TYPE_ID = @itemtypeid
    OR @ResourceType = 'IT_ALL'
    ORDER BY NAME
        
    SELECT @error = @@ERROR
    IF @error <> 0
    BEGIN
        RAISERROR(50100, 16, 2, @error, 'ap_rep01_list_parameter_sets', '')
        GOTO EXIT_SPROC
    END

    RETURN @error
*/
IF LOWER(@AuditUser) = 'system'
BEGIN 
    SELECT '{' + CAST(PARAMETER_SET_ID AS VARCHAR(200)) + '}' AS PARAMETER_SET_ID, NAME
    FROM dbo.TB_REP_PARAMETER_SET s
    WHERE s.ITEM_TYPE_ID = @itemtypeid
        OR @ResourceType = 'IT_ALL'
    ORDER BY NAME;

    SELECT @error = @@ERROR;

    IF @error <> 0
    BEGIN 
        RAISERROR (50100, 16, 2, @error, 'ap_rep01_list_parameter_sets', '');
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
        RAISERROR (50101, 16, 1, @error, 'ap_rep01_list_parameter_sets', @AuditUser);
        GOTO EXIT_SPROC;
    END;

    -- Get the user's physical location
    SELECT @userpath = PATH
    FROM TB_SEC_FOLDER f
    INNER JOIN TB_SEC_USER u ON u.FOLDER_ID = f.FOLDER_ID
    WHERE u.LOGIN_NAME = @AuditUser;

    SELECT 'f:"' + @userpath + '" context:"' + @AuditUser + '"' AS PARAMETER_SET_ID, 'All ' + NAME + 's in ' + @AuditUser + ' folder' AS NAME
    FROM dbo.TE_DIM_ITEM_TYPE
    WHERE ITEM_TYPE_ID = @itemtypeid
    UNION   
    SELECT '{' + CAST(PARAMETER_SET_ID AS VARCHAR(200)) + '}', NAME
    FROM dbo.TB_REP_PARAMETER_SET s
    INNER JOIN dbo.fn_rep_get_parameter_folders(@AuditUser, @Path) i ON i.FOLDER_ID = s.FOLDER_ID
    WHERE s.ITEM_TYPE_ID = @itemtypeid
        OR @ResourceType = 'IT_ALL'
    ORDER BY NAME;

    SELECT @error = @@ERROR;

    IF @error <> 0
    BEGIN 
        RAISERROR (50100, 16, 2, @error, 'ap_rep01_list_parameter_sets', '');
        GOTO EXIT_SPROC;
    END;
END;

EXIT_SPROC:

RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_rep01_list_parameter_sets]
	TO [portalapp_role]
GO
