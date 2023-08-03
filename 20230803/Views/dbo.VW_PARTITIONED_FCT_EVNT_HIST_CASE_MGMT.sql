SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_EVNT_HIST_CASE_MGMT]
AS
   SELECT * FROM [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_EVNT_HIST_CASE_MGMT]
	TO [portalreporting_role]
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_EVNT_HIST_CASE_MGMT]
	TO [portal_default_mediator_role]
GO
