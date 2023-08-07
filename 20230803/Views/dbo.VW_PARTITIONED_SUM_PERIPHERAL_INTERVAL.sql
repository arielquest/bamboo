SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_PERIPHERAL_INTERVAL]
AS
SELECT  *
FROM    dbo.TB_SUM_PERIPHERAL_INTERVAL;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_PERIPHERAL_INTERVAL]
	TO [portalreporting_role]
GO