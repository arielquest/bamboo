SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_get_phone_product_properties]
    (
      @ClusterResourceId AS [UNIQUEIDENTIFIER],
      @ProductCodeBusinessUrn AS [INTEGER],
      @DeviceNameFormat AS [NVARCHAR](50) OUTPUT,
      @DeviceNameString AS [NVARCHAR](50) OUTPUT
    )
AS
DECLARE @RowCount AS INTEGER;

    -- First try and match on cluster resource id
SELECT TOP 1
        @DeviceNameFormat = CAST([XML_DATA].[query]('/Columns/Column[@Name="DEVICE_NAME_FORMAT"]/text()') AS NVARCHAR(50)),
        @DeviceNameString = CAST([XML_DATA].[query]('/Columns/Column[@Name="DEVICE_NAME_STRING"]/text()') AS NVARCHAR(50))
FROM    [dbo].[TB_DIM_CODE_PKEY_MAP]
WHERE   [ITEM_BIZ_URN] = @ProductCodeBusinessUrn
        AND [CLUSTER_RESOURCE_ID] = @ClusterResourceId
ORDER BY [PKEY_MAP_URN];

SELECT  @RowCount = @@ROWCOUNT;

IF ( @RowCount < 1 )
BEGIN 
    DECLARE @ClusterResourceTypeId AS UNIQUEIDENTIFIER,
        @ClusterResourceVersion AS NVARCHAR(50);

    SELECT  @ClusterResourceTypeId = [RESOURCE_TYPE_ID],
            @ClusterResourceVersion = [VERSION]
    FROM    [dbo].[TB_CLU_RESOURCE]
    WHERE   [RESOURCE_ID] = @ClusterResourceId;

        -- Now try and match on cluster resource type and version
    SELECT TOP 1
            @DeviceNameFormat = CAST([XML_DATA].[query]('/Columns/Column[@Name="DEVICE_NAME_FORMAT"]/text()') AS NVARCHAR(50)),
            @DeviceNameString = CAST([XML_DATA].[query]('/Columns/Column[@Name="DEVICE_NAME_STRING"]/text()') AS NVARCHAR(50))
    FROM    [dbo].[TB_DIM_CODE_PKEY_MAP]
    WHERE   [ITEM_BIZ_URN] = @ProductCodeBusinessUrn
            AND [CLUSTER_RESOURCE_TYPE_ID] = @ClusterResourceTypeId
            AND [CLUSTER_VERSION] = @ClusterResourceVersion
    ORDER BY PKEY_MAP_URN;

    SELECT  @RowCount = @@ROWCOUNT;

    IF ( @RowCount < 1 )
    BEGIN 
            -- Now try and match on cluster resource type
        SELECT TOP 1
                @DeviceNameFormat = CAST([XML_DATA].[query]('/Columns/Column[@Name="DEVICE_NAME_FORMAT"]/text()') AS NVARCHAR(50)),
                @DeviceNameString = CAST([XML_DATA].[query]('/Columns/Column[@Name="DEVICE_NAME_STRING"]/text()') AS NVARCHAR(50))
        FROM    [dbo].[TB_DIM_CODE_PKEY_MAP]
        WHERE   [ITEM_BIZ_URN] = @ProductCodeBusinessUrn
                AND [CLUSTER_RESOURCE_TYPE_ID] = @ClusterResourceTypeId
        ORDER BY PKEY_MAP_URN;
    END;

END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_get_phone_product_properties]
	TO [portalapp_role]
GO
