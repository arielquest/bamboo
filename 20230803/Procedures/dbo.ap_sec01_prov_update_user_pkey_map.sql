SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_prov_update_user_pkey_map]
    (
      @SessionId UNIQUEIDENTIFIER,
      @PkeyMapUrn INT OUTPUT,
      @Status CHAR(1) = NULL, -- optional
      @Pkey1 NVARCHAR(50) = NULL,
      @Pkey2 NVARCHAR(50) = NULL,
      @SourceChangeStamp INT = NULL, -- optional
      @Purge BIT = NULL, -- optional
      @ChangeStamp INT
    )
AS
    SET NOCOUNT, QUOTED_IDENTIFIER ON;

-- Initialise error and transaction handing variables
    DECLARE @ReturnCode INT = 0,
        @InitialTransactionCount INT = @@TRANCOUNT,
        @deadlockRetry TINYINT = 0,
        @waitDelay CHAR(9),
        @ErrorMessage NVARCHAR(500) = N'';
    DECLARE @OldStatus CHAR(1),
        @OldPkey1 NVARCHAR(50),
        @OldPkey2 NVARCHAR(50),
        @RowCount INT = 0,
        @Sql NVARCHAR(2000);

    BEGIN TRANSACTION [ProvUpdUserTransaction];

    WHILE @deadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION [deadlockSavePoint];

        BEGIN TRY;
        -- Get current record info        
            SELECT  @OldStatus = CASE WHEN [STATUS] NOT IN ( 'D', 'E' )
                                           AND GETUTCDATE() > [EFFECTIVE_TO] THEN 'P'
                                      ELSE [STATUS]
                                 END,
                    @OldPkey1 = [PKEY1],
                    @OldPkey2 = [PKEY2]
            FROM    [dbo].[TB_SEC_USER_PKEY_MAP]
            WHERE   [PKEY_MAP_URN] = @PkeyMapUrn;

            IF @OldStatus IS NULL
            BEGIN 
                RAISERROR('Failed to retrieve PKEY MAP. PKEY_MAP_URN [%d]', 16, 1, @PkeyMapUrn);
            END;

            IF ( @Status = 'R'
                 AND @OldStatus IN ( 'P', 'D' )
               )
                OR ( @Status = 'D'
                     AND @OldStatus IN ( 'S', 'R' )
                   )
            BEGIN 
                SET @ReturnCode = 5000;
                RAISERROR ('Invalid Status Change. @PkeyMap=%d @OldStatus=%s @NewStatus=%s', 16, 1, @PkeyMapUrn, @OldStatus, @Status);
            END;

        -- Set item pkey map fields
            UPDATE  [dbo].[TB_SEC_USER_PKEY_MAP]
            SET     [STATUS] = CASE WHEN @Status IS NULL THEN [STATUS]
                                  ELSE @Status
                             END,
                    [PKEY1] = @Pkey1,
                    [PKEY2] = @Pkey2,
                    [SOURCE_CHANGE_STAMP] = CASE WHEN @SourceChangeStamp IS NULL THEN [SOURCE_CHANGE_STAMP]
                                               ELSE @SourceChangeStamp
                                          END,
                    [EFFECTIVE_TO] = CASE WHEN @Status IS NOT NULL
                                             AND @Status = 'D' THEN GETUTCDATE()
                                        ELSE [EFFECTIVE_TO]
                                   END,
                    [PURGED] = CASE WHEN @Purge IS NULL THEN [PURGED]
                                  WHEN @Status = 'D'
                                       AND @Pkey1 IS NULL
                                       AND @Pkey2 IS NULL THEN 1
                                  WHEN @Status = 'D' THEN @Purge
                                  ELSE [PURGED]
                             END
            WHERE   [PKEY_MAP_URN] = @PkeyMapUrn
                    AND [CHANGE_STAMP] = @ChangeStamp;

            SELECT  @RowCount = @@ROWCOUNT;

        -- Check for concurrency conflict
            IF @RowCount <> 1
            BEGIN 
                SET @ReturnCode = -2;

                RAISERROR ('Concurrency exception. RowCount=[%d], PkeyMapUrn=[%d], ChangeStamp=[%d]', 16, 1, @RowCount, @PkeyMapUrn, @ChangeStamp);
            END;

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION [ProvUpdUserTransaction];
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
            SELECT  @ReturnCode = CASE WHEN @ReturnCode NOT IN ( -2, 5000 ) THEN ERROR_NUMBER()
                                       ELSE @ReturnCode
                                  END,
                    @ErrorMessage = CASE WHEN @ErrorMessage = ''
                                              OR @ErrorMessage IS NULL THEN ERROR_MESSAGE()
                                         ELSE @ReturnCode
                                    END;

        -- User defined error? if not get from ERROR_NUMBER
            IF @ReturnCode <> 0
            BEGIN 
                IF ( XACT_STATE() ) = -1
                BEGIN 
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': SQL Error = [%d] ' + @ErrorMessage;
                    SET @deadlockRetry = 3;
                    BREAK;
                END;

                IF @ReturnCode = 1205
                BEGIN 
                    ROLLBACK TRANSACTION [deadlockSavePoint];

                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                    SET @deadlockRetry = @deadlockRetry + 1;

                --Random wait between 50ms and 999ms
                    SELECT  @waitDelay = '0:0:0.' + RIGHT('0' + CAST(CASE WHEN [a].[seed] > 949 THEN 949
                                                                          ELSE [a].[seed]
                                                                     END + 50 AS VARCHAR(3)), 3)
                    FROM    ( SELECT    ABS(CHECKSUM(NEWID()) % 999)
                            ) [a] ( [seed] );

                    WAITFOR DELAY @waitDelay;

                    CONTINUE;
                END;
                ELSE
                BEGIN 
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': SQL Error = [%d] ' + @ErrorMessage;
                    SET @deadlockRetry = 3;

                    BREAK;
                END;
            END;
        END CATCH;
    END;

    IF @InitialTransactionCount = 0
        AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK;
    END;

    IF @ErrorMessage = ''
        AND @ReturnCode = 0
    BEGIN 
        RETURN @ReturnCode;
    END;
    ELSE
    BEGIN 
        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE
        BEGIN 
            IF @InitialTransactionCount <> 0
                AND @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                IF ( XACT_STATE() ) = -1
                BEGIN 
                    SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';

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

                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));

            END;
        END;
        RAISERROR (@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_prov_update_user_pkey_map]
	TO [portalapp_role]
GO
