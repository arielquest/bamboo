SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_DIALER_INTERVAL]
AS
SELECT  *
FROM    dbo.TB_SUM_DIALER_INTERVAL;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_DIALER_INTERVAL]
	TO [portalreporting_role]
GO