SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_CONTACT_LEG_SOLVE]
AS
    SELECT  *
    FROM    [dbo].[TB_FCT_CONTACT_LEG_SOLVE];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CONTACT_LEG_SOLVE]
	TO [portalreporting_role]
GO
