SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_AGENT_SESSION_DETAIL]
AS
   SELECT *, 1 AS [Row Count] FROM [dbo].[VW_PARTITIONED_FCT_AGENT_SESSION_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AGENT_SESSION_DETAIL]
	TO [portalreporting_role]
GO
