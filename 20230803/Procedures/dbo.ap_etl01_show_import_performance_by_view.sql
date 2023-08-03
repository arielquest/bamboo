SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- Displays the importer performance stats for the specified period on a per view basis
-------------------------------------------------------------------------------  
CREATE PROCEDURE [dbo].[ap_etl01_show_import_performance_by_view] (@StartDateTime AS DATETIME, @EndDateTime AS DATETIME = NULL) AS
BEGIN 
    DECLARE @TotalMinutes AS INT;

    --  Default end date to now
    IF (@EndDateTime IS NULL)
    BEGIN 
        SET @EndDateTime = GETUTCDATE();
    END;
    SET @TotalMinutes = DATEDIFF(minute, @StartDateTime, @EndDateTime);

    -- This query aggregates results on a per view basis
    SELECT SERVER, VIEW_NAME, MIN(FIRST_BULK_LOAD) AS FIRST_BULK_LOAD, MAX(LAST_BULK_LOAD) AS LAST_BULK_LOAD, @TotalMinutes AS TOTAL_MINUTES, 
    SUM(TOTAL_ROWS) AS TOTAL_ROWS, CASE WHEN @TotalMinutes = 0 THEN 0 ELSE SUM(TOTAL_ROWS) / @TotalMinutes END AS AVG_ROWS_PER_MINUTE, 
    SUM(TOTAL_BULK_LOADS) AS TOTAL_BULK_LOADS, SUM(TOTAL_ROWS) / SUM(TOTAL_BULK_LOADS) AS AVG_ROWS_PER_BULK_LOAD
    FROM (
        -- This query aggregates results on a per partition basis
        SELECT s.DEFAULT_ADDRESS AS SERVER, fpm.CUBE_VIEW_NAME AS VIEW_NAME, fp.FACT_PARTITION_ID, fp.PARTITION_TABLE_NAME, 
        MIN(fpt.IMPORT_COMPLETE_DATE) AS FIRST_BULK_LOAD, MAX(fpt.IMPORT_COMPLETE_DATE) AS LAST_BULK_LOAD, COUNT(*) AS TOTAL_BULK_LOADS, 
        SUM(fpt.HIGH_WATER_AFTER - fpt.HIGH_WATER_BEFORE) AS TOTAL_ROWS, 
        CASE WHEN COUNT(*) = 0 THEN 0 ELSE SUM(fpt.HIGH_WATER_AFTER - fpt.HIGH_WATER_BEFORE) / COUNT(*) END AS AVG_ROWS_PER_BULK_LOAD
        FROM TB_IMP_FCT_PARTITION_TIDEMARK AS fpt
        INNER JOIN TB_IMP_FCT_PARTITION fp ON fpt.FACT_PARTITION_ID = fp.FACT_PARTITION_ID
        INNER JOIN TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
        INNER JOIN TB_CLU_RESOURCE_INSTANCE AS ri ON ri.RESOURCE_INSTANCE_ID = fp.RESOURCE_INSTANCE_ID
        INNER JOIN TB_CLU_RESOURCE_INSTANCE_COMPONENT AS comp ON ri.RESOURCE_INSTANCE_ID = comp.RESOURCE_INSTANCE_ID
        INNER JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE AS rict ON rict.COMPONENT_TYPE_ID = comp.COMPONENT_TYPE_ID
        INNER JOIN TB_CLU_SERVER AS s ON s.SERVER_ID = comp.SERVER_ID
        WHERE rict.INTERNAL_NAME = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
            AND fpt.IMPORT_COMPLETE_DATE > @StartDateTime
            AND fpt.IMPORT_COMPLETE_DATE < @EndDateTime
        GROUP BY fp.FACT_PARTITION_ID, s.DEFAULT_ADDRESS, fpm.CUBE_VIEW_NAME, fp.PARTITION_TABLE_NAME
        ) AS BNOB
    GROUP BY SERVER, VIEW_NAME
    ORDER BY SERVER, VIEW_NAME;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_etl01_show_import_performance_by_view]
	TO [portalapp_role]
GO
