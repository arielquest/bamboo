SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_ACTIVITY_SLA]
AS
   SELECT * FROM [dbo].[TB_FCT_ACTIVITY_SLA];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_ACTIVITY_SLA]
	TO [portalreporting_role]
GO
