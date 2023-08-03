SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_do_type2_skillgroup_service_member]
(@SessionId UNIQUEIDENTIFIER, @MemberUrn INT = -1 OUTPUT, @MemberBusinessUrn INT = -1 OUTPUT, @ChangeStamp INT,
 @EffectiveFrom DATETIME = NULL, @NewParentItemBusinessUrn INT = NULL, @NewChildItemBusinessUrn INT = NULL,
 @MaintainBusinessKey BIT = 1)
AS
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    
    DECLARE @ReturnCode INT = 0, @RowCount INT, @SessionUserId UNIQUEIDENTIFIER, @OldParentItemBusinessUrn INT,
    @OldChildItemBusinessUrn INT, @MemberEffectiveFrom DATETIME, @MemberEffectiveTo DATETIME,
    @UtcNow DATETIME, @OldMemberUrn INT, @AuditChanges BIT, @InitialTransactionCount INT = @@TRANCOUNT, @deadlockRetry TINYINT = 0, 
    @waitDelay CHAR(9), @deadlockRetryBegin BIT = 0, @ErrorMessage NVARCHAR(2000) = N'', @ErrorHolder NVARCHAR(500);
            
    SET @UtcNow = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE());  
    SET @EffectiveFrom = COALESCE(@EffectiveFrom, @UtcNow);
    SET @EffectiveFrom = DATEADD(ms, -(DATEPART(ms, @EffectiveFrom)), @EffectiveFrom);
    SET @OldMemberUrn = @MemberUrn;
            
    -- Create temporary audit table
    DECLARE @AuditTable TABLE (AUDIT_TYPE_INTERNAL_NAME NVARCHAR(100), INT_VAL_1 INT, INT_VAL_2 INT, INT_VAL_3 INT, INT_VAL_4 INT, CLUSTER_RESOURCE_ID UNIQUEIDENTIFIER NULL,
    EVENT_DESCRIPTION NVARCHAR(100), EVENT_UTC_DATE_TIME DATETIME NOT NULL DEFAULT(GETUTCDATE()));
            
    -- Check Session Id
    IF @SessionId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
    BEGIN 
        -- Retrieve user information
        SELECT @SessionUserId = USER_ID 
        FROM dbo.TB_SEC_USER
        WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
        AND LOGIN_NAME = (SELECT SESSION_USER_NAME FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId);

        -- Check if the supplied MEMBER_URN is valid
        IF @OldMemberUrn >= 1
        BEGIN 
            -- Load the current parent/child URN for the member        
            SELECT @OldParentItemBusinessUrn = PARENT_ITEM_BIZ_URN, @OldChildItemBusinessUrn = CHILD_ITEM_BIZ_URN, 
            @MemberBusinessUrn = MEMBER_BIZ_URN, @MemberEffectiveFrom = EFFECTIVE_FROM, @MemberEffectiveTo = EFFECTIVE_TO
            FROM dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER
            WHERE MEMBER_URN = @OldMemberUrn;
    
            -- Default parent and child URNs to existing values    
            SET @NewParentItemBusinessUrn = COALESCE(@NewParentItemBusinessUrn, @OldParentItemBusinessUrn);
            SET @NewChildItemBusinessUrn = COALESCE(@NewChildItemBusinessUrn, @OldChildItemBusinessUrn);
        
            -- If we have changed parent or child then create audits for the history tab
            IF (@OldParentItemBusinessUrn <> @NewParentItemBusinessUrn OR @OldChildItemBusinessUrn <> @NewChildItemBusinessUrn)
            BEGIN 
                SET @AuditChanges = 1;
            END;
            ELSE BEGIN 
                SET @AuditChanges = 0;
            END;
    
            -- if the input effective date is outside the effective range of the item then return.
            IF NOT(@EffectiveFrom BETWEEN @MemberEffectiveFrom AND @MemberEffectiveTo)
            BEGIN 
                RETURN;
            END;
    
            BEGIN TRANSACTION PTYP_skillgroupserviTran;
                WHILE @deadlockRetry < 3
                BEGIN 
                    SAVE TRANSACTION deadlockSavePoint;
                    BEGIN TRY;
                        -- Copy base data
                        INSERT INTO dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER (MEMBER_BIZ_URN, PARENT_ITEM_BIZ_URN, CHILD_ITEM_BIZ_URN, 
                        EFFECTIVE_FROM, EFFECTIVE_TO, CREATED_BY_ID, MODIFIED_BY_ID,
                        MODIFIED_DATE, CREATION_DATE, DELETED, HIDDEN, LATEST, SYSTEM, XML_DATA, CUSTOM_XML_DATA)
                        SELECT MEMBER_BIZ_URN, @NewParentItemBusinessUrn, @NewChildItemBusinessUrn, 
                        @EffectiveFrom, EFFECTIVE_TO, @SessionUserId, @SessionUserId, @UtcNow,
                        @UtcNow, DELETED, HIDDEN, 1, SYSTEM, XML_DATA, CUSTOM_XML_DATA
                        FROM dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER              
                        WHERE MEMBER_URN = @OldMemberUrn;

                        SELECT @RowCount = @@ROWCOUNT, @MemberUrn = SCOPE_IDENTITY();

                        -- Check for invalid member id/type
                        IF @RowCount <> 1
                        BEGIN 
                            SET @ReturnCode = -1;
                            RAISERROR ('Error updating membership: MemberUrn [%d] Error [%d] Message [Invalid member id/type conflict raised in TRY block.]', 16, 1, @OldMemberUrn, @ReturnCode);
                        END;
        
                        IF @MaintainBusinessKey = 0
                        BEGIN 
                            UPDATE dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER 
                            SET MEMBER_BIZ_URN = @MemberUrn 
                            WHERE MEMBER_URN = @MemberUrn;
                            
                            -- Copy new pkey data to temp table (only active pkeys should be copied)
                            IF object_id('tempdb..#PKEY_MAP_ROWS') IS NOT NULL
                            BEGIN 
                                DROP TABLE #PKEY_MAP_ROWS;
                            END;

                            SELECT PKEY_MAP_BIZ_URN, @MemberUrn AS [MEMBER_BIZ_URN], CLUSTER_RESOURCE_ID, 0 AS [CHANGE_STAMP],
[PRIORITY_LEVEL],
                            PKEY1, PKEY2, STATUS, CASE WHEN [EFFECTIVE_FROM] > @EffectiveFrom THEN [EFFECTIVE_FROM] ELSE @EffectiveFrom END AS [EFFECTIVE_FROM],
                            EFFECTIVE_TO, @SessionUserId AS [CREATED_BY_ID], @SessionUserId AS [MODIFIED_BY_ID], 
                            @UtcNow AS [MODIFIED_DATE], @UtcNow AS [CREATED_DATE], 0 AS [PURGED], SYSTEM,
                            1 AS [LATEST], SOURCE_CHANGE_STAMP, CAST(XML_DATA AS NVARCHAR(MAX)) AS [XML_DATA], CAST(CUSTOM_XML_DATA AS NVARCHAR(MAX)) AS [CUSTOM_XML_DATA]
                            INTO #PKEY_MAP_ROWS
                            FROM dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP
                            WHERE MEMBER_BIZ_URN = @MemberBusinessUrn AND STATUS <> 'D';

                            -- De-commission old pkey maps
                            UPDATE dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP 
                            SET STATUS = 'D', LATEST = 0, PURGED = 1, EFFECTIVE_TO = DATEADD(ss, -1, @EffectiveFrom),
                            MODIFIED_DATE = @UtcNow, MODIFIED_BY_ID = @SessionUserId
                            WHERE MEMBER_BIZ_URN = @MemberBusinessUrn AND STATUS <> 'D';
                       
                            -- Insert new pkey maps
                            INSERT INTO dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP (PKEY_MAP_BIZ_URN, MEMBER_BIZ_URN, CLUSTER_RESOURCE_ID, CHANGE_STAMP, 
[PRIORITY_LEVEL],
                            PKEY1, PKEY2, STATUS, EFFECTIVE_FROM, EFFECTIVE_TO, CREATED_BY_ID, MODIFIED_BY_ID, MODIFIED_DATE,
                            CREATION_DATE, PURGED, SYSTEM, LATEST, SOURCE_CHANGE_STAMP, XML_DATA, CUSTOM_XML_DATA)
                            SELECT PKEY_MAP_BIZ_URN, MEMBER_BIZ_URN, CLUSTER_RESOURCE_ID, CHANGE_STAMP, 
[PRIORITY_LEVEL],
                            PKEY1, PKEY2, STATUS, EFFECTIVE_FROM, EFFECTIVE_TO, CREATED_BY_ID, MODIFIED_BY_ID, MODIFIED_DATE,
                            CREATED_DATE, PURGED, SYSTEM, LATEST, SOURCE_CHANGE_STAMP, XML_DATA, CUSTOM_XML_DATA
                            FROM #PKEY_MAP_ROWS;   

                            DROP TABLE #PKEY_MAP_ROWS;

                            -- Audit pkey delete against parent and child
                            IF (@AuditChanges = 1)
                            BEGIN 
                                INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, CLUSTER_RESOURCE_ID, EVENT_DESCRIPTION)
                                SELECT 'AT_MEMBER_DELETE_COMMITTED_ON_EQUIPMENT', @OldParentItemBusinessUrn, @OldChildItemBusinessUrn, 94, 95,
                                CLUSTER_RESOURCE_ID, 'MEMBER_DELETED_ON_EQUIPMENT'
                                FROM dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP
                                WHERE MEMBER_BIZ_URN = @MemberBusinessUrn AND STATUS <> 'D';
                            END;

                            SET @MemberBusinessUrn = @MemberUrn;
                        END;

                        -- Delete member
                        UPDATE dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER
                        SET DELETED = 1, EFFECTIVE_TO = DATEADD(ss, -1, @EffectiveFrom), MODIFIED_DATE = @UtcNow,
                        MODIFIED_BY_ID = @SessionUserId, LATEST = CASE @MaintainBusinessKey WHEN 0 THEN 1 ELSE 0 END
                        WHERE MEMBER_URN = @OldMemberUrn;

                        IF (@AuditChanges = 1)
                        BEGIN 
                            -- Audit delete of old membership
                            INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, EVENT_DESCRIPTION)
                            VALUES('AT_MEMBER_DELETE_COMMITTED', @OldParentItemBusinessUrn, @OldChildItemBusinessUrn,  94, 95, 'MEMBER_DELETED');

                            -- Audit add of new membership
                            INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, EVENT_DESCRIPTION)
                            VALUES('AT_MEMBER_INSERT_COMMITTED', @NewParentItemBusinessUrn, @NewChildItemBusinessUrn,  94, 95, 'MEMBER_ADDED');

                            IF @MaintainBusinessKey = 0
                            BEGIN 
                                -- Audit insert of pkey entries against new parent/child
                                INSERT INTO @AuditTable(AUDIT_TYPE_INTERNAL_NAME, INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, CLUSTER_RESOURCE_ID, EVENT_DESCRIPTION)
                                SELECT 'AT_MEMBER_INSERT_COMMITTED_ON_EQUIPMENT', @NewParentItemBusinessUrn, @NewChildItemBusinessUrn,  94, 95,
                                CLUSTER_RESOURCE_ID, 'MEMBER_ADDED_ON_EQUIPMENT'
                                FROM dbo.TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP
                                WHERE MEMBER_BIZ_URN = @MemberUrn;
                            END;
                        END;

                        -- Insert audit records
                        INSERT INTO dbo.TB_FCT_SYSTEM_AUDIT (SESSION_ID, AUDIT_TYPE_ID, EVENT_UTC_DATE_TIME, EVENT_UTC_DATE_URN, 
                        EVENT_UTC_TIME_URN, INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, GUID_VAL_1, EVENT_OUTCOME, EVENT_DESCRIPTION)
                        SELECT @SessionId, adtp.AUDIT_TYPE_ID, EVENT_UTC_DATE_TIME, DATEDIFF(dd, 0, EVENT_UTC_DATE_TIME),
                        (DATEPART(hh, EVENT_UTC_DATE_TIME)*60 + DATEPART(mi, EVENT_UTC_DATE_TIME)), a.INT_VAL_1, a.INT_VAL_2, a.INT_VAL_3, a.INT_VAL_4,
                        a.CLUSTER_RESOURCE_ID, 'S', a.EVENT_DESCRIPTION
                        FROM @AuditTable AS a
                        INNER JOIN dbo.TE_ADM_AUDIT_TYPE AS adtp ON adtp.INTERNAL_NAME = a.AUDIT_TYPE_INTERNAL_NAME;

                        IF @InitialTransactionCount = 0 
                        BEGIN 
                            COMMIT TRANSACTION PTYP_skillgroupserviTran;
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
                        SELECT @ReturnCode = ERROR_NUMBER(),
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
        END;
        ELSE BEGIN 
            --@OldMemberUrn < 1 OR @OldMemberUrn IS NULL
            SET @ReturnCode = -1;
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
            'Invalid member urn for member. Error = [%d]';
        END;
    END;
    ELSE BEGIN 
        SET @ReturnCode = 50157;
        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': '+ 
        'Invalid session ID. Error = [%d]';
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
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_do_type2_skillgroup_service_member]
	TO [portalapp_role]
GO
