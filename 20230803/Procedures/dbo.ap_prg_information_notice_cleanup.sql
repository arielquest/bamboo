SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_prg_information_notice_cleanup] AS
SET NOCOUNT ON;

DECLARE @error INT = 0, @isPurgeActive BIT;

BEGIN TRY;
    --Check if purge is active
    SELECT @isPurgeActive = CASE WHEN CAST(ri.XML_DATA.query('/Columns/Column[@Name="PURGE_ENABLED"]/text()') AS NVARCHAR(5)) = 'True'
                                 THEN 1 ELSE 0 END
    FROM dbo.fn_clu_get_exony_db_resource_instance(NULL) AS exDb
    INNER JOIN TB_CLU_RESOURCE_INSTANCE ri ON ri.RESOURCE_INSTANCE_ID = exDb.RESOURCE_INSTANCE_ID;

    IF @isPurgeActive = 1
    BEGIN 
        DELETE dbo.TB_SEC_INFORMATION_NOTICE
        WHERE EFFECTIVE_TO < DATEADD(dd, - 31, GETUTCDATE());
    END;
END TRY
BEGIN CATCH;
    SET @error = @@ERROR;
    RAISERROR(50100, 16, 1, @error, 'ap_prg_information_notice_cleanup', '');
END CATCH;

RETURN @error;
GO
