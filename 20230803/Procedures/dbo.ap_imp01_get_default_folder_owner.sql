SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_get_default_folder_owner]
(
    @ClusterResourceId             AS UNIQUEIDENTIFIER,
    @DefaultFolderId             AS UNIQUEIDENTIFIER OUTPUT,
    @DefaultOwnerId             AS UNIQUEIDENTIFIER OUTPUT
) AS
BEGIN 
    -- Look for a specified import location for the cluster
    SELECT @DefaultFolderId = FOLDER_ID
    FROM TB_CLU_RESOURCE_FOLDER_MAPPING
    WHERE RESOURCE_ID = @ClusterResourceId
        AND DEFAULT_IMPORT_LOCATION = 1;

    -- If no default location has been specified then lookup the standard unallocated folder location 
    -- (folder id is set to cluster resource id to allow easy identification)
    IF @DefaultFolderId IS NULL
    BEGIN 
        SELECT @DefaultFolderId = FOLDER_ID
        FROM TB_SEC_FOLDER
        WHERE FOLDER_ID = @ClusterResourceId;
    END;

    -- If folder is still null then create a placeholder folder
    IF @DefaultFolderId IS NULL
    BEGIN 
        DECLARE @ClusterResourceName AS NVARCHAR(200);
        DECLARE @ClusterResourceNameTemp AS NVARCHAR(200);
        DECLARE @UnallocatedFolderPath AS NVARCHAR(200);
        DECLARE @UnallocatedDescription AS NVARCHAR(200);
        DECLARE @Counter AS TINYINT = 1;

        SELECT @ClusterResourceName = NAME, @ClusterResourceNameTemp = NAME
        FROM TB_CLU_RESOURCE
        WHERE RESOURCE_ID = @ClusterResourceId;

        SET @UnallocatedDescription = 'Unallocated resources for equipment [' + @ClusterResourceName + ']';
        SET @UnallocatedFolderPath = '/Unallocated/' + @ClusterResourceName;

        WHILE EXISTS (
                SELECT 1
                FROM dbo.TB_SEC_FOLDER
                WHERE PATH = @UnallocatedFolderPath
                )
            AND @Counter <= 255
        BEGIN 
            SET @ClusterResourceNameTemp = @ClusterResourceName + + '_' + REPLICATE('0', 3 - LEN(CONVERT(NVARCHAR(3), @Counter))) + CONVERT(NVARCHAR(3), @Counter);
            SET @UnallocatedFolderPath = '/Unallocated/' + @ClusterResourceNameTemp;
            SET @Counter = @Counter + 1;
        END;

        SET @ClusterResourceName = @ClusterResourceNameTemp;

        EXEC ap_sec01_add_folder 'System', '/Unallocated', @ClusterResourceName, @UnallocatedDescription, NULL, 1, @ClusterResourceId;

        SET @DefaultFolderId = @ClusterResourceId;
    END;

    -- Set owner id based on selected folder
    SET @DefaultOwnerId = dbo.fn_sec_get_folder_owner(@DefaultFolderId);
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_default_folder_owner]
	TO [portalapp_role]
GO
