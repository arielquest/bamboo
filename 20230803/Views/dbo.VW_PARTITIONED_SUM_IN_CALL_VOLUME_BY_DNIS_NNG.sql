SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_IN_CALL_VOLUME_BY_DNIS_NNG]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_SUM_IN_CALL_VOLUME_BY_DNIS_NNG;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_IN_CALL_VOLUME_BY_DNIS_NNG]
	TO [portalreporting_role]
GO
