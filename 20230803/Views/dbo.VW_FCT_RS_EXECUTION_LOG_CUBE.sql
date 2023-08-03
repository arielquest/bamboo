SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_RS_EXECUTION_LOG_CUBE]
--WITH ENCRYPTION
AS
   SELECT  * FROM dbo.VW_PARTITIONED_FCT_RS_EXECUTION_LOG;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_RS_EXECUTION_LOG_CUBE]
	TO [portalapp_role]
GO
