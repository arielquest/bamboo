SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_CHAT_SURVEY]
AS
SELECT  *
FROM    [dbo].[TB_FCT_CHAT_SURVEY];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CHAT_SURVEY]
	TO [portalreporting_role]
GO