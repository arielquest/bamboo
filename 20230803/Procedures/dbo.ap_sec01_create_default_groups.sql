SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_create_default_groups] 
(
    @AuditUser NVARCHAR(50), 
    @Path NVARCHAR(450), 
    @administratorGroupName NVARCHAR(450), 
    @supervisorGroupName NVARCHAR(450), 
    @userGroupName NVARCHAR(450)    
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @error INT = 0,
        @ErrorMessage NVARCHAR(200),
        @operation NVARCHAR(50) = 'Add Group',
        @global_policy UNIQUEIDENTIFIER = '00000001-0000-0000-0000-000000000004',
        @InitialTransactionCount INT = @@TRANCOUNT,
        @policy UNIQUEIDENTIFIER,
        @secid UNIQUEIDENTIFIER,
        @audit_id UNIQUEIDENTIFIER,
        @createAdvancedGroup NVARCHAR(50),
        @createBasicGroup NVARCHAR(50),
        @createSupervisorGroup NVARCHAR(50),
        @administrators_group_id UNIQUEIDENTIFIER,        
        @unused INT;

    BEGIN TRY;
        BEGIN TRY;
            -- Select which groups to create with the folder
            SELECT  
                    @createAdvancedGroup = MAX(CASE WHEN PROPERTY_KEY = 'PROP_CREATE_ADVANCED_USERS_GROUP' THEN PROPERTY_VALUE
                                                    ELSE ''
                                               END),
                    @createBasicGroup = MAX(CASE WHEN PROPERTY_KEY = 'PROP_CREATE_BASIC_USERS_GROUP' THEN PROPERTY_VALUE
                                                 ELSE ''
                                            END),
                    @createSupervisorGroup = MAX(CASE WHEN PROPERTY_KEY = 'PROP_CREATE_SUPERVISOR_USERS_GROUP' THEN PROPERTY_VALUE
                                                      ELSE ''
                                                 END)
            FROM    dbo.TB_ADM_PROPERTY
            WHERE   PROPERTY_KEY IN ( 'PROP_CREATE_ADVANCED_USERS_GROUP', 'PROP_CREATE_BASIC_USERS_GROUP', 'PROP_CREATE_SUPERVISOR_USERS_GROUP' );

        END TRY
        BEGIN CATCH;
            SET @error = @@ERROR;
            RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
        END CATCH;

        -- Check Data Validity
        IF NOT EXISTS ( SELECT  1
                        FROM    dbo.TB_SEC_FOLDER
                        WHERE   PATH = @Path )
        BEGIN 
            SET @error = 50204;
            RAISERROR (@error, 16, 1, @Path, 'ap_sec01_create_default_groups', @AuditUser);
        END;

        SET @audit_id = dbo.fn_sec_userid_from_name(@AuditUser);

        SELECT  @secid = FOLDER_ID,
                @policy = POLICY_ID
        FROM    dbo.TB_SEC_FOLDER
        WHERE   PATH = @Path;

        BEGIN TRANSACTION CreateDefGrpTransaction;  
        --Add security to the new tenant.
        DECLARE @userGroupAdvancedID UNIQUEIDENTIFIER = NEWID(),
            @userGroupBasicID UNIQUEIDENTIFIER = NEWID(),
            @userGroupSupervisorsID UNIQUEIDENTIFIER = NEWID(),
            @sysAdminGroup UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000006',
            @defaultAdminRole UNIQUEIDENTIFIER,
            @defaultUserRole UNIQUEIDENTIFIER,
            @defaultSupervisorRole AS UNIQUEIDENTIFIER,
            @global_basicRole UNIQUEIDENTIFIER,
            @global_advancedRole UNIQUEIDENTIFIER,
            @global_supervisorRole UNIQUEIDENTIFIER;

        --Select the Default Tenant Administrators Role from the Property table
        --Select the Default Tenant Administrators Global Role from the Property table
        --Select the Default supervisors Role from the Property table
        --Select the Default supervisors Global Role from the Property table
        --Select the Default Users Role from the Property table
        --Select the Default Users Role from the Property table
        SELECT  
                @defaultAdminRole = CAST(MAX(CAST(CASE WHEN p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_ADMINISTRATORS_ROLE' THEN r.ROLE_ID
                                                       ELSE NULL
                                                  END AS VARCHAR(36))) AS UNIQUEIDENTIFIER),
                @global_advancedRole = CAST(MAX(CAST(CASE WHEN p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_ADMINISTRATORS_GLOBAL_ROLE' THEN r.ROLE_ID
                                                          ELSE NULL
                                                     END AS VARCHAR(36))) AS UNIQUEIDENTIFIER),
                @defaultSupervisorRole = CAST(MAX(CAST(CASE WHEN p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_SUPERVISORS_ROLE' THEN r.ROLE_ID
                                                            ELSE NULL
                                                       END AS VARCHAR(36))) AS UNIQUEIDENTIFIER),
                @global_supervisorRole = CAST(MAX(CAST(CASE WHEN p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_SUPERVISORS_GLOBAL_ROLE' THEN r.ROLE_ID
                                                            ELSE NULL
                                                       END AS VARCHAR(36))) AS UNIQUEIDENTIFIER),
                @defaultUserRole = CAST(MAX(CAST(CASE WHEN p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_USERS_ROLE' THEN r.ROLE_ID
                                                      ELSE NULL
                                                 END AS VARCHAR(36))) AS UNIQUEIDENTIFIER),
                @global_basicRole = CAST(MAX(CAST(CASE WHEN p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_USERS_GLOBAL_ROLE' THEN r.ROLE_ID
                                                       ELSE NULL
                                                  END AS VARCHAR(36))) AS UNIQUEIDENTIFIER)
        FROM    dbo.TB_SEC_ROLE AS r
        INNER JOIN dbo.TB_ADM_PROPERTY AS p ON CAST(NULLIF(p.PROPERTY_VALUE, '') AS UNIQUEIDENTIFIER) = r.ROLE_ID
        WHERE   p.PROPERTY_KEY IN ( 'PROP_DEFAULT_TENANT_ADMINISTRATORS_ROLE', 'PROP_DEFAULT_TENANT_ADMINISTRATORS_GLOBAL_ROLE', 
                                    'PROP_DEFAULT_TENANT_SUPERVISORS_ROLE', 'PROP_DEFAULT_TENANT_SUPERVISORS_GLOBAL_ROLE', 
                                    'PROP_DEFAULT_TENANT_USERS_ROLE', 'PROP_DEFAULT_TENANT_USERS_GLOBAL_ROLE' 
                                  );

        -- Check Data Validity
        IF @defaultAdminRole IS NULL
        BEGIN 
            SET @error = 515;
            SET @ErrorMessage = ISNULL(OBJECT_NAME(@@PROCID) + ': ', '') + 'PROP_DEFAULT_TENANT_ADMINISTRATORS_ROLE does not match a role! Error[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;
        IF @defaultSupervisorRole IS NULL
        BEGIN 
            SET @error = 515;
            SET @ErrorMessage = ISNULL(OBJECT_NAME(@@PROCID) + ': ', '') + 'PROP_DEFAULT_TENANT_SUPERVISORS_ROLE does not match a role! Error[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;
        IF @defaultUserRole IS NULL
        BEGIN 
            SET @error = 515;
            SET @ErrorMessage = ISNULL(OBJECT_NAME(@@PROCID) + ': ', '') + 'PROP_DEFAULT_TENANT_USERS_ROLE does not match a role! Error[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;
        IF @global_advancedRole IS NULL
        BEGIN 
            SET @error = 515;
            SET @ErrorMessage = ISNULL(OBJECT_NAME(@@PROCID) + ': ', '') + 'PROP_DEFAULT_TENANT_ADMINISTRATORS_GLOBAL_ROLE does not match a role! Error[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;
        IF @global_supervisorRole IS NULL
        BEGIN 
            SET @error = 515;
            SET @ErrorMessage = ISNULL(OBJECT_NAME(@@PROCID) + ': ', '') + 'PROP_DEFAULT_TENANT_SUPERVISORS_GLOBAL_ROLE does not match a role! Error[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;
        IF @global_basicRole IS NULL
        BEGIN 
            SET @error = 515;
            SET @ErrorMessage = ISNULL(OBJECT_NAME(@@PROCID) + ': ', '') + 'PROP_DEFAULT_TENANT_USERS_GLOBAL_ROLE does not match a role! Error[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;

        --Create new Administrators Group for the new tenant
        IF ( @createAdvancedGroup = 'true' )
        BEGIN 
            IF NOT EXISTS ( SELECT  1
                            FROM    dbo.TB_SEC_USER
                            WHERE   LOGIN_NAME = @administratorGroupName
                                    AND USER_TYPE = 'G'
                                    AND DELETED = 0
                                    AND FOLDER_ID = @secid )
            BEGIN 
                BEGIN TRY;
                    INSERT  INTO dbo.TB_SEC_USER
                            (
                                USER_ID,
                                FOLDER_ID,
                                USER_TYPE,
                                LOGIN_NAME,
                                SYSTEM
                            )
                    VALUES  (
                                @userGroupAdvancedID,
                                @secid,
                                'G',
                                @administratorGroupName,
                                0
                            );
                END TRY
                BEGIN CATCH;
                    SET @error = @@ERROR;
                    RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
                END CATCH;
            END;
            ELSE BEGIN 
                SELECT  @userGroupAdvancedID = USER_ID
                FROM    dbo.TB_SEC_USER
                WHERE   LOGIN_NAME = @administratorGroupName
                        AND USER_TYPE = 'G'
                        AND DELETED = 0
                        AND FOLDER_ID = @secid;
            END;

            BEGIN TRY;
            -- Insert Policy User Role for Administrator group
                INSERT  INTO dbo.TB_SEC_POLICY_USER_ROLE
                        (
                            POLICY_ID,
                            USER_ID,
                            ROLE_ID
                        )
                VALUES  (
                            @policy,
                            @userGroupAdvancedID,
                            @defaultAdminRole
                        );
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
            END CATCH;

            -- Insert GLOBAL Policy 
            IF NOT EXISTS ( SELECT  1
                            FROM    dbo.TB_SEC_POLICY_USER_ROLE
                            WHERE   POLICY_ID = @global_policy
                                    AND USER_ID = @userGroupAdvancedID
                                    AND ROLE_ID = @global_advancedRole )
            BEGIN 
                BEGIN TRY;
                    INSERT  INTO dbo.TB_SEC_POLICY_USER_ROLE
                            (
                                POLICY_ID,
                                USER_ID,
                                ROLE_ID
                            )
                    VALUES  (
                                @global_policy,
                                @userGroupAdvancedID,
                                @global_advancedRole
                            );
                END TRY
                BEGIN CATCH;
                    SET @error = @@ERROR;
                    RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);                    
                END CATCH;
            END;
        END;

        --Create default supervisor group for the tenant
        IF ( @createSupervisorGroup = 'true' )
        BEGIN 
            IF NOT EXISTS ( SELECT  1
                            FROM    dbo.TB_SEC_USER
                            WHERE   LOGIN_NAME = @supervisorGroupName
                                    AND USER_TYPE = 'G'
                                    AND DELETED = 0
                                    AND FOLDER_ID = @secid )
            BEGIN 
                BEGIN TRY;
                    INSERT  INTO dbo.TB_SEC_USER
                            (
                                USER_ID,
                                FOLDER_ID,
                                USER_TYPE,
                                LOGIN_NAME,
                                SYSTEM
                            )
                    VALUES  (
                                @userGroupSupervisorsID,
                                @secid,
                                'G',
                                @supervisorGroupName,
                                0
                            );
                END TRY
                BEGIN CATCH;
                    SET @error = @@ERROR;
                    RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
                END CATCH;
            END;
            ELSE BEGIN 
                SELECT  @userGroupSupervisorsID = USER_ID
                FROM    dbo.TB_SEC_USER
                WHERE   LOGIN_NAME = @supervisorGroupName
                        AND USER_TYPE = 'G'
                        AND DELETED = 0
                        AND FOLDER_ID = @secid;
            END;
            BEGIN TRY;
            -- Insert Policy User Role for Supervisors group
                INSERT  INTO dbo.TB_SEC_POLICY_USER_ROLE
                        (
                            POLICY_ID,
                            USER_ID,
                            ROLE_ID
                        )
                VALUES  (
                            @policy,
                            @userGroupSupervisorsID,
                            @defaultSupervisorRole
                        );
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
            END CATCH;

            -- Insert GLOBAL Policy 
            IF NOT EXISTS ( SELECT  1
                            FROM    dbo.TB_SEC_POLICY_USER_ROLE
                            WHERE   POLICY_ID = @global_policy
                                    AND USER_ID = @userGroupSupervisorsID
                                    AND ROLE_ID = @global_supervisorRole )
            BEGIN 
                BEGIN TRY;
                    INSERT  INTO dbo.TB_SEC_POLICY_USER_ROLE
                            (
                                POLICY_ID,
                                USER_ID,
                                ROLE_ID
                            )
                    VALUES  (
                                @global_policy,
                                @userGroupSupervisorsID,
                                @global_supervisorRole
                            );
                END TRY
                BEGIN CATCH;
                    SET @error = @@ERROR;
                    RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser)
                END CATCH;
            END;
        END;

        --Create default user group for the tenant
        IF ( @createBasicGroup = 'true' )
        BEGIN 
        --SET @userGroupName = 'Basic Users'   
            IF NOT EXISTS ( SELECT  1
                            FROM    dbo.TB_SEC_USER
                            WHERE   LOGIN_NAME = @userGroupName
                                    AND USER_TYPE = 'G'
                                    AND DELETED = 0
                                    AND FOLDER_ID = @secid )
            BEGIN 
                BEGIN TRY;
                    INSERT  INTO dbo.TB_SEC_USER
                            (
                                USER_ID,
                                FOLDER_ID,
                                USER_TYPE,
                                LOGIN_NAME,
                                SYSTEM
                            )
                    VALUES  (
                                @userGroupBasicID,
                                @secid,
                                'G',
                                @userGroupName,
                                0
                            );
                END TRY
                BEGIN CATCH;
                    SET @error = @@ERROR;
                    RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
                END CATCH;
            END;
            ELSE BEGIN 
                SELECT  @userGroupBasicID = USER_ID
                FROM    dbo.TB_SEC_USER
                WHERE   LOGIN_NAME = @userGroupName
                        AND USER_TYPE = 'G'
                        AND DELETED = 0
                        AND FOLDER_ID = @secid;
            END;

            BEGIN TRY;
            -- Insert Policy User Role for Users group
                INSERT  INTO dbo.TB_SEC_POLICY_USER_ROLE
                        (
                            POLICY_ID,
                            USER_ID,
                            ROLE_ID
                        )
                VALUES  (
                            @policy,
                            @userGroupBasicID,
                            @defaultUserRole
                        );
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
            END CATCH;

            -- Insert GLOBAL Policy     
            IF ( 0 >= (
                        SELECT  COUNT(*)
                        FROM    dbo.TB_SEC_POLICY_USER_ROLE
                        WHERE   POLICY_ID = @global_policy
                                AND USER_ID = @userGroupBasicID
                                AND ROLE_ID = @global_basicRole
                        ) )
            BEGIN 
                BEGIN TRY;
                    INSERT  INTO dbo.TB_SEC_POLICY_USER_ROLE
                            (
                                POLICY_ID,
                                USER_ID,
                                ROLE_ID
                            )
                    VALUES  (
                                @global_policy,
                                @userGroupBasicID,
                                @global_basicRole
                            );
                END TRY
                BEGIN CATCH;
                    SET @error = @@ERROR;
                    RAISERROR (50101, 16, 4, @error, 'ap_sec01_create_default_groups', @AuditUser);
                END CATCH;
            END;
        END;

        IF @InitialTransactionCount = 0 
        BEGIN 
            COMMIT TRANSACTION CreateDefGrpTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT  @error = CASE WHEN @error = 0 THEN @@ERROR
                              ELSE @error
                         END,
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
        -- Needs to be last statement in catch so that we get the error passed back to the server
        SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;

    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_create_default_groups]
	TO [portalapp_role]
GO
