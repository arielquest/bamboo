SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_delete_va_url_pkey]
(
    @SessionId                  [UNIQUEIDENTIFIER],
    @PkeyMapUrn                 [INTEGER],
    @ChangeStamp                [INTEGER] OUTPUT, -- The row changestamp in our system
    @Purge                      [BIT] = 0,
    @Provision                  [BIT] = NULL
) AS
BEGIN 
    SET NOCOUNT ON;
    BEGIN TRY;
        DECLARE @ReturnCode                         AS [INTEGER] = 0,
                @OldStatus                          AS [CHAR](1),
                @Status                             AS [CHAR](1),
                @SessionSource                      AS [CHAR](1),
                @ItemTypeIsProvisionable            AS [BIT],            
                @ClusterResourceIsProvisionable     AS [BIT],
                @RowCount                           AS [INTEGER],
                @ItemBusinessUrn                    AS [INTEGER],
                @ClusterResourceId                  AS [UNIQUEIDENTIFIER],
                @AuditUrn                           AS [BIGINT],
                @IsEffective                        AS [BIT],
                @OldPkey1                           AS [NVARCHAR](50),
                @OldPkey2                           AS [NVARCHAR](50),
                @AuditTypeName                      AS [NVARCHAR](100),
                @UtcNow                             AS DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
                @InitialTransactionCount            AS [INTEGER] = @@TRANCOUNT,
                @Expired                            AS [BIT],
                @SessionUserId                      AS [UNIQUEIDENTIFIER],
                @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);

        --Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID);
            RAISERROR(50157, 16, 5, @ErrorMessage);
        END;
        ELSE BEGIN 
            IF NOT EXISTS(SELECT 1 
                          FROM dbo.TB_ADM_SESSION 
                          WHERE SESSION_ID = @SessionId
                          )
            BEGIN 
                SET @ReturnCode = 50157;
                SET @ErrorMessage = OBJECT_NAME(@@PROCID);
                RAISERROR(50157, 16, 5, @ErrorMessage);
            END;
            ELSE BEGIN 
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
                                                              WHEN 'ST_MEDIATOR' THEN 0 
                                                              ELSE 1 END
                    FROM dbo.TB_ADM_SESSION AS s
                    INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
                    WHERE s.SESSION_ID = @SessionId;
                END;

                -- If item urn and cluster are not supplied return
                IF @PkeyMapUrn IS NOT NULL
                BEGIN 
                    SELECT @ItemTypeIsProvisionable = PROVISIONABLE 
                    FROM dbo.TE_DIM_ITEM_TYPE 
                    WHERE ITEM_TYPE_ID = 'be47e0e6-c335-4e2f-8586-c31a164afbfa';

                    SELECT  @ItemBusinessUrn = map.[ITEM_BIZ_URN],
                            @ClusterResourceId = map.[CLUSTER_RESOURCE_ID],
                            @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                            @IsEffective = CASE WHEN map.[EFFECTIVE_FROM] <= @UtcNow THEN 1 ELSE 0 END,
                            @Expired = CASE WHEN map.[EFFECTIVE_TO] < @UtcNow THEN 1 ELSE 0 END,
                            @OldStatus = map.[STATUS],
                            @OldPkey1 = map.[PKEY1],
                            @OldPkey2 = map.[PKEY2]
                    FROM dbo.TB_DIM_VA_URL_PKEY_MAP AS map WITH(UPDLOCK)
                    INNER JOIN dbo.TB_CLU_RESOURCE AS res ON res.RESOURCE_ID = map.CLUSTER_RESOURCE_ID
                    WHERE map.PKEY_MAP_URN = @PkeyMapUrn;
          
                    -- Deleting an item which is not yet provisioned means no provisioning is required to delete it
                    IF @OldPkey1 IS NULL AND @OldPkey2 IS NULL
                    BEGIN 
                        SET @Provision = 0;
                    END;
              
                    -- If the change needs provisioning and the item type is and cluster resource are provisionable then set the item to synchronizing.
                    IF (@Provision = 1 AND @ItemTypeIsProvisionable = 1 AND @ClusterResourceIsProvisionable = 1)
                    BEGIN 
                        SET @Status = 'P';
                        SET @AuditTypeName = 'AT_DIMENSION_DELETE_OR_PURGE_REQUESTED_ON_EQUIPMENT'; -- Delete Request
                    END;
                    ELSE BEGIN 
                        -- Default to no provisioning required
                        SET @Status = 'D';
                        SET @AuditTypeName = CASE WHEN @Purge = 1 AND @OldStatus = 'D' THEN 'AT_DIMENSION_PURGE_COMMITTED_ON_EQUIPMENT' 
                                                    WHEN @Expired = 1 THEN 'AT_DIMENSION_EXPIRED_ON_EQUIPMENT'
                                                    ELSE 'AT_DIMENSION_DELETE_COMMITTED_ON_EQUIPMENT'
                                                    END; -- Purge Execution, Delete Execution or Expired?
                    END;
    
                    BEGIN TRANSACTION PDEL_PKEYTran;
                    BEGIN TRY;
                        -- Perform update
                        IF @Purge = 1
                        BEGIN 
                            UPDATE dbo.TB_DIM_VA_URL_PKEY_MAP 
                            SET EFFECTIVE_TO = CASE WHEN STATUS = 'D' THEN EFFECTIVE_TO ELSE @UtcNow END, -- If the item is being deleted and purged then set effective date. If just purge then don't.
                                MODIFIED_DATE = @UtcNow,
                                MODIFIED_BY_ID = @SessionUserId, 
                                STATUS = 'D',
                                PURGED = 1,
                                CHANGE_STAMP = CHANGE_STAMP + 1
                            WHERE [PKEY_MAP_URN] = @PkeyMapUrn AND PURGED <> 1 AND [CHANGE_STAMP] = @ChangeStamp;

                            SELECT @RowCount = @@ROWCOUNT;

                            -- Check for concurrency conflict
                            IF @RowCount <> 1
                            BEGIN 
                                SET @ReturnCode = -2;
                                SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': Concurrency conflict occured (or attempt to purge already purged entry) whilst attempting to purge item pkey map [%d], Error [%d]';
                                RAISERROR(@ErrorMessage, 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                            END;

                            -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                            SET @ChangeStamp = @ChangeStamp + 1;

                            -- Audit success
                            EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, DEFAULT, 155, DEFAULT, @ClusterResourceId, DEFAULT, 'S', 0, 'DIMENSION_PURGED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
                        END
                        ELSE BEGIN 
                            UPDATE dbo.TB_DIM_VA_URL_PKEY_MAP  
                            SET EFFECTIVE_FROM = CASE @IsEffective WHEN 1 THEN EFFECTIVE_FROM ELSE @UtcNow END,
                                EFFECTIVE_TO = CASE @Status WHEN 'D' THEN @UtcNow ELSE EFFECTIVE_TO END, 
                                MODIFIED_DATE = @UtcNow,
                                STATUS = @Status, 
                                PURGED = CASE WHEN PKEY1 IS NULL AND PKEY2 IS NULL THEN 1 ELSE 0 END,
                                CHANGE_STAMP = CHANGE_STAMP + 1
                            WHERE [PKEY_MAP_URN] = @PkeyMapUrn AND [STATUS] <> 'D' AND [CHANGE_STAMP] = @ChangeStamp;

                            SELECT @RowCount = @@ROWCOUNT;

                            -- Check for concurrency conflict
                            IF @RowCount <> 1
                            BEGIN 
                                SET @ReturnCode = -2;
                                SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': Concurrency conflict occured (or attempt to delete already deleted entry) whilst attempting to delete item pkey map [%d], Error [%d]';
                                RAISERROR(@ErrorMessage, 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                            END;

                            -- Audit success
                            EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, DEFAULT, 155, DEFAULT, @ClusterResourceId, DEFAULT, 'S', 0, 'DIMENSION_DELETED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
                        END;
                    END TRY
                    BEGIN CATCH;
                        SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
                               @ErrorMessage = OBJECT_NAME(@@PROCID) + ': Error ' + 
                                               CASE WHEN @Purge = 1 THEN 'purging' ELSE 'deleting' END                                              
                                               +' item pkey map [%d].' + 
                                               ISNULL(' SQLMessage['+ERROR_MESSAGE()+']. ',' ')+
                                               'ErrorCode [%d]';
                        RAISERROR(@ErrorMessage, 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                    END CATCH;
                
                    IF @InitialTransactionCount = 0 
                    BEGIN 
                        COMMIT TRANSACTION PDEL_PKEYTran;
                    END;
                    ELSE BEGIN 
                        WHILE @@TRANCOUNT > @InitialTransactionCount
                        BEGIN 
                            COMMIT TRANSACTION;
                        END;
                    END;
                    SET @ReturnCode = 0;
                END;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SET @ErrorMessage = CASE WHEN @ErrorMessage IS NULL THEN OBJECT_NAME(@@PROCID)+': '+ERROR_MESSAGE() ELSE ERROR_MESSAGE() END;
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = @ErrorMessage+' [Uncommittable Transaction!]';
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
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;

    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_delete_va_url_pkey]
	TO [portalapp_role]
GO
