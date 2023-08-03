SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_add_user_pkey]
(
    @SessionId                  [UNIQUEIDENTIFIER],
    @ClusterResourceId          [UNIQUEIDENTIFIER],
    @UserId                        [UNIQUEIDENTIFIER],
    @EffectiveFrom              [DATETIME],
    @EffectiveTo                [DATETIME],
    @PKey1                        [NVARCHAR](100) = NULL, 
    @PKey2                        [NVARCHAR](100) = NULL,
    @SourceChangeStamp          [INTEGER] = NULL,
    @XmlData                    [XML] = NULL,
    @CustomXmlData              [XML] = NULL,
    @InternalName                [NVARCHAR](100) = NULL,
    @Description                [NVARCHAR](500) = N'',
    @Role                        [NVARCHAR](50) = NULL,
    @Provision                  [BIT] = NULL,
    @PkeyMapUrn                 [INTEGER] OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    BEGIN TRY;

        DECLARE @ReturnCode AS [INTEGER] = 0,
                @Status AS [CHAR](1),
                @ClusterResourceName AS [NVARCHAR](50),
                @ClusterResourceIsProvisionable AS [BIT],
                @AuditUrn AS [BIGINT],
                @AuditTypeName AS [NVARCHAR](50),
                @ClusterTypeId AS [UNIQUEIDENTIFIER],
                @UtcNow AS DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
                @InitialTransactionCount AS [INTEGER] = @@TRANCOUNT,
                @SessionUserId AS [UNIQUEIDENTIFIER],
                @System AS [BIT],
                @ErrorMessage AS VARCHAR(MAX), @ErrorHolder NVARCHAR(2000);
    
        -- Deafult effective dates
        SET @EffectiveFrom = COALESCE(DATEADD(ms, -(DATEPART(ms, @EffectiveFrom)), @EffectiveFrom), @UtcNow);
        SET @EffectiveTo = COALESCE(DATEADD(ms, -(DATEPART(ms, @EffectiveTo)), @EffectiveTo), '2079-06-06 00:00:00');
    
        -- Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID);
            RAISERROR(50157, 16, 5, @ErrorMessage);
        END
        ELSE BEGIN 
            IF NOT EXISTS(SELECT * FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
            BEGIN 
                SET @ReturnCode = 50157;
                SET @ErrorMessage = OBJECT_NAME(@@PROCID);
                RAISERROR(50157, 16, 5, @ErrorMessage);
            END
            ELSE BEGIN 
                -- If not specified determine whether the operation needs provisioning using the session source
                IF @Provision IS NULL
                BEGIN 
                    SELECT @Provision = CASE st.INTERNAL_NAME WHEN 'ST_DATA_IMPORT_SERVER' THEN 0 
                                                              WHEN 'ST_MEDIATOR' THEN 0 ELSE 1 END
                    FROM dbo.TB_ADM_SESSION AS s
                    INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
                    WHERE s.SESSION_ID = @SessionId;
                END;
        
                -- If user id and cluster is not supplied return
                IF @UserId IS NOT NULL AND @ClusterResourceId IS NOT NULL
                BEGIN 
                    IF NOT EXISTS(SELECT 1 
                                  FROM dbo.TB_SEC_USER
                                  WHERE [USER_ID] = @UserId
                                  )
                    BEGIN 
                        SET @ReturnCode = -1;
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': The specified input user id does not exist.';
                        RAISERROR(@ErrorMessage, 16, 1);
                    END
                    ELSE BEGIN 
                        -- Retrieve cluster information
                        SELECT @ClusterResourceName = NAME, 
                               @ClusterResourceIsProvisionable = PROVISIONABLE, 
                               @ClusterTypeId = RESOURCE_TYPE_ID
                        FROM dbo.TB_CLU_RESOURCE 
                        WHERE RESOURCE_ID = @ClusterResourceId;
    
                        IF EXISTS(SELECT 1 
                                  FROM dbo.TB_SEC_USER_PKEY_MAP
                                  WHERE [USER_ID] = @UserId AND CLUSTER_RESOURCE_ID = @ClusterResourceId AND STATUS <> 'D'
                                  )
                        BEGIN 
                            SET @ReturnCode = -1;
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': Effective mapping already exists for user [' + CAST(@UserId AS NVARCHAR(50)) + '] on cluster [%s].';
                            RAISERROR(@ErrorMessage, 16, 1, @ClusterResourceName) WITH LOG;
                        END;
                        ELSE BEGIN  
                            -- If the change needs provisioning and cluster resource are provisionable then set the user to synchronizing.
                            IF (@Provision = 1 AND @ClusterResourceIsProvisionable = 1)
                            BEGIN 
                                SET @Status = 'S'
                                SET @AuditTypeName = 'AT_USER_INSERT_REQUESTED_ON_EQUIPMENT' -- Insert Request        
                            END;
                            ELSE BEGIN 
                                -- Default to no provisioning required
                                SET @Status = 'R';
                                SET @AuditTypeName = 'AT_USER_INSERT_COMMITTED_ON_EQUIPMENT'; -- Insert Execution
                            END;
        
                            -- Set the system flag
                            SELECT @System = CASE st.INTERNAL_NAME WHEN 'ST_INSTALLER' THEN 1 ELSE 0 END, 
                                   @SessionUserId = u.USER_ID 
                            FROM dbo.TB_ADM_SESSION AS s
                            INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
                            INNER JOIN dbo.TB_SEC_USER u ON u.LOGIN_NAME = s.SESSION_USER_NAME
                            WHERE s.SESSION_ID = @SessionId;

                            BEGIN TRANSACTION PADD_PKEYTran;
                            BEGIN TRY;
                                INSERT INTO TB_SEC_USER_PKEY_MAP(
                                        [USER_ID], 
                                        [CLUSTER_RESOURCE_ID], 
                                        [STATUS], 
                                        [EFFECTIVE_FROM], 
                                        [EFFECTIVE_TO], 
                                        [SOURCE_CHANGE_STAMP], 
                                        [PKEY1], 
                                        [PKEY2], 
                                        [XML_DATA], 
                                        [CREATED_BY_ID], 
                                        [MODIFIED_BY_ID], 
                                        [SYSTEM], 
                                        [CUSTOM_XML_DATA], 
                                        [INTERNAL_NAME], 
                                        [DESCRIPTION], 
                                        [ROLE]
                                )
                                VALUES (@UserId, 
                                        @ClusterResourceId, 
                                        @Status, 
                                        @EffectiveFrom, 
                                        @EffectiveTo, 
                                        @SourceChangeStamp, 
                                        @PKey1, 
                                        @PKey2, 
                                        @XmlData, 
                                        @SessionUserId, 
                                        @SessionUserId, 
                                        @System, 
                                        @CustomXmlData, 
                                        @InternalName, 
                                        @Description, 
                                        @Role
                                    );
        
                                SELECT @PkeyMapUrn = SCOPE_IDENTITY();
                            END TRY
                            BEGIN CATCH;
                                SELECT @ReturnCode = CASE WHEN @ReturnCode IN (-1,-2) THEN @ReturnCode ELSE ERROR_NUMBER() END,
                                       @ErrorHolder = CASE WHEN @ErrorHolder IS NULL THEN ERROR_MESSAGE() ELSE @ErrorHolder END;
                                SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': Error linking user [' + CAST(@UserId AS NVARCHAR(50)) + '] to cluster resource [%s].'+
                                                    ' SQLMessage['+@ErrorHolder+']. '+'ErrorCode [%d]';
                                RAISERROR(@ErrorMessage, @ClusterResourceName, @ReturnCode) WITH LOG;
                            END CATCH;
        
                            -- Audit success
                            EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, @ClusterResourceId, @UserId, 'S', 0, 'USER_ADDED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
                
                            IF @InitialTransactionCount = 0 
                            BEGIN 
                                COMMIT TRANSACTION PADD_PKEYTran;
                            END;
                            ELSE BEGIN 
                                WHILE @@TRANCOUNT > @InitialTransactionCount
                                BEGIN 
                                    COMMIT TRANSACTION;
                                END;
                            END;
                    END;
                END;
            END;
        END;
    END;
   
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
               @ErrorHolder = ERROR_MESSAGE();
        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                        + 'An error occured while attempting to update item.'
                        + ISNULL(' SQLMessage[' + @ErrorHolder + '] ', '')
                        + 'SQLError = [%d]';

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
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END CATCH;
    
    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_add_user_pkey]
	TO [portalapp_role]
GO
