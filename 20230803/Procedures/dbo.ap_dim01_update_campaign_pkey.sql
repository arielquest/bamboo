SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_campaign_pkey]
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
    @AbandonEnabled          [BIT] = 0, 
    @AbandonPercent          [FLOAT] = 0, 
    @NoAnswerCallback        [INT] = 0, 
    @BusyCallback            [INT] = 0, 
    @NoAnswerRingLimit       [INT] = 0, 
    @MaximumLineAgent        [FLOAT] = 0, 
    @LinesPerAgent           [FLOAT] = 0, 
    @LeaveMessageEnabled     [BIT] = 0, 
    @MaximumAttempts         [INT] = 0, 
    @WorkStartHours          [INT] = 0, 
    @WorkStartMinutes        [INT] = 0, 
    @WorkEndHours            [INT] = 0, 
    @WorkEndMinutes          [INT] = 0, 
    @HomeStartHours          [INT] = 0, 
    @HomeStartMinutes        [INT] = 0, 
    @HomeEndHours            [INT] = 0, 
    @HomeEndMinutes          [INT] = 0, 
    @HomeEnabled             [BIT] = 0, 
    @WorkEnabled             [BIT] = 0, 
    @BusyRetryEnabled        [BIT] = 0, 
    @MaximumBusyAttempts     [SMALLINT] = 0, 
    @AnswerDetectEnabled     [BIT] = 0, 
    @CallbackTimeLimit       [SMALLINT] = 0, 
    @MinimumCallDuration     [SMALLINT] = 1, 
    @ExhaustedCallsEnabled   [BIT] = 0, 
    @EdgeDetectEnabled       [BIT] = 0, 
    @QuickDetectEnabled      [BIT] = 0, 
    @SPClosedRecordEnabled   [BIT] = 0, 
    @SPClosedRecordCount     [SMALLINT] = 0, 
    @PersonalizedCallbackEnabled  [BIT] = 0, 
    @ReleaseCallbackEnabled  [BIT] = 0, 
    @RescheduleCallbackMode  [SMALLINT] = 0, 
    @IPTerminatingBeepDetect  [BIT] = 0, 
    @CampaignPurposeType     [INT] = 1, 
    @IPAMDEnabled            [BIT] = 0, 
    @AMDTreatmentMode        [INT] = 1, 
    @UseGMTFromRegionPrefix  [BIT] = 1, 
    @ConfigParam             [NVARCHAR](255) = NULL, 
    @AbandonCustomerCallback  [INT] = NULL, 
    @AbandonedDialerCallback  [INT] = NULL, 
    @CustomerNotHomeCallback  [INT] = NULL, 
    @AnsweringMachineCallback  [INT] = NULL, 
    @PrefixDigits            [NVARCHAR](5) = NULL, 
    @WaitForBusyRetry        [BIT] = 1, 
    @DisableCPA              [BIT] = 0, 
    @DSTLocation             [INT] = 1, 
    @ICMEnabled              [BIT] = 1, 
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
                @OldAbandonEnabled               [BIT], 
                @OldAbandonPercent               [FLOAT], 
                @OldNoAnswerCallback             [INT], 
                @OldBusyCallback                 [INT], 
                @OldNoAnswerRingLimit            [INT], 
                @OldMaximumLineAgent             [FLOAT], 
                @OldLinesPerAgent                [FLOAT], 
                @OldLeaveMessageEnabled          [BIT], 
                @OldMaximumAttempts              [INT], 
                @OldWorkStartHours               [INT], 
                @OldWorkStartMinutes             [INT], 
                @OldWorkEndHours                 [INT], 
                @OldWorkEndMinutes               [INT], 
                @OldHomeStartHours               [INT], 
                @OldHomeStartMinutes             [INT], 
                @OldHomeEndHours                 [INT], 
                @OldHomeEndMinutes               [INT], 
                @OldHomeEnabled                  [BIT], 
                @OldWorkEnabled                  [BIT], 
                @OldBusyRetryEnabled             [BIT], 
                @OldMaximumBusyAttempts          [SMALLINT], 
                @OldAnswerDetectEnabled          [BIT], 
                @OldCallbackTimeLimit            [SMALLINT], 
                @OldMinimumCallDuration          [SMALLINT], 
                @OldExhaustedCallsEnabled        [BIT], 
                @OldEdgeDetectEnabled            [BIT], 
                @OldQuickDetectEnabled           [BIT], 
                @OldSPClosedRecordEnabled        [BIT], 
                @OldSPClosedRecordCount          [SMALLINT], 
                @OldPersonalizedCallbackEnabled  [BIT], 
                @OldReleaseCallbackEnabled       [BIT], 
                @OldRescheduleCallbackMode       [SMALLINT], 
                @OldIPTerminatingBeepDetect      [BIT], 
                @OldCampaignPurposeType          [INT], 
                @OldIPAMDEnabled                 [BIT], 
                @OldAMDTreatmentMode             [INT], 
                @OldUseGMTFromRegionPrefix       [BIT], 
                @OldConfigParam                  [NVARCHAR](255), 
                @OldAbandonCustomerCallback      [INT], 
                @OldAbandonedDialerCallback      [INT], 
                @OldCustomerNotHomeCallback      [INT], 
                @OldAnsweringMachineCallback     [INT], 
                @OldPrefixDigits                 [NVARCHAR](5), 
                @OldWaitForBusyRetry             [BIT], 
                @OldDisableCPA                   [BIT], 
                @OldDSTLocation                  [INT], 
                @OldICMEnabled                   [BIT], 
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
                    RAISERROR('ap_dim01_update_campaign_pkey: Cannot force status change on non provisionable update', 16, 1) WITH LOG
                END;
                ELSE BEGIN 
                    -- If pkey map urn has not been supplied then exit
                    IF @PkeyMapUrn IS NOT NULL
                    BEGIN 
                        -- Save the current state of the record before updating.
                        SET @ItemTypeId = '00001600-1000-0000-0000-000000000010';
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
                                @OldAbandonEnabled = map.[ABANDON_ENABLED],
                                @OldAbandonPercent = map.[ABANDON_PERCENT],
                                @OldNoAnswerCallback = map.[NO_ANSWER_CALLBACK],
                                @OldBusyCallback = map.[BUSY_CALLBACK],
                                @OldNoAnswerRingLimit = map.[NO_ANSWER_RING_LIMIT],
                                @OldMaximumLineAgent = map.[MAXIMUM_LINE_AGENT],
                                @OldLinesPerAgent = map.[LINES_PER_AGENT],
                                @OldLeaveMessageEnabled = map.[LEAVE_MESSAGE_ENABLED],
                                @OldMaximumAttempts = map.[MAXIMUM_ATTEMPTS],
                                @OldWorkStartHours = map.[WORK_START_HOURS],
                                @OldWorkStartMinutes = map.[WORK_START_MINUTES],
                                @OldWorkEndHours = map.[WORK_END_HOURS],
                                @OldWorkEndMinutes = map.[WORK_END_MINUTES],
                                @OldHomeStartHours = map.[HOME_START_HOURS],
                                @OldHomeStartMinutes = map.[HOME_START_MINUTES],
                                @OldHomeEndHours = map.[HOME_END_HOURS],
                                @OldHomeEndMinutes = map.[HOME_END_MINUTES],
                                @OldHomeEnabled = map.[HOME_ENABLED],
                                @OldWorkEnabled = map.[WORK_ENABLED],
                                @OldBusyRetryEnabled = map.[BUSY_RETRY_ENABLED],
                                @OldMaximumBusyAttempts = map.[MAXIMUM_BUSY_ATTEMPTS],
                                @OldAnswerDetectEnabled = map.[ANSWER_DETECT_ENABLED],
                                @OldCallbackTimeLimit = map.[CALLBACK_TIME_LIMIT],
                                @OldMinimumCallDuration = map.[MINIMUM_CALL_DURATION],
                                @OldExhaustedCallsEnabled = map.[EXHAUSTED_CALLS_ENABLED],
                                @OldEdgeDetectEnabled = map.[EDGE_DETECT_ENABLED],
                                @OldQuickDetectEnabled = map.[QUICK_DETECT_ENABLED],
                                @OldSPClosedRecordEnabled = map.[SP_CLOSED_RECORD_ENABLED],
                                @OldSPClosedRecordCount = map.[SP_CLOSED_RECORD_COUNT],
                                @OldPersonalizedCallbackEnabled = map.[PERSONALIZED_CALLBACK_ENABLED],
                                @OldReleaseCallbackEnabled = map.[RELEASE_CALLBACK_ENABLED],
                                @OldRescheduleCallbackMode = map.[RESCHEDULE_CALLBACK_MODE],
                                @OldIPTerminatingBeepDetect = map.[IP_TERMINATING_BEEP_DETECT],
                                @OldCampaignPurposeType = map.[CAMPAIGN_PURPOSE_TYPE],
                                @OldIPAMDEnabled = map.[IPAMD_ENABLED],
                                @OldAMDTreatmentMode = map.[AMD_TREATMENT_MODE],
                                @OldUseGMTFromRegionPrefix = map.[USE_GMT_FROM_REGION_PREFIX],
                                @OldConfigParam = map.[CONFIG_PARAM],
                                @OldAbandonCustomerCallback = map.[ABANDON_CUSTOMER_CALLBACK],
                                @OldAbandonedDialerCallback = map.[ABANDONED_DIALER_CALLBACK],
                                @OldCustomerNotHomeCallback = map.[CUSTOMER_NOT_HOME_CALLBACK],
                                @OldAnsweringMachineCallback = map.[ANSWERING_MACHINE_CALLBACK],
                                @OldPrefixDigits = map.[PREFIX_DIGITS],
                                @OldWaitForBusyRetry = map.[WAIT_FOR_BUSY_RETRY],
                                @OldDisableCPA = map.[DISABLE_CPA],
                                @OldDSTLocation = map.[DST_LOCATION],
                                @OldICMEnabled = map.[ICM_ENABLED], 
                                @ItemBusinessUrn = item.[ITEM_BIZ_URN],
                                @ClusterResourceId = map.[CLUSTER_RESOURCE_ID],
                                @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                                @ClusterTypeId = res.RESOURCE_TYPE_ID
                        FROM dbo.TB_DIM_CAMPAIGN_PKEY_MAP AS map WITH(UPDLOCK)
                        INNER JOIN dbo.TB_DIM_CAMPAIGN AS item WITH(READUNCOMMITTED) ON map.ITEM_BIZ_URN = item.ITEM_BIZ_URN AND item.LATEST = 1
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
                                  WHERE TABLE_NAME = 'TB_DIM_CAMPAIGN_PKEY_MAP' 
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
                                      WHERE TABLE_NAME = 'TB_DIM_CAMPAIGN_PKEY_MAP' 
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
                        'CAMPAIGN_' + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],
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
                        'custom.CAMPAIGN_'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
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
                            VALUES('CAMPAIGN_INTERNAL_NAME', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldDescription IS NOT NULL AND @Description IS NOT NULL AND @OldDescription COLLATE Latin1_General_CS_AS <> @Description COLLATE Latin1_General_CS_AS)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldDescription AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@Description AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_DESCRIPTION', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAbandonEnabled IS NOT NULL AND @AbandonEnabled IS NOT NULL AND @OldAbandonEnabled <> @AbandonEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAbandonEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AbandonEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ABANDON_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAbandonPercent IS NOT NULL AND @AbandonPercent IS NOT NULL AND @OldAbandonPercent <> @AbandonPercent)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldAbandonPercent AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@AbandonPercent AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ABANDON_PERCENT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldNoAnswerCallback IS NOT NULL AND @NoAnswerCallback IS NOT NULL AND @OldNoAnswerCallback <> @NoAnswerCallback)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldNoAnswerCallback AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@NoAnswerCallback AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_NO_ANSWER_CALLBACK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldBusyCallback IS NOT NULL AND @BusyCallback IS NOT NULL AND @OldBusyCallback <> @BusyCallback)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldBusyCallback AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@BusyCallback AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_BUSY_CALLBACK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldNoAnswerRingLimit IS NOT NULL AND @NoAnswerRingLimit IS NOT NULL AND @OldNoAnswerRingLimit <> @NoAnswerRingLimit)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldNoAnswerRingLimit AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@NoAnswerRingLimit AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_NO_ANSWER_RING_LIMIT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldMaximumLineAgent IS NOT NULL AND @MaximumLineAgent IS NOT NULL AND @OldMaximumLineAgent <> @MaximumLineAgent)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldMaximumLineAgent AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@MaximumLineAgent AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_MAXIMUM_LINE_AGENT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldLinesPerAgent IS NOT NULL AND @LinesPerAgent IS NOT NULL AND @OldLinesPerAgent <> @LinesPerAgent)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldLinesPerAgent AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@LinesPerAgent AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_LINES_PER_AGENT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldLeaveMessageEnabled IS NOT NULL AND @LeaveMessageEnabled IS NOT NULL AND @OldLeaveMessageEnabled <> @LeaveMessageEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldLeaveMessageEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @LeaveMessageEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_LEAVE_MESSAGE_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldMaximumAttempts IS NOT NULL AND @MaximumAttempts IS NOT NULL AND @OldMaximumAttempts <> @MaximumAttempts)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldMaximumAttempts AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@MaximumAttempts AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_MAXIMUM_ATTEMPTS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWorkStartHours IS NOT NULL AND @WorkStartHours IS NOT NULL AND @OldWorkStartHours <> @WorkStartHours)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWorkStartHours AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WorkStartHours AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_WORK_START_HOURS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWorkStartMinutes IS NOT NULL AND @WorkStartMinutes IS NOT NULL AND @OldWorkStartMinutes <> @WorkStartMinutes)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWorkStartMinutes AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WorkStartMinutes AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_WORK_START_MINUTES', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWorkEndHours IS NOT NULL AND @WorkEndHours IS NOT NULL AND @OldWorkEndHours <> @WorkEndHours)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWorkEndHours AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WorkEndHours AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_WORK_END_HOURS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWorkEndMinutes IS NOT NULL AND @WorkEndMinutes IS NOT NULL AND @OldWorkEndMinutes <> @WorkEndMinutes)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldWorkEndMinutes AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@WorkEndMinutes AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_WORK_END_MINUTES', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldHomeStartHours IS NOT NULL AND @HomeStartHours IS NOT NULL AND @OldHomeStartHours <> @HomeStartHours)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldHomeStartHours AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@HomeStartHours AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_HOME_START_HOURS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldHomeStartMinutes IS NOT NULL AND @HomeStartMinutes IS NOT NULL AND @OldHomeStartMinutes <> @HomeStartMinutes)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldHomeStartMinutes AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@HomeStartMinutes AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_HOME_START_MINUTES', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldHomeEndHours IS NOT NULL AND @HomeEndHours IS NOT NULL AND @OldHomeEndHours <> @HomeEndHours)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldHomeEndHours AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@HomeEndHours AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_HOME_END_HOURS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldHomeEndMinutes IS NOT NULL AND @HomeEndMinutes IS NOT NULL AND @OldHomeEndMinutes <> @HomeEndMinutes)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldHomeEndMinutes AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@HomeEndMinutes AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_HOME_END_MINUTES', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldHomeEnabled IS NOT NULL AND @HomeEnabled IS NOT NULL AND @OldHomeEnabled <> @HomeEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldHomeEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @HomeEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_HOME_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWorkEnabled IS NOT NULL AND @WorkEnabled IS NOT NULL AND @OldWorkEnabled <> @WorkEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldWorkEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @WorkEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_WORK_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldBusyRetryEnabled IS NOT NULL AND @BusyRetryEnabled IS NOT NULL AND @OldBusyRetryEnabled <> @BusyRetryEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldBusyRetryEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @BusyRetryEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_BUSY_RETRY_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldMaximumBusyAttempts IS NOT NULL AND @MaximumBusyAttempts IS NOT NULL AND @OldMaximumBusyAttempts <> @MaximumBusyAttempts)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldMaximumBusyAttempts AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@MaximumBusyAttempts AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_MAXIMUM_BUSY_ATTEMPTS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAnswerDetectEnabled IS NOT NULL AND @AnswerDetectEnabled IS NOT NULL AND @OldAnswerDetectEnabled <> @AnswerDetectEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldAnswerDetectEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @AnswerDetectEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ANSWER_DETECT_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldCallbackTimeLimit IS NOT NULL AND @CallbackTimeLimit IS NOT NULL AND @OldCallbackTimeLimit <> @CallbackTimeLimit)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldCallbackTimeLimit AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@CallbackTimeLimit AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_CALLBACK_TIME_LIMIT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldMinimumCallDuration IS NOT NULL AND @MinimumCallDuration IS NOT NULL AND @OldMinimumCallDuration <> @MinimumCallDuration)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldMinimumCallDuration AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@MinimumCallDuration AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_MINIMUM_CALL_DURATION', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldExhaustedCallsEnabled IS NOT NULL AND @ExhaustedCallsEnabled IS NOT NULL AND @OldExhaustedCallsEnabled <> @ExhaustedCallsEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldExhaustedCallsEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @ExhaustedCallsEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_EXHAUSTED_CALLS_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldEdgeDetectEnabled IS NOT NULL AND @EdgeDetectEnabled IS NOT NULL AND @OldEdgeDetectEnabled <> @EdgeDetectEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldEdgeDetectEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @EdgeDetectEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_EDGE_DETECT_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldQuickDetectEnabled IS NOT NULL AND @QuickDetectEnabled IS NOT NULL AND @OldQuickDetectEnabled <> @QuickDetectEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldQuickDetectEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @QuickDetectEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_QUICK_DETECT_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldSPClosedRecordEnabled IS NOT NULL AND @SPClosedRecordEnabled IS NOT NULL AND @OldSPClosedRecordEnabled <> @SPClosedRecordEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldSPClosedRecordEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @SPClosedRecordEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_SP_CLOSED_RECORD_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldSPClosedRecordCount IS NOT NULL AND @SPClosedRecordCount IS NOT NULL AND @OldSPClosedRecordCount <> @SPClosedRecordCount)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldSPClosedRecordCount AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@SPClosedRecordCount AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_SP_CLOSED_RECORD_COUNT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldPersonalizedCallbackEnabled IS NOT NULL AND @PersonalizedCallbackEnabled IS NOT NULL AND @OldPersonalizedCallbackEnabled <> @PersonalizedCallbackEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldPersonalizedCallbackEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @PersonalizedCallbackEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_PERSONALIZED_CALLBACK_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldReleaseCallbackEnabled IS NOT NULL AND @ReleaseCallbackEnabled IS NOT NULL AND @OldReleaseCallbackEnabled <> @ReleaseCallbackEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldReleaseCallbackEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @ReleaseCallbackEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_RELEASE_CALLBACK_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldRescheduleCallbackMode IS NOT NULL AND @RescheduleCallbackMode IS NOT NULL AND @OldRescheduleCallbackMode <> @RescheduleCallbackMode)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldRescheduleCallbackMode AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@RescheduleCallbackMode AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_RESCHEDULE_CALLBACK_MODE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldIPTerminatingBeepDetect IS NOT NULL AND @IPTerminatingBeepDetect IS NOT NULL AND @OldIPTerminatingBeepDetect <> @IPTerminatingBeepDetect)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldIPTerminatingBeepDetect WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @IPTerminatingBeepDetect WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_IP_TERMINATING_BEEP_DETECT', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldCampaignPurposeType IS NOT NULL AND @CampaignPurposeType IS NOT NULL AND @OldCampaignPurposeType <> @CampaignPurposeType)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldCampaignPurposeType AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@CampaignPurposeType AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_CAMPAIGN_PURPOSE_TYPE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldIPAMDEnabled IS NOT NULL AND @IPAMDEnabled IS NOT NULL AND @OldIPAMDEnabled <> @IPAMDEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldIPAMDEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @IPAMDEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_IPAMD_ENABLED', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAMDTreatmentMode IS NOT NULL AND @AMDTreatmentMode IS NOT NULL AND @OldAMDTreatmentMode <> @AMDTreatmentMode)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldAMDTreatmentMode AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@AMDTreatmentMode AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_AMD_TREATMENT_MODE', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldUseGMTFromRegionPrefix IS NOT NULL AND @UseGMTFromRegionPrefix IS NOT NULL AND @OldUseGMTFromRegionPrefix <> @UseGMTFromRegionPrefix)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldUseGMTFromRegionPrefix WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @UseGMTFromRegionPrefix WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_USE_GMT_FROM_REGION_PREFIX', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldConfigParam IS NOT NULL AND @ConfigParam IS NOT NULL AND @OldConfigParam COLLATE Latin1_General_CS_AS <> @ConfigParam COLLATE Latin1_General_CS_AS)  
                        OR (@OldConfigParam IS NULL AND @ConfigParam IS NOT NULL)
                        OR (@OldConfigParam IS NOT NULL AND @ConfigParam IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldConfigParam AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@ConfigParam AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_CONFIG_PARAM', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAbandonCustomerCallback IS NOT NULL AND @AbandonCustomerCallback IS NOT NULL AND @OldAbandonCustomerCallback <> @AbandonCustomerCallback)  
                        OR (@OldAbandonCustomerCallback IS NULL AND @AbandonCustomerCallback IS NOT NULL)
                        OR (@OldAbandonCustomerCallback IS NOT NULL AND @AbandonCustomerCallback IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldAbandonCustomerCallback AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@AbandonCustomerCallback AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ABANDON_CUSTOMER_CALLBACK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAbandonedDialerCallback IS NOT NULL AND @AbandonedDialerCallback IS NOT NULL AND @OldAbandonedDialerCallback <> @AbandonedDialerCallback)  
                        OR (@OldAbandonedDialerCallback IS NULL AND @AbandonedDialerCallback IS NOT NULL)
                        OR (@OldAbandonedDialerCallback IS NOT NULL AND @AbandonedDialerCallback IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldAbandonedDialerCallback AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@AbandonedDialerCallback AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ABANDONED_DIALER_CALLBACK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldCustomerNotHomeCallback IS NOT NULL AND @CustomerNotHomeCallback IS NOT NULL AND @OldCustomerNotHomeCallback <> @CustomerNotHomeCallback)  
                        OR (@OldCustomerNotHomeCallback IS NULL AND @CustomerNotHomeCallback IS NOT NULL)
                        OR (@OldCustomerNotHomeCallback IS NOT NULL AND @CustomerNotHomeCallback IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldCustomerNotHomeCallback AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@CustomerNotHomeCallback AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_CUSTOMER_NOT_HOME_CALLBACK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldAnsweringMachineCallback IS NOT NULL AND @AnsweringMachineCallback IS NOT NULL AND @OldAnsweringMachineCallback <> @AnsweringMachineCallback)  
                        OR (@OldAnsweringMachineCallback IS NULL AND @AnsweringMachineCallback IS NOT NULL)
                        OR (@OldAnsweringMachineCallback IS NOT NULL AND @AnsweringMachineCallback IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldAnsweringMachineCallback AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@AnsweringMachineCallback AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ANSWERING_MACHINE_CALLBACK', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldPrefixDigits IS NOT NULL AND @PrefixDigits IS NOT NULL AND @OldPrefixDigits COLLATE Latin1_General_CS_AS <> @PrefixDigits COLLATE Latin1_General_CS_AS)  
                        OR (@OldPrefixDigits IS NULL AND @PrefixDigits IS NOT NULL)
                        OR (@OldPrefixDigits IS NOT NULL AND @PrefixDigits IS NULL) 
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldPrefixDigits AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@PrefixDigits AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_PREFIX_DIGITS', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldWaitForBusyRetry IS NOT NULL AND @WaitForBusyRetry IS NOT NULL AND @OldWaitForBusyRetry <> @WaitForBusyRetry)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldWaitForBusyRetry WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @WaitForBusyRetry WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_WAIT_FOR_BUSY_RETRY', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldDisableCPA IS NOT NULL AND @DisableCPA IS NOT NULL AND @OldDisableCPA <> @DisableCPA)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldDisableCPA WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @DisableCPA WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_DISABLE_CPA', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldDSTLocation IS NOT NULL AND @DSTLocation IS NOT NULL AND @OldDSTLocation <> @DSTLocation)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldDSTLocation AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@DSTLocation AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_DST_LOCATION', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldICMEnabled IS NOT NULL AND @ICMEnabled IS NOT NULL AND @OldICMEnabled <> @ICMEnabled)  
                        BEGIN  
                            SET @AuditTempOld = CASE @OldICMEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                            SET @AuditTempNew = CASE @ICMEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('CAMPAIGN_ICM_ENABLED', @AuditTempNew, @AuditTempOld);
 

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

                            BEGIN TRANSACTION PUPD_camPKEYTran;
                            BEGIN TRY;
                                -- Update the pkey record
                                UPDATE dbo.TB_DIM_CAMPAIGN_PKEY_MAP
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
                                    [ABANDON_ENABLED] = @AbandonEnabled, 
                                    [ABANDON_PERCENT] = @AbandonPercent, 
                                    [NO_ANSWER_CALLBACK] = @NoAnswerCallback, 
                                    [BUSY_CALLBACK] = @BusyCallback, 
                                    [NO_ANSWER_RING_LIMIT] = @NoAnswerRingLimit, 
                                    [MAXIMUM_LINE_AGENT] = @MaximumLineAgent, 
                                    [LINES_PER_AGENT] = @LinesPerAgent, 
                                    [LEAVE_MESSAGE_ENABLED] = @LeaveMessageEnabled, 
                                    [MAXIMUM_ATTEMPTS] = @MaximumAttempts, 
                                    [WORK_START_HOURS] = @WorkStartHours, 
                                    [WORK_START_MINUTES] = @WorkStartMinutes, 
                                    [WORK_END_HOURS] = @WorkEndHours, 
                                    [WORK_END_MINUTES] = @WorkEndMinutes, 
                                    [HOME_START_HOURS] = @HomeStartHours, 
                                    [HOME_START_MINUTES] = @HomeStartMinutes, 
                                    [HOME_END_HOURS] = @HomeEndHours, 
                                    [HOME_END_MINUTES] = @HomeEndMinutes, 
                                    [HOME_ENABLED] = @HomeEnabled, 
                                    [WORK_ENABLED] = @WorkEnabled, 
                                    [BUSY_RETRY_ENABLED] = @BusyRetryEnabled, 
                                    [MAXIMUM_BUSY_ATTEMPTS] = @MaximumBusyAttempts, 
                                    [ANSWER_DETECT_ENABLED] = @AnswerDetectEnabled, 
                                    [CALLBACK_TIME_LIMIT] = @CallbackTimeLimit, 
                                    [MINIMUM_CALL_DURATION] = @MinimumCallDuration, 
                                    [EXHAUSTED_CALLS_ENABLED] = @ExhaustedCallsEnabled, 
                                    [EDGE_DETECT_ENABLED] = @EdgeDetectEnabled, 
                                    [QUICK_DETECT_ENABLED] = @QuickDetectEnabled, 
                                    [SP_CLOSED_RECORD_ENABLED] = @SPClosedRecordEnabled, 
                                    [SP_CLOSED_RECORD_COUNT] = @SPClosedRecordCount, 
                                    [PERSONALIZED_CALLBACK_ENABLED] = @PersonalizedCallbackEnabled, 
                                    [RELEASE_CALLBACK_ENABLED] = @ReleaseCallbackEnabled, 
                                    [RESCHEDULE_CALLBACK_MODE] = @RescheduleCallbackMode, 
                                    [IP_TERMINATING_BEEP_DETECT] = @IPTerminatingBeepDetect, 
                                    [CAMPAIGN_PURPOSE_TYPE] = @CampaignPurposeType, 
                                    [IPAMD_ENABLED] = @IPAMDEnabled, 
                                    [AMD_TREATMENT_MODE] = @AMDTreatmentMode, 
                                    [USE_GMT_FROM_REGION_PREFIX] = @UseGMTFromRegionPrefix, 
                                    [CONFIG_PARAM] = @ConfigParam, 
                                    [ABANDON_CUSTOMER_CALLBACK] = @AbandonCustomerCallback, 
                                    [ABANDONED_DIALER_CALLBACK] = @AbandonedDialerCallback, 
                                    [CUSTOMER_NOT_HOME_CALLBACK] = @CustomerNotHomeCallback, 
                                    [ANSWERING_MACHINE_CALLBACK] = @AnsweringMachineCallback, 
                                    [PREFIX_DIGITS] = @PrefixDigits, 
                                    [WAIT_FOR_BUSY_RETRY] = @WaitForBusyRetry, 
                                    [DISABLE_CPA] = @DisableCPA, 
                                    [DST_LOCATION] = @DSTLocation, 
                                    [ICM_ENABLED] = @ICMEnabled, 
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
                                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, NULL, 13, DEFAULT, @ClusterResourceId, NULL, 'S', 0, 'DIMENSION_UPDATED_ON_EQUIPMENT', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
                                
                                IF @InitialTransactionCount = 0 
                                BEGIN 
                                    COMMIT TRANSACTION PUPD_camPKEYTran;
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
	ON [dbo].[ap_dim01_update_campaign_pkey]
	TO [portalapp_role]
GO
