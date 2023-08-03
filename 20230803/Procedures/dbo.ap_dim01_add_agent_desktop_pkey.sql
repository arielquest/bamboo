SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_add_agent_desktop_pkey]
(
    @SessionId                  [UNIQUEIDENTIFIER],
    @ClusterResourceId          [UNIQUEIDENTIFIER],
    @ItemBusinessUrn            [INTEGER],
    @EffectiveFrom              [DATETIME],
    @EffectiveTo                [DATETIME],
    @PKey1             [NVARCHAR](100) = NULL, 
    @PKey2             [NVARCHAR](100) = NULL,
    @SourceChangeStamp          [INTEGER] = NULL,
    @XmlData                    [XML] = NULL,
    @CustomXmlData              [XML] = NULL,
    @InternalName            [NVARCHAR](100) = NULL,
    @Description             [NVARCHAR](500) = N'',
    @AvailableAfterIncoming  [BIT] = 0,
    @AvailableAfterOutgoing  [BIT] = 0,
    @WrapupDataIncomingMode  [INT] = 1,
    @WrapupDataOutgoingMode  [INT] = 1,
    @AutoAnswerEnabled       [BIT] = 0,
    @IdleReasonRequired      [BIT] = 0,
    @LogoutNonActivityTime   [INT] = NULL,
    @LogoutReasonRequired    [BIT] = 0,
    @SupervisorCallsAllowed  [BIT] = 0,
    @SupervisorAssistCallMethod  [INT] = NULL,
    @EmergencyCallMethod     [INT] = NULL,
    @AutoRecordOnEmergency   [BIT] = 0,
    @AgentToAgentCallsAllowed  [BIT] = 0,
    @OutboundAccessInternational  [BIT] = 0,
    @OutboundAccessPublicNetwork  [BIT] = 0,
    @OutboundAccessPrivateNetwork  [BIT] = 0,
    @OutboundAccessOperatorAssisted  [BIT] = 0,
    @OutboundAccessPBX       [BIT] = 0,
    @NonACDCallsAllowed      [BIT] = 0,
    @QualityRecordingRate    [INT] = 0,
    @RecordingMode           [INT] = null,
    @WorkModeTimer           [INT] = NULL,
    @RingNoAnswerTime        [INT] = NULL,
    @SilentMonitorWarningMessage  [BIT] = 0,
    @SilentMonitorAudibleIndication  [BIT] = 0,
    @DefaultDevicePortAddress  [VARCHAR](32) = NULL,
    @AgentCanSelectGroup     [BIT] = 1,
    @RemoteAgentType         [INT] = 0,
    @RemoteLoginWithoutDesktop  [BIT] = 0,
    @PlayZipTone             [BIT] = 0,
    @ACDSharedLineUsage      [BIT] = 0,
    @Provision                  [BIT] = NULL,
    @PkeyMapUrn                 [INTEGER] OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    BEGIN TRY;

        DECLARE @ReturnCode AS [INTEGER] = 0,
                @Status AS [CHAR](1),
                @ItemTypeId AS [UNIQUEIDENTIFIER] = '00009100-1000-0000-0000-000000000010',
                @ItemTypeIsProvisionable AS [BIT],            
                @ClusterResourceName AS [NVARCHAR](50),
                @ClusterResourceIsProvisionable AS [BIT],
                @AuditUrn AS [BIGINT],
                @AuditTypeName AS [NVARCHAR](50),
                @ClusterTypeId AS [UNIQUEIDENTIFIER],
                @UtcNow AS DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
                @InitialTransactionCount AS [INTEGER] = @@TRANCOUNT,
                @SessionUserId AS [UNIQUEIDENTIFIER],
                @System AS [BIT],
                @ErrorMessage AS VARCHAR(MAX), 
                @ErrorHolder NVARCHAR(2000);
    
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
        
                -- If item urn and cluster is not supplied return
                IF @ItemBusinessUrn IS NOT NULL AND @ClusterResourceId IS NOT NULL
                BEGIN 
                    IF NOT EXISTS(SELECT 1 
                                  FROM dbo.TB_DIM_AGENT_DESKTOP WITH(READUNCOMMITTED) 
                                  WHERE ITEM_BIZ_URN = @ItemBusinessUrn
                                  )
                    BEGIN 
                        SET @ReturnCode = -1;
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': The specified input business urn [%d] does not exist.';
                        RAISERROR(@ErrorMessage, 16, 1, @ItemBusinessUrn);
                    END
                    ELSE BEGIN 
                        -- Retrieve cluster information
                        SELECT @ClusterResourceName = NAME, 
                               @ClusterResourceIsProvisionable = PROVISIONABLE, 
                               @ClusterTypeId = RESOURCE_TYPE_ID
                        FROM dbo.TB_CLU_RESOURCE 
                        WHERE RESOURCE_ID = @ClusterResourceId;
    
                        IF EXISTS(SELECT 1 
                                  FROM [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] WITH(READUNCOMMITTED) 
                                  WHERE ITEM_BIZ_URN = @ItemBusinessUrn AND CLUSTER_RESOURCE_ID = @ClusterResourceId AND STATUS <> 'D'
                                  )
                        BEGIN 
                            SET @ReturnCode = -1;
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': Effective mapping already exists for item [%d] on cluster [%s].';
                            RAISERROR(@ErrorMessage, 16, 1, @ItemBusinessUrn, @ClusterResourceName) WITH LOG;
                        END;
                        ELSE BEGIN 
                            -- Get item type information
                            SELECT @ItemTypeIsProvisionable = PROVISIONABLE            
                            FROM dbo.TE_DIM_ITEM_TYPE
                            WHERE ITEM_TYPE_ID = @ItemTypeId;
        
                            -- Get Default XML
                            IF @XmlData IS NULL 
                            BEGIN 
                                SELECT TOP 1 
                                @XmlData = xmlData
                                FROM (SELECT 
                                      DEFAULT_XML AS xmlData,
                                      CASE WHEN CLUSTER_RESOURCE_TYPE_ID = @ClusterTypeId THEN 1 
                                           ELSE 2 END AS Ord
                                      FROM dbo.TB_ADM_XML_DEFAULTS
                                      WHERE TABLE_NAME = 'TB_DIM_AGENT_DESKTOP_PKEY_MAP' 
                                      AND ITEM_TYPE_ID = @ItemTypeId AND CUSTOM = 0
                                      )a
                                ORDER BY Ord ASC;
                            END;
                            
                            -- Get Default Custom XML
                            IF @CustomXmlData IS NULL
                            BEGIN 
                                SELECT TOP 1 
                                @CustomXmlData = xmlData
                                FROM (SELECT 
                                      DEFAULT_XML AS xmlData,
                                      CASE WHEN CLUSTER_RESOURCE_TYPE_ID = @ClusterTypeId THEN 1 
                                           ELSE 2 END AS Ord
                                      FROM dbo.TB_ADM_XML_DEFAULTS
                                      WHERE TABLE_NAME = 'TB_DIM_AGENT_DESKTOP_PKEY_MAP' 
                                      AND ITEM_TYPE_ID = @ItemTypeId AND CUSTOM = 1
                                      )a
                                ORDER BY Ord ASC;
                            END;
       
                            -- If the change needs provisioning and the item type is and cluster resource are provisionable then set the item to synchronizing.
                            IF (@Provision = 1 AND @ItemTypeIsProvisionable = 1 AND @ClusterResourceIsProvisionable = 1)
                            BEGIN 
                                SET @Status = 'S'
                                SET @AuditTypeName = 'AT_DIMENSION_INSERT_REQUESTED_ON_EQUIPMENT' -- Insert Request        
                            END;
                            ELSE BEGIN 
                                -- Default to no provisioning required
                                SET @Status = 'R';
                                SET @AuditTypeName = 'AT_DIMENSION_INSERT_COMMITTED_ON_EQUIPMENT'; -- Insert Execution
                            END;
        
                            -- Set the system flag
                            SELECT @System = CASE st.INTERNAL_NAME WHEN 'ST_INSTALLER' THEN 1 ELSE 0 END, 
                                   @SessionUserId = u.USER_ID 
                            FROM dbo.TB_ADM_SESSION AS s
                            INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
                            INNER JOIN dbo.TB_SEC_USER u ON u.LOGIN_NAME = s.SESSION_USER_NAME
                            WHERE s.SESSION_ID = @SessionId;

                            BEGIN TRANSACTION PADD_agentdePKEYTran;
                            BEGIN TRY;
                                INSERT INTO [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP](
                                ITEM_BIZ_URN, 
                                CLUSTER_RESOURCE_ID, 
                                STATUS, 
                                EFFECTIVE_FROM, 
                                EFFECTIVE_TO, 
                                SOURCE_CHANGE_STAMP, 
                                PKEY1, 
                                PKEY2, 
                                XML_DATA, 
                                CREATED_BY_ID, 
                                MODIFIED_BY_ID, 
                                SYSTEM, 
                                CUSTOM_XML_DATA, 
                                [INTERNAL_NAME], 
                                [DESCRIPTION], 
                                [AVAILABLE_AFTER_INCOMING], 
                                [AVAILABLE_AFTER_OUTGOING], 
                                [WRAPUP_DATA_INCOMING_MODE], 
                                [WRAPUP_DATA_OUTGOING_MODE], 
                                [AUTO_ANSWER_ENABLED], 
                                [IDLE_REASON_REQUIRED], 
                                [LOGOUT_NON_ACTIVITY_TIME], 
                                [LOGOUT_REASON_REQUIRED], 
                                [SUPERVISOR_CALLS_ALLOWED], 
                                [SUPERVISOR_ASSIST_CALL_METHOD], 
                                [EMERGENCY_CALL_METHOD], 
                                [AUTO_RECORD_ON_EMERGENCY], 
                                [AGENT_TO_AGENT_CALLS_ALLOWED], 
                                [OUTBOUND_ACCESS_INTERNATIONAL], 
                                [OUTBOUND_ACCESS_PUBLIC_NETWORK], 
                                [OUTBOUND_ACCESS_PRIVATE_NETWORK], 
                                [OUTBOUND_ACCESS_OPERATOR_ASSISTED], 
                                [OUTBOUND_ACCESS_PBX], 
                                [NON_ACD_CALLS_ALLOWED], 
                                [QUALITY_RECORDING_RATE], 
                                [RECORDING_MODE], 
                                [WORK_MODE_TIMER], 
                                [RING_NO_ANSWER_TIME], 
                                [SILENT_MONITOR_WARNING_MESSAGE], 
                                [SILENT_MONITOR_AUDIBLE_INDICATION], 
                                [DEFAULT_DEVICE_PORT_ADDRESS], 
                                [AGENT_CAN_SELECT_GROUP], 
                                [REMOTE_AGENT_TYPE], 
                                [REMOTE_LOGIN_WITHOUT_DESKTOP], 
                                [PLAY_ZIP_TONE], 
                                [ACD_SHARED_LINE_USAGE]                            )
                                VALUES (@ItemBusinessUrn, 
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
                                        @AvailableAfterIncoming, 
                                        @AvailableAfterOutgoing, 
                                        @WrapupDataIncomingMode, 
                                        @WrapupDataOutgoingMode, 
                                        @AutoAnswerEnabled, 
                                        @IdleReasonRequired, 
                                        @LogoutNonActivityTime, 
                                        @LogoutReasonRequired, 
                                        @SupervisorCallsAllowed, 
                                        @SupervisorAssistCallMethod, 
                                        @EmergencyCallMethod, 
                                        @AutoRecordOnEmergency, 
                                        @AgentToAgentCallsAllowed, 
                                        @OutboundAccessInternational, 
                                        @OutboundAccessPublicNetwork, 
                                        @OutboundAccessPrivateNetwork, 
                                        @OutboundAccessOperatorAssisted, 
                                        @OutboundAccessPBX, 
                                        @NonACDCallsAllowed, 
                                        @QualityRecordingRate, 
                                        @RecordingMode, 
                                        @WorkModeTimer, 
                                        @RingNoAnswerTime, 
                                        @SilentMonitorWarningMessage, 
                                        @SilentMonitorAudibleIndication, 
                                        @DefaultDevicePortAddress, 
                                        @AgentCanSelectGroup, 
                                        @RemoteAgentType, 
                                        @RemoteLoginWithoutDesktop, 
                                        @PlayZipTone, 
                                        @ACDSharedLineUsage 
                                    );
        
                                SELECT @PkeyMapUrn = SCOPE_IDENTITY();
                            END TRY
                            BEGIN CATCH;
                                SELECT @ReturnCode = CASE WHEN @ReturnCode IN (-1,-2) THEN @ReturnCode ELSE ERROR_NUMBER() END,
                                       @ErrorHolder = CASE WHEN @ErrorHolder IS NULL THEN ERROR_MESSAGE() ELSE @ErrorHolder END;
                                SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': Error linking item [%d] to cluster resource [%s].'+
                                                    ' SQLMessage['+@ErrorHolder+']. '+'ErrorCode [%d]';
                                RAISERROR(@ErrorMessage, 16, 1, @ItemBusinessUrn, @ClusterResourceName, @ReturnCode) WITH LOG;
                            END CATCH;
        
                            -- Audit success
                            EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, DEFAULT, 2, DEFAULT, @ClusterResourceId, DEFAULT, 'S', 0, 'DIMENSION_ADDED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
                
                            IF @InitialTransactionCount = 0 
                            BEGIN 
                                COMMIT TRANSACTION PADD_agentdePKEYTran;
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
        END;
    END;
   
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
               @ErrorHolder = ERROR_MESSAGE();
        SET @ErrorMessage = ISNULL(' SQLError[' + @ErrorHolder + ']. ', '') + 'ErrorCode [%d]';

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
	ON [dbo].[ap_dim01_add_agent_desktop_pkey]
	TO [portalapp_role]
GO
