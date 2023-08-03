SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_IVR_LEG_NODE_PATH]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_FCT_IVR_LEG_NODE_PATH;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_IVR_LEG_NODE_PATH]
	TO [portalreporting_role]
GO
