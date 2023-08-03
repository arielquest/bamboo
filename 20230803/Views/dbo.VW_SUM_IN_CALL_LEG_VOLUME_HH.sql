SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_IN_CALL_LEG_VOLUME_HH]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.VW_PARTITIONED_SUM_IN_CALL_LEG_VOLUME_HH;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_IN_CALL_LEG_VOLUME_HH]
	TO [portalapp_role]
GO
