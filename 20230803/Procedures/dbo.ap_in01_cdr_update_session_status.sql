SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_update_session_status] (@I_SessionUrn INT, @I_NewStatus CHAR(1)) AS
SET NOCOUNT ON;

DECLARE @v_Error INT, @InitialTransactionCount INT = @@TRANCOUNT, @ErrorMessage VARCHAR(1000);

BEGIN TRANSACTION UpdateSessTransaction;

    BEGIN TRY;
        -- First update the main session with the new status and update any timestamps.
        UPDATE [dbo].[TB_IMP_CDR_SESSION]
        SET [STATUS] = @I_NewStatus, [COMPLETED] = CASE WHEN @I_NewStatus = 'C'
                                                        THEN GETUTCDATE()
                                                        ELSE [COMPLETED] END, 
            [LOADED] = CASE WHEN @I_NewStatus = 'L'
                            THEN GETUTCDATE()
                            ELSE [LOADED] END
        WHERE [CDR_SESSION_URN] = @I_SessionUrn;

        IF @I_NewStatus = 'C'
        BEGIN 
            -- If this is the parent of any summaries, then update those as well
            UPDATE [dbo].[TB_IMP_CDR_SUMMARY]
            SET [STATUS] = 'C', [COMPLETED] = GETUTCDATE()
            WHERE [CDR_SESSION_URN] = @I_SessionUrn
            AND [STATUS] = 'N';
        END;
        ELSE IF @I_NewStatus = 'Z'
        BEGIN 
            -- If this is the parent of any summaries, then update those as well
            UPDATE [dbo].[TB_IMP_CDR_SUMMARY]
            SET [STATUS] = 'Z'
            WHERE [CDR_SESSION_URN] = @I_SessionUrn
            AND [STATUS] = 'L'
        END;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION UpdateSessTransaction;
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
