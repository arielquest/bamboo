SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- This procedure checks the data processed within the cubes against the data 
-- imported in the fact and summary tables for a particular measure group.
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_imp01_check_olap_unprocessed_data_by_measure_group] 
(
    @CubeName AS NVARCHAR(50), 
    @MeasureGroupName AS NVARCHAR(128), 
    @ResourceInstanceID AS UNIQUEIDENTIFIER
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @ErrorMessage AS VARCHAR(2000), @v_Error INT;

    DECLARE @v_FactTable TABLE 
    (
        [FACT_PARTITION_ID] VARCHAR(50), 
        [VIEW_NAME] VARCHAR(50), 
        [CUBE_NAME] VARCHAR(50), 
        [MEASURE_GROUP_NAME] VARCHAR(50), 
        [ENABLED] BIT,
        [PARTITION_ID] INT, 
        [MAX_HIGH_WATER] INT
    );

    BEGIN TRY;
        INSERT INTO @v_FactTable 
        (
            [FACT_PARTITION_ID], 
            [VIEW_NAME], 
            [CUBE_NAME], 
            [MEASURE_GROUP_NAME], 
            [ENABLED],
            [PARTITION_ID], 
            [MAX_HIGH_WATER]
        )
        SELECT fp.[FACT_PARTITION_ID], 
               fpm.[CUBE_VIEW_NAME], 
               ol.[PARENT_OLAP_OBJECT_NAME], 
               ol.[OLAP_OBJECT_NAME], 
               mp.[ENABLED],
               fp.[PARTITION_ID], 
               MAX(pt.[HIGH_WATER_AFTER]) AS [MAX_HIGH_WATER]
        FROM [dbo].[TB_IMP_FCT_PARTITION] AS fp
        INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] AS pt ON fp.[FACT_PARTITION_ID] = pt.[FACT_PARTITION_ID]
        INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] AS fpm ON fpm.[FACT_PARTITION_METADATA_ID] = fp.[FACT_PARTITION_METADATA_ID]
        INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT] AS ol ON fpm.[CUBE_VIEW_NAME] = ol.[PRIMARY_TABLE]
        INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] AS mp ON ol.[OLAP_OBJECT_URN] = mp.[OLAP_OBJECT_URN]
        WHERE UPPER(ol.[PARENT_OLAP_OBJECT_NAME]) = UPPER(@CubeName)
            AND UPPER(ol.[OLAP_OBJECT_NAME]) = UPPER(@MeasureGroupName)
            AND fp.[RESOURCE_INSTANCE_ID] = @ResourceInstanceID
            AND fp.[ONLINE_DATE] IS NOT NULL
            AND fp.[OFFLINE_DATE] IS NULL
        GROUP BY fp.[FACT_PARTITION_ID], fpm.[CUBE_VIEW_NAME], ol.[PARENT_OLAP_OBJECT_NAME], ol.[OLAP_OBJECT_NAME], mp.[ENABLED], fp.[PARTITION_ID]
        ORDER BY 1;
    END TRY
    BEGIN CATCH;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @v_Error = @@ERROR;
        
        IF @ErrorMessage = '' OR @ErrorMessage IS NULL
        BEGIN 
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': failed to obtain data from TB_IMP_FCT_PARTITION and TB_IMP_FCT_PARTITION_TIDEMARK, [%d]';
        END;
        ELSE BEGIN 
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+'['+@ErrorMessage+']: failed to obtain data from TB_IMP_FCT_PARTITION and TB_IMP_FCT_PARTITION_TIDEMARK, [%d]';
        END;
        RAISERROR(@ErrorMessage, 16, 1, @v_Error) WITH LOG;
        RETURN -1;
    END CATCH;

    DECLARE @v_MapTable TABLE 
    (
        [FACT_PARTITION_ID] VARCHAR(50), 
        [OLAP_RESOURCE_NAME] VARCHAR(100), 
        [OLAP_RESOURCE_INSTANCE_NAME] VARCHAR(100), 
        [CUBE_NAME] VARCHAR(50), 
        [MEASURE_GROUP_NAME] VARCHAR(50), 
        [PARTITION_NAME] VARCHAR(50), 
        [LAST_HIGH_WATER] INT, 
        [STATUS] INT
    );

    BEGIN TRY;
        INSERT INTO @v_MapTable 
        (
            [FACT_PARTITION_ID], 
            [OLAP_RESOURCE_NAME], 
            [OLAP_RESOURCE_INSTANCE_NAME], 
            [CUBE_NAME], 
            [MEASURE_GROUP_NAME], 
            [PARTITION_NAME], 
            [LAST_HIGH_WATER], 
            [STATUS]
        )
        SELECT mp.[FACT_PARTITION_ID], 
               ore.[NAME], 
               ori.[NAME], 
               ol.[PARENT_OLAP_OBJECT_NAME], 
               ol.[OLAP_OBJECT_NAME], 
               op.[OLAP_PARTITION_NAME], 
               MAX(mp.[LAST_HIGH_WATER]) AS [LAST_HIGH_WATER], 
               op.[STATUS]
        FROM [dbo].[TB_IMP_FCT_OLAP_PARTITION] AS op
        INNER JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] AS mp ON mp.[OLAP_PARTITION_ID] = op.[OLAP_PARTITION_ID]
        INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] AS fp ON mp.[FACT_PARTITION_ID] = fp.[FACT_PARTITION_ID]
        INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT] AS ol ON op.[OLAP_OBJECT_URN] = ol.[OLAP_OBJECT_URN]
        INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] AS ori ON ori.[RESOURCE_INSTANCE_ID] = op.[RESOURCE_INSTANCE_ID]
        INNER JOIN [dbo].[TB_CLU_RESOURCE] AS ore ON ore.[RESOURCE_ID] = ori.[RESOURCE_ID]
        WHERE fp.[RESOURCE_INSTANCE_ID] = @ResourceInstanceID
        GROUP BY mp.[FACT_PARTITION_ID], ore.[NAME], ori.[NAME], ol.[PARENT_OLAP_OBJECT_NAME], ol.[OLAP_OBJECT_NAME], op.[OLAP_PARTITION_NAME], op.[STATUS];
    END TRY
    BEGIN CATCH;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @v_Error = @@ERROR;
        
        IF @ErrorMessage = '' OR @ErrorMessage IS NULL
        BEGIN 
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': failed to obtain data from TB_IMP_FCT_OLAP_PARTITION_MAP, [%d]';
        END;
        ELSE BEGIN 
            SET @ErrorMessage = OBJECT_NAME(@@PROCID)+'['+@ErrorMessage+']: failed to obtain data from TB_IMP_FCT_OLAP_PARTITION_MAP, [%d]';
        END;
        RAISERROR(@ErrorMessage, 16, 1, @v_Error) WITH LOG;
        RETURN -1;
    END CATCH;

    SELECT ft.[VIEW_NAME] AS [VIEW_NAME], ft.[PARTITION_ID] AS [PARTITION_ID], ft.[MAX_HIGH_WATER] AS [FACT_HIGH_WATER], ft.[CUBE_NAME] AS [CUBE_NAME], 
    ft.[MEASURE_GROUP_NAME] AS [MEASURE_GROUP_NAME], mt.[PARTITION_NAME] AS [OLAP_PARTITION_NAME], 
    CASE ft.[ENABLED] WHEN 0 THEN 'DISABLED'
                      ELSE 'Enabled' END AS [ENABLED], mt.[LAST_HIGH_WATER] AS [OLAP_HIGH_WATER], 
    CASE mt.[STATUS] WHEN 0 THEN 'Ready' 
                     WHEN 1 THEN 'Processing' 
                     WHEN 2 THEN 'Processed' 
                     WHEN 3 THEN 'Reset Required' END AS [STATUS], mt.[OLAP_RESOURCE_NAME], mt.[OLAP_RESOURCE_INSTANCE_NAME]
    FROM @v_FactTable AS ft
    LEFT OUTER JOIN @v_MapTable AS mt ON (ft.[FACT_PARTITION_ID] = mt.[FACT_PARTITION_ID] AND ft.[CUBE_NAME] = mt.[CUBE_NAME] AND ft.[MEASURE_GROUP_NAME] = mt.[MEASURE_GROUP_NAME])
    WHERE ft.[VIEW_NAME] <> 'VW_FCT_RS_EXECUTION_LOG_CUBE'
    AND (ft.[MAX_HIGH_WATER] > COALESCE(mt.[LAST_HIGH_WATER], 0) OR mt.[STATUS] <> 0)
    ORDER BY ft.[CUBE_NAME], ft.[MEASURE_GROUP_NAME], ft.[PARTITION_ID];
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_check_olap_unprocessed_data_by_measure_group]
	TO [portalapp_role]
GO
