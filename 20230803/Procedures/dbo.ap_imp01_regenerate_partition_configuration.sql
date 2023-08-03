SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_imp01_regenerate_partition_configuration] 
(
    @FromHostId     AS [UNIQUEIDENTIFIER]
) AS
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--     ap_imp01_regenerate_partition_configuration.sql
--     This stored procedure
--    1. Gets the Other Side of the @FromHostId (in most cases Side B) and Sets it as @ToHostId.
--     2. Checks if the Host Names have been found.
--     3. Calls stored procedure ap_imp01_regenerate_partition_configuration_using_hostnames to peform the actual recovery.
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
BEGIN 
    SET NOCOUNT ON;

    DECLARE @error INT, @InitialTransactionCount INT, @ErrorMessage VARCHAR(200);

    SET @error = 0;
    SET @InitialTransactionCount = @@TRANCOUNT;

    -- Set the Exony RDBMS
    DECLARE @v_PortalDBComponentType NVARCHAR(100);

    SET @v_PortalDBComponentType = 'CT_EXONY_RELATIONAL_DB_DEFAULT';

    -----------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------
    -- Get RDBMS resource instance IDs for @FromHostName and @ToHostName.
    ---------------------------------------------------------------------
    DECLARE @ToHostId AS [UNIQUEIDENTIFIER];

    -- @ToHostId Resource Instance Id
    SELECT @ToHostId = r1.[RESOURCE_INSTANCE_ID]
    FROM [dbo].[TB_CLU_RESOURCE_INSTANCE] r1
    INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] r2 ON (
            r1.[RESOURCE_ID] = r1.[RESOURCE_ID]
            AND r1.[RESOURCE_INSTANCE_ID] <> r2.[RESOURCE_INSTANCE_ID]
            )
    WHERE r1.[RESOURCE_ID] = r2.[RESOURCE_ID]
        AND r2.[RESOURCE_INSTANCE_ID] = @FromHostId;

    -----------------------------------------------------------------------------------------------------------------
    -- Used for error reporting
    DECLARE @v_FromHostName AS NVARCHAR(200);
    DECLARE @v_ToHostName AS NVARCHAR(200);
    DECLARE @v_FromHostId AS NVARCHAR(50);
    DECLARE @v_ToHostId AS NVARCHAR(50);

    SELECT @v_FromHostName = s.[SERVER_NAME]
    FROM [dbo].[TB_CLU_RESOURCE_INSTANCE] AS ri
    INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] AS co ON ri.[RESOURCE_INSTANCE_ID] = co.[RESOURCE_INSTANCE_ID]
    INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] AS ct ON co.[COMPONENT_TYPE_ID] = ct.[COMPONENT_TYPE_ID]
    INNER JOIN [dbo].[TB_CLU_SERVER] AS s ON co.[SERVER_ID] = s.[SERVER_ID]
    WHERE ct.[INTERNAL_NAME] = @v_PortalDBComponentType
        AND ri.[RESOURCE_INSTANCE_ID] = @FromHostId;

    SELECT @v_ToHostName = s.[SERVER_NAME]
    FROM [dbo].[TB_CLU_RESOURCE_INSTANCE] AS ri
    INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] AS co ON ri.[RESOURCE_INSTANCE_ID] = co.[RESOURCE_INSTANCE_ID]
    INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] AS ct ON co.[COMPONENT_TYPE_ID] = ct.[COMPONENT_TYPE_ID]
    INNER JOIN [dbo].[TB_CLU_SERVER] AS s ON co.[SERVER_ID] = s.[SERVER_ID]
    WHERE ct.[INTERNAL_NAME] = @v_PortalDBComponentType
        AND ri.[RESOURCE_INSTANCE_ID] = @ToHostId;

    SET @v_FromHostId = CAST(@FromHostId AS NVARCHAR(50));
    SET @v_ToHostId = CAST(@ToHostId AS NVARCHAR(50));

    -----------------------------------------------------------------------------------------------------------------
    -- Check if the Resource Instance IDs have been found to proceed further
    IF (
            @v_FromHostName IS NULL
            OR @v_ToHostName IS NULL
            )
    BEGIN 
        IF (@v_FromHostName IS NULL)
        BEGIN 
            SET @error = - 1;

            RAISERROR ('RDBMS Host Name of the Resource Instance Id to recover FROM not found. Please check the Resource Instance Id: [%s] exists. Error [%d]', 16, 1, @v_FromHostId, @error);

            GOTO EXIT_SPROC;
        END;

        IF (@v_ToHostName IS NULL)
        BEGIN 
            SET @error = - 1;

            RAISERROR ('Resource Instance Id of RDBMS Host Name to recover TO not found. Please check if the system is dual sided. Error [%d]', 16, 1, @error);

            GOTO EXIT_SPROC;
        END;
    END;

    -----------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------------------
    ----------------------------------
    ----------------------------------
    -- RECOVERY START
    ----------------------------------
    ----------------------------------    
    BEGIN TRY;
        -- Call stored procedure to commence recovery passing in two parameters
        EXEC [dbo].[ap_imp01_regenerate_partition_configuration_using_hostnames] @v_FromHostName, @v_ToHostName;
    END TRY

    BEGIN CATCH;
        ---------------------------------------
        -- Catch the error message for display
        --DECLARE @v_x as NVARCHAR(1000)
        --SELECT @v_x  = ERROR_MESSAGE()
        --PRINT @v_x
        EXEC ap_adm_raise_error;

        ---------------------------------------
        SELECT @error = CASE WHEN @error = 0 THEN @@ERROR ELSE @error END, @ErrorMessage = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(': ' + ERROR_MESSAGE(), '');

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
                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
            END;
        END;
        RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;

    RETURN @error;

    EXIT_SPROC:

    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_regenerate_partition_configuration]
	TO [portalapp_role]
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_regenerate_partition_configuration]
	TO [portal_database_configuration_role]
GO
