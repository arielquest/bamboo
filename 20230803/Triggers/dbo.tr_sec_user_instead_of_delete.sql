SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER tr_sec_user_instead_of_delete ON dbo.TB_SEC_USER INSTEAD OF DELETE NOT FOR REPLICATION AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    DECLARE @ErrorMessage AS NVARCHAR(500), @ErrorCode AS [INTEGER], @InitialTransactionCount AS INT = @@TRANCOUNT;

    BEGIN TRANSACTION TrSecUsrTran;

    -- Delete the group memberships for the users being deleted
    DELETE dbo.TB_SEC_GROUP_MEMBER
    WHERE CHILD_ID IN (
            SELECT USER_ID
            FROM deleted
            );

    SELECT @ErrorCode = @@ERROR;

    IF @ErrorCode <> 0
    BEGIN 
        SET @ErrorMessage = 'tr_sec_user_instead_of_delete: An error occured while attempting to delete memberships. Error [%d]';  
        GOTO EXIT_WITH_ROLLBACK;
    END;

    -- Now delete the users.
    DELETE dbo.TB_SEC_USER
    WHERE USER_ID IN (
            SELECT USER_ID
            FROM deleted
            );

    SELECT @ErrorCode = @@ERROR;

    IF @ErrorCode <> 0
    BEGIN 
        SET @ErrorMessage = 'tr_sec_user_instead_of_delete: An error occured while attempting to delete users. Error [%d]';

        GOTO EXIT_WITH_ROLLBACK;
    END;

    IF @InitialTransactionCount = 0
    BEGIN 
        COMMIT TRANSACTION TrSecUsrTran;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;

    RETURN;

    EXIT_WITH_ROLLBACK:

    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
    ELSE BEGIN 
        IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = - 1
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
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                   COMMIT TRANSACTION;
                END;
            END;

            SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
        END;
    END;
    -- Raise error should be the last statement in the trigger if the error is to be raised and caught outside the trigger.
    RAISERROR (@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
END;
GO
