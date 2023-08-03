SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_add_ivr_script_node_ivr_module_member_pkey]
(
    @SessionId         [UNIQUEIDENTIFIER],
    @ClusterResourceId [UNIQUEIDENTIFIER],
    @MemberBusinessUrn [INTEGER],
    @EffectiveFrom     [DATETIME],
    @EffectiveTo       [DATETIME],
    @PKey1             [NVARCHAR](100) = NULL,
    @PKey2             [NVARCHAR](100) = NULL,
    @SourceChangeStamp [INTEGER] = NULL,
    @XmlData           [XML] = NULL,
    @CustomXmlData     [XML] = NULL,
    @Provision         [BIT] = NULL,
    @PkeyMapUrn        [INTEGER] OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ReturnCode                     AS [INTEGER] = 0,
            @Status                         AS [CHAR](1),
            @MemberTypeId                   AS [UNIQUEIDENTIFIER],
            @MemberTypeIsProvisionable      AS [BIT],            
            @ClusterResourceName            AS [NVARCHAR](50),
            @ClusterResourceIsProvisionable AS [BIT],
            @System                         AS [BIT],
            @ParentItemBusinessUrn          AS [INTEGER],
            @ChildItemBusinessUrn           AS [INTEGER],
            @AuditUrn                       AS [BIGINT],
            @AuditTypeName                  AS [NVARCHAR](50),
            @ClusterResourceTypeId          AS [UNIQUEIDENTIFIER],
            @UtcNow                         AS [DATETIME] = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
            @InitialTransactionCount        AS [INTEGER] = @@TRANCOUNT,
            @SessionUserId                  AS [UNIQUEIDENTIFIER],
            @ErrorMessage                   AS VARCHAR(1024);
    
    -- Default effective dates
    SET @EffectiveFrom = COALESCE(@EffectiveFrom, @UtcNow);
    SET @EffectiveFrom = DATEADD(ms, -(DATEPART(ms, @EffectiveFrom)), @EffectiveFrom);
    SET @EffectiveTo = COALESCE(@EffectiveTo, '2079-06-06 00:00:00');
    SET @EffectiveTo = DATEADD(ms, -(DATEPART(ms, @EffectiveTo)), @EffectiveTo);

    BEGIN TRY;
        --Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_add_ivr_script_node_ivr_module_member_pkey');
        END;
    
        IF NOT EXISTS(SELECT 1 
                      FROM dbo.TB_ADM_SESSION 
                      WHERE SESSION_ID = @SessionId
                      )
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_add_ivr_script_node_ivr_module_member_pkey');
        END;
    
        -- If not specified determine whether the operation needs provisioning using the session source
        IF @Provision IS NULL
        BEGIN 
            SELECT @Provision = CASE st.INTERNAL_NAME WHEN 'ST_DATA_IMPORT_SERVER' THEN 0 
                                                      WHEN 'ST_MEDIATOR' THEN 0 ELSE 1 END
            FROM dbo.TB_ADM_SESSION AS s
            INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
            WHERE s.SESSION_ID = @SessionId;
        END;
        -- If member urn and cluster is not supplied return
        IF @MemberBusinessUrn IS NOT NULL AND @ClusterResourceId IS NOT NULL
        BEGIN    
            IF NOT EXISTS(SELECT 1 
                          FROM dbo.TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER WITH(READUNCOMMITTED) 
                          WHERE MEMBER_BIZ_URN = @MemberBusinessUrn
                          )
            BEGIN 
                SET @ReturnCode = -1;
                RAISERROR('ap_dim01_add_ivr_script_node_ivr_module_member_pkey: The specified input business urn [%d] does not exist.', 16, 1, @MemberBusinessUrn);
            END;  
            -- Retrieve cluster information
            SELECT  @ClusterResourceName = NAME, 
                    @ClusterResourceIsProvisionable = PROVISIONABLE,
                    @ClusterResourceTypeId = RESOURCE_TYPE_ID
            FROM dbo.TB_CLU_RESOURCE 
            WHERE RESOURCE_ID = @ClusterResourceId;
    
            IF EXISTS(SELECT 1 
                      FROM [dbo].[TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP] WITH(READUNCOMMITTED) 
                      WHERE MEMBER_BIZ_URN = @MemberBusinessUrn AND CLUSTER_RESOURCE_ID = @ClusterResourceId AND STATUS <> 'D'
                      )
            BEGIN 
                SET @ReturnCode = -1;
                RAISERROR('ap_dim01_add_ivr_script_node_ivr_module_member_pkey: Effective mapping already exists for member [%d] on cluster [%s]', 16, 1, @MemberBusinessUrn, @ClusterResourceName) WITH LOG;
            END;
    
            -- Get member information    
            SET @MemberTypeId = '00000044-1000-0000-0000-0000000000c0';

            SELECT  @ParentItemBusinessUrn = m.PARENT_ITEM_BIZ_URN,
                    @ChildItemBusinessUrn = m.CHILD_ITEM_BIZ_URN
            FROM dbo.TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER AS m WITH(READUNCOMMITTED)
            WHERE m.MEMBER_BIZ_URN = @MemberBusinessUrn AND m.LATEST = 1;

            SELECT @MemberTypeIsProvisionable = ISNULL((SELECT TOP 1 1 
                                                        FROM dbo.TE_DIM_ITEM_TYPE 
                                                        WHERE ITEM_TYPE_ID IN ('00011400-1000-0000-0000-000000000010', '00004610-1000-0000-0000-000000000010')
                                                        ORDER BY [ITEM_TYPE_ID]
                                                       ), 0);
        
            -- Set the system flag
            SELECT @System = CASE st.INTERNAL_NAME WHEN 'ST_INSTALLER' THEN 1 ELSE 0 END, @SessionUserId = u.USER_ID 
            FROM dbo.TB_ADM_SESSION AS s
            INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
            INNER JOIN dbo.TB_SEC_USER u ON u.LOGIN_NAME = s.SESSION_USER_NAME
            WHERE s.SESSION_ID = @SessionId;

            -- Get Default XML
            IF @XmlData IS NULL
            BEGIN 
                -- Try closest match first
                SELECT @XmlData = DEFAULT_XML 
                FROM dbo.TB_ADM_XML_DEFAULTS 
                WHERE TABLE_NAME = 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP' 
                AND MEMBER_TYPE_ID = @MemberTypeId AND CUSTOM = 0 
                AND CLUSTER_RESOURCE_TYPE_ID = @ClusterResourceTypeId;

                IF @XmlData IS NULL
                BEGIN 
                    SELECT @XmlData = DEFAULT_XML 
                    FROM dbo.TB_ADM_XML_DEFAULTS 
                    WHERE TABLE_NAME = 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP' 
                    AND MEMBER_TYPE_ID = @MemberTypeId AND CUSTOM = 0;
                END;
            END;
        
            -- Get Default Custom XML
            IF @CustomXmlData IS NULL
            BEGIN 
                -- Try closest match first
                SELECT @CustomXmlData = DEFAULT_XML 
                FROM dbo.TB_ADM_XML_DEFAULTS 
                WHERE TABLE_NAME = 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP' 
                AND MEMBER_TYPE_ID = @MemberTypeId AND CUSTOM = 1 
                AND CLUSTER_RESOURCE_TYPE_ID = @ClusterResourceTypeId;

                IF @CustomXmlData IS NULL
                BEGIN 
                    SELECT @CustomXmlData = DEFAULT_XML 
                    FROM dbo.TB_ADM_XML_DEFAULTS 
                    WHERE TABLE_NAME = 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP' 
                    AND MEMBER_TYPE_ID = @MemberTypeId AND CUSTOM = 1;
                END;
            END;

            -- Default to no provisioning required
            SET @Status = 'R';
            SET @AuditTypeName = 'AT_MEMBER_INSERT_COMMITTED_ON_EQUIPMENT'; -- Insert Execution
    
            -- If the change needs provisioning and the item type is and cluster resource are provisionable then set the item to synchronizing.
            IF (@Provision = 1 AND @MemberTypeIsProvisionable = 1 AND @ClusterResourceIsProvisionable = 1)
            BEGIN 
                SET @Status = 'S';
                SET @AuditTypeName = 'AT_MEMBER_INSERT_REQUESTED_ON_EQUIPMENT'; -- Insert Request        
            END;   
        
            BEGIN TRANSACTION PADD_ivrscriptnodeiPKEYTran;
       
            INSERT INTO dbo.TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP(MEMBER_BIZ_URN, 
                                                                              CLUSTER_RESOURCE_ID, 
                                                                              STATUS, 
                                                                              EFFECTIVE_FROM, 
                                                                              EFFECTIVE_TO, 
                                                                              SOURCE_CHANGE_STAMP, 
                                                                              PKEY1, 
                                                                              PKEY2, 
                                                                              XML_DATA, 
                                                                              SYSTEM, 
                                                                              MODIFIED_BY_ID, 
                                                                              CREATED_BY_ID, 
                                                                              CUSTOM_XML_DATA 
                                                                              )
            VALUES (@MemberBusinessUrn, 
                    @ClusterResourceId, 
                    @Status, 
                    @EffectiveFrom, 
                    @EffectiveTo, 
                    @SourceChangeStamp, 
                    @PKey1, 
                    @PKey2, 
                    @XmlData, 
                    @System, 
                    @SessionUserId, 
                    @SessionUserId, 
                    @CustomXmlData 
                    );
        
            SELECT @ReturnCode = @@ERROR, @PkeyMapUrn = SCOPE_IDENTITY();
            IF @ReturnCode <> 0
            BEGIN 
                RAISERROR('ap_dim01_add_ivr_script_node_ivr_module_member_pkey: Error linking member [%d] to cluster resource [%s], Error [%d] ', 16, 1, @MemberBusinessUrn, @ClusterResourceName, @ReturnCode) WITH LOG;
            END;
        
            -- Audit success against parent and child
            EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 56, 60, @ClusterResourceId, NULL, 'S', 0, 
                'MEMBER_ADDED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
            
            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION PADD_ivrscriptnodeiPKEYTran;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END;
        SET @ReturnCode = 0;
    END TRY
    BEGIN CATCH;
        SET @ErrorMessage = ERROR_MESSAGE();
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(NULLIF(@ErrorMessage,''),OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
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
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
        END;
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_add_ivr_script_node_ivr_module_member_pkey]
	TO [portalapp_role]
GO
