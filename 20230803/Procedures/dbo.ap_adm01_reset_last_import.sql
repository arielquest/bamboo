SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_adm01_reset_last_import (@RESOURCEID UNIQUEIDENTIFIER = NULL) AS
BEGIN 
    SET NOCOUNT ON;
    IF @RESOURCEID IS NOT NULL
    BEGIN 
        IF EXISTS (SELECT 1 FROM dbo.TB_CLU_RESOURCE WHERE RESOURCE_ID = @RESOURCEID)
        BEGIN 
            UPDATE dbo.TB_CLU_RESOURCE
            SET XML_DATA.modify('replace value of (/Columns/Column[@Name="LAST_DIMENSION_IMPORT_CONFIG_CHANGE_DATE"]/text())[1] with "1900-01-01T00:00:00.000Z"')
            WHERE XML_DATA IS NOT NULL AND RESOURCE_ID = @RESOURCEID;

            UPDATE dbo.TB_CLU_RESOURCE
            SET XML_DATA.modify('replace value of (/Columns/Column[@Name="LAST_MEMBER_IMPORT_CONFIG_CHANGE_DATE"]/text())[1] with "1900-01-01T00:00:00.000Z"')
            WHERE XML_DATA IS NOT NULL AND RESOURCE_ID = @RESOURCEID;

            PRINT 'UPDATED RESOURCE ID: '+CAST(@RESOURCEID AS VARCHAR(36));
        END;
        ELSE BEGIN 
            PRINT 'COULD NOT FIND RESOURCE ID: '+CAST(@RESOURCEID AS VARCHAR(36));
        END;
    END;
    ELSE BEGIN 
        UPDATE dbo.TB_CLU_RESOURCE
        SET XML_DATA.modify('replace value of (/Columns/Column[@Name="LAST_DIMENSION_IMPORT_CONFIG_CHANGE_DATE"]/text())[1] with "1900-01-01T00:00:00.000Z"')
        WHERE XML_DATA IS NOT NULL;

        UPDATE dbo.TB_CLU_RESOURCE
        SET XML_DATA.modify('replace value of (/Columns/Column[@Name="LAST_MEMBER_IMPORT_CONFIG_CHANGE_DATE"]/text())[1] with "1900-01-01T00:00:00.000Z"')
        WHERE XML_DATA IS NOT NULL;

        PRINT 'UPDATED ALL RESOURCES';
    END;
END;
GO
