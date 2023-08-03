SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.VW_PARTITIONED_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI]
	TO [portalapp_role]
GO
