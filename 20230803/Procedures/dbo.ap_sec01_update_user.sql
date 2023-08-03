SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_update_user]
    (
      @SessionId UNIQUEIDENTIFIER,
      @UserId UNIQUEIDENTIFIER,
      @FolderId UNIQUEIDENTIFIER = NULL,
      @LoginName NVARCHAR(70),
      @PassPhrase NVARCHAR(200) = NULL,
      @Description NVARCHAR(500) = NULL,
      @TenantBizUrn INT = -1,
      @EffectiveFrom DATETIME = NULL,
      @EffectiveTo DATETIME = NULL,
      @LocalLoginEnabled BIT = 0,
      @ProvisionableFieldChanged BIT = 0 OUTPUT
    )
AS
SET XACT_ABORT OFF;
SET NOCOUNT ON;
    
DECLARE @ReturnCode INT = 0,
    @RowCount INT = 0,
    @SessionUserId UNIQUEIDENTIFIER,
    @AuditTempOld VARCHAR(500),
    @AuditTempNew VARCHAR(500),
    @OldDescription NVARCHAR(500),
    @OldLoginName NVARCHAR(70),
    @OldUserName NVARCHAR(70),
    @OldDomainName NVARCHAR(255),
    @OldPassPhrase NVARCHAR(200),
    @OldFolderId UNIQUEIDENTIFIER,
    @OldTenantBizUrn INT,
    @OldEffectiveFrom DATETIME,
    @OldEffectiveTo DATETIME,
    @OldLocalLoginEnabled BIT,
    @FieldChanged BIT = 0,
    @UtcNow DATETIME = DATEADD(ms, -( DATEPART(ms, GETUTCDATE()) ),
                               GETUTCDATE()),
    @InitialTransactionCount INT = @@TRANCOUNT,
    @AuditUrn BIGINT,
    @FieldChangeXmlData XML(DOCUMENT dbo.AuditFieldChangeCollection),
    @deadlockRetry TINYINT = 0,
    @waitDelay CHAR(9),
    @deadlockRetryBegin BIT = 0,
    @ErrorMessage NVARCHAR(2000) = N'',
    @ErrorHolder NVARCHAR(500),
    @cloudDeployed BIT = 0,
    @ownerId UNIQUEIDENTIFIER;
    
    -- Default Values
SELECT  @ProvisionableFieldChanged = a.ProvisionableFieldChanged,
        @EffectiveFrom = DATEADD(ms, -( DATEPART(ms, a.effectiveFrom) ),
                                 a.effectiveFrom),
        @EffectiveTo = DATEADD(ms, -( DATEPART(ms, a.effectiveTo) ),
                               a.effectiveTo),
        @Description = a.description
FROM    ( VALUES
        ( 0, --ProvisionableFieldChanged
                 -- Default effective dates and description
        COALESCE(@EffectiveFrom, @UtcNow), COALESCE(@EffectiveTo,
                                                    '2079-06-06 00:00:00'), COALESCE(@Description,
                                                              '')
                 ) ) a ( ProvisionableFieldChanged, effectiveFrom, effectiveTo, description ); -- Create temporary table for audit attributes
DECLARE @AuditAttributeTable TABLE
    (
      ATTRIBUTE_FIELD NVARCHAR(250) NOT NULL,
      OLD_VALUE NVARCHAR(500) NULL,
      NEW_VALUE NVARCHAR(500) NULL
    );
    
    --Check Session Id
IF @SessionId IS NOT NULL
    AND EXISTS ( SELECT 1
                 FROM   dbo.TB_ADM_SESSION
                 WHERE  SESSION_ID = @SessionId )
BEGIN 
        -- Retrieve user information
    SELECT  @SessionUserId = USER_ID
    FROM    dbo.TB_SEC_USER
    WHERE   DELETED = 0
            AND LOGIN_NAME = ( SELECT   SESSION_USER_NAME
                               FROM     dbo.TB_ADM_SESSION
                               WHERE    SESSION_ID = @SessionId
                             );
    
    SELECT @ownerId = [OWNER_ID] 
            FROM TB_SEC_FOLDER 
            WHERE [FOLDER_ID] = @FolderId
            
    SELECT @cloudDeployed = CONVERT(BIT,PROPERTY_VALUE)
            FROM dbo.TB_ADM_PROPERTY
            WHERE PROPERTY_KEY = 'PROP_CLOUD_DEPLOYED';
    
    IF @cloudDeployed = 1
        BEGIN
            IF EXISTS ( SELECT  1
                        FROM    dbo.TB_SEC_USER
                        WHERE   [USER_ID] <> @UserId
                                AND (
                                        [LOGIN_NAME] = @LoginName
                                        AND ((@ownerId IS NOT NULL AND [OWNER_ID] = @ownerId) OR (@ownerId IS NULL AND [OWNER_ID] IS NULL))
                                        AND [DELETED] = 0
                                        AND [USER_TYPE] = 'U'
                                     ))
            BEGIN 
                SET @ErrorMessage = OBJECT_NAME(@@PROCID);
                RAISERROR (50200, 16, 1, @LoginName, @ErrorMessage, 'Trigger');
            END;
        END
        ELSE
        BEGIN
            IF EXISTS ( SELECT  1
                        FROM    dbo.TB_SEC_USER
                        WHERE   [USER_ID] <> @UserId
                                AND   (
                                            [LOGIN_NAME] = @LoginName
                                            AND [DELETED] = 0
                                            AND [USER_TYPE] = 'U'
                                        ))
            BEGIN 
                SET @ErrorMessage = OBJECT_NAME(@@PROCID);
                RAISERROR (50200, 16, 1, @LoginName, @ErrorMessage, 'Trigger');
            END;
        END
        
        -- Save the current state of the record before updating.
    SELECT  @OldDescription = item.[DESCRIPTION],
            @OldLoginName = item.[LOGIN_NAME],
            @OldPassPhrase = item.[PASS_PHRASE],
            @OldEffectiveFrom = item.[EFFECTIVE_FROM],
            @OldEffectiveTo = item.[EFFECTIVE_TO],
            @OldTenantBizUrn = item.[TENANT_BIZ_URN],
            @OldFolderId = item.[FOLDER_ID],
            @OldLocalLoginEnabled = [item].[LOCAL_LOGIN_ENABLED]
    FROM    dbo.TB_SEC_USER item WITH ( UPDLOCK )
    WHERE   item.[USER_ID] = @UserId;    
            
        -- Check for field changes
    IF @LoginName <> @OldLoginName
    BEGIN 
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'LOGIN_NAME',
                  @LoginName,
                  @OldLoginName
                );
    
        SET @FieldChanged = 1;
    END;
        
    IF ISNULL(@PassPhrase, '12345678-9012-3456-7890-123456789012') <> ISNULL(@OldPassPhrase,
                                                              '12345678-9012-3456-7890-123456789012')
    BEGIN 
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'PASS_PHRASE',
                  '',
                  ''
                );
        
        SET @FieldChanged = 1;
    END;

    IF @Description <> @OldDescription
    BEGIN 
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'DESCRIPTION',
                  @Description,
                  @OldDescription
                );

        SET @FieldChanged = 1;
    END;

    IF @FolderId <> @OldFolderId
    BEGIN 
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'FOLDER_ID',
                  @FolderId,
                  @OldFolderId
                );
        
        SET @FieldChanged = 1;
    END;

    IF @TenantBizUrn <> @OldTenantBizUrn
    BEGIN 
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'TENANT_BIZ_URN',
                  @TenantBizUrn,
                  @OldTenantBizUrn
                );
        
        SET @FieldChanged = 1;
        SET @ProvisionableFieldChanged = 1;
    END;
        
    IF @EffectiveFrom <> @OldEffectiveFrom
    BEGIN 
        SET @AuditTempOld = dbo.fn_adm_datetime_to_string(@OldEffectiveFrom);
        SET @AuditTempNew = dbo.fn_adm_datetime_to_string(@EffectiveFrom);
            
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'EFFECTIVE_FROM',
                  @AuditTempNew,
                  @AuditTempOld
                );

        SET @FieldChanged = 1;
    END;

    IF @EffectiveTo <> @OldEffectiveTo
    BEGIN 
        SET @AuditTempOld = dbo.fn_adm_datetime_to_string(@OldEffectiveTo);
        SET @AuditTempNew = dbo.fn_adm_datetime_to_string(@EffectiveTo);
            
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'EFFECTIVE_TO',
                  @AuditTempNew,
                  @AuditTempOld
                );
        
        SET @FieldChanged = 1;
    END;
    
    IF @LocalLoginEnabled <> @OldLocalLoginEnabled
    BEGIN 
        INSERT  INTO @AuditAttributeTable
                (
                  ATTRIBUTE_FIELD,
                  NEW_VALUE,
                  OLD_VALUE
                )
        VALUES  (
                  'LOGIN_NAME',
                  @LocalLoginEnabled,
                  @OldLocalLoginEnabled
                );
    
        SET @FieldChanged = 1;
    END;
        -- If no fields have been changed then exit now
    IF ( @FieldChanged > 0 )
    BEGIN 
        BEGIN TRANSACTION userUpdateTran;
        WHILE @deadlockRetry < 3
        BEGIN 
            SAVE TRANSACTION deadlockSavePoint;
            BEGIN TRY;
    
                -- Update the base table only if the concurrency checks are OK.
                UPDATE  dbo.TB_SEC_USER
                SET     [LOGIN_NAME] = @LoginName,
                        [PASS_PHRASE] = @PassPhrase,
                        [FOLDER_ID] = @FolderId,
                        [DESCRIPTION] = @Description,
                        [EFFECTIVE_FROM] = @EffectiveFrom,
                        [EFFECTIVE_TO] = @EffectiveTo,
                        [TENANT_BIZ_URN] = @TenantBizUrn,
                        [LOCAL_LOGIN_ENABLED] = @LocalLoginEnabled,
                        [LAST_MODIFIED_DATE] = GETUTCDATE(),
                        [LAST_MODIFIED_BY] = @SessionUserId
                WHERE   [USER_ID] = @UserId;
          
                SELECT  @RowCount = @@ROWCOUNT;

                -- Check for concurrency conflict
                IF @RowCount <> 1
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR ('Error raised in TRY block.', 16, 1);
                END;

                -- Audit success
                SET @FieldChangeXmlData =  ( SELECT ATTRIBUTE_FIELD,
                                                    OLD_VALUE,
                                                    NEW_VALUE
                                             FROM   @AuditAttributeTable
                FOR XML RAW,
                        TYPE).query('<FieldChanges>{
                            for $node in /row
                            return 
                            <FieldChange Field="{data($node/@ATTRIBUTE_FIELD)}"><PreviousValue>{data($node/@OLD_VALUE)}</PreviousValue><NewValue>{data($node/@NEW_VALUE)}</NewValue></FieldChange>
                            }</FieldChanges>');

                EXEC dbo.ap_adm01_audit_event @SessionId,
                    'AT_USER_UPDATE_COMMITTED', DEFAULT, DEFAULT, DEFAULT,
                    DEFAULT, DEFAULT, @UserId, DEFAULT, 'S', 0, 'USER_UPDATED',
                    NULL, @FieldChangeXmlData, NULL, @AuditUrn OUTPUT;
    
                IF @InitialTransactionCount = 0
                BEGIN 
                    COMMIT TRANSACTION userUpdateTran;
                END;
                ELSE
                BEGIN 
                    WHILE @@TRANCOUNT > @InitialTransactionCount
                    BEGIN 
                        COMMIT TRANSACTION;
                    END;
                END;
                SET @deadlockRetry = 3;
                BREAK;
            END TRY
            BEGIN CATCH
                SELECT  @ReturnCode = CASE WHEN @ReturnCode = -2
                                           THEN @ReturnCode
                                           ELSE ERROR_NUMBER()
                                      END,
                        @ErrorHolder = ERROR_MESSAGE();
                SELECT  @ErrorMessage = OBJECT_NAME(@@PROCID)
                        + ': Error updating item [%d]. ' + 'SQLError['
                        + @ErrorHolder + ']. ' + 'ErrorCode [%d]';
                IF @ReturnCode = 1205
                BEGIN 
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                            + 'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = 3;
                        BREAK;
                    END;
                    ELSE
                    BEGIN 
                        ROLLBACK TRANSACTION deadlockSavePoint;
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                            + 'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = @deadlockRetry + 1;
                
                                  --Random wait between 50ms and 999ms
                        SELECT  @waitDelay = '0:0:0.' + RIGHT('0'
                                                              + CAST(CASE
                                                              WHEN seed > 949
                                                              THEN 949
                                                              ELSE seed
                                                              END + 50 AS VARCHAR(3)),
                                                              3)
                        FROM    ( SELECT    ABS(CHECKSUM(NEWID()) % 999)
                                ) a ( seed );
                            
                        WAITFOR DELAY @waitDelay;
                        CONTINUE;
                    END;
                END;
                ELSE
                BEGIN 
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                        + 'An error occured while attempting to update item.'
                        + ' SQLMessage[' + @ErrorMessage + ']. '
                        + 'SQLError = [%d]';
                    SET @deadlockRetry = 3;
                    BREAK;
                END;
            END CATCH;
        END;
    END;
END;
ELSE
BEGIN 
    SET @ReturnCode = 50157;
END;  

IF @InitialTransactionCount = 0
    AND @@TRANCOUNT > 0
BEGIN 
    ROLLBACK TRANSACTION;
END;
    
IF NOT (
         @ErrorMessage = ''
         AND @ReturnCode = 0
       )
BEGIN 
    IF @InitialTransactionCount = 0
        AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
    ELSE
        IF @InitialTransactionCount <> 0
            AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF ( XACT_STATE() ) = -1
            BEGIN 
                SET @ErrorMessage = @ErrorMessage
                    + ' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE
            BEGIN 
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
	ON [dbo].[ap_sec01_update_user]
	TO [portalapp_role]
GO
