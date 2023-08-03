SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_release_previous_object_locks] (@SessionId AS UNIQUEIDENTIFIER = NULL) AS
SET NOCOUNT ON;

DECLARE @InitialTransactionCount INT = @@TRANCOUNT, @Error INT = 0, @SessionTypeId UNIQUEIDENTIFIER, @SessionComputer NVARCHAR(50), @ErrorMessage VARCHAR(1000);

BEGIN TRY;

    SELECT @SessionTypeId = SESSION_TYPE_ID, @SessionComputer = SESSION_COMPUTER
    FROM dbo.TB_ADM_SESSION
    WHERE SESSION_ID = @SessionId;

    IF @SessionTypeId IS NOT NULL
    BEGIN 
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

        BEGIN TRANSACTION ReleaseLockTransaction;
        

            DELETE dbo.TB_ADM_OBJECT_LOCK
            FROM dbo.TB_ADM_OBJECT_LOCK AS l
            INNER JOIN dbo.TB_ADM_SESSION AS s ON s.SESSION_ID = l.SESSION_ID
            WHERE s.SESSION_TYPE_ID = @SessionTypeId AND s.SESSION_COMPUTER = @SessionComputer;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION ReleaseLockTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
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
	ON [dbo].[ap_adm01_release_previous_object_locks]
	TO [portalapp_role]
GO
