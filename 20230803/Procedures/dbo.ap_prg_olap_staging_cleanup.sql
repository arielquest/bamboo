SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_prg_olap_staging_cleanup] AS

SET NOCOUNT ON;

DECLARE @error AS INT, @rowcount AS INT;

SET @error = 0;

-- We do not need to check the purge token since the staging tables are not replicated. Hence need to be deleted from both sides separately.    
-- Truncate the table only if no OLAP resource instances are configured.
IF NOT EXISTS (
        SELECT ri.RESOURCE_INSTANCE_ID
        FROM TB_CLU_RESOURCE_INSTANCE AS ri
        INNER JOIN TB_CLU_RESOURCE AS r ON r.RESOURCE_ID = ri.RESOURCE_ID
        INNER JOIN TE_ADM_CLUSTER_RESOURCE_TYPE AS t ON r.RESOURCE_TYPE_ID = t.CLUSTER_RESOURCE_TYPE_ID
        WHERE t.INTERNAL_NAME = 'CRT_EXONY_OLAP_DB'
        )
BEGIN 
    BEGIN TRY;
        TRUNCATE TABLE dbo.TS_IMP_SUMMARIZED;
    END TRY
    BEGIN CATCH;
        SET @error = ERROR_NUMBER();
        EXEC dbo.ap_adm_raise_error;
    END CATCH;
END;
RETURN @error;
GO
