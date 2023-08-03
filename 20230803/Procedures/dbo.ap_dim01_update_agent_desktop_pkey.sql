SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_agent_desktop_pkey]
(    
    @SessionId                  [UNIQUEIDENTIFIER],
    @PkeyMapUrn                 [INTEGER],
    @ChangeStamp                [INTEGER] OUTPUT, -- The row changestamp in our system
    @EffectiveFrom              [DATETIME],
    @EffectiveTo                [DATETIME],
    @SourceChangeStamp          [INTEGER] = -1, -- The changestamp on the remote source
    @XmlData                    [XML] = NULL,        
    @CustomXmlData              [XML] = NULL, 
    @UpdateCustomXmlData        [BIT] = 0, 
    @InternalName            [NVARCHAR](100) = NULL, 
    @Description             [NVARCHAR](500) = NULL, 
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
    @ForceStatusChange          [BIT] = 0,    -- Indicates that the status should be changed even if none of the pkey fields have been updated. Used when base or derived fields have been changed to force provisioning.
    @Provision                  [BIT] = NULL -- Does this change need provisioning if fields have changed?
) AS
BEGIN 
    SET NOCOUNT ON;

    BEGIN TRY;

        DECLARE @ReturnCode                             AS [INTEGER] = 0,
                @Status                                 AS [CHAR](1),
                @ItemTypeIsProvisionable                AS [BIT],            
                @ClusterResourceIsProvisionable         AS [BIT],
                @OldStatus                              AS [CHAR](1),
                @OldEffectiveFrom                       AS [DATETIME], 
                @OldEffectiveTo                         AS [DATETIME], 
                @OldXmlData                             AS [XML],
                @OldCustomXmlData                       AS [XML],
                @OldSourceChangeStamp                   AS [INT], 
                @OldInternalName                 [NVARCHAR](100), 
                @OldDescription                  [NVARCHAR](500), 
                @OldAvailableAfterIncoming       [BIT], 
                @OldAvailableAfterOutgoing       [BIT], 
                @OldWrapupDataIncomingMode       [INT], 
                @OldWrapupDataOutgoingMode       [INT], 
                @OldAutoAnswerEnabled            [BIT], 
                @OldIdleReasonRequired           [BIT], 
                @OldLogoutNonActivityTime        [INT], 
                @OldLogoutReasonRequired         [BIT], 
                @OldSupervisorCallsAllowed       [BIT], 
                @OldSupervisorAssistCallMethod   [INT], 
                @OldEmergencyCallMethod          [INT], 
                @OldAutoRecordOnEmergency        [BIT], 
                @OldAgentToAgentCallsAllowed     [BIT], 
                @OldOutboundAccessInternational  [BIT], 
                @OldOutboundAccessPublicNetwork  [BIT], 
                @OldOutboundAccessPrivateNetwork  [BIT], 
                @OldOutboundAccessOperatorAssisted  [BIT], 
                @OldOutboundAccessPBX            [BIT], 
                @OldNonACDCallsAllowed           [BIT], 
                @OldQualityRecordingRate         [INT], 
                @OldRecordingMode                [INT], 
                @OldWorkModeTimer                [INT], 
                @OldRingNoAnswerTime             [INT], 
                @OldSilentMonitorWarningMessage  [BIT], 
                @OldSilentMonitorAudibleIndication  [BIT], 
                @OldDefaultDevicePortAddress     [VARCHAR](32), 
                @OldAgentCanSelectGroup          [BIT], 
                @OldRemoteAgentType              [INT], 
                @OldRemoteLoginWithoutDesktop    [BIT], 
                @OldPlayZipTone                  [BIT], 
                @OldACDSharedLineUsage           [BIT], 
                @FieldsChanged                          AS [BIT] = 0,
                @ProvisionableFieldsChanged             AS [BIT] = 0,
                @AuditTempOld                           AS [VARCHAR](250),
                @AuditTempNew                           AS [VARCHAR](250),
                @RowCount                               AS [INTEGER],
                @UtcNow                                 AS [DATETIME] = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
                @ClusterResourceId                      AS [UNIQUEIDENTIFIER],
                @ItemBusinessUrn                        AS [INTEGER],
                @AuditUrn                               AS [BIGINT],
                @AuditTypeName                          AS [NVARCHAR](50),
                @ItemTypeId                             AS [UNIQUEIDENTIFIER],
                @ClusterTypeId                          AS [UNIQUEIDENTIFIER],
                @InitialTransactionCount                AS [INTEGER] = @@TRANCOUNT,
                @FieldChangeXmlData                     AS XML(DOCUMENT dbo.AuditFieldChangeCollection),
                @SessionUserId                          AS [UNIQUEIDENTIFIER],
                @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);
               
        -- Create temporary tables for audit attributes
        DECLARE @AuditAttributeTable TABLE
        (
            ATTRIBUTE_FIELD NVARCHAR(250) NOT NULL,
            OLD_VALUE  NVARCHAR(500) NULL,
            NEW_VALUE NVARCHAR(500) NULL
        );
    
        -- Default effective dates
        SET @EffectiveFrom = COALESCE(DATEADD(ms, -(DATEPART(ms, @EffectiveFrom)), @EffectiveFrom), @UtcNow);
        SET @EffectiveTo = COALESCE(DATEADD(ms, -(DATEPART(ms, @EffectiveTo)), @EffectiveTo), '2079-06-06 00:00:00');

        --Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID);
            RAISERROR(50157, 16, 5, @ErrorMessage);
        END;
        ELSE BEGIN 
            IF NOT EXISTS(SELECT 1 
                          FROM [dbo].[TB_ADM_SESSION] 
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
                                  WHERE SESSION_ID = @SessionId);

                -- If not specified determine whether the operation needs provisioning using the session source
                IF @Provision IS NULL
                BEGIN 
                    SELECT @Provision = CASE st.INTERNAL_NAME WHEN 'ST_DATA_IMPORT_SERVER' THEN 0 
                                                              WHEN 'ST_MEDIATOR' THEN 0 ELSE 1 END
                    FROM dbo.TB_ADM_SESSION AS s
                    INNER JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
                    WHERE s.SESSION_ID = @SessionId;
                END;
                
                -- Check for invalid flag states
                IF @Provision = 0 AND @ForceStatusChange = 1
                BEGIN 
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': Cannot force status change on non provisionable update';
                    RAISERROR('ap_dim01_update_agent_desktop_pkey: Cannot force status change on non provisionable update', 16, 1) WITH LOG
                END;
                ELSE BEGIN 
                    -- If pkey map urn has not been supplied then exit
                    IF @PkeyMapUrn IS NOT NULL
                    BEGIN 
                        -- Save the current state of the record before updating.
                        SET @ItemTypeId = '00009100-1000-0000-0000-000000000010';
                        SELECT @ItemTypeIsProvisionable = PROVISIONABLE 
                        FROM dbo.TE_DIM_ITEM_TYPE WHERE 
                        ITEM_TYPE_ID = @ItemTypeId;

                        SELECT  @OldEffectiveFrom = map.[EFFECTIVE_FROM],
                                @OldEffectiveTo = map.[EFFECTIVE_TO],
                                @OldStatus = map.[STATUS],
                                @OldXmlData = map.[XML_DATA],
                                @OldCustomXmlData = map.[CUSTOM_XML_DATA],
                                @OldSourceChangeStamp = map.[SOURCE_CHANGE_STAMP],
                                @OldInternalName = map.[INTERNAL_NAME],
                                @OldDescription = map.[DESCRIPTION],
                                @OldAvailableAfterIncoming = map.[AVAILABLE_AFTER_INCOMING],
                                @OldAvailableAfterOutgoing = map.[AVAILABLE_AFTER_OUTGOING],
                                @OldWrapupDataIncomingMode = map.[WRAPUP_DATA_INCOMING_MODE],
                                @OldWrapupDataOutgoingMode = map.[WRAPUP_DATA_OUTGOING_MODE],
                                @OldAutoAnswerEnabled = map.[AUTO_ANSWER_ENABLED],
                                @OldIdleReasonRequired = map.[IDLE_REASON_REQUIRED],
                                @OldLogoutNonActivityTime = map.[LOGOUT_NON_ACTIVITY_TIME],
                                @OldLogoutReasonRequired = map.[LOGOUT_REASON_REQUIRED],
                                @OldSupervisorCallsAllowed = map.[SUPERVISOR_CALLS_ALLOWED],
                                @OldSupervisorAssistCallMethod = map.[SUPERVISOR_ASSIST_CALL_METHOD],
                                @OldEmergencyCallMethod = map.[EMERGENCY_CALL_METHOD],
                                @OldAutoRecordOnEmergency = map.[AUTO_RECORD_ON_EMERGENCY],
                                @OldAgentToAgentCallsAllowed = map.[AGENT_TO_AGENT_CALLS_ALLOWED],
                                @OldOutboundAccessInternational = map.[OUTBOUND_ACCESS_INTERNATIONAL],
                                @OldOutboundAccessPublicNetwork = map.[OUTBOUND_ACCESS_PUBLIC_NETWORK],
                                @OldOutboundAccessPrivateNetwork = map.[OUTBOUND_ACCESS_PRIVATE_NETWORK],
                                @OldOutboundAccessOperatorAssisted = map.[OUTBOUND_ACCESS_OPERATOR_ASSISTED],
                                @OldOutboundAccessPBX = map.[OUTBOUND_ACCESS_PBX],
                                @OldNonACDCallsAllowed = map.[NON_ACD_CALLS_ALLOWED],
                                @OldQualityRecordingRate = map.[QUALITY_RECORDING_RATE],
                                @OldRecordingMode = map.[RECORDING_MODE],
                                @OldWorkModeTimer = map.[WORK_MODE_TIMER],
                                @OldRingNoAnswerTime = map.[RING_NO_ANSWER_TIME],
                                @OldSilentMonitorWarningMessage = map.[SILENT_MONITOR_WARNING_MESSAGE],
                                @OldSilentMonitorAudibleIndication = map.[SILENT_MONITOR_AUDIBLE_INDICATION],
                                @OldDefaultDevicePortAddress = map.[DEFAULT_DEVICE_PORT_ADDRESS],
                                @OldAgentCanSelectGroup = map.[AGENT_CAN_SELECT_GROUP],
                                @OldRemoteAgentType = map.[REMOTE_AGENT_TYPE],
                                @OldRemoteLoginWithoutDesktop = map.[REMOTE_LOGIN_WITHOUT_DESKTOP],
                                @OldPlayZipTone = map.[PLAY_ZIP_TONE],
                                @OldACDSharedLineUsage = map.[ACD_SHARED_LINE_USAGE], 
                                @ItemBusinessUrn = item.[ITEM_BIZ_URN],
                                @ClusterResourceId = map.[CLUSTER_RESOURCE_ID],
                                @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                                @ClusterTypeId = res.RESOURCE_TYPE_ID
                        FROM dbo.TB_DIM_AGENT_DESKTOP_PKEY_MAP AS map WITH(UPDLOCK)
                        INNER JOIN dbo.TB_DIM_AGENT_DESKTOP AS item WITH(READUNCOMMITTED) ON map.ITEM_BIZ_URN = item.ITEM_BIZ_URN AND item.LATEST = 1
                        LEFT JOIN dbo.TB_CLU_RESOURCE AS res ON res.RESOURCE_ID = map.CLUSTER_RESOURCE_ID
                        WHERE map.PKEY_MAP_URN = @PkeyMapUrn;
    
                        -- If source changestamp not specified, then use old value
                        IF @SourceChangeStamp = -1
                        BEGIN 
                            SET @SourceChangeStamp = @OldSourceChangeStamp
                        End;

                        -- Get Default XML
                        IF @XmlData IS NULL AND @ClusterTypeId IS NOT NULL
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
                            
                        -- Ignore xml data if specified
                        IF (@UpdateCustomXmlData = 0)
                        BEGIN 
                            SET @CustomXmlData = @OldCustomXmlData;
                        END;
                        ELSE BEGIN 
                            -- Get Default Custom XML
                            IF @CustomXmlData IS NULL AND @ClusterTypeId IS NOT NULL
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
                        END;
        
                        -- Check for field changes
                        IF (@SourceChangeStamp IS NOT NULL AND @OldSourceChangeStamp IS NOT NULL AND @SourceChangeStamp <> @OldSourceChangeStamp)
                        OR (@OldSourceChangeStamp IS NULL AND @SourceChangeStamp IS NOT NULL)
                        OR (@OldSourceChangeStamp IS NOT NULL AND @SourceChangeStamp IS NULL)
                        BEGIN 
                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CHANGE_STAMP', @SourceChangeStamp, @OldSourceChangeStamp);
    
                            SET @FieldsChanged = 1;
                        END;
    
                        IF @EffectiveFrom <> @OldEffectiveFrom
                        BEGIN 
                            SET @AuditTempOld = CONVERT(NVARCHAR(250), @OldEffectiveFrom, 126);
                            SET @AuditTempNew = CONVERT(NVARCHAR(250), @EffectiveFrom, 126);

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('EFFECTIVE_FROM', @AuditTempNew, @AuditTempOld);

                            SET @FieldsChanged = 1
                        END;
    
                        IF @EffectiveTo <> @OldEffectiveTo
                        BEGIN 
                            SET @AuditTempOld = CONVERT(NVARCHAR(250), @OldEffectiveTo, 126);
                            SET @AuditTempNew = CONVERT(NVARCHAR(250), @EffectiveTo, 126);
        
                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('EFFECTIVE_TO', @AuditTempNew, @AuditTempOld);

                            SET @FieldsChanged = 1;
                        END;
       
                        INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                        SELECT 
                        'AGENT_DESKTOP_' + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],
                        SUBSTRING(CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)), 1, 500) AS [NEW_VALUE],
                        SUBSTRING(CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX)), 1, 500) AS [OLD_VALUE]
                        FROM @OldXmlData.nodes('Columns/Column') AS OldAttributes(Attribute)
                        FULL OUTER JOIN @XmlData.nodes('Columns/Column') AS NewAttributes(Attribute)
                        ON OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') = NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)')
                        WHERE OldAttributes.Attribute IS NULL OR NewAttributes.Attribute IS NULL OR 
                        (
                            OldAttributes.Attribute.value('string(@DataType)', 'NVARCHAR(50)') <> 'Xml'
                            AND CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) <> CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX))
                         );
        
                        IF @@ROWCOUNT > 0
                        BEGIN 
                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged = 1;
                        END;
        
                        INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                        SELECT 
                        'custom.AGENT_DESKTOP_'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
                        SUBSTRING(CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)), 1, 500) AS [NEW_VALUE],
                        SUBSTRING(CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX)), 1, 500) AS [OLD_VALUE]
                        FROM @OldCustomXmlData.nodes('Columns/Column') AS OldAttributes(Attribute)
                        FULL OUTER JOIN @CustomXmlData.nodes('Columns/Column') AS NewAttributes(Attribute)
                        ON OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') = NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)')
                        WHERE OldAttributes.Attribute IS NULL OR NewAttributes.Attribute IS NULL OR 
                        (
                            OldAttributes.Attribute.value('string(@DataType)', 'NVARCHAR(50)') <> 'Xml'
                            AND CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) <> CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX))
                        );
        
                        IF @@ROWCOUNT > 0
                        BEGIN              
                            SET @FieldsChanged = 1;
                        END;
 
                        IF (@OldInternalName IS NOT NULL AND @InternalName IS NOT NULL AND @OldInternalName COLLATE Latin1_General_CS_AS <> @InternalName COLLATE Latin1_General_CS_AS)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldInternalName AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@InternalName AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_INTERNAL_NAME', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldDescription IS NOT NULL AND @Description IS NOT NULL AND @OldDescription COLLATE Latin1_General_CS_AS <> @Description COLLATE Latin1_General_CS_AS)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldDescription AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@Description AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_DESCRIPTION', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAvailableAfterIncoming IS NOT NULL AND @AvailableAfterIncoming IS NOT NULL AND @OldAvailableAfterIncoming <> @AvailableAfterIncoming)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAvailableAfterIncoming WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AvailableAfterIncoming WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_AVAILABLE_AFTER_INCOMING', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAvailableAfterOutgoing IS NOT NULL AND @AvailableAfterOutgoing IS NOT NULL AND @OldAvailableAfterOutgoing <> @AvailableAfterOutgoing)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAvailableAfterOutgoing WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AvailableAfterOutgoing WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_AVAILABLE_AFTER_OUTGOING', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWrapupDataIncomingMode IS NOT NULL AND @WrapupDataIncomingMode IS NOT NULL AND @OldWrapupDataIncomingMode <> @WrapupDataIncomingMode)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWrapupDataIncomingMode AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WrapupDataIncomingMode AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_WRAPUP_DATA_INCOMING_MODE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWrapupDataOutgoingMode IS NOT NULL AND @WrapupDataOutgoingMode IS NOT NULL AND @OldWrapupDataOutgoingMode <> @WrapupDataOutgoingMode)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWrapupDataOutgoingMode AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WrapupDataOutgoingMode AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_WRAPUP_DATA_OUTGOING_MODE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAutoAnswerEnabled IS NOT NULL AND @AutoAnswerEnabled IS NOT NULL AND @OldAutoAnswerEnabled <> @AutoAnswerEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAutoAnswerEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AutoAnswerEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_AUTO_ANSWER_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldIdleReasonRequired IS NOT NULL AND @IdleReasonRequired IS NOT NULL AND @OldIdleReasonRequired <> @IdleReasonRequired)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldIdleReasonRequired WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @IdleReasonRequired WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_IDLE_REASON_REQUIRED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldLogoutNonActivityTime IS NOT NULL AND @LogoutNonActivityTime IS NOT NULL AND @OldLogoutNonActivityTime <> @LogoutNonActivityTime)  
                        OR (@OldLogoutNonActivityTime IS NULL AND @LogoutNonActivityTime IS NOT NULL)
                        OR (@OldLogoutNonActivityTime IS NOT NULL AND @LogoutNonActivityTime IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldLogoutNonActivityTime AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@LogoutNonActivityTime AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_LOGOUT_NON_ACTIVITY_TIME', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldLogoutReasonRequired IS NOT NULL AND @LogoutReasonRequired IS NOT NULL AND @OldLogoutReasonRequired <> @LogoutReasonRequired)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldLogoutReasonRequired WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @LogoutReasonRequired WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_LOGOUT_REASON_REQUIRED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldSupervisorCallsAllowed IS NOT NULL AND @SupervisorCallsAllowed IS NOT NULL AND @OldSupervisorCallsAllowed <> @SupervisorCallsAllowed)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldSupervisorCallsAllowed WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @SupervisorCallsAllowed WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_SUPERVISOR_CALLS_ALLOWED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldSupervisorAssistCallMethod IS NOT NULL AND @SupervisorAssistCallMethod IS NOT NULL AND @OldSupervisorAssistCallMethod <> @SupervisorAssistCallMethod)  
                        OR (@OldSupervisorAssistCallMethod IS NULL AND @SupervisorAssistCallMethod IS NOT NULL)
                        OR (@OldSupervisorAssistCallMethod IS NOT NULL AND @SupervisorAssistCallMethod IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldSupervisorAssistCallMethod AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@SupervisorAssistCallMethod AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_SUPERVISOR_ASSIST_CALL_METHOD', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldEmergencyCallMethod IS NOT NULL AND @EmergencyCallMethod IS NOT NULL AND @OldEmergencyCallMethod <> @EmergencyCallMethod)  
                        OR (@OldEmergencyCallMethod IS NULL AND @EmergencyCallMethod IS NOT NULL)
                        OR (@OldEmergencyCallMethod IS NOT NULL AND @EmergencyCallMethod IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldEmergencyCallMethod AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@EmergencyCallMethod AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_EMERGENCY_CALL_METHOD', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAutoRecordOnEmergency IS NOT NULL AND @AutoRecordOnEmergency IS NOT NULL AND @OldAutoRecordOnEmergency <> @AutoRecordOnEmergency)  
                        OR (@OldAutoRecordOnEmergency IS NULL AND @AutoRecordOnEmergency IS NOT NULL)
                        OR (@OldAutoRecordOnEmergency IS NOT NULL AND @AutoRecordOnEmergency IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAutoRecordOnEmergency WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AutoRecordOnEmergency WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_AUTO_RECORD_ON_EMERGENCY', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAgentToAgentCallsAllowed IS NOT NULL AND @AgentToAgentCallsAllowed IS NOT NULL AND @OldAgentToAgentCallsAllowed <> @AgentToAgentCallsAllowed)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAgentToAgentCallsAllowed WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AgentToAgentCallsAllowed WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_AGENT_TO_AGENT_CALLS_ALLOWED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldOutboundAccessInternational IS NOT NULL AND @OutboundAccessInternational IS NOT NULL AND @OldOutboundAccessInternational <> @OutboundAccessInternational)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldOutboundAccessInternational WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @OutboundAccessInternational WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_OUTBOUND_ACCESS_INTERNATIONAL', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldOutboundAccessPublicNetwork IS NOT NULL AND @OutboundAccessPublicNetwork IS NOT NULL AND @OldOutboundAccessPublicNetwork <> @OutboundAccessPublicNetwork)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldOutboundAccessPublicNetwork WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @OutboundAccessPublicNetwork WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_OUTBOUND_ACCESS_PUBLIC_NETWORK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldOutboundAccessPrivateNetwork IS NOT NULL AND @OutboundAccessPrivateNetwork IS NOT NULL AND @OldOutboundAccessPrivateNetwork <> @OutboundAccessPrivateNetwork)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldOutboundAccessPrivateNetwork WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @OutboundAccessPrivateNetwork WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_OUTBOUND_ACCESS_PRIVATE_NETWORK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldOutboundAccessOperatorAssisted IS NOT NULL AND @OutboundAccessOperatorAssisted IS NOT NULL AND @OldOutboundAccessOperatorAssisted <> @OutboundAccessOperatorAssisted)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldOutboundAccessOperatorAssisted WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @OutboundAccessOperatorAssisted WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_OUTBOUND_ACCESS_OPERATOR_ASSISTED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldOutboundAccessPBX IS NOT NULL AND @OutboundAccessPBX IS NOT NULL AND @OldOutboundAccessPBX <> @OutboundAccessPBX)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldOutboundAccessPBX WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @OutboundAccessPBX WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_OUTBOUND_ACCESS_PBX', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldNonACDCallsAllowed IS NOT NULL AND @NonACDCallsAllowed IS NOT NULL AND @OldNonACDCallsAllowed <> @NonACDCallsAllowed)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldNonACDCallsAllowed WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @NonACDCallsAllowed WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_NON_ACD_CALLS_ALLOWED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldQualityRecordingRate IS NOT NULL AND @QualityRecordingRate IS NOT NULL AND @OldQualityRecordingRate <> @QualityRecordingRate)  
                        OR (@OldQualityRecordingRate IS NULL AND @QualityRecordingRate IS NOT NULL)
                        OR (@OldQualityRecordingRate IS NOT NULL AND @QualityRecordingRate IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldQualityRecordingRate AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@QualityRecordingRate AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_QUALITY_RECORDING_RATE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldRecordingMode IS NOT NULL AND @RecordingMode IS NOT NULL AND @OldRecordingMode <> @RecordingMode)  
                        OR (@OldRecordingMode IS NULL AND @RecordingMode IS NOT NULL)
                        OR (@OldRecordingMode IS NOT NULL AND @RecordingMode IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldRecordingMode AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@RecordingMode AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_RECORDING_MODE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWorkModeTimer IS NOT NULL AND @WorkModeTimer IS NOT NULL AND @OldWorkModeTimer <> @WorkModeTimer)  
                        OR (@OldWorkModeTimer IS NULL AND @WorkModeTimer IS NOT NULL)
                        OR (@OldWorkModeTimer IS NOT NULL AND @WorkModeTimer IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWorkModeTimer AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WorkModeTimer AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_WORK_MODE_TIMER', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldRingNoAnswerTime IS NOT NULL AND @RingNoAnswerTime IS NOT NULL AND @OldRingNoAnswerTime <> @RingNoAnswerTime)  
                        OR (@OldRingNoAnswerTime IS NULL AND @RingNoAnswerTime IS NOT NULL)
                        OR (@OldRingNoAnswerTime IS NOT NULL AND @RingNoAnswerTime IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldRingNoAnswerTime AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@RingNoAnswerTime AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_RING_NO_ANSWER_TIME', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldSilentMonitorWarningMessage IS NOT NULL AND @SilentMonitorWarningMessage IS NOT NULL AND @OldSilentMonitorWarningMessage <> @SilentMonitorWarningMessage)  
                        OR (@OldSilentMonitorWarningMessage IS NULL AND @SilentMonitorWarningMessage IS NOT NULL)
                        OR (@OldSilentMonitorWarningMessage IS NOT NULL AND @SilentMonitorWarningMessage IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CASE @OldSilentMonitorWarningMessage WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @SilentMonitorWarningMessage WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_SILENT_MONITOR_WARNING_MESSAGE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldSilentMonitorAudibleIndication IS NOT NULL AND @SilentMonitorAudibleIndication IS NOT NULL AND @OldSilentMonitorAudibleIndication <> @SilentMonitorAudibleIndication)  
                        OR (@OldSilentMonitorAudibleIndication IS NULL AND @SilentMonitorAudibleIndication IS NOT NULL)
                        OR (@OldSilentMonitorAudibleIndication IS NOT NULL AND @SilentMonitorAudibleIndication IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CASE @OldSilentMonitorAudibleIndication WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @SilentMonitorAudibleIndication WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_SILENT_MONITOR_AUDIBLE_INDICATION', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldDefaultDevicePortAddress IS NOT NULL AND @DefaultDevicePortAddress IS NOT NULL AND @OldDefaultDevicePortAddress COLLATE Latin1_General_CS_AS <> @DefaultDevicePortAddress COLLATE Latin1_General_CS_AS)  
                        OR (@OldDefaultDevicePortAddress IS NULL AND @DefaultDevicePortAddress IS NOT NULL)
                        OR (@OldDefaultDevicePortAddress IS NOT NULL AND @DefaultDevicePortAddress IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldDefaultDevicePortAddress AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@DefaultDevicePortAddress AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_DEFAULT_DEVICE_PORT_ADDRESS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAgentCanSelectGroup IS NOT NULL AND @AgentCanSelectGroup IS NOT NULL AND @OldAgentCanSelectGroup <> @AgentCanSelectGroup)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAgentCanSelectGroup WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AgentCanSelectGroup WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_AGENT_CAN_SELECT_GROUP', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldRemoteAgentType IS NOT NULL AND @RemoteAgentType IS NOT NULL AND @OldRemoteAgentType <> @RemoteAgentType)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldRemoteAgentType AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@RemoteAgentType AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_REMOTE_AGENT_TYPE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldRemoteLoginWithoutDesktop IS NOT NULL AND @RemoteLoginWithoutDesktop IS NOT NULL AND @OldRemoteLoginWithoutDesktop <> @RemoteLoginWithoutDesktop)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldRemoteLoginWithoutDesktop WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @RemoteLoginWithoutDesktop WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_REMOTE_LOGIN_WITHOUT_DESKTOP', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldPlayZipTone IS NOT NULL AND @PlayZipTone IS NOT NULL AND @OldPlayZipTone <> @PlayZipTone)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldPlayZipTone WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @PlayZipTone WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_PLAY_ZIP_TONE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldACDSharedLineUsage IS NOT NULL AND @ACDSharedLineUsage IS NOT NULL AND @OldACDSharedLineUsage <> @ACDSharedLineUsage)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldACDSharedLineUsage WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @ACDSharedLineUsage WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('AGENT_DESKTOP_ACD_SHARED_LINE_USAGE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 

                    -- Force status change if in error
                    IF @OldStatus = 'E'
                    BEGIN 
                        SET @ForceStatusChange = 1;
                    END;
    
                    -- If no fields have been changed and we don't have any status changes then exit
                    IF (SELECT COUNT(*)
                        FROM (SELECT @FieldsChanged
                              UNION ALL SELECT @ForceStatusChange
                              )a(fields)
                        WHERE fields = 0
                        ) <> 2
                    BEGIN 

                        -- Validate that provisonable change is not being performed on deleted pkey map
                        IF @OldStatus IN ('P', 'D') AND @ProvisionableFieldsChanged = 1
                        BEGIN 
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': Cannot perform provisionable update on deleted or deleting pkey map [%d]';
                            RAISERROR(@ErrorMessage, 16, 1, @PkeyMapUrn) WITH LOG;
                        END;
                        ELSE BEGIN      
                            -- If this is a provisoning update then update status flag
                            IF @Provision = 1 AND @ItemTypeIsProvisionable = 1 AND @ClusterResourceIsProvisionable = 1    
                            AND (@ProvisionableFieldsChanged = 1 OR @ForceStatusChange = 1 OR @OldEffectiveFrom > @UtcNow)            
                            BEGIN 
                                SET @Status = 'S';
                            END;
                            ELSE BEGIN 
                                SET @Status = @OldStatus;
                            END;
    
                            SET @AuditTypeName = CASE WHEN @Status = 'S' THEN 'AT_DIMENSION_UPDATE_REQUESTED_ON_EQUIPMENT' 
                                                                         ELSE 'AT_DIMENSION_UPDATE_COMMITTED_ON_EQUIPMENT' END;

                            BEGIN TRANSACTION PUPD_agentdePKEYTran;
                            BEGIN TRY;
                                -- Update the pkey record
                                UPDATE dbo.TB_DIM_AGENT_DESKTOP_PKEY_MAP
                                SET [EFFECTIVE_FROM] = @EffectiveFrom,
                                    [EFFECTIVE_TO] = @EffectiveTo,
                                    [MODIFIED_DATE] = @UtcNow,
                                    [MODIFIED_BY_ID] = @SessionUserId, 
                                    [XML_DATA] = @XmlData,
                                    [CUSTOM_XML_DATA] = @CustomXmlData,
                                    [STATUS] = @Status,
                                    [SOURCE_CHANGE_STAMP] = @SourceChangeStamp, 
                                    [INTERNAL_NAME] = @InternalName, 
                                    [DESCRIPTION] = @Description, 
                                    [AVAILABLE_AFTER_INCOMING] = @AvailableAfterIncoming, 
                                    [AVAILABLE_AFTER_OUTGOING] = @AvailableAfterOutgoing, 
                                    [WRAPUP_DATA_INCOMING_MODE] = @WrapupDataIncomingMode, 
                                    [WRAPUP_DATA_OUTGOING_MODE] = @WrapupDataOutgoingMode, 
                                    [AUTO_ANSWER_ENABLED] = @AutoAnswerEnabled, 
                                    [IDLE_REASON_REQUIRED] = @IdleReasonRequired, 
                                    [LOGOUT_NON_ACTIVITY_TIME] = @LogoutNonActivityTime, 
                                    [LOGOUT_REASON_REQUIRED] = @LogoutReasonRequired, 
                                    [SUPERVISOR_CALLS_ALLOWED] = @SupervisorCallsAllowed, 
                                    [SUPERVISOR_ASSIST_CALL_METHOD] = @SupervisorAssistCallMethod, 
                                    [EMERGENCY_CALL_METHOD] = @EmergencyCallMethod, 
                                    [AUTO_RECORD_ON_EMERGENCY] = @AutoRecordOnEmergency, 
                                    [AGENT_TO_AGENT_CALLS_ALLOWED] = @AgentToAgentCallsAllowed, 
                                    [OUTBOUND_ACCESS_INTERNATIONAL] = @OutboundAccessInternational, 
                                    [OUTBOUND_ACCESS_PUBLIC_NETWORK] = @OutboundAccessPublicNetwork, 
                                    [OUTBOUND_ACCESS_PRIVATE_NETWORK] = @OutboundAccessPrivateNetwork, 
                                    [OUTBOUND_ACCESS_OPERATOR_ASSISTED] = @OutboundAccessOperatorAssisted, 
                                    [OUTBOUND_ACCESS_PBX] = @OutboundAccessPBX, 
                                    [NON_ACD_CALLS_ALLOWED] = @NonACDCallsAllowed, 
                                    [QUALITY_RECORDING_RATE] = @QualityRecordingRate, 
                                    [RECORDING_MODE] = @RecordingMode, 
                                    [WORK_MODE_TIMER] = @WorkModeTimer, 
                                    [RING_NO_ANSWER_TIME] = @RingNoAnswerTime, 
                                    [SILENT_MONITOR_WARNING_MESSAGE] = @SilentMonitorWarningMessage, 
                                    [SILENT_MONITOR_AUDIBLE_INDICATION] = @SilentMonitorAudibleIndication, 
                                    [DEFAULT_DEVICE_PORT_ADDRESS] = @DefaultDevicePortAddress, 
                                    [AGENT_CAN_SELECT_GROUP] = @AgentCanSelectGroup, 
                                    [REMOTE_AGENT_TYPE] = @RemoteAgentType, 
                                    [REMOTE_LOGIN_WITHOUT_DESKTOP] = @RemoteLoginWithoutDesktop, 
                                    [PLAY_ZIP_TONE] = @PlayZipTone, 
                                    [ACD_SHARED_LINE_USAGE] = @ACDSharedLineUsage, 
                                    [CHANGE_STAMP] = [CHANGE_STAMP] + 1
                                WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                                AND [CHANGE_STAMP] = @ChangeStamp;
                            
                                SELECT @RowCount = @@ROWCOUNT;
                                                
                                -- Check for concurrency conflict
                                IF @RowCount <> 1
                                BEGIN 
                                    SET @ReturnCode = -2;
                                    SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': Concurrency conflict occured whilst attempting to update item pkey map [%d], Error [%d]';
                                    RAISERROR(@ErrorMessage, 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                                END;
                                 
                
                                -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                                SET @ChangeStamp = @ChangeStamp + 1;
        
                                -- Audit success
                                SET @FieldChangeXmlData = ( SELECT  [ATTRIBUTE_FIELD] AS "@Field",
                                                                    ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE([OLD_VALUE] COLLATE Latin1_General_BIN,
                                                                    CHAR(0), ''), CHAR(1), ''), CHAR(2), ''), CHAR(3), ''),
                                                                    CHAR(4), ''), CHAR(5), ''), CHAR(6), ''), CHAR(7), ''),
                                                                    CHAR(8), ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''),
                                                                    CHAR(12), ''), CHAR(13), ''), CHAR(14), ''), CHAR(15), ''),
                                                                    CHAR(16), ''), CHAR(17), ''), CHAR(18), ''), CHAR(19), ''), 
                                                                    CHAR(20), ''), CHAR(21), ''), CHAR(22), ''), CHAR(23), ''),
                                                                    CHAR(24), ''), CHAR(25), ''), CHAR(26), ''), CHAR(27), ''), 
                                                                    CHAR(28), ''), CHAR(29), ''), CHAR(128), ''), '') AS [PreviousValue],
                                                                    ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                                    REPLACE(REPLACE(REPLACE([NEW_VALUE] COLLATE Latin1_General_BIN,
                                                                    CHAR(0), ''), CHAR(1), ''), CHAR(2), ''), CHAR(3), ''),
                                                                    CHAR(4), ''), CHAR(5), ''), CHAR(6), ''), CHAR(7), ''),
                                                                    CHAR(8), ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''),
                                                                    CHAR(12), ''), CHAR(13), ''), CHAR(14), ''), CHAR(15), ''),
                                                                    CHAR(16), ''), CHAR(17), ''), CHAR(18), ''), CHAR(19), ''), 
                                                                    CHAR(20), ''), CHAR(21), ''), CHAR(22), ''), CHAR(23), ''),
                                                                    CHAR(24), ''), CHAR(25), ''), CHAR(26), ''), CHAR(27), ''), 
                                                                    CHAR(28), ''), CHAR(29), ''), CHAR(128), ''), '') AS [NewValue]
                                                            FROM    @AuditAttributeTable
                                                          FOR
                                                            XML PATH('FieldChange'),
                                                                ROOT('FieldChanges')
                                                          );

                                -- Audit against parent and child
                                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, NULL, 2, DEFAULT, @ClusterResourceId, NULL, 'S', 0, 'DIMENSION_UPDATED_ON_EQUIPMENT', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
                                
                                IF @InitialTransactionCount = 0 
                                BEGIN 
                                    COMMIT TRANSACTION PUPD_agentdePKEYTran;
                                END;
                                ELSE BEGIN 
                                    WHILE @@TRANCOUNT > @InitialTransactionCount
                                    BEGIN 
                                        COMMIT TRANSACTION;
                                    END;
                                END;
                                SET @ReturnCode = 0;
                            END TRY
                            BEGIN CATCH;
                                SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
                                       @ErrorHolder = ERROR_MESSAGE();
                                SELECT @ErrorMessage = OBJECT_NAME(@@PROCID)+': Error updating item pkey map [%d]. '+
                                                      'SQLError['+@ErrorHolder+']. '+
                                                      'ErrorCode [%d]';
                                RAISERROR(@ErrorMessage, 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                            END CATCH;
                        END;
                    END;
                END;
            END;
        END;
    END;
    END TRY
    BEGIN CATCH;
        SET @ErrorMessage = CASE WHEN @ErrorMessage IS NULL THEN OBJECT_NAME(@@PROCID)+': '+ERROR_MESSAGE() ELSE ERROR_MESSAGE() END;
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION
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
	ON [dbo].[ap_dim01_update_agent_desktop_pkey]
	TO [portalapp_role]
GO
