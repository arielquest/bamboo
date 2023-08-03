SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_olap_fact_partition] (@ResourceInstanceID AS UNIQUEIDENTIFIER, @FactTableName AS NVARCHAR(45)) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT;

    BEGIN TRY;
            SELECT DISTINCT PARTITION_ID
            FROM dbo.TB_IMP_FCT_PARTITION AS fp
            INNER JOIN dbo.TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
            WHERE fpm.CUBE_VIEW_NAME = @FactTableName AND fp.RESOURCE_INSTANCE_ID = @ResourceInstanceID;
    END TRY
    BEGIN CATCH;
        DECLARE @ErrorMessage VARCHAR(200) = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(': ' + ERROR_MESSAGE(),'');
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

    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_olap_fact_partition]
	TO [portalapp_role]
GO
