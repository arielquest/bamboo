SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_VOICE_AGENT_STATE_DETAIL]
AS
SELECT  *
FROM    [dbo].[TB_FCT_VOICE_AGENT_STATE_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_VOICE_AGENT_STATE_DETAIL]
	TO [portalreporting_role]
GO
