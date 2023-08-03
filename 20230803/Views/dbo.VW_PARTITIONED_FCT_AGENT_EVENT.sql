SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_AGENT_EVENT]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_FCT_AGENT_EVENT;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_AGENT_EVENT]
	TO [portalreporting_role]
GO
