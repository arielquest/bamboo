SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_prov_increment_table_checksum]
    (
      @ClusterResourceId UNIQUEIDENTIFIER,
      @ImportName NVARCHAR(215),
      @ChecksumIncrement BIGINT
    )
AS
    BEGIN
        SET NOCOUNT, QUOTED_IDENTIFIER ON;
        
    -- Initialise error and transaction handing variables
        DECLARE @ReturnCode INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @deadlockRetry TINYINT = 0,
            @waitDelay CHAR(9),
            @ErrorMessage NVARCHAR(500) = N'',
            @ErrorHolder NVARCHAR(2000);
        
        BEGIN TRANSACTION [ProvIncTransaction];
    
        WHILE @deadlockRetry < 3
        BEGIN 
            SAVE TRANSACTION [deadlockSavePoint];
            BEGIN TRY;
                UPDATE  [dbo].[TB_IMP_TABLE_CHECKSUM]
                SET     [LAST_CHECKSUM] = [LAST_CHECKSUM] + @ChecksumIncrement
                WHERE   [IMPORT_NAME] = @ImportName
                        AND [CLUSTER_RESOURCE_ID] = @ClusterResourceId;
            
                IF @InitialTransactionCount = 0
                BEGIN 
                    COMMIT TRANSACTION [ProvIncTransaction];
                END;
                ELSE
                BEGIN 
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
                SELECT  @ReturnCode = CASE WHEN @ReturnCode NOT IN ( -2, 5000 ) THEN ERROR_NUMBER()
                                           ELSE @ReturnCode
                                      END,
                        @ErrorHolder = ERROR_MESSAGE();
            -- User defined error? if not get from ERROR_NUMBER

                IF @ReturnCode <> 0
                BEGIN 
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': SQL Error = [%d] ' + @ErrorHolder;
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
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': SQL Error = [%d] ' + @ErrorHolder;
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
    
        IF ( @ErrorMessage <> ''
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
            RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
        END;

        RETURN @ReturnCode;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_prov_increment_table_checksum]
	TO [portalapp_role]
GO
