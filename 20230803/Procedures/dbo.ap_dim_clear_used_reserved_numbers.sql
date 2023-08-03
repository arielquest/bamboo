SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- This routine removes any existing reserved numbers that have now been
-- assigned to the relevant dimension table. 
-------------------------------------------------------------------------------
CREATE PROCEDURE dbo.ap_dim_clear_used_reserved_numbers (@I_ItemTypeID AS UNIQUEIDENTIFIER, @I_ItemColumnName AS NVARCHAR(50), 
@I_ParentURN AS INT = NULL, @I_ClusterResourceID AS UNIQUEIDENTIFIER = NULL, @I_FolderID AS UNIQUEIDENTIFIER = NULL, 
@I_OwnerID AS UNIQUEIDENTIFIER = NULL, @O_NextValue AS NVARCHAR(50) OUTPUT) AS

SET NOCOUNT ON;

-- Fix up default parameters
IF @I_ParentURN IS NULL
BEGIN 
    SET @I_ParentURN = -2;
END;

IF @I_ClusterResourceID IS NULL
BEGIN 
    SET @I_ClusterResourceID = '00000002-0000-0000-0000-000000000005';
END;

IF @I_FolderID IS NULL
BEGIN 
    SET @I_FolderID = '00000002-0000-0000-0000-000000000005';
END;

DECLARE @v_Error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, @ErrorMessage VARCHAR(200);

BEGIN TRANSACTION ClearReservedTransaction;

    BEGIN TRY;
        IF @I_ItemTypeID = '00011100-1000-0000-0000-000000000010' AND @I_ItemColumnName = 'DIRECTORY_NUMBER_OR_PATTERN'
        -- Directory Number type id
        BEGIN 
            DELETE
            FROM dbo.TB_DIM_RESERVED_NAME WITH (READPAST)
            WHERE [ITEM_TYPE_ID] = @I_ItemTypeID AND [COLUMN_NAME] = @I_ItemColumnName AND [PARENT_URN] = @I_ParentURN
            AND ((@I_ClusterResourceID IS NULL AND CLUSTER_RESOURCE_ID IS NULL) OR [CLUSTER_RESOURCE_ID] = @I_ClusterResourceID)
            AND [FOLDER_ID] = @I_FolderID AND [OWNER_ID] = @I_OwnerID AND EXISTS (SELECT 1
                                                                                  FROM dbo.TB_DIM_DIRECTORY_NUMBER_PKEY_MAP WITH (READPAST)
                                                                                  WHERE [DIRECTORY_NUMBER_OR_PATTERN] = [RESERVED_NAME]);
        END;
        ELSE IF @I_ItemTypeID = '00001100-1000-0000-0000-000000000010' AND @I_ItemColumnName = 'PERIPHERAL_NUMBER'
        -- Agent type id
        BEGIN 
            DELETE
            FROM dbo.TB_DIM_RESERVED_NAME WITH (READPAST)
            WHERE [ITEM_TYPE_ID] = @I_ItemTypeID AND [COLUMN_NAME] = @I_ItemColumnName AND [PARENT_URN] = @I_ParentURN
            AND ((@I_ClusterResourceID IS NULL AND CLUSTER_RESOURCE_ID IS NULL) OR [CLUSTER_RESOURCE_ID] = @I_ClusterResourceID)
            AND [FOLDER_ID] = @I_FolderID AND [OWNER_ID] = @I_OwnerID AND EXISTS (SELECT 1
                                                                                  FROM dbo.TB_DIM_AGENT_PKEY_MAP WITH (READPAST)
                                                                                  WHERE [PERIPHERAL_NUMBER] = [RESERVED_NAME]);
        END;
        ELSE IF @I_ItemTypeID = '00007600-1000-0000-0000-000000000010' AND @I_ItemColumnName = 'PERIPHERAL_NUMBER'
        -- Skill group type id
        BEGIN 
            DELETE
            FROM dbo.TB_DIM_RESERVED_NAME WITH (READPAST)
            WHERE [ITEM_TYPE_ID] = @I_ItemTypeID AND [COLUMN_NAME] = @I_ItemColumnName AND [PARENT_URN] = @I_ParentURN
            AND ((@I_ClusterResourceID IS NULL AND CLUSTER_RESOURCE_ID IS NULL) OR [CLUSTER_RESOURCE_ID] = @I_ClusterResourceID)
            AND [FOLDER_ID] = @I_FolderID AND [OWNER_ID] = @I_OwnerID AND EXISTS (SELECT 1
                                                                                  FROM dbo.TB_DIM_SKILLGROUP_PKEY_MAP WITH (READPAST)
                                                                                  WHERE [PERIPHERAL_NUMBER] = [RESERVED_NAME]);
        END;
        ELSE IF @I_ItemTypeID = '00007500-1000-0000-0000-000000000010' AND @I_ItemColumnName = 'PERIPHERAL_NUMBER'
        -- Service type id
        BEGIN 
            DELETE
            FROM dbo.TB_DIM_RESERVED_NAME WITH (READPAST)
            WHERE [ITEM_TYPE_ID] = @I_ItemTypeID AND [COLUMN_NAME] = @I_ItemColumnName AND [PARENT_URN] = @I_ParentURN
            AND ((@I_ClusterResourceID IS NULL AND CLUSTER_RESOURCE_ID IS NULL) OR [CLUSTER_RESOURCE_ID] = @I_ClusterResourceID)
            AND [FOLDER_ID] = @I_FolderID AND [OWNER_ID] = @I_OwnerID AND EXISTS (SELECT 1
                                                                                  FROM dbo.TB_DIM_SERVICE_PKEY_MAP WITH (READPAST)
                                                                                  WHERE [PERIPHERAL_NUMBER] = [RESERVED_NAME]);
        END;
        ELSE BEGIN 
            SET @v_Error = -1;
            RAISERROR ('Invalid type parameters, error [%d]', 16, 1, @v_Error);
        END;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION ClearReservedTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
        SET @v_Error = 0;
    END TRY
    BEGIN CATCH;
        SELECT @v_Error = CASE WHEN @v_Error <> -1 THEN @@ERROR ELSE @v_Error END,
               @ErrorMessage = '['+ OBJECT_NAME(@@PROCID) + ']' +ISNULL(': '+ERROR_MESSAGE(),'');
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
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    END CATCH;

RETURN @v_Error;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim_clear_used_reserved_numbers]
	TO [portalapp_role]
GO
