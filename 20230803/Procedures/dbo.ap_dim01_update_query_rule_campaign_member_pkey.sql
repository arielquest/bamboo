SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_query_rule_campaign_member_pkey]
(
    @SessionId           [UNIQUEIDENTIFIER],
    @PkeyMapUrn          [INTEGER],
    @ChangeStamp         [INTEGER] OUTPUT, -- The row changestamp in our system
    @EffectiveFrom       [DATETIME],
    @EffectiveTo         [DATETIME],
    @SourceChangeStamp   [INTEGER] = -1, -- The changestamp on the remote source
    @XmlData             [XML] = NULL,
    @CustomXmlData       [XML] = NULL, 
    @UpdateCustomXmlData [BIT] = 0,
    @QueryRuleEnabled        [BIT] = NULL,
    @QueryRuleOrder          [INT] = NULL,
    @StartHours              [INT] = NULL,
    @StartMinutes            [INT] = NULL,
    @EndHours                [INT] = NULL,
    @EndMinutes              [INT] = NULL,
    @DurationEnabled         [BIT] = NULL,
    @Duration                [INT] = NULL,
    @HitRateEnabled          [BIT] = NULL,
    @HitRate                 [INT] = NULL,
    @PenetrationEnabled      [BIT] = NULL,
    @Penetration             [INT] = NULL,
    @ForceStatusChange   [BIT] = 0,    -- Indicates that the status should be changed even if none of the pkey fields have been updated. Used when base or derived fields have been changed to force provisioning.
    @Provision           [BIT] = NULL -- Does this change need provisioning if fields have changed?
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ReturnCode                     AS [INTEGER],
            @Status                         AS [CHAR](1),
            @MemberTypeIsProvisionable      AS [BIT],            
            @ClusterResourceIsProvisionable AS [BIT],
            @OldStatus                      AS [CHAR](1),
            @OldEffectiveFrom               AS [DATETIME], 
            @OldEffectiveTo                 AS [DATETIME], 
            @OldXmlData                     AS [XML],
            @OldCustomXmlData               AS [XML],
            @OldSourceChangeStamp           AS [INTEGER], 
            @OldQueryRuleEnabled             [BIT], 
            @OldQueryRuleOrder               [INT], 
            @OldStartHours                   [INT], 
            @OldStartMinutes                 [INT], 
            @OldEndHours                     [INT], 
            @OldEndMinutes                   [INT], 
            @OldDurationEnabled              [BIT], 
            @OldDuration                     [INT], 
            @OldHitRateEnabled               [BIT], 
            @OldHitRate                      [INT], 
            @OldPenetrationEnabled           [BIT], 
            @OldPenetration                  [INT], 
            @FieldsChanged                  AS [BIT] = 0,
            @ProvisionableFieldsChanged     AS [BIT] = 0,
            @AuditTempOld                   AS [VARCHAR](250),
            @AuditTempNew                   AS [VARCHAR](250),
            @RowCount                       AS [INTEGER],
            @UtcNow                         AS [DATETIME] = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
            @SessionSource                  AS [CHAR](1),
            @ClusterResourceId              AS [UNIQUEIDENTIFIER],
            @AuditType                      AS [NVARCHAR](100),
            @ParentItemBusinessUrn          AS [INTEGER],
            @ChildItemBusinessUrn           AS [INTEGER],
            @AuditUrn                       AS [BIGINT],
            @AuditTypeName                  AS [NVARCHAR](50),
            @MemberTypeId                   AS [UNIQUEIDENTIFIER],
            @ClusterResourceTypeId          AS [UNIQUEIDENTIFIER],
            @InitialTransactionCount        AS [INTEGER] = @@TRANCOUNT,
            @FieldChangeXmlData             AS XML(DOCUMENT dbo.AuditFieldChangeCollection),
            @SessionUserId                  AS [UNIQUEIDENTIFIER],
            @ErrorMessage                   AS VARCHAR(1024);
    
    -- Create temporary tables for audit attributes
    DECLARE @AuditAttributeTable TABLE
    (
        ATTRIBUTE_FIELD NVARCHAR(250) NOT NULL,
        OLD_VALUE  NVARCHAR(500) NULL,
        NEW_VALUE NVARCHAR(500) NULL
    );
            
    SET @ReturnCode = 0;
    
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
            RAISERROR(50157, 16, 5, 'ap_dim01_update_query_rule_campaign_member_pkey');
        END;
    
        IF NOT EXISTS(SELECT 1 
                      FROM dbo.TB_ADM_SESSION 
                      WHERE SESSION_ID = @SessionId
                      )
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_update_query_rule_campaign_member_pkey');
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
                        
        -- Check for invalid flag states
        IF @Provision = 0 AND @ForceStatusChange = 1
        BEGIN 
            RAISERROR('ap_dim01_update_dimension_pkey: Cannot force status change on non provisionable update', 16, 1) WITH LOG;
        END;
    
        -- If pkey map urn has not been supplied then exit
        IF @PkeyMapUrn IS NOT NULL
        BEGIN    
            -- Save the current state of the record before updating.
            SET @MemberTypeId = '00000033-1000-0000-0000-0000000000c0';
            SELECT @MemberTypeIsProvisionable = ISNULL((SELECT TOP 1 1 
                                                        FROM dbo.TE_DIM_ITEM_TYPE 
                                                        WHERE ITEM_TYPE_ID IN ('00001600-1000-0000-0000-000000000010', '00006700-1000-0000-0000-000000000010')
                                                        ORDER BY [ITEM_TYPE_ID]
                                                        ), 0);

            SELECT  @OldEffectiveFrom = pm.[EFFECTIVE_FROM],
                    @OldEffectiveTo = pm.[EFFECTIVE_TO],
                    @OldStatus = pm.[STATUS],
                    @OldXmlData = pm.[XML_DATA],
                    @OldCustomXmlData = pm.[CUSTOM_XML_DATA],
                    @OldSourceChangeStamp = pm.[SOURCE_CHANGE_STAMP], 
                    @OldQueryRuleEnabled = pm.[QUERY_RULE_ENABLED], 
                    @OldQueryRuleOrder = pm.[QUERY_RULE_ORDER], 
                    @OldStartHours = pm.[START_HOURS], 
                    @OldStartMinutes = pm.[START_MINUTES], 
                    @OldEndHours = pm.[END_HOURS], 
                    @OldEndMinutes = pm.[END_MINUTES], 
                    @OldDurationEnabled = pm.[DURATION_ENABLED], 
                    @OldDuration = pm.[DURATION], 
                    @OldHitRateEnabled = pm.[HIT_RATE_ENABLED], 
                    @OldHitRate = pm.[HIT_RATE], 
                    @OldPenetrationEnabled = pm.[PENETRATION_ENABLED], 
                    @OldPenetration = pm.[PENETRATION], 
                    @ClusterResourceId = pm.[CLUSTER_RESOURCE_ID],
                    @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                    @ParentItemBusinessUrn = m.PARENT_ITEM_BIZ_URN,
                    @ChildItemBusinessUrn = m.CHILD_ITEM_BIZ_URN,
                    @ClusterResourceTypeId = res.RESOURCE_TYPE_ID
            FROM dbo.TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP AS pm WITH(UPDLOCK)
            INNER JOIN dbo.TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER AS m WITH(READUNCOMMITTED) ON pm.MEMBER_BIZ_URN = m.MEMBER_BIZ_URN AND m.LATEST = 1
            INNER JOIN dbo.TB_CLU_RESOURCE AS res    ON res.RESOURCE_ID =  pm.CLUSTER_RESOURCE_ID
            WHERE pm.PKEY_MAP_URN = @PkeyMapUrn;
            
            -- If source changestamp not specified, then use old value
            IF @SourceChangeStamp = -1
            BEGIN 
                SET @SourceChangeStamp = @OldSourceChangeStamp
            End;

            -- Get Default XML
            IF @XmlData IS NULL AND @ClusterResourceTypeId IS NOT NULL
            BEGIN 
                -- Perform closest lookup first
                SELECT @XmlData = DEFAULT_XML 
                FROM dbo.TB_ADM_XML_DEFAULTS 
                WHERE TABLE_NAME = 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP' 
                AND MEMBER_TYPE_ID = @MemberTypeId AND CUSTOM = 0 
                AND CLUSTER_RESOURCE_TYPE_ID = @ClusterResourceTypeId;

                IF @XmlData IS NULL
                BEGIN 
                    SELECT @XmlData = DEFAULT_XML 
                    FROM dbo.TB_ADM_XML_DEFAULTS 
                    WHERE TABLE_NAME = 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP' 
                    AND MEMBER_TYPE_ID = @MemberTypeId 
                    AND CUSTOM = 0;
                END;
            END;
    
            -- Get Custom Default XML
            IF @CustomXmlData IS NULL AND @ClusterResourceTypeId IS NOT NULL
            BEGIN 
                -- Perform closest lookup first
                SELECT @CustomXmlData = DEFAULT_XML 
                FROM dbo.TB_ADM_XML_DEFAULTS 
                WHERE TABLE_NAME = 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP' 
                AND MEMBER_TYPE_ID = @MemberTypeId 
                AND CUSTOM = 1 
                AND CLUSTER_RESOURCE_TYPE_ID = @ClusterResourceTypeId;

                IF @CustomXmlData IS NULL
                BEGIN 
                    SELECT @CustomXmlData = DEFAULT_XML 
                    FROM dbo.TB_ADM_XML_DEFAULTS 
                    WHERE TABLE_NAME = 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP' 
                    AND MEMBER_TYPE_ID = @MemberTypeId 
                    AND CUSTOM = 1;
                END;
            END;
    
            -- Ignore xml data if specified
            IF (@UpdateCustomXmlData = 0)
            BEGIN 
                SET @CustomXmlData = @OldCustomXmlData;
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
                SET @AuditTempOld = convert(NVARCHAR(250), @OldEffectiveFrom, 126);
                SET @AuditTempNew = convert(NVARCHAR(250), @EffectiveFrom, 126);
        
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('EFFECTIVE_FROM', @AuditTempNew, @AuditTempOld);

                SET @FieldsChanged = 1;
            END;
    
            IF @EffectiveTo <> @OldEffectiveTo
            BEGIN 
                SET @AuditTempOld = convert(NVARCHAR(250), @OldEffectiveTo, 126);
                SET @AuditTempNew = convert(NVARCHAR(250), @EffectiveTo, 126);
        
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('EFFECTIVE_TO', @AuditTempNew, @AuditTempOld);

                SET @FieldsChanged = 1;
            END;
            
            INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            SELECT 
            'QUERY_RULE_CAMPAIGN_MEMBER_' + OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') AS [ATTRIBUTE_FIELD],
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
            'custom.QUERY_RULE_CAMPAIGN_MEMBER_'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
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
 
            IF (@OldQueryRuleEnabled IS NOT NULL AND @QueryRuleEnabled IS NOT NULL AND @OldQueryRuleEnabled <> @QueryRuleEnabled) 
 
            BEGIN  
                SET @AuditTempOld = CASE @OldQueryRuleEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                SET @AuditTempNew = CASE @QueryRuleEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_QUERY_RULE_ENABLED', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldQueryRuleOrder IS NOT NULL AND @QueryRuleOrder IS NOT NULL AND @OldQueryRuleOrder <> @QueryRuleOrder) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldQueryRuleOrder AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@QueryRuleOrder AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_QUERY_RULE_ORDER', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldStartHours IS NOT NULL AND @StartHours IS NOT NULL AND @OldStartHours <> @StartHours) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldStartHours AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@StartHours AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_START_HOURS', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldStartMinutes IS NOT NULL AND @StartMinutes IS NOT NULL AND @OldStartMinutes <> @StartMinutes) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldStartMinutes AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@StartMinutes AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_START_MINUTES', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldEndHours IS NOT NULL AND @EndHours IS NOT NULL AND @OldEndHours <> @EndHours) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldEndHours AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@EndHours AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_END_HOURS', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldEndMinutes IS NOT NULL AND @EndMinutes IS NOT NULL AND @OldEndMinutes <> @EndMinutes) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldEndMinutes AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@EndMinutes AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_END_MINUTES', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldDurationEnabled IS NOT NULL AND @DurationEnabled IS NOT NULL AND @OldDurationEnabled <> @DurationEnabled) 
 
            BEGIN  
                SET @AuditTempOld = CASE @OldDurationEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                SET @AuditTempNew = CASE @DurationEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_DURATION_ENABLED', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldDuration IS NOT NULL AND @Duration IS NOT NULL AND @OldDuration <> @Duration) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldDuration AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@Duration AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_DURATION', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldHitRateEnabled IS NOT NULL AND @HitRateEnabled IS NOT NULL AND @OldHitRateEnabled <> @HitRateEnabled) 
 
            BEGIN  
                SET @AuditTempOld = CASE @OldHitRateEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                SET @AuditTempNew = CASE @HitRateEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_HIT_RATE_ENABLED', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldHitRate IS NOT NULL AND @HitRate IS NOT NULL AND @OldHitRate <> @HitRate) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldHitRate AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@HitRate AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_HIT_RATE', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldPenetrationEnabled IS NOT NULL AND @PenetrationEnabled IS NOT NULL AND @OldPenetrationEnabled <> @PenetrationEnabled) 
 
            BEGIN  
                SET @AuditTempOld = CASE @OldPenetrationEnabled WHEN 1 THEN 'Yes' ELSE 'No' END;
                SET @AuditTempNew = CASE @PenetrationEnabled WHEN 1 THEN 'Yes' ELSE 'No' END; 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_PENETRATION_ENABLED', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldPenetration IS NOT NULL AND @Penetration IS NOT NULL AND @OldPenetration <> @Penetration) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldPenetration AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@Penetration AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('QUERY_RULE_CAMPAIGN_MEMBER_PENETRATION', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            -- Force status change if in error
            IF @OldStatus = 'E'
            BEGIN 
                SET @ForceStatusChange = 1;
            END;
    
            -- If no fields have been changed and we don't have any status changes
            IF ISNULL(@FieldsChanged,1) <> 0 OR ISNULL(@ForceStatusChange,1) <> 0
            BEGIN        
                -- Validate that provisonable change is not being performed on deleted pkey map
                IF @OldStatus IN ('P', 'D') AND @ProvisionableFieldsChanged = 1
                BEGIN 
                    RAISERROR('ap_dim01_update_query_rule_campaign_member_pkey: Cannot perform provisionable update on deleted or deleting pkey map [%d]', 16, 1, @PkeyMapUrn) WITH LOG;
                END;

                -- If this is a provisoning update then update status flag
                IF @Provision = 1 AND @MemberTypeIsProvisionable = 1 AND @ClusterResourceIsProvisionable = 1    
                AND (@ProvisionableFieldsChanged = 1 OR @ForceStatusChange = 1 OR @OldEffectiveFrom > @UtcNow)            
                BEGIN 
                    SET @Status = 'S';
                END;
                ELSE BEGIN 
                    SET @Status = @OldStatus;
                END;

                SET @AuditTypeName = CASE WHEN @Status = 'S' THEN 'AT_MEMBER_UPDATE_REQUESTED_ON_EQUIPMENT' 
                                          ELSE 'AT_MEMBER_UPDATE_COMMITTED_ON_EQUIPMENT' END;
    
                BEGIN TRANSACTION PUPD_queryrulecampaPKEYTran;       
                -- Update the pkey  record
                UPDATE dbo.TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP
                SET [EFFECTIVE_FROM] = @EffectiveFrom,
                    [EFFECTIVE_TO] = @EffectiveTo,
                    [MODIFIED_DATE] = @UtcNow, 
                    [MODIFIED_BY_ID] = @SessionUserId,
                    [XML_DATA] = @XmlData,
                    [CUSTOM_XML_DATA] = @CustomXmlData,
                    [STATUS] = @Status,
                    [SOURCE_CHANGE_STAMP] = @SourceChangeStamp, 
                    [QUERY_RULE_ENABLED] = @QueryRuleEnabled, 
                    [QUERY_RULE_ORDER] = @QueryRuleOrder, 
                    [START_HOURS] = @StartHours, 
                    [START_MINUTES] = @StartMinutes, 
                    [END_HOURS] = @EndHours, 
                    [END_MINUTES] = @EndMinutes, 
                    [DURATION_ENABLED] = @DurationEnabled, 
                    [DURATION] = @Duration, 
                    [HIT_RATE_ENABLED] = @HitRateEnabled, 
                    [HIT_RATE] = @HitRate, 
                    [PENETRATION_ENABLED] = @PenetrationEnabled, 
                    [PENETRATION] = @Penetration, 
                    [CHANGE_STAMP] = [CHANGE_STAMP] + 1
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                AND [CHANGE_STAMP] = @ChangeStamp;
        
                SELECT @ReturnCode = @@ERROR, @RowCount = @@ROWCOUNT;
        
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_dim01_update_query_rule_campaign_member_pkey: Error updating member pkey map [%d], Error [%d] ', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;
        
                -- Check for concurrency conflict
                IF @RowCount <> 1
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR('ap_dim01_update_query_rule_campaign_member_pkey: Concurrency conflict occured whilst attempting to update member pkey map [%d], Error [%d]', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;
        
                -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                SET @ChangeStamp = @ChangeStamp + 1;

                -- Audit success against parent and child
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
                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 13, 81, @ClusterResourceId, NULL, 'S', 0, 
                    'MEMBER_UPDATED_ON_EQUIPMENT', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
            
                IF @InitialTransactionCount = 0 
                BEGIN 
                    COMMIT TRANSACTION PUPD_queryrulecampaPKEYTran;
                END;
                ELSE BEGIN 
                    WHILE @@TRANCOUNT > @InitialTransactionCount
                    BEGIN 
                        COMMIT TRANSACTION;
                    END;
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
	ON [dbo].[ap_dim01_update_query_rule_campaign_member_pkey]
	TO [portalapp_role]
GO
