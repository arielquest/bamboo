SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_IN_CDR]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_FCT_IN_CDR;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_IN_CDR]
	TO [portalreporting_role]
GO
