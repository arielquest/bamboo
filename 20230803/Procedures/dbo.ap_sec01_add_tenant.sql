SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_add_tenant] 
(
    @AuditUser NVARCHAR(50), 
    @Path NVARCHAR(250), 
    @Name NVARCHAR(50), 
    @Description NVARCHAR(500) = '', 
    @XmlData XML = NULL, 
    @System BIT = 0, 
    @OwnerId UNIQUEIDENTIFIER OUT
) AS
BEGIN 
    SET NOCOUNT ON;
    
    DECLARE @ErrorMessage VARCHAR(2000);

    DECLARE @ReturnCode INT = 0, @FullPath NVARCHAR(450) = @Path + '/' + @Name, @FullPermissionsRole UNIQUEIDENTIFIER = '00000004-0000-0000-0000-000000000C10',
    @InitialTransactionCount INT = @@TRANCOUNT,
    @PolicyId UNIQUEIDENTIFIER, @AuditId UNIQUEIDENTIFIER, @AdministratorsGroupId UNIQUEIDENTIFIER, @CreateAdvancedGroup NVARCHAR(50), 
    @CreateBasicGroup NVARCHAR(50), @CreateSupervisorGroup NVARCHAR(50), @unused INT;

    BEGIN TRY;
        -- Get Default XML
        IF @XmlData IS NULL
        BEGIN 
            SELECT @XmlData = DEFAULT_XML
            FROM TB_ADM_XML_DEFAULTS
            WHERE TABLE_NAME = 'TB_SEC_FOLDER' AND TYPE_CHARACTER = 'T';
        END;
        BEGIN TRY;
            -- Select which groups to create with the tenant
            SELECT @CreateAdvancedGroup = PROPERTY_VALUE
            FROM TB_ADM_PROPERTY
            WHERE PROPERTY_KEY = 'PROP_CREATE_ADVANCED_USERS_GROUP';

            SELECT @CreateBasicGroup = PROPERTY_VALUE
            FROM TB_ADM_PROPERTY
            WHERE PROPERTY_KEY = 'PROP_CREATE_BASIC_USERS_GROUP';

            SELECT @CreateSupervisorGroup = PROPERTY_VALUE
            FROM TB_ADM_PROPERTY
            WHERE PROPERTY_KEY = 'PROP_CREATE_SUPERVISOR_USERS_GROUP';
        END TRY
        BEGIN CATCH;
            SET @ReturnCode = @@ERROR;
            RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
        END CATCH;

        -- Check Data Validity
        IF NOT EXISTS (SELECT 1 FROM dbo.TB_SEC_FOLDER WHERE PATH = @Path)
        BEGIN 
            SET @ReturnCode = 50204;
            RAISERROR (@ReturnCode, 16, 1, @Path, 'ap_sec01_add_tenant', @AuditUser);
        END;

        IF (SELECT dbo.fn_sec_valid_path(@FullPath, 'T')) = 0
        BEGIN 
            SET @ReturnCode = 50206;
            RAISERROR (@ReturnCode, 16, 1, @FullPath, 'ap_sec01_add_tenant', @AuditUser);
        END;

        SET @AuditId = dbo.fn_sec_userid_from_name(@AuditUser);
        -- Generate a new FOLDER_ID
        SET @OwnerId = NEWID();
        -- Create a new Policy
        SET @PolicyId = NEWID();

        BEGIN TRANSACTION AddTennantTransaction;
            BEGIN TRY;
                INSERT INTO dbo.TB_SEC_POLICY (POLICY_ID, NAME, GLOBAL_POLICY)
                VALUES (@PolicyId, @FullPath, 0);
            END TRY
            BEGIN CATCH;
                SET @ReturnCode = @@ERROR;
                RAISERROR(50101, 16, 1, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
            END CATCH;

            -- Add a policy for the System Administrators group 'administrators' to the new tenant folder policy
            SELECT @AdministratorsGroupId = USER_ID
            FROM TB_SEC_USER
            WHERE LOGIN_NAME = 'administrators' AND USER_TYPE = 'G' AND [SYSTEM] = 1;

            BEGIN TRY;
                INSERT INTO TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                VALUES (@PolicyId, @AdministratorsGroupId, @FullPermissionsRole);
        
                -- Insert SEC_FOLDER
                INSERT INTO dbo.TB_SEC_FOLDER (FOLDER_ID, OWNER_ID, POLICY_ID, FOLDER_TYPE, PATH, DESCRIPTION, POLICY_ROOT, CREATED_BY_ID, XML_DATA, SYSTEM)
                VALUES (@OwnerId, @OwnerId, @PolicyId, 'T', @FullPath, @Description, 1, @AuditId, @XmlData, @System);
                
                -- Insert into TB_ADM_RESOURCE_GROUP_TENANT_MAP
                INSERT INTO dbo.TB_ADM_RESOURCE_GROUP_TENANT_MAP (RESOURCE_GROUP_ID, TENANT_ID, BROWSE_ENABLED, MANAGE_ENABLED, CREATED_BY_ID, MODIFIED_BY_ID, CREATION_DATE, MODIFIED_DATE)
                SELECT ID AS RESOURCE_GROUP_ID, @OwnerId, 1, 0, @AuditId, @AuditId, GETUTCDATE(), GETUTCDATE() 
                FROM dbo.TB_ADM_RESOURCE_GROUP
                WHERE [PATH] IN (
                    '/egain/adm',
                    '/egain/rpt',
                    '/egain/othr'
                    );
                    
                -- Insert into TB_ADM_GADGET_VERSION_TENANT_MAP
                WITH LatestGadgetVersionCTE (ID, GADGET_ID, SORT_NUMBER) 
                AS
                (
                    SELECT gtdVer.ID, gtdVer.GADGET_ID, ROW_NUMBER() OVER (PARTITION BY gtdVer.GADGET_ID ORDER BY MAJOR_VERSION DESC, MINOR_VERSION DESC, BUILD_VERSION DESC, REVISION_NUMBER DESC) AS SORT_NUMBER
                    FROM dbo.TB_ADM_GADGET_VERSION AS gtdVer
                    INNER JOIN dbo.TB_ADM_GADGET AS gtd ON gtd.ID = gtdVer.GADGET_ID
                    WHERE gtd.ID IN (
                        'AF257019-563B-4BC2-B30C-4B37D2B2E450', --'Charts'
                        'C366090F-5E8A-49F9-9F8F-115D249F131B', --'Gadget Manager'
                        'D1BB5D5C-EF48-4F1F-B0DA-7BBCA71C9ACC', --'Reporting'
                        '354D55D0-04D3-43E5-810D-FF71852A3878', --'Resource Manager'
                        '04DB721A-CE3D-4C5E-ADAB-CE53D11515AB', --'Resource Search'
                        '1B1BFCDD-4854-4E20-AF9A-CFBB27348224'--'Welcome'
                    )
                )
                INSERT INTO dbo.TB_ADM_GADGET_VERSION_TENANT_MAP (GADGET_VERSION_ID, TENANT_ID, BROWSE_ENABLED, CREATED_BY_ID, MODIFIED_BY_ID, CREATION_DATE, MODIFIED_DATE)
                SELECT ID, @OwnerId, 1, @AuditId, @AuditId, GETUTCDATE(), GETUTCDATE() 
                FROM LatestGadgetVersionCTE
                WHERE SORT_NUMBER = 1;

            END TRY
            BEGIN CATCH;
                SET @ReturnCode = @@ERROR;
                RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
            END CATCH;
            
            --Add security to the new tenant.
            DECLARE @UserGroupId UNIQUEIDENTIFIER = NEWID(), @UserGroupName NVARCHAR(450), @AdministratorGroupName NVARCHAR(450), 
            @SupervisorGroupName NVARCHAR(450), @SysAdminGroupId UNIQUEIDENTIFIER, @DefaultAdminRoleId UNIQUEIDENTIFIER, 
            @DefaultUserRoleId UNIQUEIDENTIFIER;

            IF (@CreateAdvancedGroup = 'true')
            BEGIN 
                SET @AdministratorGroupName = 'Advanced Users';
                SET @SysAdminGroupId = '00000000-0000-0000-0000-000000000006';

                BEGIN TRY;
                    --Create new Administrators Group for the new tenant
                    INSERT INTO dbo.TB_SEC_USER (USER_ID, FOLDER_ID, USER_TYPE, LOGIN_NAME, SYSTEM)
                    VALUES (@UserGroupId, @OwnerId, 'G', @AdministratorGroupName, 0);
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;

                --Select the Default Tenant Administrators Role from the Property table
                SELECT @DefaultAdminRoleId = r.ROLE_ID
                FROM dbo.TB_SEC_ROLE AS r
                INNER JOIN dbo.TB_ADM_PROPERTY AS p ON CAST(p.PROPERTY_VALUE AS UNIQUEIDENTIFIER) = r.ROLE_ID
                WHERE p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_ADMINISTRATORS_ROLE';

                BEGIN TRY;
                    --Insert Policy User Role data for the Default Administrators group for the Tenant
                    INSERT INTO dbo.TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                    VALUES (@PolicyId, @UserGroupId, @DefaultAdminRoleId);

                    -- Insert Policy User (Global) Role for Tenant Administrator group
                    INSERT INTO dbo.TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                    VALUES ('00000001-0000-0000-0000-000000000004', @UserGroupId, '00000001-0000-0000-0000-000000000C10');
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;
                
                -- Insert into TB_ADM_GADGET_VERSION_USER_MAP
                BEGIN TRY;
                    WITH LatestGadgetVersionCTE (ID, GADGET_ID, SORT_NUMBER) 
                    AS
                    (
                        SELECT gtdVer.ID, gtdVer.GADGET_ID, ROW_NUMBER() OVER (PARTITION BY gtdVer.GADGET_ID ORDER BY MAJOR_VERSION DESC, MINOR_VERSION DESC, BUILD_VERSION DESC, REVISION_NUMBER DESC) AS SORT_NUMBER
                        FROM dbo.TB_ADM_GADGET_VERSION AS gtdVer
                        INNER JOIN dbo.TB_ADM_GADGET AS gtd ON gtd.ID = gtdVer.GADGET_ID
                           WHERE gtd.ID IN (
                            'AF257019-563B-4BC2-B30C-4B37D2B2E450', --'Charts'
                            'C366090F-5E8A-49F9-9F8F-115D249F131B', --'Gadget Manager'
                            'D1BB5D5C-EF48-4F1F-B0DA-7BBCA71C9ACC', --'Reporting'
                            '354D55D0-04D3-43E5-810D-FF71852A3878', --'Resource Manager'
                            '04DB721A-CE3D-4C5E-ADAB-CE53D11515AB', --'Resource Search'
                            '1B1BFCDD-4854-4E20-AF9A-CFBB27348224'--'Welcome'
                        )
                    )
                    INSERT INTO dbo.TB_ADM_GADGET_VERSION_USER_MAP (GADGET_VERSION_ID, USER_ID, BROWSE_ENABLED, CREATED_BY_ID, MODIFIED_BY_ID, CREATION_DATE, MODIFIED_DATE)
                    SELECT ID, @UserGroupId, 1, @AuditId, @AuditId, GETUTCDATE(), GETUTCDATE() 
                    FROM LatestGadgetVersionCTE
                    WHERE SORT_NUMBER = 1;
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;
            END;

            IF (@CreateSupervisorGroup = 'true')
            BEGIN 
                --Create default supervisor group for the tenant
                SET @UserGroupId = NEWID();
                SET @SupervisorGroupName = 'Supervisors';

                BEGIN TRY;
                    INSERT INTO dbo.TB_SEC_USER (USER_ID, FOLDER_ID, USER_TYPE, LOGIN_NAME, SYSTEM)
                    VALUES (@UserGroupId, @OwnerId, 'G', @SupervisorGroupName, 0);
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;

                --Select the Default supervisors Role from the Property table
                SELECT @DefaultUserRoleId = r.ROLE_ID
                FROM dbo.TB_SEC_ROLE AS r
                INNER JOIN dbo.TB_ADM_PROPERTY AS p ON CAST(p.PROPERTY_VALUE AS UNIQUEIDENTIFIER) = r.ROLE_ID
                WHERE p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_SUPERVISORS_ROLE';
            
                BEGIN TRY;           
                    IF @DefaultUserRoleId IS NOT NULL
                    BEGIN 
                        --Insert Policy User Role data for the Default Supervisors group for the Tenant
                        INSERT INTO dbo.TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                        VALUES (@PolicyId, @UserGroupId, @DefaultUserRoleId);
                    END;

                    -- Insert Policy User (Global) Role for Supervisors users group
                    INSERT INTO dbo.TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                    VALUES ('00000001-0000-0000-0000-000000000004', @UserGroupId, '00000003-0000-0000-0000-000000000C10');
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;
                
                BEGIN TRY;
                    WITH LatestGadgetVersionCTE (ID, GADGET_ID, SORT_NUMBER) 
                    AS
                    (
                        SELECT gtdVer.ID, gtdVer.GADGET_ID, ROW_NUMBER() OVER (PARTITION BY gtdVer.GADGET_ID ORDER BY MAJOR_VERSION DESC, MINOR_VERSION DESC, BUILD_VERSION DESC, REVISION_NUMBER DESC) AS SORT_NUMBER
                        FROM dbo.TB_ADM_GADGET_VERSION AS gtdVer
                        INNER JOIN dbo.TB_ADM_GADGET AS gtd ON gtd.ID = gtdVer.GADGET_ID
                        WHERE gtd.ID IN (
                            'AF257019-563B-4BC2-B30C-4B37D2B2E450', --'Charts'
                            'C366090F-5E8A-49F9-9F8F-115D249F131B', --'Gadget Manager'
                            'D1BB5D5C-EF48-4F1F-B0DA-7BBCA71C9ACC', --'Reporting'
                            '354D55D0-04D3-43E5-810D-FF71852A3878', --'Resource Manager'
                            '04DB721A-CE3D-4C5E-ADAB-CE53D11515AB', --'Resource Search'
                            '1B1BFCDD-4854-4E20-AF9A-CFBB27348224'--'Welcome'
                        )
                    )
                    INSERT INTO dbo.TB_ADM_GADGET_VERSION_USER_MAP (GADGET_VERSION_ID, USER_ID, BROWSE_ENABLED, CREATED_BY_ID, MODIFIED_BY_ID, CREATION_DATE, MODIFIED_DATE)
                    SELECT ID, @UserGroupId, 1, @AuditId, @AuditId, GETUTCDATE(), GETUTCDATE() 
                    FROM LatestGadgetVersionCTE
                    WHERE SORT_NUMBER = 1;
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;
            END;

            IF (@CreateBasicGroup = 'true')
            BEGIN 
                --Create default user group for the tenant
                SET @UserGroupId = NEWID();
                SET @UserGroupName = 'Basic Users';

                BEGIN TRY;
                    INSERT INTO dbo.TB_SEC_USER (USER_ID, FOLDER_ID, USER_TYPE, LOGIN_NAME, SYSTEM)
                    VALUES (@UserGroupId, @OwnerId, 'G', @UserGroupName, 0);
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;

                --Select the Default Users Role from the Property table
                SELECT @DefaultUserRoleId = r.ROLE_ID
                FROM dbo.TB_SEC_ROLE AS r
                INNER JOIN dbo.TB_ADM_PROPERTY AS p ON CAST(p.PROPERTY_VALUE AS UNIQUEIDENTIFIER) = r.ROLE_ID
                WHERE p.PROPERTY_KEY = 'PROP_DEFAULT_TENANT_USERS_ROLE';

                BEGIN TRY;
                    IF @DefaultUserRoleId IS NOT NULL
                    BEGIN 
                        --Insert Policy User Role data for the Default users group for the Tenant
                        INSERT INTO dbo.TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                        VALUES (@PolicyId, @UserGroupId, @DefaultUserRoleId);
                    END;

                    -- Insert Policy User (Global) Role for Tenant users group
                    INSERT INTO dbo.TB_SEC_POLICY_USER_ROLE (POLICY_ID, USER_ID, ROLE_ID)
                    VALUES ('00000001-0000-0000-0000-000000000004', @UserGroupId, '00000003-0000-0000-0000-000000000C10');
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;
                
                BEGIN TRY;
                    WITH LatestGadgetVersionCTE (ID, GADGET_ID, SORT_NUMBER) 
                    AS
                    (
                        SELECT gtdVer.ID, gtdVer.GADGET_ID, ROW_NUMBER() OVER (PARTITION BY gtdVer.GADGET_ID ORDER BY MAJOR_VERSION DESC, MINOR_VERSION DESC, BUILD_VERSION DESC, REVISION_NUMBER DESC) AS SORT_NUMBER
                        FROM dbo.TB_ADM_GADGET_VERSION AS gtdVer
                        INNER JOIN dbo.TB_ADM_GADGET AS gtd ON gtd.ID = gtdVer.GADGET_ID
                        WHERE gtd.ID IN (
                            'AF257019-563B-4BC2-B30C-4B37D2B2E450', --'Charts'
                            'C366090F-5E8A-49F9-9F8F-115D249F131B', --'Gadget Manager'
                            'D1BB5D5C-EF48-4F1F-B0DA-7BBCA71C9ACC', --'Reporting'
                            '354D55D0-04D3-43E5-810D-FF71852A3878', --'Resource Manager'
                            '04DB721A-CE3D-4C5E-ADAB-CE53D11515AB', --'Resource Search'
                            '1B1BFCDD-4854-4E20-AF9A-CFBB27348224'--'Welcome'
                        )
                    )
                    INSERT INTO dbo.TB_ADM_GADGET_VERSION_USER_MAP (GADGET_VERSION_ID, USER_ID, BROWSE_ENABLED, CREATED_BY_ID, MODIFIED_BY_ID, CREATION_DATE, MODIFIED_DATE)
                    SELECT ID, @UserGroupId, 1, @AuditId, @AuditId, GETUTCDATE(), GETUTCDATE() 
                    FROM LatestGadgetVersionCTE
                    WHERE SORT_NUMBER = 1;
                END TRY
                BEGIN CATCH;
                    SET @ReturnCode = @@ERROR;
                    RAISERROR(50101, 16, 4, @ReturnCode, 'ap_sec01_add_tenant', @AuditUser);
                END CATCH;
            END;
            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION AddTennantTransaction;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = CASE WHEN @ReturnCode <> 0 THEN @@ERROR ELSE @ReturnCode END,
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

    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_add_tenant]
	TO [portalapp_role]
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_add_tenant]
	TO [portal_database_configuration_role]
GO
