SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_unpurge_dimension_to_deleted]
(
    @SessionId AS [UNIQUEIDENTIFIER],
    @PkeyMapUrn AS [INTEGER],
    @ItemTypeId AS [UNIQUEIDENTIFIER]
) AS
    SET NOCOUNT ON;
    
    DECLARE    @v_AuditUrn                AS [BIGINT],        
            @v_ItemBusinessUrn        AS [INT],
            @v_ClusterResourceId    AS [uniqueidentifier],
            @v_SessionUserId        AS [uniqueidentifier],
            @v_PkeyTableName        AS NVARCHAR(100),
            @v_Sql                    AS NVARCHAR(2000),
            @v_ItemTypeUrn            AS [INT],
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
            SELECT     @v_ItemBusinessUrn = m.ITEM_BIZ_URN,
                    @v_ClusterResourceId = m.CLUSTER_RESOURCE_ID
            FROM dbo.' + @v_PkeyTableName + N'_PKEY_MAP m
            WHERE m.PKEY_MAP_URN = @PkeyMapUrn
            AND m.LATEST = 1
            AND m.PURGED = 1;';

    EXEC sp_executesql @v_Sql, N'@v_ItemBusinessUrn [INT] OUTPUT,
              @v_ClusterResourceId [uniqueidentifier] OUTPUT,
              @PkeyMapUrn [INT]', @v_ItemBusinessUrn = @v_ItemBusinessUrn OUTPUT, @v_ClusterResourceId = @v_ClusterResourceId OUTPUT, @PkeyMapUrn = @PkeyMapUrn;
 

    -- check record is currently purged
    IF @v_ItemBusinessUrn IS NULL
    BEGIN 
        RAISERROR('ap_dim01_unpurge_dimension_to_deleted: Pkey Map [%d,%s] does not exist or is not currently purged.', 16, 1, @PkeyMapUrn, @v_PkeyTableName) WITH LOG;
        RETURN 1;
    END;
        
    BEGIN TRANSACTION UnpurgeDimensionDTransaction;    
        -- de-purge cluster resource record    
        SET @v_Sql = N'
                    UPDATE dbo.' + @v_PkeyTableName + N'_PKEY_MAP
                    SET PURGED = 0, MODIFIED_DATE = GETUTCDATE(), MODIFIED_BY_ID = @v_SessionUserId
                    WHERE PKEY_MAP_URN = @PkeyMapUrn 
                    AND PURGED = 1
                    AND LATEST = 1;';

        EXEC sp_executesql @v_Sql, N'@v_SessionUserId [uniqueidentifier],
                      @PkeyMapUrn [INT]', @v_SessionUserId = @v_SessionUserId, @PkeyMapUrn = @PkeyMapUrn;

        -- audit the execution event under the session
        EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_DIMENSION_DELETE_COMMITTED_ON_EQUIPMENT', DEFAULT, @v_ItemBusinessUrn, DEFAULT,  @v_ItemTypeUrn, DEFAULT, @v_ClusterResourceId, DEFAULT, 'S', 0, 
                                    'DIM_DELETED_FROM_EQUIPMENT_BY_IMPORTER', 'Item unpurged to deleted by importer', NULL, NULL, @v_AuditUrn out;
    
    IF @InitialTransactionCount = 0 
    BEGIN 
        COMMIT TRANSACTION UnpurgeDimensionDTransaction;
    END;    
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_unpurge_dimension_to_deleted]
	TO [portalapp_role]
GO
