SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_do_type2_rating_period_pkey_map]
(
    @SessionId UNIQUEIDENTIFIER, 
    @PkeyMapUrn INT = -1 OUTPUT,
    @PkeyMapBusinessUrn INT = -1 OUTPUT,
    @ChangeStamp INT, 
    @EffectiveFrom DATETIME = NULL,
    @IgnoreConsolidationPeriod BIT = 0,
    @MaintainBusinessKey BIT = 1
)
AS
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    -- Declare variables
    DECLARE @RowCount INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, @ReturnCode INT = 0,
    @SessionUserId UNIQUEIDENTIFIER, @NewPkeyMapUrn INT, @NewPkeyMapBusinessUrn INT, 
    @UtcNow DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()), 
    @ConsolidationPeriod INT, @PkeyMapEffectiveFrom DATETIME, @PkeyMapEffectiveTo DATETIME, 
    @CurrentNextSurrogateEffectiveFrom DATETIME, @deadlockRetry TINYINT = 0, 
    @waitDelay CHAR(9), @deadlockRetryBegin BIT = 0, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);
    
    IF(@EffectiveFrom IS NULL)
    BEGIN 
        SET @EffectiveFrom = @UtcNow;
    END;
   
    -- Get the configured consolidation period and the default timezone offset
    SELECT @ConsolidationPeriod = CAST(PROPERTY_VALUE AS INT) 
    FROM dbo.TB_ADM_PROPERTY WHERE PROPERTY_KEY = 'PROP_TYPE2_CONSOLIDATION_PERIOD';
    
    SET @ConsolidationPeriod = COALESCE(@ConsolidationPeriod, 1440);
    
    -- Consolidation period should be atleast one minute to avoid any overlapping effective dates.
    IF @ConsolidationPeriod < 1
    BEGIN 
        SET @ConsolidationPeriod = 1;
    END;
            
    -- Check if the supplied PKEY_MAP_URN is valid
    IF @PkeyMapUrn > 1
    BEGIN 
        SELECT @PkeyMapBusinessUrn = PKEY_MAP_BIZ_URN, @NewPkeyMapBusinessUrn = PKEY_MAP_BIZ_URN,
        @PkeyMapEffectiveFrom = EFFECTIVE_FROM, @PkeyMapEffectiveTo = EFFECTIVE_TO
        FROM dbo.TB_DIM_RATING_PERIOD_PKEY_MAP 
        WHERE PKEY_MAP_URN = @PkeyMapUrn;
    
        IF @PkeyMapBusinessUrn > 1 AND @SessionId IS NOT NULL
        AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
        BEGIN 
            -- if the input effective date is outside the effective range of the pkey map then return.
            IF NOT(@EffectiveFrom BETWEEN @PkeyMapEffectiveFrom AND @PkeyMapEffectiveTo)
            BEGIN 
                RETURN 0;
            END;
            
            SELECT @SessionUserId = USER_ID 
            FROM dbo.TB_SEC_USER
            WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
            AND LOGIN_NAME = (SELECT SESSION_USER_NAME 
                              FROM dbo.TB_ADM_SESSION 
                              WHERE SESSION_ID = @SessionId);
    
            -- Check if there are any surrogates of the pkey map effective in the future
            -- if yes then get the effective from of the first surrogate.    
            SELECT TOP 1 @CurrentNextSurrogateEffectiveFrom = EFFECTIVE_FROM 
            FROM dbo.TB_DIM_RATING_PERIOD_PKEY_MAP 
            WHERE PKEY_MAP_BIZ_URN = @PkeyMapBusinessUrn AND EFFECTIVE_FROM > @PkeyMapEffectiveTo
            ORDER BY EFFECTIVE_FROM;
        
            -- If Consolidation period is *not* to be ignored, then if the difference (minutes) between the pkey maps effective from 
            -- and the input effective from is less than or equal to the consolidation period then exit.
            -- OR 
            -- If the type 2 effective from is before the pkey map's effective from then just exit.           
            IF NOT EXISTS (SELECT 1 
                           FROM (VALUES(@IgnoreConsolidationPeriod, @PkeyMapEffectiveFrom, @EffectiveFrom)
                                ) a(IgnoreConsolidationPeriod, PkeyMapEffectiveFrom, EffectiveFrom)
                           WHERE (@IgnoreConsolidationPeriod = 0 AND DATEDIFF(mi, @PkeyMapEffectiveFrom, @EffectiveFrom) <= @ConsolidationPeriod)
                           OR (@EffectiveFrom <= @PkeyMapEffectiveFrom))
            BEGIN 
                BEGIN TRANSACTION PTYP_ratingpPKEYTran;
                    WHILE @deadlockRetry < 3
                    BEGIN 
                        SAVE TRANSACTION deadlockSavePoint;
                        BEGIN TRY;                     
                            -- Copy new pkey maps to temp table
                            IF object_id('tempdb..#PKEY_MAP_ROW') IS NOT NULL
                            BEGIN 
                                DROP TABLE #PKEY_MAP_ROW;
                            END;

                            SELECT [PKEY_MAP_BIZ_URN], [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2], [STATUS], 
                                                        CASE WHEN [EFFECTIVE_FROM] > @EffectiveFrom THEN [EFFECTIVE_FROM] ELSE @EffectiveFrom END AS [EFFECTIVE_FROM],
                            [EFFECTIVE_TO], @SessionUserId AS [CREATED_BY_ID], @SessionUserId AS [MODIFIED_BY_ID], @UtcNow AS [MODIFIED_DATE],
                            @UtcNow AS [CREATION_DATE], [PURGED], [SYSTEM], 1 AS [LATEST], [SOURCE_CHANGE_STAMP],
                            CAST([XML_DATA] AS NVARCHAR(MAX)) AS XML_DATA, CAST([CUSTOM_XML_DATA] AS NVARCHAR(MAX)) AS CUSTOM_XML_DATA
                            INTO #PKEY_MAP_ROW
                            FROM dbo.TB_DIM_RATING_PERIOD_PKEY_MAP
                            WHERE PKEY_MAP_URN = @PkeyMapUrn AND CHANGE_STAMP = @ChangeStamp;
                
                            -- De-commission old pkey map
                            UPDATE dbo.TB_DIM_RATING_PERIOD_PKEY_MAP
                            SET STATUS = 'D', 
                            EFFECTIVE_TO = CASE WHEN @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO 
                                                THEN DATEADD(ss, -1, @EffectiveFrom) 
                                                ELSE EFFECTIVE_TO END,
                            LATEST = 0, PURGED = 1, MODIFIED_DATE = @UtcNow, MODIFIED_BY_ID = @SessionUserId
                            WHERE PKEY_MAP_URN = @PkeyMapUrn AND CHANGE_STAMP = @ChangeStamp;
                
                            -- Insert new pkey maps
                            INSERT INTO dbo.TB_DIM_RATING_PERIOD_PKEY_MAP  ([PKEY_MAP_BIZ_URN], [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2], 
                                                        [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO], [CREATED_BY_ID], [MODIFIED_BY_ID], [MODIFIED_DATE], [CREATION_DATE],
                            [PURGED], [SYSTEM], [LATEST], [SOURCE_CHANGE_STAMP], [XML_DATA], [CUSTOM_XML_DATA])
                            SELECT [PKEY_MAP_BIZ_URN], [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2], 
                                                        [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO], [CREATED_BY_ID], [MODIFIED_BY_ID], [MODIFIED_DATE], [CREATION_DATE],
                            [PURGED], [SYSTEM], [LATEST], [SOURCE_CHANGE_STAMP], [XML_DATA], [CUSTOM_XML_DATA]
                            FROM #PKEY_MAP_ROW;

                            SELECT @RowCount = @@ROWCOUNT, @NewPkeyMapUrn = SCOPE_IDENTITY();

                            -- Concurrency error
                            IF @RowCount = 0
                            BEGIN 
                                SET @ReturnCode = -2;
                                RAISERROR ('Error updating dimension: PkeyMapUrn [%d] Error [%d] Message [Concurrency conflict raised in TRY block.]', 16, 1, @PkeyMapUrn, @ReturnCode);
                            END;
            
                            IF @MaintainBusinessKey = 0
                            BEGIN     
                                IF @CurrentNextSurrogateEffectiveFrom IS NOT NULL
                                BEGIN 
                                    SET @ReturnCode = -1;
                                    RAISERROR ('Error updating dimension: PkeyMapUrn [%d] Error [%d] Message [Effective surrogate exists raised in TRY block.]', 16, 1, @PkeyMapUrn, @ReturnCode);
                                END;
                
                                UPDATE dbo.TB_DIM_RATING_PERIOD_PKEY_MAP 
                                SET PKEY_MAP_BIZ_URN = @NewPkeyMapUrn 
                                WHERE PKEY_MAP_URN = @NewPkeyMapUrn;
                    
                                SET @NewPkeyMapBusinessUrn = @NewPkeyMapUrn;
                            END;
                        
                            IF @CurrentNextSurrogateEffectiveFrom IS NOT NULL
                            BEGIN 
                                UPDATE dbo.TB_DIM_RATING_PERIOD_PKEY_MAP 
                                SET EFFECTIVE_TO = @PkeyMapEffectiveTo, LATEST = 0, STATUS = 'D', PURGED = 1 
                                WHERE PKEY_MAP_URN = @NewPkeyMapUrn;
                            END;
            
                           -- Effectively date the old record
                           UPDATE dbo.TB_DIM_RATING_PERIOD_PKEY_MAP 
                           SET STATUS = 'D', PURGED = 1, EFFECTIVE_TO = DATEADD(ss, -1, @EffectiveFrom),
                           LATEST = CASE @MaintainBusinessKey WHEN 0 THEN 1 ELSE 0 END,
                           MODIFIED_DATE = @UtcNow, MODIFIED_BY_ID = @SessionUserId
                           WHERE PKEY_MAP_URN = @PkeyMapUrn AND CHANGE_STAMP = @ChangeStamp;                         
            
                           -- Finally set the @PkeyMapUrn to @NewPkeyMapUrn
                           SET @PkeyMapUrn = @NewPkeyMapUrn; 
                           SET @PkeyMapBusinessUrn = @NewPkeyMapBusinessUrn;
                       
                           DROP TABLE #PKEY_MAP_ROW;
            
                           IF @InitialTransactionCount = 0 
                           BEGIN 
                               COMMIT TRANSACTION PTYP_ratingpPKEYTran;
                           END;
                           ELSE BEGIN 
                               WHILE @@TRANCOUNT > @InitialTransactionCount
                               BEGIN 
                                   COMMIT TRANSACTION;
                               END;
                           END;
                           SET @deadlockRetry = 3;
                           SET @ReturnCode = 0;
                           BREAK;
                       END TRY
                       BEGIN CATCH;
                           SELECT @ReturnCode = CASE WHEN @ReturnCode = -2 THEN @ReturnCode ELSE ERROR_NUMBER() END,
                                  @ErrorMessage = CASE WHEN @ErrorMessage IS NULL OR @ErrorMessage = '' THEN ERROR_MESSAGE() ELSE @ErrorMessage END;
                           IF @ReturnCode = 1205 
                           BEGIN 
                               IF (XACT_STATE()) = -1
                               BEGIN 
                                   SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                                   'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                                   SET @deadlockRetry = 3;
                                   BREAK;
                               END;
                               ELSE BEGIN 
                                   ROLLBACK TRANSACTION deadlockSavePoint;
                                   SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
                                   'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                                   SET @deadlockRetry = @deadlockRetry + 1;
                
                                   --Random wait between 50ms and 999ms
                                   SELECT @waitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                                   FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);
                        
                                   WAITFOR DELAY @waitDelay;
                                   CONTINUE;
                               END;
                           END;
                           ELSE BEGIN 
                               SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+
                               'An error occured while attempting to update item.'+
                               ' SQLMessage['+@ErrorMessage+']. '+
                               'SQLError = [%d]';
                               SET @waitDelay = 3;
                               BREAK;
                           END;
                       END CATCH;
                       END;
                END;
                ELSE BEGIN 
                    RETURN 0; -- Do nothing due to consolidation period.
                END;
        END;
        ELSE BEGIN 
            SET @ErrorMessage = 'Invalid @SessionId specified';
            SET @ReturnCode = -1;
        END;
    END;

    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK;
    END;
    
    IF NOT (@ErrorMessage = '' AND @ReturnCode = 0)
    BEGIN 
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = @ErrorMessage+' [Uncommittable Transaction!]';
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
        END;     
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_do_type2_rating_period_pkey_map]
	TO [portalapp_role]
GO
