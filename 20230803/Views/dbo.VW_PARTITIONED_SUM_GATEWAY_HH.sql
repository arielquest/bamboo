SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_GATEWAY_HH]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_SUM_GATEWAY_HH;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_GATEWAY_HH]
	TO [portalreporting_role]
GO
