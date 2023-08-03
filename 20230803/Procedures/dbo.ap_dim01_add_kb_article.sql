SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_add_kb_article]
(
    @SessionId          UNIQUEIDENTIFIER, 
    @Name               NVARCHAR(255),
    @Description        NVARCHAR(500) = NULL,
    @FolderId           UNIQUEIDENTIFIER = NULL,
    @OwnerId            UNIQUEIDENTIFIER = NULL,
    @ItemSubTypeId      UNIQUEIDENTIFIER = NULL, 
    @EffectiveFrom      DATETIME = NULL,
    @EffectiveTo        DATETIME = NULL,
    @XmlData            XML = NULL,
    @CustomXmlData      XML = NULL,
    @TimeZoneUrn        INT = NULL,
    @TenantBizUrn       INT = NULL,
    @HierarchyParentUrn INT = NULL,
    @ArticleCreationCultureUrn  [INT] = -1,
    @ArticleCommitState      [SMALLINT] = 1,
    @ArticlePublishState     [CHAR](1) = '^',
    @ArticleOwnerAgentBizUrn  [INT] = -1,
    @ArticleCreatedByAgentBizUrn  [INT] = NULL,
    @ArticleLastModifiedByAgentBizUrn  [INT] = -1,
    @ArticleCreationDateTime  [DATETIME] = '1900-01-01',
    @ArticleLastModifiedDateTime  [DATETIME] = '1900-01-01',
    @ArticleVersion          [INT] = -1,
    @ArticleAvailableFrom    [DATETIME] = '1900-01-01',
    @ArticleExpiresOn        [DATETIME] = '9999-12-31 23:59:59.997',
    @KBFolderBizUrn          [INT] = -1,
    @ItemUrn            INT = -1 OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT = 0, @AuditUrn BIGINT, @SessionUserId UNIQUEIDENTIFIER, 
    @System BIT = 0, @UtcNow DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
    @InitialTransactionCount INT = @@TRANCOUNT, @deadlockRetry TINYINT = 0, @waitDelay CHAR(9), 
    @deadlockRetryBegin BIT = 0, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(2000);
        
    SELECT  @TimeZoneUrn = a.timeZoneUrn, @TenantBizUrn = a.tenantBizUrn, @FolderId = a.folderId, @ItemSubTypeId = a.itemSubTypeId, 
    @EffectiveFrom = DATEADD(ms, -(DATEPART(ms, a.effectiveFrom)), a.effectiveFrom),
    @EffectiveTo = DATEADD(ms, -(DATEPART(ms, a.effectiveTo)), a.effectiveTo),
    @CustomXmlData = COALESCE(@CustomXmlData,c.DEFAULT_XML), @Description = a.description,
    @XmlData = COALESCE(@XmlData,b.DEFAULT_XML)
    FROM (VALUES(-- Default the fields 
                 COALESCE(@TimeZoneUrn, 2),  COALESCE(@TenantBizUrn, -1), 
                 -- Default folder is shared
                 COALESCE(@FolderId, '00000001-0000-0000-0000-000000000005'),
                 -- Default sub type is NONE
                 COALESCE(@ItemSubTypeId, '00000000-0000-0000-0000-000000000010'),
                 -- Default effective from and to dates
                 COALESCE(@EffectiveFrom, @UtcNow), COALESCE(@EffectiveTo, '2079-06-06 00:00:00'),
                 COALESCE(@Description, '')
                 )
          ) a(timeZoneUrn, tenantBizUrn, folderId, itemSubTypeId, effectiveFrom, effectiveTo, description)
    OUTER APPLY (SELECT TOP 1 
                 DEFAULT_XML 
                 FROM [dbo].[TB_ADM_XML_DEFAULTS] 
                 WHERE TABLE_NAME = 'TB_DIM_KB_ARTICLE' AND ITEM_TYPE_ID = 'E349B610-402F-4A1A-B555-BA26ABDC6F30' AND CUSTOM = 0
                 ORDER BY [XML_DEFAULTS_URN]) b
    OUTER APPLY (SELECT TOP 1 
                 DEFAULT_XML 
                 FROM [dbo].[TB_ADM_XML_DEFAULTS] 
                 WHERE TABLE_NAME = 'TB_DIM_KB_ARTICLE' AND ITEM_TYPE_ID = 'E349B610-402F-4A1A-B555-BA26ABDC6F30' AND CUSTOM = 1
                 ORDER BY [XML_DEFAULTS_URN]) c;

    --Check Session Id
    IF @SessionId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
    -- Check folder exists and is not deleted
    AND EXISTS(SELECT 1 FROM dbo.TB_SEC_FOLDER WHERE FOLDER_ID = @FolderId AND DELETED = 0) 
    BEGIN 
        -- Set the system flag
        SELECT @System = CASE st.INTERNAL_NAME WHEN 'ST_INSTALLER' THEN 1 ELSE 0 END, @SessionUserId = u.USER_ID 
        FROM dbo.TB_ADM_SESSION AS s
        JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
        JOIN dbo.TB_SEC_USER u ON u.LOGIN_NAME = s.SESSION_USER_NAME
        WHERE s.SESSION_ID = @SessionId; 

        -- Custom pre-commit section. Do not delete the following comments. They are used by external products that integrate with VIM.

        -- #BEGIN CUSTOM PRE_COMMIT

        -- #END CUSTOM PRE_COMMIT

        -- Only continue if the custom pre-commit did not indicate an error
        IF (@ErrorMessage = '' AND @ReturnCode = 0)
        BEGIN
            -- Insert the base and derived table in a transaction to ensure an atomic insert.
            BEGIN TRANSACTION PADD_kbarTran;
                WHILE @deadlockRetry < 3
                BEGIN 
                    SAVE TRANSACTION deadlockSavePoint;
                    BEGIN TRY;
                        -- Add the base data
                        INSERT INTO dbo.TB_DIM_KB_ARTICLE
                        (
                         [FOLDER_ID], [OWNER_ID], [ITEM_SUBTYPE_ID], [NAME], [DESCRIPTION], [EFFECTIVE_FROM], [EFFECTIVE_TO], [SYSTEM],
                         [XML_DATA], [TIME_ZONE_URN], [TENANT_BIZ_URN], [HIERARCHY_PARENT_URN], [CUSTOM_XML_DATA], [CREATED_BY_ID], [MODIFIED_BY_ID]
                       , [ARTICLE_CREATION_CULTURE_URN]
                       , [ARTICLE_COMMIT_STATE]
                       , [ARTICLE_PUBLISH_STATE]
                       , [ARTICLE_OWNER_AGENT_BIZ_URN]
                       , [ARTICLE_CREATED_BY_AGENT_BIZ_URN]
                       , [ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN]
                       , [ARTICLE_CREATION_DATE_TIME]
                       , [ARTICLE_LAST_MODIFIED_DATE_TIME]
                       , [ARTICLE_VERSION]
                       , [ARTICLE_AVAILABLE_FROM]
                       , [ARTICLE_EXPIRES_ON]
                       , [KB_FOLDER_BIZ_URN]
                        )
                        VALUES (@FolderId, @OwnerId, @ItemSubTypeId, @Name, @Description, @EffectiveFrom, @EffectiveTo, @System,
                        @XmlData, @TimeZoneUrn, @TenantBizUrn, @HierarchyParentUrn, @CustomXmlData, @SessionUserId, @SessionUserId
                         , @ArticleCreationCultureUrn
                         , @ArticleCommitState
                         , @ArticlePublishState
                         , @ArticleOwnerAgentBizUrn
                         , @ArticleCreatedByAgentBizUrn
                         , @ArticleLastModifiedByAgentBizUrn
                         , @ArticleCreationDateTime
                         , @ArticleLastModifiedDateTime
                         , @ArticleVersion
                         , @ArticleAvailableFrom
                         , @ArticleExpiresOn
                         , @KBFolderBizUrn
                        );

                        SELECT @ItemUrn = SCOPE_IDENTITY();
            
                        -- Audit success
                        EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_INSERT_COMMITTED', DEFAULT, @ItemUrn, DEFAULT, 123, DEFAULT, DEFAULT, DEFAULT, 'S', 0, 'DIMENSION_ADDED', NULL, NULL, NULL, @AuditUrn OUTPUT;

                        IF @InitialTransactionCount = 0 
                        BEGIN 
                            COMMIT TRANSACTION PADD_kbarTran;
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
                   BEGIN CATCH;
                       SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
                              @ErrorHolder = CASE WHEN @ErrorHolder IS NULL THEN ERROR_MESSAGE() ELSE @ErrorHolder END;
                       IF @ReturnCode = 1205 
                       BEGIN 
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
                     ELSE BEGIN 
                           SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                           'An error occured while attempting to update item.'+
                           ISNULL(' SQLMessage['+@ErrorHolder+'] ','')+
                           'SQLError = [%d]';
                           SET @deadlockRetry = 3;
                           BREAK;
                       END;
                   END CATCH;
                END;
            END;
    END;
    ELSE BEGIN 
        IF NOT EXISTS(SELECT 1 FROM dbo.TB_SEC_FOLDER WHERE FOLDER_ID = @FolderId AND DELETED = 0)
        BEGIN 
            SET @ReturnCode = 60012;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+'Folder not found';
        END; 
        ELSE BEGIN 
            SET @ReturnCode = 50157;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+'The session id is null or does not exist or is a duplicate';
        END;
    END;

    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
   
    IF (@ErrorMessage <> '' OR @ReturnCode <> 0)
    BEGIN 
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
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;

    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_add_kb_article]
	TO [portalapp_role]
GO
