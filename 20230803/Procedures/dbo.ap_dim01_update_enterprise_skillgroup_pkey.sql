SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_enterprise_skillgroup_pkey]
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
                    RAISERROR('ap_dim01_update_enterprise_skillgroup_pkey: Cannot force status change on non provisionable update', 16, 1) WITH LOG
                END;
                ELSE BEGIN 
                    -- If pkey map urn has not been supplied then exit
                    IF @PkeyMapUrn IS NOT NULL
                    BEGIN 
                        -- Save the current state of the record before updating.
                        SET @ItemTypeId = '00003400-1000-0000-0000-000000000010';
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
                                @ItemBusinessUrn = item.[ITEM_BIZ_URN],
                                @ClusterResourceId = map.[CLUSTER_RESOURCE_ID],
                                @ClusterResourceIsProvisionable = res.PROVISIONABLE,
                                @ClusterTypeId = res.RESOURCE_TYPE_ID
                        FROM dbo.TB_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP AS map WITH(UPDLOCK)
                        INNER JOIN dbo.TB_DIM_ENTERPRISE_SKILLGROUP AS item WITH(READUNCOMMITTED) ON map.ITEM_BIZ_URN = item.ITEM_BIZ_URN AND item.LATEST = 1
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
                                  WHERE TABLE_NAME = 'TB_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP' 
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
                                      WHERE TABLE_NAME = 'TB_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP' 
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
                        'ENTERPRISE_SKILLGROUP_' + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],
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
                        'custom.ENTERPRISE_SKILLGROUP_'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
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
                            VALUES('ENTERPRISE_SKILLGROUP_INTERNAL_NAME', @AuditTempNew, @AuditTempOld);
 

                            SET @FieldsChanged = 1;
                            SET @ProvisionableFieldsChanged= 1;
 
                        END; 
                        IF (@OldDescription IS NOT NULL AND @Description IS NOT NULL AND @OldDescription COLLATE Latin1_General_CS_AS <> @Description COLLATE Latin1_General_CS_AS)  
                        BEGIN  
                            SET @AuditTempOld = CAST(@OldDescription AS NVARCHAR(250));
                            SET @AuditTempNew = CAST(@Description AS NVARCHAR(250)); 

                            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                            VALUES('ENTERPRISE_SKILLGROUP_DESCRIPTION', @AuditTempNew, @AuditTempOld);
 

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

                            BEGIN TRANSACTION PUPD_enterpriseskilPKEYTran;
                            BEGIN TRY;
                                -- Update the pkey record
                                UPDATE dbo.TB_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP
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
                                EXEC dbo.ap_adm01_audit_event @SessionId, @AuditTypeName, DEFAULT, @ItemBusinessUrn, NULL, 42, DEFAULT, @ClusterResourceId, NULL, 'S', 0, 'DIMENSION_UPDATED_ON_EQUIPMENT', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
                                
                                IF @InitialTransactionCount = 0 
                                BEGIN 
                                    COMMIT TRANSACTION PUPD_enterpriseskilPKEYTran;
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
	ON [dbo].[ap_dim01_update_enterprise_skillgroup_pkey]
	TO [portalapp_role]
GO
