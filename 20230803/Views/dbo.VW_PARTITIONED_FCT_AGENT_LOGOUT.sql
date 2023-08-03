SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_AGENT_LOGOUT]
--WITH ENCRYPTION
AS
   SELECT  * FROM dbo.TB_FCT_AGENT_LOGOUT;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_AGENT_LOGOUT]
	TO [portalreporting_role]
GO
