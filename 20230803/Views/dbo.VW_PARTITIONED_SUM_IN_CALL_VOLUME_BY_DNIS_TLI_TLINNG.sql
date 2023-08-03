SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG]
	TO [portalreporting_role]
GO
