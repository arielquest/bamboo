SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CBR_SESSION_SUMMARY]
AS
   SELECT *, 1 AS [Row Count] FROM [dbo].[VW_PARTITIONED_FCT_CBR_SESSION_SUMMARY];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CBR_SESSION_SUMMARY]
	TO [portalreporting_role]
GO
