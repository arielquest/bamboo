SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_add_code_code_group_member] 
(
    @SessionId UNIQUEIDENTIFIER, 
    @ParentItemBusinessUrn INT,
    @ChildItemBusinessUrn INT,
    @EffectiveFrom DATETIME = NULL,
    @EffectiveTo DATETIME = NULL,
    @XmlData AS XML = NULL,
    @CustomXmlData [XML] = NULL,
    @MemberUrn INT = -1 OUTPUT
)
AS
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT = 0, @AuditUrn BIGINT, @SessionSource CHAR(1),
    @RowCount INT, @UtcNow DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()), 
    @InitialTransactionCount INT = @@TRANCOUNT, @deadlockRetry TINYINT = 0, @waitDelay CHAR(9), @deadlockRetryBegin BIT = 0, 
    @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500),  @SessionUserId UNIQUEIDENTIFIER, @System BIT = 0;

    -- Get Default XML
    IF @XmlData IS NULL
    BEGIN 
        SELECT @XmlData = DEFAULT_XML FROM dbo.TB_ADM_XML_DEFAULTS WHERE TABLE_NAME = 'TB_DIM_CODE_CODE_GROUP_MEMBER' AND MEMBER_TYPE_ID = '00000045-1000-0000-0000-0000000000C0' AND CUSTOM = 0;
    END;
    
    -- Get Custom Default XML
    IF @CustomXmlData IS NULL
    BEGIN 
        SELECT @CustomXmlData = DEFAULT_XML FROM dbo.TB_ADM_XML_DEFAULTS WHERE TABLE_NAME = 'TB_DIM_CODE_CODE_GROUP_MEMBER' AND MEMBER_TYPE_ID = '00000045-1000-0000-0000-0000000000C0' AND CUSTOM = 1;
    END;

    -- Default effective from and to dates    
    SET @EffectiveFrom = COALESCE(@EffectiveFrom, @UtcNow);
    SET @EffectiveFrom = DATEADD(ms, -(DATEPART(ms, @EffectiveFrom)), @EffectiveFrom);
    SET @EffectiveTo = COALESCE(@EffectiveTo, '2079-06-06 00:00:00');
    SET @EffectiveTo = DATEADD(ms, -(DATEPART(ms, @EffectiveTo)), @EffectiveTo);
    
    -- Check Session Id
    IF @SessionId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
    BEGIN 
        -- Set the system flag
        SELECT @System = CASE st.INTERNAL_NAME WHEN 'ST_INSTALLER' THEN 1 ELSE 0 END, @SessionUserId = u.USER_ID 
        FROM dbo.TB_ADM_SESSION AS s
        JOIN dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
        JOIN dbo.TB_SEC_USER u ON u.LOGIN_NAME = s.SESSION_USER_NAME
        WHERE s.SESSION_ID = @SessionId;
    
        IF @ParentItemBusinessUrn IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_DIM_CODE_GROUP WITH (READUNCOMMITTED) WHERE ITEM_BIZ_URN = @ParentItemBusinessUrn)
        BEGIN 
            IF @ChildItemBusinessUrn IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_DIM_CODE WITH (READUNCOMMITTED) WHERE ITEM_BIZ_URN = @ChildItemBusinessUrn)
            BEGIN 
                -- Insert the base and derived table in a transaction to ensure an atomic insert.
                BEGIN TRANSACTION PADD_codecodegroupmeTran;
                    WHILE @deadlockRetry < 3
                    BEGIN 
                        SAVE TRANSACTION deadlockSavePoint;
                        BEGIN TRY;
                            -- Add the base data
                            INSERT INTO dbo.TB_DIM_CODE_CODE_GROUP_MEMBER 
                            (
                             [PARENT_ITEM_BIZ_URN], [CHILD_ITEM_BIZ_URN], [EFFECTIVE_FROM], [EFFECTIVE_TO], [XML_DATA], [SYSTEM], [MODIFIED_BY_ID], [CREATED_BY_ID], [CUSTOM_XML_DATA] 
                            )
                            SELECT TOP 1 @ParentItemBusinessUrn, @ChildItemBusinessUrn, @EffectiveFrom, @EffectiveTo, @XmlData, @System, @SessionUserId, @SessionUserId, @CustomXmlData 
                            WHERE NOT EXISTS (SELECT TOP 1 [MEMBER_URN]
                                              FROM [dbo].[TB_DIM_CODE_CODE_GROUP_MEMBER]
                                              WHERE [DELETED] = 0 AND @EffectiveTo >= [EFFECTIVE_FROM] AND @EffectiveFrom <= [EFFECTIVE_TO]
                                              AND [PARENT_ITEM_BIZ_URN] = @ParentItemBusinessUrn
                                              AND [CHILD_ITEM_BIZ_URN] = @ChildItemBusinessUrn 
                                              ORDER BY [MEMBER_URN]);
        
                            SELECT @RowCount = @@ROWCOUNT, @MemberUrn = SCOPE_IDENTITY();
                            IF @RowCount = 0
                            BEGIN 
                                SET @ReturnCode = -2; --Concurrency conflict
                                RAISERROR ('Error adding membership: ParentItemBusinessUrn [%d] ChildItemBusinessUrn [%d] Error [%d] Message [Concurrency conflict raised in TRY block.]', 16, 1, @ParentItemBusinessUrn, @ChildItemBusinessUrn, @ReturnCode);
                            END;
                            
                            -- Audit success
                            EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_MEMBER_INSERT_COMMITTED', DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 18, 17, DEFAULT, DEFAULT, 'S', 0, 
                            'MEMBER_ADDED', NULL, NULL, NULL, @AuditUrn OUTPUT;

                            IF @InitialTransactionCount = 0 
                            BEGIN 
                                COMMIT TRANSACTION PADD_codecodegroupmeTran;
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
                                   @ErrorHolder = ERROR_MESSAGE();
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
                                ' SQLMessage['+@ErrorHolder+']. '+
                                'SQLError = [%d]';
                                SET @deadlockRetry = 3;
                                BREAK;
                            END;
                        END CATCH;
                    END;
            END;
            ELSE BEGIN 
                SET @ReturnCode = -1;
                SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
                'The specified input child item business urn ' + CHAR(39) + 
                CASE WHEN @ChildItemBusinessUrn IS NULL THEN 'NULL' ELSE CAST(@ChildItemBusinessUrn AS VARCHAR(36)) END
                + CHAR(39) + ' does not exist. Error = [%d]';
            END;
        END;
        ELSE BEGIN 
            SET @ReturnCode = -1;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
            'The specified input parent item business urn ' + CHAR(39) + 
            CASE WHEN @ParentItemBusinessUrn IS NULL THEN 'NULL' ELSE CAST(@ParentItemBusinessUrn AS VARCHAR(36)) END
            + CHAR(39) + ' does not exist. Error = [%d]';
        END;
    END;
    ELSE BEGIN 
        SET @ReturnCode = 50157;
        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
        'The specified session id ' + CHAR(39) + 
        CASE WHEN @SessionId IS NULL THEN 'NULL' ELSE CAST(@SessionId AS VARCHAR(36)) END
        + CHAR(39) + ' is invalid. Error = [%d]';
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
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_add_code_code_group_member]
	TO [portalapp_role]
GO
