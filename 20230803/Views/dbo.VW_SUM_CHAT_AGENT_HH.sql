SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_CHAT_AGENT_HH]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.VW_PARTITIONED_SUM_CHAT_AGENT_HH;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_CHAT_AGENT_HH]
	TO [portalreporting_role]
GO
