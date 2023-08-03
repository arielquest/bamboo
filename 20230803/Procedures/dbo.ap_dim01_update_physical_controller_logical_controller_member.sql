SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_update_physical_controller_logical_controller_member] 
(
    @SessionId UNIQUEIDENTIFIER,
    @MemberUrn INT OUTPUT,
    @ChangeStamp INT OUTPUT,
    @ParentItemBusinessUrn INT = NULL,
    @ChildItemBusinessUrn INT = NULL,
    @EffectiveFrom DATETIME = NULL,
    @EffectiveTo DATETIME = NULL,
    @XmlData XML = NULL, 
    @CustomXmlData XML = NULL,
    @UpdateCustomXmlData BIT = 0,
    @ProvisionableFieldChanged BIT = 0 OUTPUT)
AS
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    DECLARE @ReturnCode INT = 0, @RowCount INT, @AuditTempOld VARCHAR(500), @AuditTempNew VARCHAR(500),
    @MemberBusinessUrn INT, @OldMemberUrn INT, @OldParentItemBusinessUrn INT, @OldChildItemBusinessUrn INT,
    @OldEffectiveFrom DATETIME, @OldEffectiveTo DATETIME, @OldXmlData XML, @OldCustomXmlData AS XML,  
    @KeyFieldChanged BIT = 0, @FieldChanged BIT = 0,
    @AuditUrn BIGINT, @HasAttributes BIT, @DoType2 BIT = 0, @UtcNow DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
    @InitialTransactionCount INT = @@TRANCOUNT, @FieldChangeXmlData XML(DOCUMENT dbo.AuditFieldChangeCollection),
    @deadlockRetry TINYINT = 0, @waitDelay CHAR(9), @deadlockRetryBegin BIT = 0, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500),  @SessionUserId [UNIQUEIDENTIFIER];

    SET @ProvisionableFieldChanged = 0;
            
    -- Get Default XML
    IF @XmlData IS NULL
    BEGIN 
        SELECT @XmlData = DEFAULT_XML 
        FROM dbo.TB_ADM_XML_DEFAULTS 
        WHERE TABLE_NAME = 'TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER' AND MEMBER_TYPE_ID = '0000000B-1000-0000-0000-0000000000C0' AND CUSTOM = 0;
    END;
           
    -- Get Custom Default XML
    IF @CustomXmlData IS NULL
    BEGIN 
        SELECT @CustomXmlData = DEFAULT_XML 
        FROM dbo.TB_ADM_XML_DEFAULTS 
        WHERE TABLE_NAME = 'TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER' AND MEMBER_TYPE_ID = '0000000B-1000-0000-0000-0000000000C0' AND CUSTOM = 1;
    END;

    -- Default effective dates
    SET @EffectiveFrom = COALESCE(@EffectiveFrom, @UtcNow);
    SET @EffectiveFrom = DATEADD(ms, -(DATEPART(ms, @EffectiveFrom)), @EffectiveFrom);
    SET @EffectiveTo = COALESCE(@EffectiveTo, '2079-06-06 00:00:00');
    SET @EffectiveTo = DATEADD(ms, -(DATEPART(ms, @EffectiveTo)), @EffectiveTo);
    
    -- Create temporary table for audit attributes
    DECLARE @AuditAttributeTable TABLE (ATTRIBUTE_FIELD NVARCHAR(250) NOT NULL, OLD_VALUE NVARCHAR(500) NULL, 
    NEW_VALUE NVARCHAR(500) NULL);

    -- Check Session Id
    IF @SessionId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
    BEGIN 
        -- Retrieve user information
        SELECT @SessionUserId = USER_ID 
        FROM dbo.TB_SEC_USER
        WHERE DELETED = 0
        AND LOGIN_NAME = (SELECT SESSION_USER_NAME FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId);
             
        -- Save the current state of the record before we update it.
        SELECT @MemberBusinessUrn = member.[MEMBER_BIZ_URN], @OldEffectiveFrom = member.[EFFECTIVE_FROM], 
        @OldEffectiveTo = member.[EFFECTIVE_TO], @OldCustomXmlData = member.[CUSTOM_XML_DATA],         @OldXmlData = member.[XML_DATA], @OldMemberUrn = member.[MEMBER_URN], @OldParentItemBusinessUrn = member.[PARENT_ITEM_BIZ_URN],
        @OldChildItemBusinessUrn = member.[CHILD_ITEM_BIZ_URN]
        FROM dbo.TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER member
        WHERE member.[MEMBER_URN] = @MemberUrn;
    
        -- Default parent and child URNs to existing values
        SET @ParentItemBusinessUrn = COALESCE(@ParentItemBusinessUrn, @OldParentItemBusinessUrn);
        SET @ChildItemBusinessUrn = COALESCE(@ChildItemBusinessUrn, @OldChildItemBusinessUrn);
    
        -- Ignore xml data if specified
        IF (@UpdateCustomXmlData = 0)
        BEGIN 
            SET @CustomXmlData = @OldCustomXmlData;
        END;
        
        IF EXISTS(SELECT 1 FROM dbo.TB_DIM_LOGICAL_INTERFACE_CONTROLLER WITH (READUNCOMMITTED) WHERE ITEM_BIZ_URN = @ParentItemBusinessUrn)
        BEGIN 
            IF EXISTS(SELECT 1 FROM dbo.TB_DIM_PHYSICAL_INTERFACE_CONTROLLER WITH (READUNCOMMITTED) WHERE ITEM_BIZ_URN = @ChildItemBusinessUrn)
            BEGIN 
                IF @ParentItemBusinessUrn <> @OldParentItemBusinessUrn
                BEGIN 
                    SET @KeyFieldChanged = 1;
                    -- Parent change should trigger a type 2
                    SET @DoType2 = 1;
                END;
                IF @ChildItemBusinessUrn <> @OldChildItemBusinessUrn
                BEGIN 
                    SET @KeyFieldChanged = 1;
                    -- Child change should trigger a type 2
                    SET @DoType2 = 1;
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
    
                INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                SELECT 'PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_' + OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') AS [ATTRIBUTE_FIELD],
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
                    SET @FieldChanged = 1;
                    SET @ProvisionableFieldChanged= 1;
                END;
                
                INSERT INTO @AuditAttributeTable(ATTRIBUTE_FIELD, NEW_VALUE, OLD_VALUE)
                SELECT 
                'custom.PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_'  + CASE WHEN OldAttributes.Attribute IS NULL THEN NewAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') ELSE OldAttributes.Attribute.value('string(@Name)', 'NVARCHAR(250)') END AS [ATTRIBUTE_FIELD],        
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

                -- If no fields have been changed then exit now
                IF @KeyFieldChanged <> 0 OR @FieldChanged <> 0
                BEGIN 
                    -- Update the tables
                    BEGIN TRANSACTION PUPD_physicalcontrolTran;
                        WHILE @deadlockRetry < 3
                        BEGIN 
                            SAVE TRANSACTION deadlockSavePoint;
                            BEGIN TRY;
                                -- Do we need to perform a type 2 operation before updating the record?
                                IF @DoType2 = 1
                                BEGIN 
                                    EXEC @ReturnCode = dbo.ap_dim01_do_type2_physical_controller_logical_controller_member @SessionId, @MemberUrn OUT, @MemberBusinessUrn OUT, @ChangeStamp, DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 1;
                                    IF @ReturnCode <> 0
                                    BEGIN 
                                        RAISERROR ('ap_dim01_do_type2_physical_controller_logical_controller_member returned [%d] Error raised in TRY block.', 16, 1, @ReturnCode);
                                    END;
                                    IF @OldMemberUrn <> @MemberUrn
                                    BEGIN 
                                        SET @ChangeStamp = 0;
                                    END;
                                END;
                                -- We may have just changed the parent/child. In this case don't perform an update
                                IF @FieldChanged = 1 OR @FieldChanged = 1
                                BEGIN 
                                    UPDATE dbo.TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER
                                    SET [EFFECTIVE_TO] = @EffectiveTo,
                                    [EFFECTIVE_FROM] = CASE WHEN @OldMemberUrn <> @MemberUrn THEN [EFFECTIVE_FROM] ELSE @EffectiveFrom END,
                                    [MODIFIED_DATE] = GETUTCDATE(), [MODIFIED_BY_ID] = @SessionUserId, [CHANGE_STAMP] = [CHANGE_STAMP] + 1,
                                    [XML_DATA] = @XmlData, [CUSTOM_XML_DATA] = @CustomXmlData, [PARENT_ITEM_BIZ_URN] = @ParentItemBusinessUrn, [CHILD_ITEM_BIZ_URN] = @ChildItemBusinessUrn
                                    WHERE [MEMBER_URN] = @MemberUrn AND [CHANGE_STAMP] = @ChangeStamp;

                                    SELECT @RowCount = @@ROWCOUNT;

                                    -- Check for concurrency conflict
                                    IF @RowCount <> 1
                                    BEGIN 
                                        SET @ReturnCode = -2;
                                        RAISERROR ('Error updating membership: MemberUrn [%d] Error [%d] Message [Concurrency conflict raised in TRY block.]', 16, 1, @MemberUrn, @ReturnCode);
                                    END;
                                    
                                    -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                                    SET @ChangeStamp = @ChangeStamp + 1;
                                END;
                                ELSE BEGIN 
                                    IF @InitialTransactionCount = 0 
                                    BEGIN 
                                        COMMIT TRANSACTION PUPD_physicalcontrolTran;
                                    END;
                                    ELSE BEGIN 
                                        WHILE @@TRANCOUNT > @InitialTransactionCount
                                        BEGIN 
                                            COMMIT TRANSACTION;
                                        END;
                                    END;
                                    SET @deadlockRetry = 3;
                                    BREAK;
                                END;

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
    
                                EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_MEMBER_UPDATE_COMMITTED', DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 64, 75, DEFAULT, DEFAULT, 'S', 0, 'MEMBER_UPDATED', NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
                            
                                IF @InitialTransactionCount = 0 
                                BEGIN 
                                    COMMIT TRANSACTION PUPD_physicalcontrolTran;
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
                                SELECT @ErrorMessage = OBJECT_NAME(@@PROCID)+': Error updating item pkey map [%d]. '+
                                                      'SQLError['+@ErrorHolder+']. '+
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
                                    ISNULL(' SQLMessage['+@ErrorMessage+']',' ')+
                                    'SQLError = [%d]';
                                    SET @deadlockRetry = 3;
                                    BREAK;
                                END;
                            END CATCH;
                        END;
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
        ROLLBACK;
    END;
    
    IF NOT (@ErrorMessage = '' AND @ReturnCode = 0)
    BEGIN 
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END
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
	ON [dbo].[ap_dim01_update_physical_controller_logical_controller_member]
	TO [portalapp_role]
GO
