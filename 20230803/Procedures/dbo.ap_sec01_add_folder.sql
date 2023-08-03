SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_add_folder] 
(
    @AuditUser NVARCHAR(50), 
    @Path NVARCHAR(450), 
    @Name NVARCHAR(50), 
    @Description NVARCHAR(500) = '', 
    @XmlData XML = NULL,
    @System BIT = 0, 
    @FolderId UNIQUEIDENTIFIER OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ErrorMessage VARCHAR(2000);

    IF @FolderId IS NULL
    BEGIN 
        SET @FolderId = NEWID();
    END;

    DECLARE @Error INT = 0, @Operation NVARCHAR(50) = 'Add Folder', @FolderName NVARCHAR(450) = @Path + '/' + @Name, @InitialTransactionCount INT = @@TRANCOUNT,
    @Policy UNIQUEIDENTIFIER, @AuditId UNIQUEIDENTIFIER, @unused INT, @Owner_ID UNIQUEIDENTIFIER;

    BEGIN TRY;
        -- Get Default XML
        IF @XmlData IS NULL
        BEGIN 
            SELECT @XmlData = DEFAULT_XML
            FROM TB_ADM_XML_DEFAULTS
            WHERE TABLE_NAME = 'TB_SEC_FOLDER' AND TYPE_CHARACTER = 'F';
        END;

        -- Check Data Validity
        IF NOT EXISTS (SELECT 1 FROM dbo.TB_SEC_FOLDER WHERE PATH = @Path)
        BEGIN 
            SET @Error = 50204;
            RAISERROR (@Error, 16, 1, @Path, 'ap_sec01_add_folder', @AuditUser);
        END;

        -- Determine Policy
        SELECT @Policy = POLICY_ID
        FROM dbo.TB_SEC_FOLDER
        WHERE FOLDER_ID = dbo.fn_folder_id_from_path(@Path);

        IF @Policy IS NULL
        BEGIN 
            SET @Error = 50203;
            RAISERROR (@Error, 16, 2, @Path, 'ap_sec01_add_folder', @AuditUser);
        END;

        -- Determine Owner
        SELECT  @Owner_ID = [OWNER_ID]
        FROM    [dbo].[TB_SEC_FOLDER]
        WHERE   [PATH] = LEFT(@FolderName, LEN(@FolderName) - CHARINDEX('/', REVERSE(@FolderName)));

        IF @Owner_ID = @FolderId
        BEGIN
            SET @Owner_ID = NULL;
        END;

        SET @AuditId = dbo.fn_sec_userid_from_name(@AuditUser);

        BEGIN TRANSACTION AddFolderTransaction;   
            BEGIN TRY;
                INSERT INTO [TB_SEC_FOLDER] (FOLDER_ID, OWNER_ID, POLICY_ID, FOLDER_TYPE, PATH, DESCRIPTION, CONTAINER, SYSTEM, CREATED_BY_ID, XML_DATA)
                VALUES (@FolderId, @Owner_ID, @Policy, 'F', @FolderName, @Description, 1, @System, @AuditId, @XmlData);
            END TRY
            BEGIN CATCH;
                SET @Error = @@ERROR;
                RAISERROR (50101, 16, 3, @Error, 'ap_sec01_add_folder', @AuditUser);
            END CATCH;
        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION AddFolderTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;   
    END TRY
    BEGIN CATCH;
        SELECT @Error = CASE WHEN @Error <> 0 THEN @@ERROR ELSE @Error END,
               @ErrorMessage = ERROR_MESSAGE();
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END;
        SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
    RETURN @Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_add_folder]
	TO [portalapp_role]
GO
