SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_delete_route_enterprise_route_member_pkey]
(
    @SessionId    [UNIQUEIDENTIFIER],
    @PkeyMapUrn   [INTEGER],
    @ChangeStamp  [INTEGER] OUTPUT, -- The row changestamp in our system
    @Purge        [BIT] = 0,
    @Provision    [BIT] = NULL
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ReturnCode                     AS [INTEGER] = 0,
            @OldStatus                      AS [CHAR](1),
            @Status                         AS [CHAR](1),
            @SessionSource                  AS [CHAR](1),
            @AuditType                      AS [NVARCHAR](100),
            @MemberTypeIsProvisionable      AS [BIT],            
            @ClusterResourceIsProvisionable AS [BIT],
            @RowCount                       AS [INTEGER],
            @ClusterResourceId              AS [UNIQUEIDENTIFIER],
            @ParentItemBusinessUrn          AS [INTEGER],
            @ChildItemBusinessUrn           AS [INTEGER],
            @AuditUrn                       AS [BIGINT],
            @IsEffective                    AS [BIT],            
            @OldPkey1                       AS [NVARCHAR](50),
            @OldPkey2                       AS [NVARCHAR](50),
            @AuditTypeName                  AS [NVARCHAR](50),
            @UtcNow                         AS [DATETIME] = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
            @InitialTransactionCount        AS [INTEGER] = @@TRANCOUNT,            
            @Expired                        AS [BIT],
            @SessionUserId                  AS [UNIQUEIDENTIFIER],
            @ErrorMessage                   AS VARCHAR(1024);

    BEGIN TRY;
        --Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_delete_route_enterprise_route_member_pkey');
        END;
    
        IF NOT EXISTS(SELECT 1 
                      FROM dbo.TB_ADM_SESSION 
                      WHERE SESSION_ID = @SessionId
                      )
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_delete_route_enterprise_route_member_pkey');
        END;
          
        -- Retrieve user information
        SELECT @SessionUserId = USER_ID 
        FROM dbo.TB_SEC_USER
        WHERE DELETED = 0
        AND LOGIN_NAME = (SELECT SESSION_USER_NAME 
                          FROM dbo.TB_ADM_SESSION 
                          WHERE SESSION_ID = @SessionId
                          );

        -- If not specified determine whether the operation needs provisioning using the session source
        IF @Provision IS NULL
        BEGIN 
            SELECT @Provision = CASE st.INTERNAL_NAME WHEN 'ST_DATA_IMPORT_SERVER' THEN 0 
                                                      WHEN 'ST_MEDIATOR' THEN 0 ELSE 1 END
            FROM dbo.TB_ADM_SESSION AS s
            INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
            WHERE s.SESSION_ID = @SessionId;
        END;
        
        -- If item urn and cluster are not supplied return
        IF @PkeyMapUrn IS NOT NULL
        BEGIN   
            SELECT @MemberTypeIsProvisionable = ISNULL((SELECT TOP 1 1 
                                                        FROM dbo.TE_DIM_ITEM_TYPE 
                                                        WHERE ITEM_TYPE_ID IN ('00003200-1000-0000-0000-000000000010', '00005400-1000-0000-0000-000000000010') 
                                                        AND PROVISIONABLE = 1
                                                        ORDER BY [ITEM_TYPE_ID]
                                                        ), 0);

            SELECT  @ClusterResourceId = pm.[CLUSTER_RESOURCE_ID],
                    @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                    @IsEffective = CASE WHEN pm.[EFFECTIVE_FROM] <= @UtcNow THEN 1 ELSE 0 END,
                    @Expired = CASE WHEN pm.[EFFECTIVE_TO] < @UtcNow THEN 1 ELSE 0 END,
                    @ParentItemBusinessUrn = m.[PARENT_ITEM_BIZ_URN],
                    @ChildItemBusinessUrn = m.[CHILD_ITEM_BIZ_URN],
                    @OldStatus = pm.[STATUS],
                    @OldPkey1 = pm.[PKEY1],
                    @OldPkey2 = pm.[PKEY2]    
            FROM dbo.TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP AS pm WITH(UPDLOCK)
            INNER JOIN dbo.TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER AS m WITH(READUNCOMMITTED) ON pm.MEMBER_BIZ_URN = m.MEMBER_URN
            INNER JOIN dbo.TB_CLU_RESOURCE AS res ON res.RESOURCE_ID =  pm.CLUSTER_RESOURCE_ID
            WHERE pm.PKEY_MAP_URN = @PkeyMapUrn;
             
            -- Deleting a member which is not yet provisioned means no provisioning is required to delete it
            IF @OldPkey1 IS NULL AND @OldPkey2 IS NULL
            BEGIN 
                SET @Provision = 0;
            END;
        
            -- Default to no provisioning required
            SET @Status = 'D';
            SET @AuditTypeName = CASE WHEN @Purge = 1 AND @OldStatus = 'D' THEN 'AT_MEMBER_PURGE_COMMITTED_ON_EQUIPMENT' 
                                        WHEN @Expired = 1 THEN 'AT_MEMBER_EXPIRED_ON_EQUIPMENT'
                                        ELSE 'AT_MEMBER_DELETE_COMMITTED_ON_EQUIPMENT'
                                    END; -- Purge Execution, Delete Execution or Expired?
        
            -- If the change needs provisioning and the item type is and cluster resource are provisionable then set the item to synchronizing.
            IF (@Provision = 1 AND @MemberTypeIsProvisionable = 1 AND @ClusterResourceIsProvisionable = 1)
            BEGIN 
                SET @Status = 'P';
                SET @AuditTypeName = 'AT_MEMBER_DELETE_OR_PURGE_REQUESTED_ON_EQUIPMENT'; -- Delete Request
            END;

            BEGIN TRANSACTION PDEL_routeenterprisPKEYTran;
            -- Perform update
            IF @Purge = 1
            BEGIN 
                UPDATE dbo.TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP 
                SET EFFECTIVE_TO = CASE WHEN STATUS = 'D' THEN EFFECTIVE_TO ELSE @UtcNow END, -- If the member is being deleted and purged then set effective date. If just purge then don't.
                    MODIFIED_DATE = @UtcNow, 
                    MODIFIED_BY_ID = @SessionUserId,
                    STATUS = 'D',
                    PURGED = 1,
                    CHANGE_STAMP = CHANGE_STAMP + 1
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                AND PURGED <> 1
                AND [CHANGE_STAMP] = @ChangeStamp;
            
                SELECT @ReturnCode = @@ERROR, @RowCount = @@ROWCOUNT;
    
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_dim01_delete_route_enterprise_route_member_pkey: Error purging member pkey map [%d], Error [%d] ', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;
            
                -- Check for concurrency conflict
                IF @RowCount <> 1
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR('ap_dim01_delete_route_enterprise_route_member_pkey: Concurrency conflict occured (or attempt to purge already purged entry) whilst attempting to purge member pkey map [%d], Error [%d]', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;
            
                -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                SET @ChangeStamp = @ChangeStamp + 1;

                -- Audit success against parent and child
                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 40, 86, @ClusterResourceId, NULL, 'S', 0, 
                    'MEMBER_PURGED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
            END;
            ELSE BEGIN 
                UPDATE dbo.TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP 
                SET EFFECTIVE_FROM = CASE @IsEffective WHEN 1 THEN EFFECTIVE_FROM ELSE @UtcNow END,
                    EFFECTIVE_TO = CASE @Status WHEN 'D' THEN @UtcNow ELSE EFFECTIVE_TO END,
                    MODIFIED_DATE = @UtcNow,
                    STATUS = @Status,
                    PURGED = CASE WHEN PKEY1 IS NULL AND PKEY2 IS NULL THEN 1 ELSE 0 END,
                    CHANGE_STAMP = CHANGE_STAMP + 1
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                AND [STATUS] <> 'D'
                AND [CHANGE_STAMP] = @ChangeStamp;

                SELECT @ReturnCode = @@ERROR, @RowCount = @@ROWCOUNT;
            
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_dim01_delete_route_enterprise_route_member_pkey: Error deleting member pkey map [%d], Error [%d] ', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;
            
                -- Check for concurrency conflict
                IF @RowCount <> 1
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR('ap_dim01_delete_route_enterprise_route_member_pkey: Concurrency conflict occured (or attempt to delete already deleted entry) whilst attempting to delete member pkey map [%d], Error [%d]', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;

                -- Audit success against parent and child
                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 40, 86, @ClusterResourceId, NULL, 'S', 0, 
                    'MEMBER_DELETED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
            END;

            IF @InitialTransactionCount = 0 
            BEGIN 
                COMMIT TRANSACTION PDEL_routeenterprisPKEYTran;
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
	ON [dbo].[ap_dim01_delete_route_enterprise_route_member_pkey]
	TO [portalapp_role]
GO
