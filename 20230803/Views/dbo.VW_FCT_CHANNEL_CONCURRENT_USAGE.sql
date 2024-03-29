SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CHANNEL_CONCURRENT_USAGE]
--WITH ENCRYPTION
AS
SELECT  *, 1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_FCT_CHANNEL_CONCURRENT_USAGE;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CHANNEL_CONCURRENT_USAGE]
	TO [portalreporting_role]
GO
