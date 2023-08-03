SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_try_acquire_object_lock]
(
    @ObjectName AS NVARCHAR(255),
    @SessionId AS UNIQUEIDENTIFIER = NULL,
    @ObjectLockId AS UNIQUEIDENTIFIER OUTPUT 
) AS 
BEGIN 
    SET NOCOUNT ON;

    DECLARE @InitialTransactionCount INT = @@TRANCOUNT, @Error INT = 0, 
    @ExistingObjectLockId UNIQUEIDENTIFIER, @ExistingSessionId UNIQUEIDENTIFIER, @ErrorMessage VARCHAR(1000);

    --SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    BEGIN TRANSACTION ObjectLockTransaction;
        BEGIN TRY;
            -- Check if the lock already exists
            SELECT @ExistingObjectLockId = OBJECT_LOCK_ID, @ExistingSessionId = SESSION_ID
            FROM dbo.TB_ADM_OBJECT_LOCK WITH(XLOCK)
            WHERE OBJECT_NAME = @ObjectName;

            IF @ExistingObjectLockId IS NOT NULL AND @ExistingSessionId = @SessionId
            -- If the lock is already associated with the current user session then return existing id
            BEGIN 
                SET @ObjectLockId = @ExistingObjectLockId;

                -- Increment nested lock count
                UPDATE dbo.TB_ADM_OBJECT_LOCK
                SET NESTED_LOCK_COUNT = NESTED_LOCK_COUNT + 1
                WHERE OBJECT_LOCK_ID = @ObjectLockId;
            END;
            ELSE IF (@ExistingObjectLockId IS NULL) 
            -- If no lock exists then create one
            BEGIN 
                SET @ObjectLockId = NEWID();
            
                INSERT INTO dbo.TB_ADM_OBJECT_LOCK (OBJECT_LOCK_ID, OBJECT_NAME, LOCKED_AT, SESSION_ID)
                VALUES (@ObjectLockId, @ObjectName, GETUTCDATE(), @SessionId);
            END;

            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION ObjectLockTransaction;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        
        END TRY
        BEGIN CATCH;
            SET @ErrorMessage = ERROR_MESSAGE();
            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ' ['+@ErrorMessage+']';
            IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                IF (XACT_STATE()) = -1
                BEGIN 
                    SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
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
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END CATCH;

    RETURN @Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_try_acquire_object_lock]
	TO [portalapp_role]
GO
