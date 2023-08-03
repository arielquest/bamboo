SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- Displays the importer performance stats for the specified period on a per partition basis
------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ap_etl01_show_import_performance_by_partition] (@StartDateTime AS DATETIME, @EndDateTime AS DATETIME = NULL) AS
BEGIN 
    DECLARE @TotalMinutes AS INT;

    --  Default end date to now
    IF (@EndDateTime IS NULL)
    BEGIN 
        SET @EndDateTime = GETUTCDATE();
    END;
    
    SET @TotalMinutes = DATEDIFF(minute, @StartDateTime, @EndDateTime);

    -- This query aggregates results on a per partition basis
    SELECT SERVER, VIEW_NAME, FACT_PARTITION_ID, PARTITION_TABLE_NAME, FIRST_BULK_LOAD, LAST_BULK_LOAD, @TotalMinutes AS TOTAL_MINUTES, TOTAL_ROWS, 
    CASE WHEN @TotalMinutes = 0 THEN 0 ELSE SUM(TOTAL_ROWS) / @TotalMinutes END AS AVG_ROWS_PER_MINUTE, 
    TOTAL_BULK_LOADS, TOTAL_ROWS / TOTAL_BULK_LOADS AS AVG_ROWS_PER_BULK_LOAD
    FROM (
        SELECT s.DEFAULT_ADDRESS AS SERVER, fpm.CUBE_VIEW_NAME AS VIEW_NAME, fp.FACT_PARTITION_ID, fp.PARTITION_TABLE_NAME, 
        MIN(fpt.IMPORT_COMPLETE_DATE) AS FIRST_BULK_LOAD, MAX(fpt.IMPORT_COMPLETE_DATE) AS LAST_BULK_LOAD, COUNT(*) AS TOTAL_BULK_LOADS, 
        SUM(fpt.HIGH_WATER_AFTER - fpt.HIGH_WATER_BEFORE) AS TOTAL_ROWS, 
        CASE WHEN COUNT(*) = 0 THEN 0 ELSE SUM(fpt.HIGH_WATER_AFTER - fpt.HIGH_WATER_BEFORE) / COUNT(*) END AS AVG_ROWS_PER_BULK_LOAD
        FROM TB_IMP_FCT_PARTITION_TIDEMARK AS fpt
        INNER JOIN TB_IMP_FCT_PARTITION fp ON fpt.FACT_PARTITION_ID = fp.FACT_PARTITION_ID
        INNER JOIN TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
        INNER JOIN TB_CLU_RESOURCE_INSTANCE AS ri ON ri.RESOURCE_INSTANCE_ID = fp.RESOURCE_INSTANCE_ID
        INNER JOIN TB_CLU_RESOURCE_INSTANCE_COMPONENT AS comp ON comp.RESOURCE_INSTANCE_ID = ri.RESOURCE_INSTANCE_ID
        INNER JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE AS rict ON rict.COMPONENT_TYPE_ID = comp.COMPONENT_TYPE_ID
        INNER JOIN TB_CLU_SERVER AS s ON s.SERVER_ID = comp.SERVER_ID
        WHERE rict.INTERNAL_NAME = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
            AND fpt.IMPORT_COMPLETE_DATE > @StartDateTime
            AND fpt.IMPORT_COMPLETE_DATE < @EndDateTime
        GROUP BY fp.FACT_PARTITION_ID, s.DEFAULT_ADDRESS, fpm.CUBE_VIEW_NAME, fp.PARTITION_TABLE_NAME
        ) AS BLOB
    GROUP BY SERVER, VIEW_NAME, FACT_PARTITION_ID, PARTITION_TABLE_NAME, FIRST_BULK_LOAD, LAST_BULK_LOAD, TOTAL_ROWS, TOTAL_BULK_LOADS
    ORDER BY SERVER, VIEW_NAME, PARTITION_TABLE_NAME;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_etl01_show_import_performance_by_partition]
	TO [portalapp_role]
GO
