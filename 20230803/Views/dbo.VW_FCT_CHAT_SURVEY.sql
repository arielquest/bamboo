SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CHAT_SURVEY]
AS
SELECT  *, 1 AS [Row Count]
FROM    [dbo].[VW_PARTITIONED_FCT_CHAT_SURVEY];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CHAT_SURVEY]
	TO [portalreporting_role]
GO
