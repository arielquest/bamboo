SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER tr_imp_fct_partition_updated ON TB_IMP_FCT_PARTITION FOR UPDATE NOT FOR REPLICATION AS 
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    DECLARE @InitialTransactionCount INT = @@TRANCOUNT;

    IF UPDATE (DROP_DATE)
    BEGIN 
        BEGIN TRY;
            BEGIN TRANSACTION TrImpUpdTran;

            -- Delete tidemark and tidemark slice data        
            DELETE TB_IMP_FCT_PARTITION_TIDEMARK
            WHERE FACT_PARTITION_ID IN (
                    SELECT FACT_PARTITION_ID
                    FROM inserted
                    WHERE DROP_DATE IS NOT NULL
                    );

            -- Delete Olap Tidemark data
            DELETE TB_IMP_FCT_OLAP_PARTITION_MAP
            WHERE FACT_PARTITION_ID IN (
                    SELECT FACT_PARTITION_ID
                    FROM inserted
                    WHERE DROP_DATE IS NOT NULL
                    );

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION TrImpUpdTran;
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
            IF @InitialTransactionCount = 0
                AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE BEGIN 
                IF @InitialTransactionCount <> 0
                    AND @@TRANCOUNT > @InitialTransactionCount
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
