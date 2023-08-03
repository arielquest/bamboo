SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
AS
SELECT  *
FROM    [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
	TO [portalreporting_role]
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
