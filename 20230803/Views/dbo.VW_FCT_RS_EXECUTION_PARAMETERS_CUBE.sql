SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_RS_EXECUTION_PARAMETERS_CUBE]
--WITH ENCRYPTION
AS
   SELECT  * FROM dbo.VW_PARTITIONED_FCT_RS_EXECUTION_PARAMETERS;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_RS_EXECUTION_PARAMETERS_CUBE]
	TO [portalapp_role]
GO
