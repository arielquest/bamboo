SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_rep_report_deleted_gc] ON [dbo].[TB_REP_REPORT] FOR DELETE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    IF NOT EXISTS (
            SELECT 1
            FROM deleted
            )
    BEGIN 
        RETURN;
    END;

    DECLARE @ErrorMessage AS NVARCHAR(500), @ErrorCode AS [INTEGER], @InitialTransactionCount AS [INTEGER], @TableGenerationCount AS BIGINT, @TableGenerationCountUrn AS INT;

    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @ErrorMessage = '';
    SET @ErrorCode = 0;

    BEGIN TRANSACTION;

    -- Increment table generation count by 1
    SELECT @TableGenerationCount = GENERATION_COUNT, @TableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
    FROM dbo.TS_ADM_TABLE_GENERATION_COUNT WITH (UPDLOCK)
    WHERE TABLE_NAME = 'TB_REP_REPORT';

    SET @TableGenerationCount = @TableGenerationCount + 1;

    UPDATE dbo.TS_ADM_TABLE_GENERATION_COUNT
    SET GENERATION_COUNT = @TableGenerationCount, MODIFIED_DATE = GETUTCDATE()
    WHERE TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;

    SELECT @ErrorCode = @@ERROR;

    IF @ErrorCode <> 0
    BEGIN 
        SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
        GOTO EXIT_WITH_ROLLBACK;
    END;

    -- Update the generation counts for existing items
    UPDATE dbo.TS_ADM_DATA_GENERATION_COUNT
    SET GENERATION_COUNT = @TableGenerationCount, LAST_OPERATION = 'D', MODIFIED_DATE = GETUTCDATE()
    FROM dbo.TS_ADM_DATA_GENERATION_COUNT AS datagc
    INNER JOIN deleted AS d ON d.REPORT_ID = datagc.GUID_KEY
    WHERE datagc.TABLE_GENERATION_COUNT_URN = @TableGenerationCountUrn;

    SELECT @ErrorCode = @@ERROR;

    IF @ErrorCode <> 0
    BEGIN 
        SET @ErrorMessage = 'An error occured while attempting to update item. Error = [%d]';
        GOTO EXIT_WITH_ROLLBACK;
    END;

    COMMIT TRANSACTION;

    RETURN;

    EXIT_WITH_ROLLBACK:

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
                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
                RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
            RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
        END;
    END;

    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + @ErrorMessage;
    -- Raise error should be the last statement in the trigger if the error is to be raised and caught outside the trigger.
    RAISERROR (@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
END;
GO