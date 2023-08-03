SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_fileshare]
(
    @SessionId                 UNIQUEIDENTIFIER, 
    @ItemUrn                   INT OUTPUT,
    @ChangeStamp               INT OUTPUT, 
    @FolderId                  UNIQUEIDENTIFIER,
    @OwnerId                   UNIQUEIDENTIFIER = NULL,
    @Name                      NVARCHAR(100),
    @Description               NVARCHAR(500) = NULL,
    @EffectiveFrom             DATETIME = NULL, 
    @EffectiveTo               DATETIME = NULL, 
    @XmlData                   XML = NULL, 
    @CustomXmlData             XML = NULL,
    @UpdateCustomXmlData       BIT = 0,
    @TimeZoneUrn               INT = NULL, 
    @TenantBizUrn              INT = NULL, 
    @HierarchyParentUrn        INT = NULL, 
    @InternalName                    [NVARCHAR](100) = NULL, 
    @UncDirectoryPath                [NVARCHAR](450) = NULL, 
    @UserName                        [NVARCHAR](70) = NULL, 
    @PassPhrase                      [VARBINARY](100) = NULL, 
    @ProvisionableFieldChanged    BIT = 0 OUTPUT,    
    @ItemBusinessUrn            INT = NULL OUTPUT
)
AS
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    
    DECLARE @ReturnCode INT = 0, @RowCount INT = 0, @SessionUserId UNIQUEIDENTIFIER, @AuditTempOld VARCHAR(500),
    @AuditTempNew VARCHAR(500), @OldItemBusinessUrn INT, @OldItemUrn INT,  @OldDescription NVARCHAR(500), @OldTimeZoneUrn INT, @OldTenantBizUrn INT,
    @OldName NVARCHAR(100), @OldOwnerId UNIQUEIDENTIFIER, @OldFolderId UNIQUEIDENTIFIER, @OldEffectiveFrom DATETIME, @OldEffectiveTo DATETIME, 
    @OldXmlData XML, @OldCustomXmlData XML, @OldHierarchyParentUrn INT, 
    @OldInternalName                 [NVARCHAR](100),
    @OldUncDirectoryPath             [NVARCHAR](450),
    @OldUserName                     [NVARCHAR](70),
    @OldPassPhrase                   [VARBINARY](100),
    @FieldChanged BIT = 0, @UtcNow DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
    @DoOwnershipType2 BIT = 0, @DoStandardType2 BIT = 0, @IgnoreConsolidationPeriod BIT = 0, 
    @InitialTransactionCount INT = @@TRANCOUNT, @AuditUrn BIGINT, @FieldChangeXmlData XML(DOCUMENT dbo.AuditFieldChangeCollection),
    @deadlockRetry TINYINT = 0, @waitDelay CHAR(9), @deadlockRetryBegin BIT = 0, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);
            
    SELECT @ProvisionableFieldChanged = a.ProvisionableFieldChanged, 
    @EffectiveFrom = DATEADD(ms, -(DATEPART(ms, a.effectiveFrom)), a.effectiveFrom),
    @EffectiveTo = DATEADD(ms, -(DATEPART(ms, a.effectiveTo)), a.effectiveTo),
    @CustomXmlData = COALESCE(@CustomXmlData,c.DEFAULT_XML), 
    @XmlData = COALESCE(@XmlData, b.DEFAULT_XML),
    @Description = a.description
    FROM (VALUES(0, --ProvisionableFieldChanged
                 -- Default effective dates and description
                 COALESCE(@EffectiveFrom, @UtcNow), COALESCE(@EffectiveTo, '2079-06-06 00:00:00'),
                 COALESCE(@Description, '')
                 )
         ) a(ProvisionableFieldChanged,effectiveFrom,effectiveTo,description)
    OUTER APPLY (SELECT TOP 1 
                 DEFAULT_XML 
                 FROM dbo.TB_ADM_XML_DEFAULTS 
                 WHERE TABLE_NAME = 'TB_DIM_FILESHARE' AND ITEM_TYPE_ID = '00002700-1000-0000-0000-000000000010' AND CUSTOM = 0
                 ORDER BY [XML_DEFAULTS_URN]) b
    OUTER APPLY (SELECT TOP 1 
                 DEFAULT_XML 
                 FROM dbo.TB_ADM_XML_DEFAULTS 
                 WHERE TABLE_NAME = 'TB_DIM_FILESHARE' AND ITEM_TYPE_ID = '00002700-1000-0000-0000-000000000010' AND CUSTOM = 1
                 ORDER BY [XML_DEFAULTS_URN]) c;

    -- Create temporary table for audit attributes
    DECLARE @AuditAttributeTable TABLE
    (
        ATTRIBUTE_FIELD NVARCHAR(250) NOT NULL,
        OLD_VALUE  NVARCHAR(500) NULL,
        NEW_VALUE NVARCHAR(500) NULL
    );
    
    --Check Session Id
    IF @SessionId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId) 
    BEGIN 
        -- Retrieve user information
        SELECT @SessionUserId = USER_ID 
        FROM dbo.TB_SEC_USER
        WHERE DELETED = 0
        AND LOGIN_NAME = (SELECT SESSION_USER_NAME FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId);

        -- Save the current state of the record before updating.
        SELECT @ItemBusinessUrn = item.[ITEM_BIZ_URN], @OldItemBusinessUrn = item.[ITEM_BIZ_URN],  @OldDescription = item.[DESCRIPTION],
        @OldItemUrn = item.[ITEM_URN], @OldName = item.[NAME], @OldOwnerId = item.[OWNER_ID], @OldEffectiveFrom = item.[EFFECTIVE_FROM],
        @OldEffectiveTo = item.[EFFECTIVE_TO], @OldHierarchyParentUrn = item.[HIERARCHY_PARENT_URN], @OldTimeZoneUrn = item.[TIME_ZONE_URN],
        @OldTenantBizUrn = item.[TENANT_BIZ_URN], @OldXmlData = item.[XML_DATA], @OldCustomXmlData = item.[CUSTOM_XML_DATA],  
        @OldInternalName = item.[INTERNAL_NAME], 
        @OldUncDirectoryPath = item.[UNC_DIRECTORY_PATH], 
        @OldUserName = item.[USER_NAME], 
        @OldPassPhrase = item.[PASS_PHRASE], 
        @OldFolderId = item.[FOLDER_ID]
        FROM dbo.TB_DIM_FILESHARE item WITH(UPDLOCK)
        WHERE item.[ITEM_URN] = @ItemUrn;
    
        -- If Time Zone not specified, then default to current value
        IF @TimeZoneUrn IS NULL
        BEGIN 
            SET @TimeZoneUrn = @OldTimeZoneUrn;
        END;
        
        -- If Tenant Biz Urn not specified, then default to current value
        IF @TenantBizUrn IS NULL
        BEGIN 
            SET @TenantBizUrn = @OldTenantBizUrn;
        END;

        -- Ignore xml data if specified
        IF (@UpdateCustomXmlData = 0)
        BEGIN 
            SET @CustomXmlData = @OldCustomXmlData;
        END;
        
        -- Check for field changes
        IF ISNULL(@Name,'12345678-9012-3456-7890-123456789012') COLLATE Latin1_General_CS_AS <> ISNULL(@OldName,'12345678-9012-3456-7890-123456789012') COLLATE Latin1_General_CS_AS
        BEGIN 
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('NAME', @Name, @OldName);
    
            SET @FieldChanged = 1;
        END;

        IF @Description COLLATE Latin1_General_CS_AS <> @OldDescription COLLATE Latin1_General_CS_AS 
        BEGIN 
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('DESCRIPTION', @Description, @OldDescription);

            SET @FieldChanged = 1;
        END;

        IF ISNULL(@OwnerId,'12345678-9012-3456-7890-123456789012') <> ISNULL(@OldOwnerId,'12345678-9012-3456-7890-123456789012')
        BEGIN 
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('OWNER_ID', @OwnerId, @OldOwnerId);

            SET @FieldChanged = 1;
        
            -- Ensures placeholder dimensions are not type 2'd
            IF @OldOwnerId IS NOT NULL
            BEGIN 
                SET @DoOwnershipType2 = 1
            END;
        END;
    
        IF @FolderId <> @OldFolderId
        BEGIN 
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('FOLDER_ID', @FolderId, @OldFolderId);
        
            SET @FieldChanged = 1;
        END;

        IF @EffectiveFrom <> @OldEffectiveFrom
        BEGIN 
            SET @AuditTempOld = dbo.fn_adm_datetime_to_string(@OldEffectiveFrom);
            SET @AuditTempNew = dbo.fn_adm_datetime_to_string(@EffectiveFrom);
            
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('EFFECTIVE_FROM', @AuditTempNew, @AuditTempOld);

            SET @FieldChanged = 1;
        END;

        IF @EffectiveTo <> @OldEffectiveTo
        BEGIN 
            SET @AuditTempOld = dbo.fn_adm_datetime_to_string(@OldEffectiveTo);
            SET @AuditTempNew = dbo.fn_adm_datetime_to_string(@EffectiveTo);
            
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('EFFECTIVE_TO', @AuditTempNew, @AuditTempOld);
        
            SET @FieldChanged = 1;
        END;

        IF @TimeZoneUrn <> @OldTimeZoneUrn
        BEGIN 
            SELECT @AuditTempOld = STANDARD_NAME FROM dbo.TE_ADM_TIME_ZONE WHERE TIME_ZONE_URN = @OldTimeZoneUrn;
            SELECT @AuditTempNew = STANDARD_NAME FROM dbo.TE_ADM_TIME_ZONE WHERE TIME_ZONE_URN = @TimeZoneUrn;
            
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('TIME_ZONE_URN', @AuditTempNew, @AuditTempOld);
        
            SET @FieldChanged = 1;
        END;
        
        IF @TenantBizUrn <> @OldTenantBizUrn
        BEGIN 
            SELECT @AuditTempOld = NAME FROM dbo.TB_DIM_TENANT WHERE ITEM_BIZ_URN = @OldTenantBizUrn AND LATEST = 1;
            SELECT @AuditTempNew = NAME FROM dbo.TB_DIM_TENANT WHERE ITEM_BIZ_URN = @TenantBizUrn AND LATEST = 1;
            
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('TENANT_BIZ_URN', @AuditTempNew, @AuditTempOld);
        
            SET @FieldChanged = 1;

            IF @OldTenantBizUrn <> -1
            BEGIN 
                SET @DoOwnershipType2 = 1;
            END;
        END;

        IF ISNULL(CAST(@HierarchyParentUrn AS VARCHAR(10)),'NULL') <> 
           ISNULL(CAST(@OldHierarchyParentUrn AS VARCHAR(10)),'NULL')
        BEGIN 
            SET @AuditTempOld = @OldHierarchyParentUrn;
            SET @AuditTempNew = @HierarchyParentUrn;
            
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('HIERARCHY_PARENT', @AuditTempNew, @AuditTempOld);
        
            SET @DoStandardType2 = 1;
            SET @FieldChanged = 1;
        END;
    
        INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
        SELECT 
        'FILESHARE_' + OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') AS [ATTRIBUTE_FIELD],        
        SUBSTRING(CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)), 1, 500) AS [NEW_VALUE],
        SUBSTRING(CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX)), 1, 500) AS [OLD_VALUE]
        FROM @OldXmlData.nodes('Columns/Column') AS OldAttributes(Attribute)
        FULL OUTER JOIN @XmlData.nodes('Columns/Column') AS NewAttributes(Attribute)
        ON OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') = NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)')
        WHERE OldAttributes.Attribute.value('string(@DataType)', 'NVARCHAR(50)') <> 'Xml'
        AND (CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) <> CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX))
        OR ((CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) IS NULL AND CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) IS NOT NULL)
        OR ((CAST(NewAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) IS NOT NULL AND CAST(OldAttributes.Attribute.query('text()') AS NVARCHAR(MAX)) IS NULL))));
            
        IF @@ROWCOUNT > 0
        BEGIN 
            SET @FieldChanged = 1;
            SET @ProvisionableFieldChanged= 1;
        END;
    
        INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
        SELECT 
        'custom.'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
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
            SET @FieldChanged = 1;
        END;

        IF (@OldInternalName IS NOT NULL AND @InternalName IS NOT NULL AND @OldInternalName <> @InternalName) 
        BEGIN      
            SET @AuditTempOld = CAST(@OldInternalName AS NVARCHAR(250));
            SET @AuditTempNew = CAST(@InternalName AS NVARCHAR(250));
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('FILESHARE_INTERNAL_NAME', @AuditTempNew, @AuditTempOld);
            SET @FieldChanged = 1;
            SET @ProvisionableFieldChanged= 1;
        END;
            
        IF (@OldUncDirectoryPath IS NOT NULL AND @UncDirectoryPath IS NOT NULL AND @OldUncDirectoryPath <> @UncDirectoryPath) 
        BEGIN      
            SET @AuditTempOld = CAST(@OldUncDirectoryPath AS NVARCHAR(250));
            SET @AuditTempNew = CAST(@UncDirectoryPath AS NVARCHAR(250));
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('FILESHARE_UNC_DIRECTORY_PATH', @AuditTempNew, @AuditTempOld);
            SET @FieldChanged = 1;
            SET @ProvisionableFieldChanged= 1;
        END;
            
        IF (@OldUserName IS NOT NULL AND @UserName IS NOT NULL AND @OldUserName <> @UserName) 
        OR (@OldUserName IS NULL AND @UserName IS NOT NULL)
        OR (@OldUserName IS NOT NULL AND @UserName IS NULL)
        BEGIN      
            SET @AuditTempOld = CAST(@OldUserName AS NVARCHAR(250));
            SET @AuditTempNew = CAST(@UserName AS NVARCHAR(250));
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('FILESHARE_USER_NAME', @AuditTempNew, @AuditTempOld);
            SET @FieldChanged = 1;
            SET @ProvisionableFieldChanged= 1;
        END;
            
        IF (@OldPassPhrase IS NOT NULL AND @PassPhrase IS NOT NULL AND @OldPassPhrase <> @PassPhrase) 
        OR (@OldPassPhrase IS NULL AND @PassPhrase IS NOT NULL)
        OR (@OldPassPhrase IS NOT NULL AND @PassPhrase IS NULL)
        BEGIN      
            SET @AuditTempOld = CAST(@OldPassPhrase AS NVARCHAR(250));
            SET @AuditTempNew = CAST(@PassPhrase AS NVARCHAR(250));
            INSERT INTO @AuditAttributeTable (ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
            VALUES('FILESHARE_PASS_PHRASE', NULL, NULL);
            SET @FieldChanged = 1;
            SET @ProvisionableFieldChanged= 1;
        END;
            
        
        -- Apply historical branching setting
        IF @DoOwnershipType2 = 1
        BEGIN 
            SELECT @DoOwnershipType2 = CAST(CASE LOWER(PROPERTY_VALUE) WHEN 'true' THEN 1 ELSE 0 END AS BIT) FROM [dbo].[TB_ADM_PROPERTY] WHERE PROPERTY_KEY = 'PROP_ENABLE_HISTORICAL_BRANCHING_ON_MOVE';
        END;

        -- Custom pre-commit section. Do not delete the following comments. They are used by external products that integrate with VIM.

        -- #BEGIN CUSTOM PRE_COMMIT

        -- #END CUSTOM PRE_COMMIT

        -- Only continue if fields have been changed and the custom pre-commit did not indicate an error
        IF (@ErrorMessage = '' AND @ReturnCode = 0 AND @FieldChanged > 0)
        BEGIN 
            BEGIN TRANSACTION PUPD_fileTran;
                WHILE @deadlockRetry < 3
                BEGIN 
                    SAVE TRANSACTION deadlockSavePoint;
                    BEGIN TRY;
                        -- If base or derived fields have changed then update tables
                        IF @DoOwnershipType2 = 1 OR @DoStandardType2 = 1
                        BEGIN 
                            IF @DoOwnershipType2 = 1
                            BEGIN 
                                EXEC @ReturnCode = dbo.ap_dim01_do_type2_fileshare @SessionId, @ItemUrn OUT, @ItemBusinessUrn OUT, @ChangeStamp, DEFAULT, 1, 0;
                                IF @ReturnCode <> 0
                                BEGIN 
                                    RAISERROR ('ap_dim01_do_type2_fileshare returned [%d] in TRY block.', 16, 1, @ReturnCode);
                                END;
                            END;
                            ELSE BEGIN               
                                EXEC @ReturnCode = dbo.ap_dim01_do_type2_fileshare @SessionId, @ItemUrn OUT, @ItemBusinessUrn OUT, @ChangeStamp, DEFAULT, @IgnoreConsolidationPeriod, 1;
                                IF @ReturnCode <> 0
                                BEGIN 
                                    RAISERROR ('ap_dim01_do_type2_fileshare returned [%d] in TRY block.', 16, 1, @ReturnCode);
                                END;       
                            END;
            
                            IF @OldItemUrn <> @ItemUrn
                            BEGIN 
                                SET @ChangeStamp = 0;
                            END;
                        END;           
    
                        -- Update the base table only if the concurrency checks are OK.
                        UPDATE dbo.TB_DIM_FILESHARE
                        SET [NAME] = @Name, [OWNER_ID] = @OwnerId, [FOLDER_ID] = @FolderId, [DESCRIPTION] = @Description,
                        [EFFECTIVE_FROM] = CASE WHEN @OldItemUrn <> @ItemUrn THEN [EFFECTIVE_FROM] ELSE @EffectiveFrom END,
                        [EFFECTIVE_TO] = @EffectiveTo, [MODIFIED_DATE] = GETUTCDATE(), [MODIFIED_BY_ID] = @SessionUserId, [CHANGE_STAMP] = [CHANGE_STAMP] + 1,
                        [XML_DATA] = @XmlData, [HIERARCHY_PARENT_URN] = @HierarchyParentUrn, [TIME_ZONE_URN] = @TimeZoneUrn, [TENANT_BIZ_URN] = @TenantBizUrn, 
                        [CUSTOM_XML_DATA] = @CustomXmlData
,[INTERNAL_NAME] = @InternalName        
,[UNC_DIRECTORY_PATH] = @UncDirectoryPath        
,[USER_NAME] = @UserName        
,[PASS_PHRASE] = @PassPhrase        
                        WHERE [ITEM_URN] = @ItemUrn AND [CHANGE_STAMP] = @ChangeStamp;
          
                        SELECT @RowCount = @@ROWCOUNT;

                        -- Check for concurrency conflict
                        IF @RowCount <> 1
                        BEGIN 
                            SET @ReturnCode = -2;
                            RAISERROR ('Error updating dimension: ItemUrn [%d] Error [%d] Message [Concurrency conflict raised in TRY block.]', 16, 1, @ItemUrn, @ReturnCode);
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

                        EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_UPDATE_COMMITTED', DEFAULT, @ItemBusinessUrn, DEFAULT, 44, DEFAULT, DEFAULT, DEFAULT, 'S', 0, 'DIMENSION_UPDATED', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
    
                        IF @InitialTransactionCount = 0 
                        BEGIN 
                            COMMIT TRANSACTION PUPD_fileTran;
                        END;
                        ELSE BEGIN 
                            WHILE @@TRANCOUNT > @InitialTransactionCount
                            BEGIN 
                                COMMIT TRANSACTION;
                            END;
                        END;
                        SET @deadlockRetry = 3;
                        SET @ReturnCode = 0;
                        BREAK;
                    END TRY
                    BEGIN CATCH
                        SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
                                @ErrorHolder = ERROR_MESSAGE();
                        SELECT @ErrorMessage = OBJECT_NAME(@@PROCID)+': Error updating item pkey map [%d]. '+
                                            'SQLError['+ @ErrorHolder +']. '+
                                            'ErrorCode [%d]';
                        IF @ReturnCode = 1205 
                        BEGIN 
                            IF (XACT_STATE()) = -1
                            BEGIN 
                                SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                                'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                                SET @deadlockRetry = 3;
                                BREAK;
                            END;
                            ELSE BEGIN 
                                ROLLBACK TRANSACTION deadlockSavePoint;
                                SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
                                'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                                SET @deadlockRetry = @deadlockRetry + 1;
                
                                --Random wait between 50ms and 999ms
                                SELECT @waitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                                FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);
                            
                                WAITFOR DELAY @waitDelay;
                                CONTINUE;
                            END;
                        END;
                        ELSE BEGIN 
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                            'An error occured while attempting to update item.'+
                            ' SQLMessage['+@ErrorMessage+']. '+
                            'SQLError = [%d]';
                            SET @deadlockRetry = 3;
                            BREAK;
                        END;
                    END CATCH;
                END;
        END;
    END; 
    ELSE BEGIN 
        SET @ReturnCode = 50157;
        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+'The session id is null or does not exist or is a duplicate';
    END;  

    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
    
    IF NOT (@ErrorMessage = '' AND @ReturnCode = 0)
    BEGIN 
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
    END;
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_update_fileshare]
	TO [portalapp_role]
GO
