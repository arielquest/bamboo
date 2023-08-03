SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_rep01_replication_configured_indicator] (@Input UNIQUEIDENTIFIER) AS
BEGIN 
    IF EXISTS (
            SELECT 1
            FROM dbo.TB_ADM_PROPERTY
            WHERE PROPERTY_KEY = 'PROP_REPLICATION_CONFIGURED'
                AND PROPERTY_VALUE = CAST(@Input AS VARCHAR(36))
            )
    BEGIN 
        SELECT 1;
    END;
    ELSE BEGIN
        SELECT 0;
    END;
END;
GO
