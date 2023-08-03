SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_commit_lc_checkpoints] (@I_SessionUrn INT) AS
SET NOCOUNT ON;

DECLARE @v_Error INT, @InitialTransactionCount INT = @@TRANCOUNT, @ErrorMessage VARCHAR(1000);

BEGIN TRANSACTION CommCDRTransaction;

    BEGIN TRY;
        DELETE FROM [dbo].[TB_IMP_CDR_LC_CHECKPOINT]
        WHERE [CDR_SESSION_URN] = @I_SessionUrn;

        INSERT INTO [dbo].[TB_IMP_CDR_LC_CHECKPOINT] ([CDR_SESSION_URN], [TYPE], [START], [DNI], [TLI], [CLI], [DATE], 
        [TIME], [RINGTIME], [TALKTIME], [SOURCE_URN], [SOURCE_CODE], [SOURCE_TYPE], [OUTCOME], [LINK])
        SELECT @I_SessionUrn, [TYPE], [START], [DNI], [TLI], [CLI], [DATE], [TIME], [RINGTIME], [TALKTIME], 
        [SOURCE_URN], [SOURCE_CODE], [SOURCE_TYPE], [OUTCOME], [LINK]
        FROM [dbo].[TS_IMP_CDR_LC_CHECKPOINT]
        WHERE [CDR_SESSION_URN] = @I_SessionUrn;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION CommCDRTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;

        DELETE FROM [dbo].[TS_IMP_CDR_LC_CHECKPOINT]
        WHERE [CDR_SESSION_URN] = @I_SessionUrn;
    END TRY
    BEGIN CATCH;
        SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
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
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    END CATCH;

RETURN @v_Error;
GO
