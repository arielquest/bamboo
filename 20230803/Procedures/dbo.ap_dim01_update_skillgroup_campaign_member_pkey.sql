SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_skillgroup_campaign_member_pkey]
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
    @AbandonedRoutePoint     [NVARCHAR](50) = NULL,
    @AutoAnswerReservationCall  [INT] = NULL,
    @ConfigParam             [NVARCHAR](255) = NULL,
    @Digits                  [NVARCHAR](32) = NULL,
    @IVRPorts                [INT] = NULL,
    @IVRRoutePoint           [NVARCHAR](50) = NULL,
    @OverflowAgents          [INT] = NULL,
    @RecordsToCache          [INT] = NULL,
    @ReservationPercentage   [INT] = NULL,
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
            @OldAbandonedRoutePoint          [NVARCHAR](50), 
            @OldAutoAnswerReservationCall    [INT], 
            @OldConfigParam                  [NVARCHAR](255), 
            @OldDigits                       [NVARCHAR](32), 
            @OldIVRPorts                     [INT], 
            @OldIVRRoutePoint                [NVARCHAR](50), 
            @OldOverflowAgents               [INT], 
            @OldRecordsToCache               [INT], 
            @OldReservationPercentage        [INT], 
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
            RAISERROR(50157, 16, 5, 'ap_dim01_update_skillgroup_campaign_member_pkey');
        END;
    
        IF NOT EXISTS(SELECT 1 
                      FROM dbo.TB_ADM_SESSION 
                      WHERE SESSION_ID = @SessionId
                      )
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_update_skillgroup_campaign_member_pkey');
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
            SET @MemberTypeId = '00000034-1000-0000-0000-0000000000c0';
            SELECT @MemberTypeIsProvisionable = ISNULL((SELECT TOP 1 1 
                                                        FROM dbo.TE_DIM_ITEM_TYPE 
                                                        WHERE ITEM_TYPE_ID IN ('00001600-1000-0000-0000-000000000010', '00007600-1000-0000-0000-000000000010')
                                                        ORDER BY [ITEM_TYPE_ID]
                                                        ), 0);

            SELECT  @OldEffectiveFrom = pm.[EFFECTIVE_FROM],
                    @OldEffectiveTo = pm.[EFFECTIVE_TO],
                    @OldStatus = pm.[STATUS],
                    @OldXmlData = pm.[XML_DATA],
                    @OldCustomXmlData = pm.[CUSTOM_XML_DATA],
                    @OldSourceChangeStamp = pm.[SOURCE_CHANGE_STAMP], 
                    @OldAbandonedRoutePoint = pm.[ABANDONED_ROUTE_POINT], 
                    @OldAutoAnswerReservationCall = pm.[AUTO_ANSWER_RESERVATION_CALL], 
                    @OldConfigParam = pm.[CONFIG_PARAM], 
                    @OldDigits = pm.[DIGITS], 
                    @OldIVRPorts = pm.[IVR_PORTS], 
                    @OldIVRRoutePoint = pm.[IVR_ROUTE_POINT], 
                    @OldOverflowAgents = pm.[OVERFLOW_AGENTS], 
                    @OldRecordsToCache = pm.[RECORDS_TO_CACHE], 
                    @OldReservationPercentage = pm.[RESERVATION_PERCENTAGE], 
                    @ClusterResourceId = pm.[CLUSTER_RESOURCE_ID],
                    @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                    @ParentItemBusinessUrn = m.PARENT_ITEM_BIZ_URN,
                    @ChildItemBusinessUrn = m.CHILD_ITEM_BIZ_URN,
                    @ClusterResourceTypeId = res.RESOURCE_TYPE_ID
            FROM dbo.TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP AS pm WITH(UPDLOCK)
            INNER JOIN dbo.TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER AS m WITH(READUNCOMMITTED) ON pm.MEMBER_BIZ_URN = m.MEMBER_BIZ_URN AND m.LATEST = 1
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
                WHERE TABLE_NAME = 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP' 
                AND MEMBER_TYPE_ID = @MemberTypeId AND CUSTOM = 0 
                AND CLUSTER_RESOURCE_TYPE_ID = @ClusterResourceTypeId;

                IF @XmlData IS NULL
                BEGIN 
                    SELECT @XmlData = DEFAULT_XML 
                    FROM dbo.TB_ADM_XML_DEFAULTS 
                    WHERE TABLE_NAME = 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP' 
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
                WHERE TABLE_NAME = 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP' 
                AND MEMBER_TYPE_ID = @MemberTypeId 
                AND CUSTOM = 1 
                AND CLUSTER_RESOURCE_TYPE_ID = @ClusterResourceTypeId;

                IF @CustomXmlData IS NULL
                BEGIN 
                    SELECT @CustomXmlData = DEFAULT_XML 
                    FROM dbo.TB_ADM_XML_DEFAULTS 
                    WHERE TABLE_NAME = 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP' 
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
            'SKILLGROUP_CAMPAIGN_MEMBER_' + OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') AS [ATTRIBUTE_FIELD],
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
            'custom.SKILLGROUP_CAMPAIGN_MEMBER_'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
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
 
            IF (@OldAbandonedRoutePoint IS NOT NULL AND @AbandonedRoutePoint IS NOT NULL AND @OldAbandonedRoutePoint <> @AbandonedRoutePoint) 
 
            OR (@OldAbandonedRoutePoint IS NULL AND @AbandonedRoutePoint IS NOT NULL)
            OR (@OldAbandonedRoutePoint IS NOT NULL AND @AbandonedRoutePoint IS NULL) 
            BEGIN  
                SET @AuditTempOld = CAST(@OldAbandonedRoutePoint AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@AbandonedRoutePoint AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_ABANDONED_ROUTE_POINT', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldAutoAnswerReservationCall IS NOT NULL AND @AutoAnswerReservationCall IS NOT NULL AND @OldAutoAnswerReservationCall <> @AutoAnswerReservationCall) 
 
            OR (@OldAutoAnswerReservationCall IS NULL AND @AutoAnswerReservationCall IS NOT NULL)
            OR (@OldAutoAnswerReservationCall IS NOT NULL AND @AutoAnswerReservationCall IS NULL) 
            BEGIN  
                SET @AuditTempOld = CAST(@OldAutoAnswerReservationCall AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@AutoAnswerReservationCall AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_AUTO_ANSWER_RESERVATION_CALL', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldConfigParam IS NOT NULL AND @ConfigParam IS NOT NULL AND @OldConfigParam <> @ConfigParam) 
 
            OR (@OldConfigParam IS NULL AND @ConfigParam IS NOT NULL)
            OR (@OldConfigParam IS NOT NULL AND @ConfigParam IS NULL) 
            BEGIN  
                SET @AuditTempOld = CAST(@OldConfigParam AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@ConfigParam AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_CONFIG_PARAM', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldDigits IS NOT NULL AND @Digits IS NOT NULL AND @OldDigits <> @Digits) 
 
            OR (@OldDigits IS NULL AND @Digits IS NOT NULL)
            OR (@OldDigits IS NOT NULL AND @Digits IS NULL) 
            BEGIN  
                SET @AuditTempOld = CAST(@OldDigits AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@Digits AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_DIGITS', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldIVRPorts IS NOT NULL AND @IVRPorts IS NOT NULL AND @OldIVRPorts <> @IVRPorts) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldIVRPorts AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@IVRPorts AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_IVR_PORTS', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldIVRRoutePoint IS NOT NULL AND @IVRRoutePoint IS NOT NULL AND @OldIVRRoutePoint <> @IVRRoutePoint) 
 
            OR (@OldIVRRoutePoint IS NULL AND @IVRRoutePoint IS NOT NULL)
            OR (@OldIVRRoutePoint IS NOT NULL AND @IVRRoutePoint IS NULL) 
            BEGIN  
                SET @AuditTempOld = CAST(@OldIVRRoutePoint AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@IVRRoutePoint AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_IVR_ROUTE_POINT', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldOverflowAgents IS NOT NULL AND @OverflowAgents IS NOT NULL AND @OldOverflowAgents <> @OverflowAgents) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldOverflowAgents AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@OverflowAgents AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_OVERFLOW_AGENTS', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldRecordsToCache IS NOT NULL AND @RecordsToCache IS NOT NULL AND @OldRecordsToCache <> @RecordsToCache) 
 
            BEGIN  
                SET @AuditTempOld = CAST(@OldRecordsToCache AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@RecordsToCache AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_RECORDS_TO_CACHE', @AuditTempNew, @AuditTempOld); 
                SET @FieldsChanged = 1;
                SET @ProvisionableFieldsChanged= 1; 
            END;
            
 
            IF (@OldReservationPercentage IS NOT NULL AND @ReservationPercentage IS NOT NULL AND @OldReservationPercentage <> @ReservationPercentage) 
 
            OR (@OldReservationPercentage IS NULL AND @ReservationPercentage IS NOT NULL)
            OR (@OldReservationPercentage IS NOT NULL AND @ReservationPercentage IS NULL) 
            BEGIN  
                SET @AuditTempOld = CAST(@OldReservationPercentage AS NVARCHAR(250));
                SET @AuditTempNew = CAST(@ReservationPercentage AS NVARCHAR(250)); 
                INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                VALUES('SKILLGROUP_CAMPAIGN_MEMBER_RESERVATION_PERCENTAGE', @AuditTempNew, @AuditTempOld); 
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
                    RAISERROR('ap_dim01_update_skillgroup_campaign_member_pkey: Cannot perform provisionable update on deleted or deleting pkey map [%d]', 16, 1, @PkeyMapUrn) WITH LOG;
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
    
                BEGIN TRANSACTION PUPD_skillgroupcampPKEYTran;       
                -- Update the pkey  record
                UPDATE dbo.TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP
                SET [EFFECTIVE_FROM] = @EffectiveFrom,
                    [EFFECTIVE_TO] = @EffectiveTo,
                    [MODIFIED_DATE] = @UtcNow, 
                    [MODIFIED_BY_ID] = @SessionUserId,
                    [XML_DATA] = @XmlData,
                    [CUSTOM_XML_DATA] = @CustomXmlData,
                    [STATUS] = @Status,
                    [SOURCE_CHANGE_STAMP] = @SourceChangeStamp, 
                    [ABANDONED_ROUTE_POINT] = @AbandonedRoutePoint, 
                    [AUTO_ANSWER_RESERVATION_CALL] = @AutoAnswerReservationCall, 
                    [CONFIG_PARAM] = @ConfigParam, 
                    [DIGITS] = @Digits, 
                    [IVR_PORTS] = @IVRPorts, 
                    [IVR_ROUTE_POINT] = @IVRRoutePoint, 
                    [OVERFLOW_AGENTS] = @OverflowAgents, 
                    [RECORDS_TO_CACHE] = @RecordsToCache, 
                    [RESERVATION_PERCENTAGE] = @ReservationPercentage, 
                    [CHANGE_STAMP] = [CHANGE_STAMP] + 1
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                AND [CHANGE_STAMP] = @ChangeStamp;
        
                SELECT @ReturnCode = @@ERROR, @RowCount = @@ROWCOUNT;
        
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_dim01_update_skillgroup_campaign_member_pkey: Error updating member pkey map [%d], Error [%d] ', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
                END;
        
                -- Check for concurrency conflict
                IF @RowCount <> 1
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR('ap_dim01_update_skillgroup_campaign_member_pkey: Concurrency conflict occured whilst attempting to update member pkey map [%d], Error [%d]', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
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
                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 13, 95, @ClusterResourceId, NULL, 'S', 0, 
                    'MEMBER_UPDATED_ON_EQUIPMENT', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
            
                IF @InitialTransactionCount = 0 
                BEGIN 
                    COMMIT TRANSACTION PUPD_skillgroupcampPKEYTran;
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
	ON [dbo].[ap_dim01_update_skillgroup_campaign_member_pkey]
	TO [portalapp_role]
GO
