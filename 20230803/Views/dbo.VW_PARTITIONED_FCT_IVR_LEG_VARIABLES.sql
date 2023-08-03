SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_IVR_LEG_VARIABLES]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_FCT_IVR_LEG_VARIABLES;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_IVR_LEG_VARIABLES]
	TO [portalreporting_role]
GO
