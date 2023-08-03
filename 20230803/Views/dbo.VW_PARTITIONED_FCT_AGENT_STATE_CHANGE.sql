SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_AGENT_STATE_CHANGE]
--WITH ENCRYPTION
AS
    SELECT  * FROM dbo.TB_FCT_AGENT_STATE_CHANGE;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_AGENT_STATE_CHANGE]
	TO [portalreporting_role]
GO
