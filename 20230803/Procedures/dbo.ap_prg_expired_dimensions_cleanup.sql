SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_prg_expired_dimensions_cleanup] AS
SET NOCOUNT ON;

DECLARE @v_Error INT, @InitialTransactionCount INT = @@TRANCOUNT, @factRentitionPeriod INT, @currentDateTime DATETIME,
@lastRetentionDateTime DATETIME, @itemBizUrn INT, @itemTypeId UNIQUEIDENTIFIER, @itemTypeUrn INT, @ErrorMessage VARCHAR(1000);

BEGIN TRANSACTION ExpDimCleanTransaction;

    BEGIN TRY;
        SELECT @factRentitionPeriod = CAST(PROPERTY_VALUE AS INT)
        FROM TB_ADM_PROPERTY
        WHERE PROPERTY_KEY = 'PROP_DIMENSION_PURGE_RENTENTION_PERIOD_DAYS';

        SELECT @factRentitionPeriod = COALESCE(DATEDIFF(dd, MIN(START_DATE_TIME) - 1, GETUTCDATE()), @factRentitionPeriod)
        FROM TB_IMP_FCT_PARTITION
        WHERE DROP_DATE IS NOT NULL;

        IF @factRentitionPeriod IS NULL
        BEGIN 
            RAISERROR ('Fact retention period is not defined', 16, 1);
        END;

        -- Get the current date
        SET @currentDateTime = GETUTCDATE();
        -- Determine the oldest dimensions that we need to keep
        SET @lastRetentionDateTime = DATEADD(day, - @factRentitionPeriod, @currentDateTime);

        -- Loop through all items to be purged
        DECLARE purge_cur CURSOR FAST_FORWARD FOR
        SELECT ITEM_BIZ_URN, ITEM_TYPE_URN
        FROM VW_DIM_ITEM
        WHERE EFFECTIVE_TO < @lastRetentionDateTime AND ITEM_URN > 0
        AND LATEST = 1
        ORDER BY ITEM_TYPE_URN;

        OPEN purge_cur;

        FETCH NEXT
        FROM purge_cur
        INTO @itemBizUrn, @itemTypeUrn;

        WHILE @@FETCH_STATUS = 0
        BEGIN 
            -- Delete the item
            EXEC ap_dim01_purge_dimension @itemBizUrn, @itemTypeUrn, 1;
            FETCH NEXT
            FROM purge_cur
            INTO @itemBizUrn, @itemTypeUrn;
        END;

        CLOSE purge_cur;
        DEALLOCATE purge_cur;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION ExpDimCleanTransaction;
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
        DECLARE @CURSOR_STATUS INT;
        SELECT @CURSOR_STATUS = CURSOR_STATUS('global','purge_cur');
        IF @CURSOR_STATUS >= 0
        BEGIN 
            CLOSE purge_cur;
            DEALLOCATE purge_cur;
        END;
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
GO
GRANT EXECUTE
	ON [dbo].[ap_prg_expired_dimensions_cleanup]
	TO [portalapp_role]
GO
