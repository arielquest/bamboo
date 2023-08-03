SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Many items must have globally unique column/field names. This procedure 
-- assembles the name based on the rules for that type and column and the 
-- supplied seed values. The assmebled named is reserved within the dictionary
-- Returns: < 0 - SQL Engine error
--            0 - Value reserved correctly
--            1 - Value already reserved.
-------------------------------------------------------------------------------
CREATE PROCEDURE dbo.ap_dim01_reserve_internal_name (
@I_ItemTypeID UNIQUEIDENTIFIER, @I_ItemInternalName NVARCHAR(50), @I_ParentURN INT = - 2,
@I_ClusterResourceID UNIQUEIDENTIFIER = NULL, @I_FolderID UNIQUEIDENTIFIER = NULL,
@I_OwnerID UNIQUEIDENTIFIER = NULL) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error INT = 0, @v_RowCount INT, @InitialTransactionCount INT = @@TRANCOUNT, @ErrorMessage VARCHAR(200);
    
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    
    -- Perform a test and set operation on the next number.
    BEGIN TRANSACTION ReserveInternalTransaction;
    BEGIN TRY;
        -- Remove any names from the reserved list that are now in the main dimension base table.
        DELETE A 
        FROM dbo.TB_DIM_RESERVED_NAME A
        INNER JOIN dbo.VW_DIM_ITEM_PKEY_MAP B ON B.ITEM_TYPE_ID = @I_ItemTypeID AND A.[RESERVED_NAME] = B.[INTERNAL_NAME]
        WHERE A.COLUMN_NAME = 'INTERNAL_NAME' AND A.ITEM_TYPE_ID = B.ITEM_TYPE_ID
        OPTION(RECOMPILE);

        DECLARE @exists BIT;
        SELECT @exists = CASE WHEN EXISTS (SELECT 1
                                           FROM (SELECT INTERNAL_NAME, ITEM_TYPE_ID
                                                 FROM [dbo].[VW_DIM_ITEM_PKEY_MAP]
                                                 UNION ALL 
                                                 SELECT [RESERVED_NAME], [ITEM_TYPE_ID] 
                                                 FROM [dbo].[TB_DIM_RESERVED_NAME]
                                                 WHERE [COLUMN_NAME]='INTERNAL_NAME') a(INTERNAL_NAME, ITEM_TYPE_ID)
                                           WHERE INTERNAL_NAME = @I_ItemInternalName AND ITEM_TYPE_ID = @I_ItemTypeID
                                           ) THEN 1 ELSE 0 END
        OPTION(RECOMPILE);

        IF @exists = 0
        BEGIN 
            BEGIN TRY;
                -- Name not reserved so reserve it.
                INSERT INTO dbo.TB_DIM_RESERVED_NAME ([ITEM_TYPE_ID], [RESERVED_NAME], [COLUMN_NAME], [PARENT_URN], [CLUSTER_RESOURCE_ID], [OWNER_ID], [FOLDER_ID])
                VALUES (@I_ItemTypeID, @I_ItemInternalName, 'INTERNAL_NAME', @I_ParentURN, @I_ClusterResourceID, @I_OwnerID, @I_FolderID);

                SET @v_RowCount = @@ROWCOUNT;
                IF @v_RowCount <> 1
                BEGIN 
                    RAISERROR('Could not reserve internal name [%s]. Error [%d]', 16, 1, @v_Error, @I_ItemInternalName);
                END;
            END TRY
            BEGIN CATCH;
                SELECT @ErrorMessage = ISNULL(': '+ERROR_MESSAGE(),'');
                RAISERROR(@ErrorMessage, 16, 1);
            END CATCH;              
        END;
        ELSE BEGIN 
            SET @v_Error = 1;
        END;
        IF (XACT_STATE()) = -1
        BEGIN 
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': Uncommittable Transaction!';
            RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
        END;
        ELSE BEGIN
            IF @InitialTransactionCount = 0 
            BEGIN 
                COMMIT TRANSACTION ReserveInternalTransaction;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END;    
    END TRY
    BEGIN CATCH;
        SELECT @ErrorMessage = OBJECT_NAME(@@PROCID)+ISNULL(': '+ERROR_MESSAGE(),'');
        -- Did we initiate all transactions
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
        END;
        RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
    
    RETURN @v_Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_reserve_internal_name]
	TO [portalapp_role]
GO
