SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_unpurge_dimension_to_ready]
(
    @SessionId AS [UNIQUEIDENTIFIER],
    @PkeyMapUrn AS [INTEGER],
    @ItemTypeId AS [UNIQUEIDENTIFIER],
    @EffectiveTo AS [SMALLDATETIME] OUTPUT
) AS
    SET NOCOUNT ON;

    DECLARE    @v_AuditType           AS [NVARCHAR](50),
            @v_AuditUrn                AS [BIGINT],
            @v_ItemUrn                AS [INT],
            @v_ItemBusinessUrn        AS [INT],
            @v_ItemTypeUrn            AS [INT],
            @v_ClusterResourceId    AS [uniqueidentifier],
            @v_SessionUserId        AS [uniqueidentifier],
            @v_PkeyTableName        AS NVARCHAR(100),
            @v_Sql                    AS NVARCHAR(2000),
            @InitialTransactionCount INT = @@TRANCOUNT;
    
    --Check Session Id
    IF @SessionId IS NULL
    BEGIN 
        RAISERROR(50157, 16, 5, 'ap_dim01_unpurge_dimension_to_deleted');
        RETURN 1;
    END;
    
    IF NOT EXISTS(SELECT * FROM TB_ADM_SESSION WHERE SESSION_ID = @SessionId)
    BEGIN 
        RAISERROR(50157, 16, 5, 'ap_dim01_unpurge_dimension_to_deleted');
        RETURN 1;
    END;
    
    -- Retrieve user information
    SELECT @v_SessionUserId = USER_ID
    FROM dbo.TB_SEC_USER
    WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM
            AND EFFECTIVE_TO
        AND LOGIN_NAME = (
            SELECT SESSION_USER_NAME
            FROM dbo.TB_ADM_SESSION
            WHERE SESSION_ID = @SessionId
            );

    -- Get table name for this type
    SELECT @v_PkeyTableName = TABLE_NAME, @v_ItemTypeUrn = ITEM_TYPE_URN
    FROM dbo.TE_DIM_ITEM_TYPE
    WHERE ITEM_TYPE_ID = @ItemTypeId;

    -- Get info
    SET @v_Sql = N'
            SELECT @EffectiveTo = i.EFFECTIVE_TO, @v_ItemUrn = i.ITEM_URN, @v_ItemBusinessUrn = i.ITEM_BIZ_URN, @v_ClusterResourceId = m.CLUSTER_RESOURCE_ID
            FROM dbo.' + @v_PkeyTableName + N' i
            JOIN dbo.' + @v_PkeyTableName + N'_PKEY_MAP m ON m.ITEM_BIZ_URN = i.ITEM_BIZ_URN AND m.LATEST = 1    
            WHERE m.PKEY_MAP_URN = @PkeyMapUrn
            AND i.LATEST = 1
            AND m.STATUS IN (''D'', ''E'') ';

    EXEC sp_executesql @v_Sql, N'@EffectiveTo [SMALLDATETIME] OUTPUT,
              @v_ItemUrn [INT] OUTPUT,
              @v_ItemBusinessUrn [INT] OUTPUT,
              @v_ClusterResourceId [uniqueidentifier] OUTPUT,
              @PkeyMapUrn [INT]', @EffectiveTo = @EffectiveTo OUTPUT, @v_ItemUrn = @v_ItemUrn OUTPUT, @v_ItemBusinessUrn = @v_ItemBusinessUrn OUTPUT, 
              @v_ClusterResourceId = @v_ClusterResourceId OUTPUT, @PkeyMapUrn = @PkeyMapUrn;

    -- Check record is currently deleted
    IF @v_ItemUrn IS NULL
    BEGIN 
        RAISERROR('ap_dim01_unpurge_dimension_to_ready: Pkey Map [%d, %s] not currently deleted or does not exist.', 16, 1, @PkeyMapUrn, @v_PkeyTableName) WITH LOG;
        RETURN 1;
    END;
    
    IF(@EffectiveTo <= GETUTCDATE())
    BEGIN 
        SET @EffectiveTo = '2079-06-06 00:00:00';    
    END;
    
    BEGIN TRANSACTION UnpurgeDimensionTransaction;
    -- Undelete item if needed
    SET @v_Sql = N'
                UPDATE dbo.' + @v_PkeyTableName + N' 
                SET DELETED = 0, 
                    EFFECTIVE_TO = @EffectiveTo,
                    MODIFIED_DATE = GETUTCDATE(),
                    MODIFIED_BY_ID = @v_SessionUserId
                WHERE ITEM_URN = @v_ItemUrn    
                AND (DELETED = 1 OR EFFECTIVE_TO < GETUTCDATE())
                AND LATEST = 1';

    EXEC sp_executesql @v_Sql, N'@EffectiveTo [SMALLDATETIME],
                  @v_SessionUserId [uniqueidentifier],
                  @v_ItemUrn [INT]', @EffectiveTo = @EffectiveTo, @v_SessionUserId = @v_SessionUserId, @v_ItemUrn = @v_ItemUrn;

    -- de-purge cluster resource record    
    SET @v_Sql = N'
                UPDATE dbo.' + @v_PkeyTableName + N'_PKEY_MAP
                SET PURGED = 0, STATUS = ''R'', EFFECTIVE_TO = @EffectiveTo, MODIFIED_DATE = GETUTCDATE(), MODIFIED_BY_ID = @v_SessionUserId
                WHERE PKEY_MAP_URN = @PkeyMapUrn
                AND STATUS IN (''D'', ''E'')
                AND LATEST = 1';

    EXEC sp_executesql @v_Sql, N'@EffectiveTo [SMALLDATETIME],
                  @v_SessionUserId [uniqueidentifier],
                  @PkeyMapUrn [INT]', @EffectiveTo = @EffectiveTo, @v_SessionUserId = @v_SessionUserId, @PkeyMapUrn = @PkeyMapUrn;

    -- audit the execution event under the session
    EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_INSERT_COMMITTED_ON_EQUIPMENT', DEFAULT, @v_ItemBusinessUrn, DEFAULT, @v_ItemTypeUrn, DEFAULT, 
    @v_ClusterResourceId, DEFAULT, 'S', 0, 'DIM_ADDED_BY_IMPORTER', 'Item unpurged to Ready by importer', NULL, NULL, @v_AuditUrn OUT;


    IF @InitialTransactionCount = 0 
    BEGIN 
       COMMIT TRANSACTION UnpurgeDimensionTransaction;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_unpurge_dimension_to_ready]
	TO [portalapp_role]
GO
