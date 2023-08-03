SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_RS_EXECUTION_LOG]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_FCT_RS_EXECUTION_LOG;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_RS_EXECUTION_LOG]
	TO [portalreporting_role]
GO
