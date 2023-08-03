SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_release_object_lock] (@ObjectLockId AS UNIQUEIDENTIFIER) AS
SET NOCOUNT ON;
DECLARE @InitialTransactionCount INT = @@TRANCOUNT, @Error INT = 0, @ErrorMessage VARCHAR(1000);

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION ReleaseObjectTransaction;


    BEGIN TRY;
        UPDATE dbo.TB_ADM_OBJECT_LOCK
        SET NESTED_LOCK_COUNT = NESTED_LOCK_COUNT - 1
        WHERE OBJECT_LOCK_ID = @ObjectLockId;

        DELETE FROM dbo.TB_ADM_OBJECT_LOCK
        WHERE OBJECT_LOCK_ID = @ObjectLockId AND NESTED_LOCK_COUNT < 0;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION ReleaseObjectTransaction;
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
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_release_object_lock]
	TO [portalapp_role]
GO
