SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_prov_update_dimension_pkey_map]
    (
      @SessionId UNIQUEIDENTIFIER,
      @PkeyMapUrn INT OUTPUT,
      @TypeUrn INT,
      @Status CHAR(1) = NULL, -- optional
      @Pkey1 NVARCHAR(MAX) = NULL,
      @Pkey2 NVARCHAR(50) = NULL,
      @SourceChangeStamp INT = NULL, -- optional
      @Purge BIT = NULL, -- optional
      @ChangeStamp INT,
      @ForceType1 BIT = 0
    )
AS
    BEGIN
        SET NOCOUNT, QUOTED_IDENTIFIER ON;

        -- Initialise error and transaction handing variables
        DECLARE @ReturnCode INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @deadlockRetry TINYINT = 0,
            @waitDelay CHAR(9),
            @ErrorMessage NVARCHAR(500) = N'';
        DECLARE @OldStatus CHAR(1),
            @OldPkey1 NVARCHAR(MAX),
            @OldPkey2 NVARCHAR(50),
            @RowCount INT = 0,
            @Sql NVARCHAR(2000);

        BEGIN TRANSACTION;

        WHILE @deadlockRetry < 3
        BEGIN
            SAVE TRANSACTION [deadlockSavePoint];

            BEGIN TRY;
                -- Get current record info        
                SELECT  @Sql = 'SELECT @OldStatus = CASE WHEN STATUS NOT IN (''D'', ''E'') AND GETUTCDATE() > EFFECTIVE_TO THEN ''P'' ELSE STATUS END,
                                   @OldPkey1 = PKEY1,
                                   @OldPkey2 = PKEY2
                            FROM dbo.' + [TABLE_NAME] + '_PKEY_MAP
                            WHERE PKEY_MAP_URN = @PkeyMapUrn;'
                FROM    [dbo].[TE_DIM_ITEM_TYPE]
                WHERE   [ITEM_TYPE_URN] = @TypeUrn;

                EXECUTE [sys].[sp_executesql] @Sql, N'@PkeyMapUrn INT, @OldStatus CHAR(1) OUTPUT, @OldPkey1 NVARCHAR(50) OUTPUT, @OldPkey2 NVARCHAR(50) OUTPUT',
                    @PkeyMapUrn = @PkeyMapUrn, @OldStatus = @OldStatus OUTPUT, @OldPkey1 = @OldPkey1 OUTPUT, @OldPkey2 = @OldPkey2 OUTPUT;

                IF @OldStatus IS NULL
                BEGIN
                    RAISERROR ('Failed to retrieve PKEY MAP. PKEY_MAP_URN [%d] TYPE [%d]', 16, 1, @PkeyMapUrn, @TypeUrn);
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

                -- Type 2 on pkey change
                IF @ForceType1 = 0
                    AND ( @OldPkey1 IS NOT NULL
                          AND @Pkey1 <> @OldPkey1
                        )
                    OR ( @OldPkey2 IS NOT NULL
                         AND @Pkey2 <> @OldPkey2
                       )
                BEGIN
                    DECLARE @UtcNow DATETIME;

                    SET @UtcNow = GETUTCDATE();

                    EXEC [dbo].[ap_dim01_do_type2_item_pkey_map] @SessionId = @SessionId, @PkeyMapUrn = @PkeyMapUrn OUTPUT, @ItemTypeUrn = @TypeUrn,
                        @ChangeStamp = @ChangeStamp, @EffectiveFrom = @UtcNow, @IgnoreConsolidationPeriod = 1, @MaintainBusinessKey = 1;
            
                    SET @ChangeStamp = 0;
                END;

                -- Set item pkey map fields
                SELECT  @Sql = 'UPDATE dbo.' + [TABLE_NAME] + '_PKEY_MAP
                            SET STATUS = CASE 
                                            WHEN @Status IS NULL THEN STATUS
                                            ELSE @Status
                                          END, 
                                PKEY1 = @Pkey1, 
                                PKEY2 = @Pkey2, 
                                SOURCE_CHANGE_STAMP = CASE 
                                                        WHEN @SourceChangeStamp IS NULL THEN SOURCE_CHANGE_STAMP
                                                        ELSE @SourceChangeStamp
                                                      END,
                                EFFECTIVE_TO = CASE 
                                                WHEN @Status IS NOT NULL AND @Status = ''D'' THEN GETUTCDATE() 
                                                ELSE EFFECTIVE_TO
                                               END,
                                PURGED = CASE 
                                            WHEN @Purge IS NULL THEN PURGED
                                            WHEN @Status = ''D'' AND @Pkey1 IS NULL AND @Pkey2 IS NULL THEN 1
                                            WHEN @Status = ''D'' THEN @Purge
                                            ELSE PURGED
                                         END
                            WHERE PKEY_MAP_URN = @PkeyMapUrn
                            AND CHANGE_STAMP = @ChangeStamp;'
                FROM    [dbo].[TE_DIM_ITEM_TYPE]
                WHERE   [ITEM_TYPE_URN] = @TypeUrn;

                EXECUTE [sys].[sp_executesql] @Sql,
                    N'@PkeyMapUrn INT, @Status CHAR(1), @Pkey1 NVARCHAR(MAX), @Pkey2 NVARCHAR(50), @SourceChangeStamp INT, @Purge BIT, @ChangeStamp INT',
                    @PkeyMapUrn, @Status, @Pkey1, @Pkey2, @SourceChangeStamp, @Purge, @ChangeStamp;

                SELECT  @RowCount = @@ROWCOUNT;

                -- Check for concurrency conflict
                IF @RowCount <> 1
                BEGIN
                    SET @ReturnCode = -2;

                    RAISERROR ('Concurrency exception. RowCount=[%d], PkeyMapUrn=[%d], Type=[%d], ChangeStamp=[%d]', 16, 1, @RowCount, @PkeyMapUrn, @TypeUrn, @ChangeStamp);
                END;

                IF @InitialTransactionCount = 0
                BEGIN
                    COMMIT TRANSACTION;
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
                        @ErrorMessage = ERROR_MESSAGE();

                -- Can't insert duplicate key!
                IF @ReturnCode = 2601
                BEGIN
                    -- DuplicateItemEquipmentMapping
                    SET @ReturnCode = 50504;
                    ROLLBACK TRANSACTION [ProvUpdMemTransaction];
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': SQL Error = [2601] ' + ERROR_MESSAGE();
                    SET @deadlockRetry = 3;
                    BREAK;
                END;
                ELSE
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

                            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': A deadlock occurred and this transaction was the deadlock-victim. Error = [%d]';
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

        IF ISNULL(@ErrorMessage, '3B5E4323-0B77-42C8-B01C-CF0F284B8E29') <> ''
            OR @ReturnCode <> 0
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
            -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
            DECLARE @transactionFake INT = @@TRANCOUNT;

            WHILE @transactionFake < @InitialTransactionCount
            BEGIN
                BEGIN TRANSACTION;
                SET @transactionFake = @transactionFake + 1;
            END;
            IF @ReturnCode = 50504
            BEGIN
                RAISERROR(@ReturnCode, 16, 1, @ErrorMessage) WITH LOG;
            END;
            ELSE
            BEGIN
                RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
            END;
        END;
        RETURN @ReturnCode;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_prov_update_dimension_pkey_map]
	TO [portalapp_role]
GO
