SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_do_type2_vxmlapplication_server]
(@SessionId UNIQUEIDENTIFIER, 
 @ItemUrn INT = -1 OUTPUT, @ItemBusinessUrn INT = -1 OUTPUT,
 @ChangeStamp INT, @EffectiveFrom DATETIME = NULL,
 @IgnoreConsolidationPeriod BIT = 0, @MaintainBusinessKey BIT = 1)
AS
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    -- Declare variables
    DECLARE @RowCount INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, @ReturnCode INT = 0,
    @SessionUserId UNIQUEIDENTIFIER, @AuditUrn BIGINT, @NewItemUrn INT, @NewItemBusinessUrn INT, 
    @UtcNow DATETIME = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()), 
    @ConsolidationPeriod INT, @ItemEffectiveFrom DATETIME, @ItemEffectiveTo DATETIME, 
    @CurrentNextSurrogateEffectiveFrom DATETIME, @deadlockRetry TINYINT = 0, 
    @waitDelay CHAR(9), @deadlockRetryBegin BIT = 0, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);
    
    IF(@EffectiveFrom IS NULL)
    BEGIN 
        SET @EffectiveFrom = @UtcNow;
    END;
   
    DECLARE @AuditTable TABLE (AUDIT_TYPE_INTERNAL_NAME NVARCHAR(100), INT_VAL_1 INT, INT_VAL_2 INT, INT_VAL_3 INT, EVENT_DESCRIPTION NVARCHAR(100));

    -- Get the configured consolidation period and the default timezone offset
    SELECT @ConsolidationPeriod = CAST(PROPERTY_VALUE AS INT) 
    FROM dbo.TB_ADM_PROPERTY WHERE PROPERTY_KEY = 'PROP_TYPE2_CONSOLIDATION_PERIOD';
    
    SET @ConsolidationPeriod = COALESCE(@ConsolidationPeriod, 1440);
    
    -- Consolidation period should be atleast one minute to avoid any overlapping effective dates.
    IF @ConsolidationPeriod < 1
    BEGIN 
        SET @ConsolidationPeriod = 1;
    END;
            
    -- Check if the supplied ITEM_URN is valid
    IF @ItemUrn > 1
    BEGIN 
        SELECT @ItemBusinessUrn = ITEM_BIZ_URN, @NewItemBusinessUrn = ITEM_BIZ_URN,
        @ItemEffectiveFrom = EFFECTIVE_FROM, @ItemEffectiveTo = EFFECTIVE_TO
        FROM dbo.TB_DIM_VXMLAPPLICATION_SERVER 
        WHERE ITEM_URN = @ItemUrn;
    
        IF @ItemBusinessUrn > 1 AND @SessionId IS NOT NULL
        AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
        BEGIN 
            -- if the input effective date is outside the effective range of the item then return.
            IF NOT(@EffectiveFrom BETWEEN @ItemEffectiveFrom AND @ItemEffectiveTo)
            BEGIN 
                RETURN 0;
            END;
            
            SELECT @SessionUserId = USER_ID 
            FROM dbo.TB_SEC_USER
            WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
            AND LOGIN_NAME = (SELECT SESSION_USER_NAME 
                              FROM dbo.TB_ADM_SESSION 
                              WHERE SESSION_ID = @SessionId);
    
            -- Check if there are any surrogates of the item effective in the future
            -- if yes then get the effective from of the first surrogate.    
            SELECT TOP 1 @CurrentNextSurrogateEffectiveFrom = EFFECTIVE_FROM 
            FROM dbo.TB_DIM_VXMLAPPLICATION_SERVER 
            WHERE ITEM_BIZ_URN = @ItemBusinessUrn AND EFFECTIVE_FROM > @ItemEffectiveTo
            ORDER BY EFFECTIVE_FROM;
        
            -- If Consolidation period is *not* to be ignored, then if the difference (minutes) between the items effective from 
            -- and the input effective from is less than or equal to the consolidation period then exit.
            -- OR 
            -- If the type 2 effective from is before the item's effective from then just exit.           
            IF NOT EXISTS (SELECT 1 
                           FROM (VALUES(@IgnoreConsolidationPeriod, @ItemEffectiveFrom, @EffectiveFrom)
                                ) a(IgnoreConsolidationPeriod, ItemEffectiveFrom, EffectiveFrom)
                           WHERE (@IgnoreConsolidationPeriod = 0 AND DATEDIFF(mi, @ItemEffectiveFrom, @EffectiveFrom) <= @ConsolidationPeriod)
                           OR (@EffectiveFrom <= @ItemEffectiveFrom))
            BEGIN 
    
                BEGIN TRANSACTION PTYP_vxmlapplicationTran;
                    WHILE @deadlockRetry < 3
                    BEGIN 
                        SAVE TRANSACTION deadlockSavePoint;
                        BEGIN TRY;
                            -- Insert the new type-2 item record
                            INSERT INTO dbo.TB_DIM_VXMLAPPLICATION_SERVER ([ITEM_BIZ_URN], [SKIP_LEVEL], [FOLDER_ID], [OWNER_ID], [ITEM_SUBTYPE_ID], [NAME], [DESCRIPTION],
                            [EFFECTIVE_FROM], [EFFECTIVE_TO], [CREATED_BY_ID], [MODIFIED_BY_ID], [MODIFIED_DATE], [CREATION_DATE],    
                            [DELETED], [HIDDEN], [LATEST], [SYSTEM], [TIME_ZONE_URN], [TENANT_BIZ_URN],
                            [HIERARCHY_PARENT_URN], [XML_DATA], [CUSTOM_XML_DATA])
                            SELECT [ITEM_BIZ_URN], [SKIP_LEVEL], [FOLDER_ID], [OWNER_ID], [ITEM_SUBTYPE_ID], [NAME], [DESCRIPTION],
                            @EffectiveFrom, [EFFECTIVE_TO], @SessionUserId,  @SessionUserId, @UtcNow, @UtcNow,
                            [DELETED], [HIDDEN], 1, [SYSTEM], [TIME_ZONE_URN],  [TENANT_BIZ_URN],
                            [HIERARCHY_PARENT_URN], [XML_DATA], [CUSTOM_XML_DATA]
                            FROM dbo.TB_DIM_VXMLAPPLICATION_SERVER 
                            WHERE ITEM_URN = @ItemUrn AND CHANGE_STAMP = @ChangeStamp;
            
                            SELECT @RowCount = @@ROWCOUNT, @NewItemUrn = SCOPE_IDENTITY();

                            -- Concurrency error
                            IF @RowCount = 0
                            BEGIN 
                                SET @ReturnCode = -2;
                                RAISERROR ('Error adding dimension: ItemUrn [%d] Error [%d] Message [Concurrency conflict raised in TRY block.]', 16, 1, @ItemUrn, @ReturnCode);
                            END;
            
                            IF @MaintainBusinessKey = 0
                            BEGIN            
                                IF @CurrentNextSurrogateEffectiveFrom IS NOT NULL
                                BEGIN 
                                    SET @ReturnCode = -1;
                                    RAISERROR ('Error adding dimension: ItemUrn [%d] Error [%d] Message [Surrogate is effective conflict raised in TRY block.]', 16, 1, @ItemUrn, @ReturnCode);
                                END;
                
                                UPDATE dbo.TB_DIM_VXMLAPPLICATION_SERVER 
                                SET ITEM_BIZ_URN = @NewItemUrn 
                                WHERE ITEM_URN = @NewItemUrn;
                    
                                -- Copy new pkey maps to temp table
                                IF object_id('tempdb..#PKEY_MAP_ROWS') IS NOT NULL
                                BEGIN 
                                    DROP TABLE #PKEY_MAP_ROWS;
                                END;

                                SELECT [PKEY_MAP_BIZ_URN], @NewItemUrn AS [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2], [STATUS],
[IP_ADDRESS], 
[HOSTNAME], 
                                CASE WHEN [EFFECTIVE_FROM] > @EffectiveFrom THEN [EFFECTIVE_FROM] ELSE @EffectiveFrom END AS [EFFECTIVE_FROM],
                                [EFFECTIVE_TO], @SessionUserId AS [CREATED_BY_ID], @SessionUserId AS [MODIFIED_BY_ID], @UtcNow AS [MODIFIED_DATE],
                                @UtcNow AS [CREATION_DATE], 0 AS [PURGED], [SYSTEM], 1 AS [LATEST], [SOURCE_CHANGE_STAMP],
                                CAST([XML_DATA] AS NVARCHAR(MAX)) AS XML_DATA, CAST([CUSTOM_XML_DATA] AS NVARCHAR(MAX)) AS CUSTOM_XML_DATA
                                INTO #PKEY_MAP_ROWS
                                FROM dbo.TB_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP 
                                WHERE ITEM_BIZ_URN = @ItemBusinessUrn AND STATUS <> 'D';
                
                                -- De-commission old pkey maps
                                UPDATE dbo.TB_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP 
                                SET STATUS = 'D', 
                                EFFECTIVE_TO = CASE WHEN @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO 
                                                    THEN DATEADD(ss, -1, @EffectiveFrom) 
                                                    ELSE EFFECTIVE_TO END,
                                LATEST = 0, PURGED = 1, MODIFIED_DATE = @UtcNow, MODIFIED_BY_ID = @SessionUserId
                                WHERE ITEM_BIZ_URN = @ItemBusinessUrn AND STATUS <> 'D';
                
                                -- Insert new pkey maps
                                INSERT INTO dbo.TB_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP  ([PKEY_MAP_BIZ_URN], [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2],                            
[IP_ADDRESS], 
[HOSTNAME], 
                                [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO], [CREATED_BY_ID], [MODIFIED_BY_ID], [MODIFIED_DATE], [CREATION_DATE],
                                [PURGED], [SYSTEM], [LATEST], [SOURCE_CHANGE_STAMP], [XML_DATA], [CUSTOM_XML_DATA])
                                SELECT [PKEY_MAP_BIZ_URN], @NewItemUrn AS [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2],                                
[IP_ADDRESS], [HOSTNAME],                                 [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO], [CREATED_BY_ID], [MODIFIED_BY_ID], [MODIFIED_DATE], [CREATION_DATE],
                                [PURGED], [SYSTEM], [LATEST], [SOURCE_CHANGE_STAMP], [XML_DATA], [CUSTOM_XML_DATA]
                                FROM #PKEY_MAP_ROWS;

                                DROP TABLE #PKEY_MAP_ROWS;

                                SET @NewItemBusinessUrn = @NewItemUrn;
                            END;
                        
                            IF @CurrentNextSurrogateEffectiveFrom IS NOT NULL
                            BEGIN 
                                UPDATE dbo.TB_DIM_VXMLAPPLICATION_SERVER 
                                SET EFFECTIVE_TO = @ItemEffectiveTo, LATEST = 0, DELETED = 1 
                                WHERE ITEM_URN = @NewItemUrn;
                            END;
            
                           -- Effectively date the old record
                           UPDATE dbo.TB_DIM_VXMLAPPLICATION_SERVER 
                           SET DELETED = 1, EFFECTIVE_TO = DATEADD(ss, -1, @EffectiveFrom),
                           LATEST = CASE @MaintainBusinessKey WHEN 0 THEN 1 ELSE 0 END,
                           MODIFIED_DATE = @UtcNow, MODIFIED_BY_ID = @SessionUserId
                           WHERE ITEM_URN = @ItemUrn AND CHANGE_STAMP = @ChangeStamp;

                           -- Add audit record
                           IF @ItemBusinessUrn = @NewItemBusinessUrn
                           BEGIN 
                               INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, EVENT_DESCRIPTION)
                               VALUES('AT_DIMENSION_TYPE_2_PERFORMED', @ItemBusinessUrn, @NewItemUrn, 110, 'DIMENSION_TYPE_2_CHANGE');
                           END;
                           ELSE BEGIN 
                               INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, EVENT_DESCRIPTION)                
                               VALUES('AT_DIMENSION_TYPE_2_TOMBSTONE_PERFORMED', @ItemBusinessUrn, @ItemUrn, 110, 'DIMENSION_TYPE_2_CHANGE');
                           END;
            
                           IF @MaintainBusinessKey = 0
                           BEGIN 
                               INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, EVENT_DESCRIPTION)
                               VALUES('AT_DIMENSION_TYPE_2_REVIVAL_PERFORMED', @NewItemBusinessUrn, @ItemUrn, 110, 'DIMENSION_TYPE_2_CHANGE');
            
                               -- Type-2 the correspondiing memberships
                               DECLARE @MemberUrn INT, @MemberBusinessUrn INT, @MemberChangeStamp INT;

                           END;
            
                           -- Finally set the @ItemUrn to @NewItemUrn
                           SET @ItemUrn = @NewItemUrn; 
                           SET @ItemBusinessUrn = @NewItemBusinessUrn;
                       
                           IF @InitialTransactionCount = 0 
                           BEGIN 
                               COMMIT TRANSACTION PTYP_vxmlapplicationTran;
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
                               SET @deadlockRetry = 3;
                               BREAK;
                           END;
                       END CATCH;
                       END;
                END
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
        ROLLBACK TRANSACTION;
    END;
    
    IF @ErrorMessage = '' AND @ReturnCode = 0
    BEGIN 
        -- Insert Audit records    
        INSERT INTO dbo.TB_FCT_SYSTEM_AUDIT (SESSION_ID, AUDIT_TYPE_ID, EVENT_UTC_DATE_TIME, EVENT_UTC_DATE_URN, EVENT_UTC_TIME_URN, 
        INT_VAL_1, INT_VAL_2, INT_VAL_3, EVENT_OUTCOME, EVENT_DESCRIPTION)
        SELECT @SessionId, at.AUDIT_TYPE_ID, @UtcNow, DATEDIFF(dd, 0, @UtcNow), (DATEPART(hh, @UtcNow)*60 + DATEPART(mi, @UtcNow)),
        a.INT_VAL_1, a.INT_VAL_2, a.INT_VAL_3, 'S', a.EVENT_DESCRIPTION        
        FROM @AuditTable AS a
        INNER JOIN dbo.TE_ADM_AUDIT_TYPE AS at ON at.INTERNAL_NAME = a.AUDIT_TYPE_INTERNAL_NAME;
    END;
    ELSE BEGIN 
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(NULLIF(@ErrorMessage,''),OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
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
        EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_TYPE_2_PERFORMED', DEFAULT, @ItemBusinessUrn, DEFAULT, 110, DEFAULT, DEFAULT, DEFAULT, 'F', 0, 'DIMENSION_TYPE_2_CHANGE', NULL, DEFAULT, DEFAULT, @AuditUrn out;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_do_type2_vxmlapplication_server]
	TO [portalapp_role]
GO
