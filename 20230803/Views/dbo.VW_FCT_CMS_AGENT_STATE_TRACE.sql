SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CMS_AGENT_STATE_TRACE]
AS
SELECT  *,
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_FCT_CMS_AGENT_STATE_TRACE;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CMS_AGENT_STATE_TRACE]
	TO [portalapp_role]
GO
