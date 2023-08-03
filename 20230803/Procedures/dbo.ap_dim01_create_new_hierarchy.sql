SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_create_new_hierarchy] (
@SessionId AS UNIQUEIDENTIFIER, 
@TenantId AS UNIQUEIDENTIFIER, 
@Name AS NVARCHAR(100), 
@Description AS NVARCHAR(500), 
@ItemSubTypeId AS UNIQUEIDENTIFIER, 
@ItemUrn AS INT OUTPUT)
AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ReturnCode AS INT = 0, @UtcNow AS DATETIME = DATEADD(ms, - (DATEPART(ms, GETUTCDATE())), GETUTCDATE()), @InitialTransactionCount AS INT = @@TRANCOUNT, @ErrorMessage VARCHAR(1000);
    SET @ItemUrn = NULL;

    -- Validate Session ID
    IF @SessionId IS NULL
    BEGIN 
        SET @ReturnCode = 50157;
        RAISERROR (50157, 16, 1, 'ap_dim01_create_new_hierarchy');
        RETURN @ReturnCode;
    END;

    IF NOT EXISTS (
            SELECT 1
            FROM dbo.TB_ADM_SESSION
            WHERE SESSION_ID = @SessionId
            )
    BEGIN 
        SET @ReturnCode = 50157;
        RAISERROR (50157, 16, 1, 'ap_dim01_create_new_hierarchy');
        RETURN @ReturnCode;
    END;

    -- Validate Tenant ID
    IF @TenantId IS NULL
    BEGIN 
        SET @ReturnCode = - 1;
        RAISERROR ('ap_dim01_create_new_hierarchy: The tenant id not specified', 16, 5);
        RETURN @ReturnCode;
    END;

    IF NOT EXISTS (
            SELECT 1
            FROM dbo.TB_SEC_FOLDER
            WHERE FOLDER_ID = @TenantId AND FOLDER_TYPE = 'T'
            )
    BEGIN 
        SET @ReturnCode = - 1;
        RAISERROR ('ap_dim01_create_new_hierarchy: The specified tenant id either does not exist or is not a valid tenant', 16, 1);
        RETURN @ReturnCode;
    END;

    -- Validate Item Subtype ID
    IF @ItemSubTypeId IS NULL
    BEGIN 
        SET @ReturnCode = - 1;
        RAISERROR ('ap_dim01_create_new_hierarchy: The item sub-type id not specified', 16, 5);
        RETURN @ReturnCode;
    END;

    IF NOT EXISTS (
            SELECT 1
            FROM dbo.TE_DIM_ITEM_SUBTYPE
            WHERE ITEM_SUBTYPE_ID = @ItemSubTypeId AND ITEM_TYPE_ID = '00039551-1000-0000-0000-000000000010'
            )
    BEGIN 
        SET @ReturnCode = - 1
        RAISERROR ('ap_dim01_create_new_hierarchy: The specified item sub-type id either does not exist or is not a valid sub type of item type Hierarchy (IT_HIERARCHY).', 16, 1)
        RETURN @ReturnCode;
    END;

    -- Check if there is a hierarchy of the specified sub-type already in the tenant.
    IF EXISTS (
            SELECT 1
            FROM dbo.VW_DIM_HIERARCHY
            WHERE ITEM_SUBTYPE_ID = @ItemSubTypeId AND OWNER_ID = @TenantId
            AND @UtcNow BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
            )
    BEGIN 
        SET @ReturnCode = - 1;
        RAISERROR ('ap_dim01_create_new_hierarchy: A hierarchy of the specified subtype already exists within the specified tenant.', 16, 1);
        RETURN @ReturnCode;
    END;

    -- Validate name
    IF LEN(@Name) = 0 OR @Name IS NULL
    BEGIN 
        SET @ReturnCode = - 1
        RAISERROR ('ap_dim01_create_new_hierarchy: Specified name is invalid.', 16, 1);
        RETURN @ReturnCode;
    END;

    BEGIN TRANSACTION CreateHierarchyTransaction;
    
    BEGIN TRY;
        EXEC @ReturnCode = [dbo].[ap_dim01_add_hierarchy] @SessionId = @SessionId, @Name = @Name, @FolderId = @TenantId, 
        @OwnerId = @TenantId, @ItemSubTypeId = @ItemSubTypeId, @Description = @Description, @EffectiveFrom = @UtcNow, 
        @EffectiveTo = NULL, @XmlData = NULL, @HierarchyParentUrn = NULL, @Editable = 1, @ItemUrn = @ItemUrn OUTPUT;

        IF @ReturnCode <> 0
        BEGIN 
            RAISERROR ('Error in catch block', 16, 1);
        END;

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
        SET @ReturnCode = 0;
    END TRY
    BEGIN CATCH;
        SET @ErrorMessage = ERROR_MESSAGE();
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
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    END CATCH;

    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_create_new_hierarchy]
	TO [portalapp_role]
GO
