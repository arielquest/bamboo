SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_conform_person_pkey_maps] (
@SessionId UNIQUEIDENTIFIER, 
@ItemUrn INT, 
@PkeyMapUrn INT, 
@CleanupOldItems BIT, 
@PkeyChangeStamp INT OUTPUT)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RowCount INT = 0, @ItemBusinessUrn INT, @Name NVARCHAR(100), @PkeyName NVARCHAR(101), @ItemName NVARCHAR(101), @AuditType NVARCHAR(100), @ClusterResourceId UNIQUEIDENTIFIER, 
    @OldItemUrn INT, @OldItemBusinessUrn INT, @Status CHAR(1), @EffectiveTo DATETIME, @AuditUrn BIGINT, 
    @ReturnCode INT, @ErrorMessage NVARCHAR(500), @SessionUserId UNIQUEIDENTIFIER, @InitialTransactionCount INT = @@TRANCOUNT;

    ---------------------------------------------------------------------------------
    -- PERFORM VALIDATION
    ---------------------------------------------------------------------------------
    BEGIN TRY;
        
        -- Get information required
        SELECT @ItemBusinessUrn = i.ITEM_BIZ_URN
        FROM [dbo].TB_DIM_PERSON AS i
        WHERE i.ITEM_URN = @ItemUrn;

        -- check if item exists
        IF @ItemBusinessUrn IS NULL
        BEGIN 
            SET @ReturnCode = - 1;
            RAISERROR ('Item [%d] does not exist', 16, 1, @ItemUrn) WITH LOG;
        END;

        -- check if pkey exists
        IF NOT EXISTS (
                SELECT 1
                FROM [dbo].[TB_DIM_PERSON_PKEY_MAP]
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                )
        BEGIN 
            SET @ReturnCode = - 1;
            RAISERROR ('PKey map urn [%d] does not exist', 16, 1, @PkeyMapUrn);
        END;

        -- check pkey not already associated to pkey-map
        IF EXISTS (
                SELECT 1
                FROM [dbo].[TB_DIM_PERSON_PKEY_MAP] map
                INNER JOIN [dbo].[TB_DIM_PERSON] item ON item.[ITEM_BIZ_URN] = map.[ITEM_BIZ_URN] AND item.[LATEST] = 1
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn AND item.[ITEM_URN] = @ItemUrn AND [STATUS] <> 'D'
                )
        BEGIN 
            SET @ReturnCode = - 1;
            SELECT @PkeyName = CONCAT(map.FIRST_NAME,'_',map.LAST_NAME), @Name = item.NAME
                FROM [dbo].[TB_DIM_PERSON_PKEY_MAP] map
                INNER JOIN [dbo].[TB_DIM_PERSON] item ON item.[ITEM_BIZ_URN] = map.[ITEM_BIZ_URN] AND item.[LATEST] = 1
                WHERE [PKEY_MAP_URN] = @PkeyMapUrn AND item.[ITEM_URN] = @ItemUrn AND [STATUS] <> 'D';
            RAISERROR ('There is already a link between Item [%s] and PkeyMap [%s]', 16, 1, @Name, @PkeyName);
        END;

        -- check item is not already associated with the cluster resource
        IF EXISTS (
                SELECT 1
                FROM [dbo].[TB_DIM_PERSON_PKEY_MAP] map
                INNER JOIN [dbo].[TB_DIM_PERSON] item ON item.[ITEM_BIZ_URN] = map.[ITEM_BIZ_URN] AND item.[LATEST] = 1
                WHERE item.[ITEM_URN] = @ItemUrn AND [STATUS] <> 'D'
                AND [CLUSTER_RESOURCE_ID] IN (SELECT [CLUSTER_RESOURCE_ID]
                                              FROM [dbo].[TB_DIM_PERSON_PKEY_MAP]
                                              WHERE [PKEY_MAP_URN] = @PkeyMapUrn
                                              )
                )
        BEGIN 
            SET @ReturnCode = - 1;
            SELECT  @ItemName = item.NAME
                FROM [dbo].[TB_DIM_PERSON_PKEY_MAP] map
                INNER JOIN [dbo].[TB_DIM_PERSON] item ON item.[ITEM_BIZ_URN] = map.[ITEM_BIZ_URN] AND item.[LATEST] = 1
                WHERE item.[ITEM_URN] = @ItemUrn AND [STATUS] <> 'D';
            RAISERROR ('Item [%s] already has an active pkey mapping for the cluster resource.', 16, 1, @ItemName);
        END;

        IF NOT EXISTS (
                SELECT 1
                FROM dbo.TB_ADM_SESSION
                WHERE SESSION_ID = @SessionId
                )
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR (@ReturnCode, 16, 1, 'ap_dim01_conform_person_pkey_maps');
        END;
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = CASE WHEN @@ERROR <> 0 AND @ReturnCode <> 0 THEN @@ERROR ELSE @ReturnCode END, 
               @ErrorMessage = CASE WHEN @@ERROR <> 0 AND @ReturnCode <> 0 THEN ERROR_MESSAGE() ELSE '' END;
        RAISERROR (@ErrorMessage, 16, 5, @ReturnCode) WITH LOG;
    END CATCH;
    ---------------------------------------------------------------------------------
    -- COLLECT VALUES REQUIRED
    ---------------------------------------------------------------------------------    
    -- Retrieve user information
    SELECT @SessionUserId = USER_ID
    FROM dbo.TB_SEC_USER
    WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
    AND LOGIN_NAME = (SELECT SESSION_USER_NAME
                      FROM dbo.TB_ADM_SESSION
                      WHERE SESSION_ID = @SessionId
                      );

    -- Get old item info
    SELECT @Status = map.STATUS, @EffectiveTo = map.EFFECTIVE_TO, @OldItemUrn = it.[ITEM_URN], @OldItemBusinessUrn = it.[ITEM_BIZ_URN], @ClusterResourceId = [CLUSTER_RESOURCE_ID]
    FROM [dbo].[TB_DIM_PERSON_PKEY_MAP] map
    INNER JOIN [dbo].[TB_DIM_PERSON] it ON it.ITEM_BIZ_URN = map.ITEM_BIZ_URN
    WHERE [PKEY_MAP_URN] = @PkeyMapUrn AND it.LATEST = 1;

    BEGIN TRY;
        BEGIN TRANSACTION CreateHierarchyTransaction;
        

        ---------------------------------------------------------------------------------
        -- MARK OLD PKEY MAP URN AS DELETED
        ---------------------------------------------------------------------------------
        UPDATE [dbo].[TB_DIM_PERSON_PKEY_MAP]
        SET [MODIFIED_DATE] = GETUTCDATE(), 
            [MODIFIED_BY_ID] = @SessionUserId, 
            [EFFECTIVE_TO] = GETUTCDATE(), 
            [STATUS] = 'D', 
            [PURGED] = 1, 
            [CHANGE_STAMP] = [CHANGE_STAMP] + 1, 
            [LATEST] = 0
        WHERE [PKEY_MAP_URN] = @PkeyMapUrn AND [CHANGE_STAMP] = @PkeyChangeStamp AND [STATUS] <> 'D';

        SELECT @RowCount = @@ROWCOUNT;

        IF @RowCount <> 1 -- no rows updated during update
        BEGIN 
            SET @ReturnCode = - 2;
            RAISERROR ('Concurrency conflict marking old pkey-map [%d] as deleted. Error [%d]', 16, 1, @PkeyMapUrn, @ReturnCode) WITH LOG;
        END;

        ---------------------------------------------------------------------------------
        -- COPY PKEY MAP RECORD
        ---------------------------------------------------------------------------------
        INSERT INTO [dbo].[TB_DIM_PERSON_PKEY_MAP] ([PKEY_MAP_BIZ_URN], [ITEM_BIZ_URN], [CLUSTER_RESOURCE_ID], [STATUS], [PKEY1], 
        [PKEY2], [SOURCE_CHANGE_STAMP], [DESCRIPTION], [FIRST_NAME], [LAST_NAME], [LOGIN_NAME], [PASS_PHRASE], [LOGIN_ENABLED], 
        [EFFECTIVE_FROM], [EFFECTIVE_TO], [SYSTEM], [PURGED], [LATEST], [CREATED_BY_ID], [MODIFIED_BY_ID], [CREATION_DATE], 
        [MODIFIED_DATE], [XML_DATA], [CUSTOM_XML_DATA])
        SELECT p.[PKEY_MAP_BIZ_URN], @ItemBusinessUrn, p.[CLUSTER_RESOURCE_ID], @Status, p.[PKEY1], p.[PKEY2], p.[SOURCE_CHANGE_STAMP], 
        p.[DESCRIPTION], p.[FIRST_NAME], p.[LAST_NAME], p.[LOGIN_NAME], p.[PASS_PHRASE], p.[LOGIN_ENABLED], p.[EFFECTIVE_FROM], 
        p.[EFFECTIVE_TO], p.[SYSTEM], 0, 1, @SessionUserId, @SessionUserId, GETUTCDATE(), GETUTCDATE(), p.[XML_DATA], p.[CUSTOM_XML_DATA]
        FROM [dbo].[TB_DIM_PERSON_PKEY_MAP] p
        WHERE p.[PKEY_MAP_URN] = @PkeyMapUrn;

        -- audit change | 74 = IT_PERSON
        EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_MERGED', DEFAULT, @OldItemBusinessUrn, @ItemBusinessUrn, 74, 74, @ClusterResourceId, 
        NULL, 'S', 0, 'DIMENSION_MERGED', NULL, NULL, NULL, @AuditUrn OUTPUT;

        ---------------------------------------------------------------------------------
        -- Copy AGENT_PERSON_MEMBERs
        ---------------------------------------------------------------------------------
        INSERT INTO [dbo].[TB_DIM_AGENT_PERSON_MEMBER] ([MEMBER_BIZ_URN], [PARENT_ITEM_BIZ_URN], [CHILD_ITEM_BIZ_URN], [EFFECTIVE_FROM], 
        [EFFECTIVE_TO], [CREATION_DATE], [MODIFIED_DATE], [CREATED_BY_ID], [MODIFIED_BY_ID], [DELETED], [HIDDEN], [LATEST], [SYSTEM], [XML_DATA])
        SELECT m.[MEMBER_BIZ_URN], CASE [PARENT_ITEM_BIZ_URN] WHEN @OldItemBusinessUrn THEN @ItemBusinessUrn ELSE [PARENT_ITEM_BIZ_URN] END, 
        CASE [CHILD_ITEM_BIZ_URN] WHEN @OldItemBusinessUrn THEN @ItemBusinessUrn ELSE [CHILD_ITEM_BIZ_URN] END, 
        CASE WHEN m.[EFFECTIVE_FROM] > GETUTCDATE() THEN m.[EFFECTIVE_FROM] ELSE GETUTCDATE() END, m.[EFFECTIVE_TO], GETUTCDATE(), GETUTCDATE(), 
        @SessionUserId, @SessionUserId, [DELETED], [HIDDEN], 1, m.[SYSTEM], m.[XML_DATA]
        FROM [dbo].[TB_DIM_AGENT_PERSON_MEMBER] m
        INNER JOIN [dbo].[TB_DIM_AGENT_PERSON_MEMBER_PKEY_MAP] map ON m.[MEMBER_BIZ_URN] = map.[MEMBER_BIZ_URN] AND map.LATEST = 1 AND m.LATEST = 1 
        WHERE m.[PARENT_ITEM_BIZ_URN] = @OldItemBusinessUrn AND map.[CLUSTER_RESOURCE_ID] = @ClusterResourceId AND map.[STATUS] <> 'D';

        -- Mark old member records as deleted if no more active pkey maps exist
        IF NOT EXISTS (
                SELECT 1
                FROM [dbo].[TB_DIM_AGENT_PERSON_MEMBER] m
                INNER JOIN [dbo].[TB_DIM_AGENT_PERSON_MEMBER_PKEY_MAP] map ON m.[MEMBER_BIZ_URN] = map.[MEMBER_BIZ_URN] AND map.LATEST = 1 AND m.LATEST = 1
                WHERE m.[PARENT_ITEM_BIZ_URN] = @OldItemBusinessUrn AND map.[CLUSTER_RESOURCE_ID] <> @ClusterResourceId AND map.[STATUS] <> 'D'
                )
        BEGIN 
            UPDATE [dbo].[TB_DIM_AGENT_PERSON_MEMBER]
            SET [DELETED] = 1, 
                [LATEST] = 0, 
                [EFFECTIVE_TO] = GETUTCDATE(), 
                [MODIFIED_DATE] = GETUTCDATE(), 
                [MODIFIED_BY_ID] = @SessionUserId, 
                [CHANGE_STAMP] = [CHANGE_STAMP] + 1
            WHERE [MEMBER_URN] IN (
                    SELECT m.[MEMBER_URN]
                    FROM [dbo].[TB_DIM_AGENT_PERSON_MEMBER] m
                    WHERE m.[PARENT_ITEM_BIZ_URN] = @OldItemBusinessUrn AND m.DELETED = 0 AND m.LATEST = 1
                    );
        END;

        ---------------------------------------------------------------------------------
        -- Copy DEVICE_PROFILE_PERSON_MEMBERs
        ---------------------------------------------------------------------------------
        INSERT INTO [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER] ([MEMBER_BIZ_URN], [PARENT_ITEM_BIZ_URN], [CHILD_ITEM_BIZ_URN], [EFFECTIVE_FROM], 
        [EFFECTIVE_TO], [CREATION_DATE], [MODIFIED_DATE], [CREATED_BY_ID], [MODIFIED_BY_ID], [DELETED], [HIDDEN], [LATEST], [SYSTEM], [XML_DATA])
        SELECT m.[MEMBER_BIZ_URN], CASE [PARENT_ITEM_BIZ_URN] WHEN @OldItemBusinessUrn THEN @ItemBusinessUrn ELSE [PARENT_ITEM_BIZ_URN] END, 
        CASE [CHILD_ITEM_BIZ_URN] WHEN @OldItemBusinessUrn THEN @ItemBusinessUrn ELSE [CHILD_ITEM_BIZ_URN] END, 
        CASE WHEN m.[EFFECTIVE_FROM] > GETUTCDATE() THEN m.[EFFECTIVE_FROM] ELSE GETUTCDATE() END, m.[EFFECTIVE_TO], GETUTCDATE(), GETUTCDATE(), 
        @SessionUserId, @SessionUserId, [DELETED], [HIDDEN], 1, m.[SYSTEM], m.[XML_DATA]
        FROM [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER] m
        INNER JOIN [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP] map ON m.[MEMBER_BIZ_URN] = map.[MEMBER_BIZ_URN] AND map.LATEST = 1 AND m.LATEST = 1
        WHERE m.[PARENT_ITEM_BIZ_URN] = @OldItemBusinessUrn AND map.[CLUSTER_RESOURCE_ID] = @ClusterResourceId AND map.[STATUS] <> 'D';

        -- Mark old member records as deleted if no more active pkey maps exist
        IF NOT EXISTS (
                SELECT 1
                FROM [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER] m
                INNER JOIN [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP] map ON m.[MEMBER_BIZ_URN] = map.[MEMBER_BIZ_URN] AND map.LATEST = 1 AND m.LATEST = 1
                WHERE m.[PARENT_ITEM_BIZ_URN] = @OldItemBusinessUrn AND map.[CLUSTER_RESOURCE_ID] <> @ClusterResourceId AND map.[STATUS] <> 'D'
                )
        BEGIN 
            UPDATE [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER]
            SET [DELETED] = 1, 
                [LATEST] = 0, 
                [EFFECTIVE_TO] = GETUTCDATE(), 
                [MODIFIED_DATE] = GETUTCDATE(), 
                [MODIFIED_BY_ID] = @SessionUserId, 
                [CHANGE_STAMP] = [CHANGE_STAMP] + 1
            WHERE [MEMBER_URN] IN (
                    SELECT m.[MEMBER_URN]
                    FROM [dbo].[TB_DIM_DEVICE_PROFILE_PERSON_MEMBER] m
                    WHERE m.[PARENT_ITEM_BIZ_URN] = @OldItemBusinessUrn
                        AND m.DELETED = 0
                        AND m.LATEST = 1
                    );
        END;

        -- if user wants to clean up old items; mark the old item as deleted if it doesn't have a related pkey map
        IF @CleanupOldItems = 1 AND NOT EXISTS (SELECT 1
                                                FROM [dbo].[TB_DIM_PERSON_PKEY_MAP]
                                                WHERE [ITEM_BIZ_URN] = @OldItemBusinessUrn
                                                AND [STATUS] <> 'D' AND [LATEST] = 1
                                                )
        BEGIN 
            DECLARE @_ChangeStamp INT;

            SELECT @_ChangeStamp = [CHANGE_STAMP]
            FROM [dbo].[TB_DIM_PERSON]
            WHERE [ITEM_URN] = @OldItemUrn;

            EXEC [ap_dim01_delete_person] @SessionId, @OldItemUrn, @_ChangeStamp;
        END;
        SET @ReturnCode = 0;
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = CASE WHEN @ReturnCode <> 0 THEN @@ERROR ELSE @ReturnCode END,
               @ErrorMessage = CASE WHEN @ReturnCode <> 0 THEN ERROR_MESSAGE() ELSE '' END;

        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
            RAISERROR (@ErrorMessage, 16, 2, 'ap_dim01_conform_person_pkey_maps');
        END;
        ELSE BEGIN
            IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
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
            END;
        END;
    END CATCH;

    IF @InitialTransactionCount = 0 
    BEGIN 
       COMMIT TRANSACTION CreateHierarchyTransaction;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;

    RETURN @ReturnCode;
END
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_conform_person_pkey_maps]
	TO [portalapp_role]
GO
