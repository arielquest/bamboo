SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_prepare_reset_generation_counts]
AS
    TRUNCATE TABLE dbo.TS_IMP_OLAP_DIMENSION_STATE;
    DBCC CHECKIDENT ('TS_IMP_OLAP_DIMENSION_STATE', reseed, 0);

    TRUNCATE TABLE dbo.TS_ADM_DATA_GENERATION_COUNT;
    DBCC CHECKIDENT ('TS_ADM_TABLE_GENERATION_COUNT', reseed, 10000);

    DELETE dbo.TS_ADM_TABLE_GENERATION_COUNT;
GO