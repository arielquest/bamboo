SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_add_campaign_pkey]
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
    @Provision                  [BIT] = NULL,
    @PkeyMapUrn                 [INTEGER] OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    BEGIN TRY;

        DECLARE @ReturnCode AS [INTEGER] = 0,
                @Status AS [CHAR](1),
                @ItemTypeId AS [UNIQUEIDENTIFIER] = '00001600-1000-0000-0000-000000000010',
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
                                  FROM dbo.TB_DIM_CAMPAIGN WITH(READUNCOMMITTED) 
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
                                  FROM [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] WITH(READUNCOMMITTED) 
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
                                      WHERE TABLE_NAME = 'TB_DIM_CAMPAIGN_PKEY_MAP' 
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
                                      WHERE TABLE_NAME = 'TB_DIM_CAMPAIGN_PKEY_MAP' 
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

                            BEGIN TRANSACTION PADD_camPKEYTran;
                            BEGIN TRY;
                                INSERT INTO [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP](
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
                                [ABANDON_ENABLED], 
                                [ABANDON_PERCENT], 
                                [NO_ANSWER_CALLBACK], 
                                [BUSY_CALLBACK], 
                                [NO_ANSWER_RING_LIMIT], 
                                [MAXIMUM_LINE_AGENT], 
                                [LINES_PER_AGENT], 
                                [LEAVE_MESSAGE_ENABLED], 
                                [MAXIMUM_ATTEMPTS], 
                                [WORK_START_HOURS], 
                                [WORK_START_MINUTES], 
                                [WORK_END_HOURS], 
                                [WORK_END_MINUTES], 
                                [HOME_START_HOURS], 
                                [HOME_START_MINUTES], 
                                [HOME_END_HOURS], 
                                [HOME_END_MINUTES], 
                                [HOME_ENABLED], 
                                [WORK_ENABLED], 
                                [BUSY_RETRY_ENABLED], 
                                [MAXIMUM_BUSY_ATTEMPTS], 
                                [ANSWER_DETECT_ENABLED], 
                                [CALLBACK_TIME_LIMIT], 
                                [MINIMUM_CALL_DURATION], 
                                [EXHAUSTED_CALLS_ENABLED], 
                                [EDGE_DETECT_ENABLED], 
                                [QUICK_DETECT_ENABLED], 
                                [SP_CLOSED_RECORD_ENABLED], 
                                [SP_CLOSED_RECORD_COUNT], 
                                [PERSONALIZED_CALLBACK_ENABLED], 
                                [RELEASE_CALLBACK_ENABLED], 
                                [RESCHEDULE_CALLBACK_MODE], 
                                [IP_TERMINATING_BEEP_DETECT], 
                                [CAMPAIGN_PURPOSE_TYPE], 
                                [IPAMD_ENABLED], 
                                [AMD_TREATMENT_MODE], 
                                [USE_GMT_FROM_REGION_PREFIX], 
                                [CONFIG_PARAM], 
                                [ABANDON_CUSTOMER_CALLBACK], 
                                [ABANDONED_DIALER_CALLBACK], 
                                [CUSTOMER_NOT_HOME_CALLBACK], 
                                [ANSWERING_MACHINE_CALLBACK], 
                                [PREFIX_DIGITS], 
                                [WAIT_FOR_BUSY_RETRY], 
                                [DISABLE_CPA], 
                                [DST_LOCATION], 
                                [ICM_ENABLED]                            )
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
                                        @AbandonEnabled, 
                                        @AbandonPercent, 
                                        @NoAnswerCallback, 
                                        @BusyCallback, 
                                        @NoAnswerRingLimit, 
                                        @MaximumLineAgent, 
                                        @LinesPerAgent, 
                                        @LeaveMessageEnabled, 
                                        @MaximumAttempts, 
                                        @WorkStartHours, 
                                        @WorkStartMinutes, 
                                        @WorkEndHours, 
                                        @WorkEndMinutes, 
                                        @HomeStartHours, 
                                        @HomeStartMinutes, 
                                        @HomeEndHours, 
                                        @HomeEndMinutes, 
                                        @HomeEnabled, 
                                        @WorkEnabled, 
                                        @BusyRetryEnabled, 
                                        @MaximumBusyAttempts, 
                                        @AnswerDetectEnabled, 
                                        @CallbackTimeLimit, 
                                        @MinimumCallDuration, 
                                        @ExhaustedCallsEnabled, 
                                        @EdgeDetectEnabled, 
                                        @QuickDetectEnabled, 
                                        @SPClosedRecordEnabled, 
                                        @SPClosedRecordCount, 
                                        @PersonalizedCallbackEnabled, 
                                        @ReleaseCallbackEnabled, 
                                        @RescheduleCallbackMode, 
                                        @IPTerminatingBeepDetect, 
                                        @CampaignPurposeType, 
                                        @IPAMDEnabled, 
                                        @AMDTreatmentMode, 
                                        @UseGMTFromRegionPrefix, 
                                        @ConfigParam, 
                                        @AbandonCustomerCallback, 
                                        @AbandonedDialerCallback, 
                                        @CustomerNotHomeCallback, 
                                        @AnsweringMachineCallback, 
                                        @PrefixDigits, 
                                        @WaitForBusyRetry, 
                                        @DisableCPA, 
                                        @DSTLocation, 
                                        @ICMEnabled 
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
                            EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, DEFAULT, 13, DEFAULT, @ClusterResourceId, DEFAULT, 'S', 0, 'DIMENSION_ADDED_ON_EQUIPMENT', NULL, NULL, NULL, @AuditUrn OUTPUT;
                
                            IF @InitialTransactionCount = 0 
                            BEGIN 
                                COMMIT TRANSACTION PADD_camPKEYTran;
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
	ON [dbo].[ap_dim01_add_campaign_pkey]
	TO [portalapp_role]
GO
