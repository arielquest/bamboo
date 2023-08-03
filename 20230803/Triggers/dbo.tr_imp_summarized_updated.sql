SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_imp_summarized_updated] ON [dbo].[TS_IMP_SUMMARIZED] FOR UPDATE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    DECLARE @InitialTransactionCount INT = @@TRANCOUNT;

    IF UPDATE (STATUS)
    BEGIN 
        BEGIN TRY;
            BEGIN TRANSACTION TrImpSumTran;

            -- Delete data that have been processed        
            DELETE [dbo].[TS_IMP_SUMMARIZED]
            WHERE [STATUS] = 2;

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION TrImpSumTran;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END TRY
        BEGIN CATCH;
            DECLARE @ErrorMessage VARCHAR(200);
            IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE BEGIN 
                IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
                BEGIN
                    IF (XACT_STATE()) = - 1
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
                    SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
                END;
            END;
            RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
        END CATCH;
    END;
END;
GO
