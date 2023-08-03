SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_add_user]
    (
      @SessionId UNIQUEIDENTIFIER,
      @FolderId UNIQUEIDENTIFIER = NULL,
      @LoginName NVARCHAR(70),
      @PassPhrase NVARCHAR(200) = NULL,
      @Enabled BIT = 1,
      @Description NVARCHAR(500) = NULL,
      @TenantBizUrn INT = -1,
      @EffectiveFrom DATETIME = NULL,
      @EffectiveTo DATETIME = NULL,
      @LocalLoginEnabled BIT = 0,
      @UserId UNIQUEIDENTIFIER = NULL OUTPUT
    )
AS
BEGIN 
    SET NOCOUNT ON;
    
    DECLARE @ReturnCode INT = 0,
        @AuditUrn BIGINT,
        @SessionUserId UNIQUEIDENTIFIER,
        @System BIT = 0,
        @UtcNow DATETIME = DATEADD(ms, -( DATEPART(ms, GETUTCDATE()) ),
                                   GETUTCDATE()),
        @InitialTransactionCount INT = @@TRANCOUNT,
        @deadlockRetry TINYINT = 0,
        @waitDelay CHAR(9),
        @deadlockRetryBegin BIT = 0,
        @ErrorMessage NVARCHAR(2000) = N'',
        @ErrorHolder NVARCHAR(2000),
        @cloudDeployed bit = 0,
        @ownerId UNIQUEIDENTIFIER;
        
    -- Default values    
    IF @UserId IS NULL
    BEGIN 
        SET @UserId = NEWID();
    END;
    
    SELECT  @FolderId = a.folderId,
            @EffectiveFrom = DATEADD(ms, -( DATEPART(ms, a.effectiveFrom) ),
                                     a.effectiveFrom),
            @EffectiveTo = DATEADD(ms, -( DATEPART(ms, a.effectiveTo) ),
                                   a.effectiveTo),
            @Description = a.description
    FROM    ( VALUES
            (
                 -- Default folder is shared
            COALESCE(@FolderId, '00000001-0000-0000-0000-000000000005'),
                 -- Default effective from and to dates
            COALESCE(@EffectiveFrom, @UtcNow), COALESCE(@EffectiveTo,
                                                        '2079-06-06 00:00:00'), COALESCE(@Description,
                                                              '')
                 ) ) a ( folderId, effectiveFrom, effectiveTo, description );

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
                        WHERE   (
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
                        WHERE   (
                                    [LOGIN_NAME] = @LoginName
                                    AND [DELETED] = 0
                                    AND [USER_TYPE] = 'U'
                                ))
            BEGIN 
                SET @ErrorMessage = OBJECT_NAME(@@PROCID);
                RAISERROR (50200, 16, 1, @LoginName, @ErrorMessage, 'Trigger');
            END;
        END             
          
    --Check Session Id
    IF @SessionId IS NOT NULL
        AND EXISTS ( SELECT 1
                     FROM   dbo.TB_ADM_SESSION
                     WHERE  SESSION_ID = @SessionId )
    -- Check folder exists and is not deleted
        AND EXISTS ( SELECT 1
                     FROM   dbo.TB_SEC_FOLDER
                     WHERE  FOLDER_ID = @FolderId
                            AND DELETED = 0 )
    BEGIN 
        -- Set the system flag
        SELECT  @System = CASE st.INTERNAL_NAME
                            WHEN 'ST_INSTALLER' THEN 1
                            ELSE 0
                          END,
                @SessionUserId = u.USER_ID
        FROM    dbo.TB_ADM_SESSION AS s
        JOIN    dbo.TE_ADM_SESSION_TYPE AS st ON st.SESSION_TYPE_ID = s.SESSION_TYPE_ID
        JOIN    dbo.TB_SEC_USER u ON u.LOGIN_NAME = s.SESSION_USER_NAME
        WHERE   s.SESSION_ID = @SessionId; 

        -- Insert the base and derived table in a transaction to ensure an atomic insert.
        BEGIN TRANSACTION addUserTran;
        WHILE @deadlockRetry < 3
        BEGIN 
            SAVE TRANSACTION deadlockSavePoint;
            BEGIN TRY;
                    -- Add the base data
                INSERT  INTO dbo.TB_SEC_USER
                        (
                          [USER_ID],
                          [FOLDER_ID],
                          [OWNER_ID],
                          [HOME_FOLDER_ID],
                          [USER_TYPE],
                          [LOGIN_NAME],
                          [PASS_PHRASE],
                          [DESCRIPTION],
                          [TENANT_BIZ_URN],
                          [ENABLED],
                          [EFFECTIVE_FROM],
                          [EFFECTIVE_TO],
                          [SYSTEM],
                          [CREATED_BY],
                          [LAST_MODIFIED_BY],
                          [LOCAL_LOGIN_ENABLED]
                        )
                VALUES  (
                          @UserId,
                          @FolderId,
                          @ownerId,
                          @FolderId,
                          'U',
                          @LoginName,
                          @PassPhrase,
                          @Description,
                          @TenantBizUrn,
                          @Enabled,
                          @EffectiveFrom,
                          @EffectiveTo,
                          @System,
                          @SessionUserId,
                          @SessionUserId,
                          @LocalLoginEnabled
                        );
        
                    -- Audit success
                EXEC dbo.ap_adm01_audit_event @SessionId,
                    'AT_USER_INSERT_COMMITTED', DEFAULT, DEFAULT, DEFAULT,
                    DEFAULT, DEFAULT, @UserId, DEFAULT, 'S', 0, 'USER_ADDED',
                    NULL, NULL, NULL, @AuditUrn OUTPUT;

                IF @InitialTransactionCount = 0
                BEGIN 
                    COMMIT TRANSACTION addUserTran;
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
            BEGIN CATCH;
                SELECT  @ReturnCode = CASE WHEN @ReturnCode = -2
                                           THEN @ReturnCode
                                           ELSE ERROR_NUMBER()
                                      END,
                        @ErrorHolder = ERROR_MESSAGE();
                IF @ReturnCode = 1205
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
                ELSE
                BEGIN 
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                        + 'An error occured while attempting to update item.'
                        + ISNULL(' SQLMessage[' + @ErrorHolder + '] ', '')
                        + 'SQLError = [%d]';
                    SET @deadlockRetry = 3;
                    BREAK;
                END;
            END CATCH;
        END;
    END;
    ELSE
    BEGIN 
        IF NOT EXISTS ( SELECT  1
                        FROM    dbo.TB_SEC_FOLDER
                        WHERE   FOLDER_ID = @FolderId
                                AND DELETED = 0 )
        BEGIN 
            SET @ReturnCode = 60012;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                + 'Folder not found';
        END;
        ELSE
        BEGIN 
            SET @ReturnCode = 50157;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': '
                + 'The session id is null or does not exist or is a duplicate';
        END;
    END;

    IF @InitialTransactionCount = 0
        AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
   
    IF (
         @ErrorMessage <> ''
         OR @ReturnCode <> 0
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
                    SET @ErrorMessage = ISNULL(@ErrorMessage,
                                               OBJECT_NAME(@@PROCID))
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
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_add_user]
	TO [portalapp_role]
GO
