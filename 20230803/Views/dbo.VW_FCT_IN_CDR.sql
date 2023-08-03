SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_IN_CDR]
--WITH ENCRYPTION
AS
SELECT  *,
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_FCT_IN_CDR;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IN_CDR]
	TO [portalapp_role]
GO
