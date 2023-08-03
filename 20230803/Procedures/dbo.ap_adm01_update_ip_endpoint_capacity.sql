SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_update_ip_endpoint_capacity]
(
    @ClusterResourceName AS VARCHAR(100),
    @DefaultCapacity AS [INTEGER],
    @MinCapacity AS [INTEGER],
    @MaxCapacity AS [INTEGER]
) AS
    DECLARE @InitialTransactionCount INT = @@TRANCOUNT,
            @ClusterResourceId AS [UNIQUEIDENTIFIER],
            @ErrorMessage VARCHAR(1000);

    BEGIN TRANSACTION;
    BEGIN TRY

        SELECT @ClusterResourceId=RESOURCE_ID FROM TB_CLU_RESOURCE WHERE NAME=@ClusterResourceName AND RESOURCE_TYPE_ID='00000035-0000-0000-0000-000000000020' AND DELETED=0;

        IF @ClusterResourceId IS NULL
        BEGIN
            RAISERROR('RESOURCE NAME IS INVALID',16,1);
        END;

        UPDATE dbo.TB_ADM_CAPACITY
        SET DEFAULT_CAPACITY=@DefaultCapacity,
            MIN_CAPACITY=@MinCapacity,
            MAX_CAPACITY=@MaxCapacity
        WHERE CLUSTER_RESOURCE_ID=@ClusterResourceId AND INTERNAL_NAME='MAX_IP_PHONES_PER_CALL_MANAGER';

        COMMIT TRANSACTION; 

    END TRY
    BEGIN CATCH

    SELECT @ErrorMessage = '['+ OBJECT_NAME(@@PROCID) + ']' +ISNULL(': '+ERROR_MESSAGE(),'');
    DECLARE @transactionFake INT;
    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;
    ELSE BEGIN
        IF (XACT_STATE()) <> -1
        BEGIN
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
                    SET @transactionFake = @@TRANCOUNT;
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
        END;
        ELSE BEGIN
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
            ROLLBACK TRANSACTION;
            -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
            SET @transactionFake = @@TRANCOUNT;
            WHILE @transactionFake < @InitialTransactionCount
            BEGIN
                BEGIN TRANSACTION;
                SET @transactionFake = @transactionFake + 1;
            END;
        END;
        SET @ErrorMessage = ISNULL(@ErrorMessage,'['+OBJECT_NAME(@@PROCID)+']');
    END;
    RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_update_ip_endpoint_capacity]
	TO [portalapp_role]
GO
