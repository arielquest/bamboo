SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_SERVICE_5M]
--WITH ENCRYPTION
AS
SELECT  *,
        1 AS [Row Count]
FROM    [dbo].[VW_PARTITIONED_SUM_SERVICE_5M];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_SERVICE_5M]
	TO [portalreporting_role]
GO
