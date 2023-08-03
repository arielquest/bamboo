SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_delete_notify_channel] (@SessionId UNIQUEIDENTIFIER, @ItemUrn INT, @ChangeStamp INT OUTPUT)
AS BEGIN 
    SET NOCOUNT ON;

    DECLARE @ReturnCode AS INT = 0, @ItemBusinessUrn AS INT, @RowCount AS INT, @AuditUrn AS BIGINT, @Deleted AS [BIT], 
    @UtcNow AS DATETIME = DATEADD(ms, - (DATEPART(ms, GETUTCDATE())), GETUTCDATE()), @InitialTransactionCount AS INT = @@TRANCOUNT, 
    @SessionUserId AS UNIQUEIDENTIFIER, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);

    --Check Session Id
    IF @SessionId IS NULL
    BEGIN 
        SET @ReturnCode = 50157;
        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
        'The SessionId can''t be NULL, Error [%d]';
    END;
    ELSE IF NOT EXISTS (SELECT 1
                        FROM [dbo].[TB_ADM_SESSION]
                        WHERE SESSION_ID = @SessionId
                        )
    BEGIN 
        SET @ReturnCode = 50157;
        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
        'The SessionId [%d] doesn''t exist, Error [%d]';
    END;
    -- If item urn is not supplied return
    ELSE IF @ItemUrn IS NOT NULL
    BEGIN 
        -- Retrieve the item information
        SELECT @ItemBusinessUrn = ITEM_BIZ_URN, @Deleted = DELETED
        FROM dbo.TB_DIM_NOTIFY_CHANNEL WITH (UPDLOCK)
        WHERE ITEM_URN = @ItemUrn;

        -- Return if already deleted
        IF @Deleted <> 1
        BEGIN 
            -- Retrieve user information
            SELECT @SessionUserId = USER_ID
            FROM dbo.TB_SEC_USER
            WHERE DELETED = 0 AND LOGIN_NAME = (SELECT SESSION_USER_NAME
                                                FROM dbo.TB_ADM_SESSION
                                                WHERE SESSION_ID = @SessionId
                                                );

            -- Custom pre-commit section. Do not delete the following comments. They are used by external products that integrate with VIM.

            -- #BEGIN CUSTOM PRE_COMMIT

            -- #END CUSTOM PRE_COMMIT

            -- Only continue if the custom pre-commit did not indicate an error
            IF (@ErrorMessage = '' AND @ReturnCode = 0)
            BEGIN
                BEGIN TRANSACTION PDEL_notifychTran;
                    BEGIN TRY;
                        -- Mark the item as deleted
                        UPDATE dbo.TB_DIM_notify_channel
                        SET EFFECTIVE_FROM = CASE WHEN DATEDIFF(mi, EFFECTIVE_FROM, @UtcNow) < 0 THEN @UtcNow ELSE EFFECTIVE_FROM END, 
                        EFFECTIVE_TO = @UtcNow, DELETED = 1, MODIFIED_DATE = @UtcNow, MODIFIED_BY_ID = @SessionUserId, CHANGE_STAMP = CHANGE_STAMP + 1
                        WHERE ITEM_URN = @ItemUrn AND DELETED = 0 AND CHANGE_STAMP = @ChangeStamp;
                            
                        SELECT @RowCount = @@RowCount;

                        -- Concurrency conflict or attempt to delete non deleted record
                        IF @RowCount = 0
                        BEGIN 
                            SET @ReturnCode = - 2;
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                            'Concurrency conflict occured (or attempt to delete already deleted item) whilst deleting item [%d]';
                            RAISERROR (@ErrorMessage, 16, 1, @ItemUrn) WITH LOG;
                        END;
                
                        -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                        SET @ChangeStamp = @ChangeStamp + 1;

                        -- Audit success
                        EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_DELETE_COMMITTED', DEFAULT, @ItemBusinessUrn, DEFAULT, 159, DEFAULT, DEFAULT, DEFAULT, 'S', 0, 'DIMENSION_DELETED', NULL, NULL, NULL, @AuditUrn OUTPUT;

                        IF @InitialTransactionCount = 0 
                        BEGIN 
                            COMMIT TRANSACTION PDEL_notifychTran;
                        END;
                        ELSE BEGIN 
                            WHILE @@TRANCOUNT > @InitialTransactionCount
                            BEGIN 
                                COMMIT TRANSACTION;
                            END;
                        END;
                        SET @ReturnCode = 0;
                    END TRY
                    BEGIN CATCH;
                        SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE @@ERROR END,
                        @ErrorMessage = OBJECT_NAME(@@PROCID)+CASE WHEN @ReturnCode = -2 THEN ': An error occured while attempting to delete item. Error = [%d]' ELSE ERROR_MESSAGE()+', Error [%d]' END;
                    END CATCH;
            END;
        END;
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
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_delete_notify_channel]
	TO [portalapp_role]
GO
