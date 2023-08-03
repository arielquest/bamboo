SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_prov_set_member_pkey_map_error]
    (
      @PkeyMapUrn INT,
      @TypeUrn INT,
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
    
    DECLARE @RowCount INT = 0,
        @Sql NVARCHAR(2000);
    
    BEGIN TRANSACTION [ProvErrMemTransaction];
    
    WHILE @deadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION [deadlockSavePoint];
        
        BEGIN TRY;
        
            -- Set member pkey map to error
            SELECT  @Sql = 'UPDATE dbo.' + [TABLE_NAME] + '_PKEY_MAP 
                            SET STATUS = ''E''
                            WHERE PKEY_MAP_URN = @PkeyMapUrn
                            AND CHANGE_STAMP = @ChangeStamp;'
            FROM    [dbo].[TE_DIM_MEMBER_TYPE]
            WHERE   [MEMBER_TYPE_URN] = @TypeUrn;
            
            EXECUTE [sys].[sp_executesql] @Sql, N'@PkeyMapUrn [INT], @ChangeStamp [INT]', @PkeyMapUrn, @ChangeStamp;
                
            SELECT  @RowCount = @@ROWCOUNT;

            -- Check for concurrency conflict
            IF @RowCount <> 1
            BEGIN 
                SET @ReturnCode = -2;
                RAISERROR ('Concurrency exception. RowCount=[%d], PkeyMapUrn=[%d], Type=[%d], ChangeStamp=[%d]', 16, 1, @RowCount, @PkeyMapUrn, @TypeUrn, @ChangeStamp);
            END;
            
            -- Undelete member if needed
            SELECT  @Sql = 'UPDATE dbo.' + [TABLE_NAME] + '
                            SET DELETED = 0, EFFECTIVE_TO = ''2079-06-06 00:00:00''
                            FROM dbo.' + [TABLE_NAME] + ' i
                            JOIN dbo.' + [TABLE_NAME] + '_PKEY_MAP map ON i.MEMBER_BIZ_URN = map.MEMBER_BIZ_URN
                            WHERE PKEY_MAP_URN = @PkeyMapUrn
                            AND i.LATEST = 1
                            AND i.DELETED = 1
                            AND i.EFFECTIVE_TO < GETUTCDATE();'
            FROM    [dbo].[TE_DIM_MEMBER_TYPE]
            WHERE   [MEMBER_TYPE_URN] = @TypeUrn;
            
            EXECUTE [sys].[sp_executesql] @Sql, N'@PkeyMapUrn [INT]', @PkeyMapUrn;
        
            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION [ProvErrMemTransaction];
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
            -- User defined error? if not get from ERROR_NUMBER
            SELECT  @ReturnCode = CASE WHEN @ReturnCode NOT IN ( -2, 5000 ) THEN ERROR_NUMBER()
                                       ELSE @ReturnCode
                                  END,
                    @ErrorMessage = CASE WHEN @ErrorMessage = ''
                                              OR @ErrorMessage IS NULL THEN ERROR_MESSAGE()
                                         ELSE @ErrorMessage
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
                    ROLLBACK TRANSACTION [deadlockSavePoint];
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': SQL Error = [%d] ' + ERROR_MESSAGE();
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
                RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
            END;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_prov_set_member_pkey_map_error]
	TO [portalapp_role]
GO
