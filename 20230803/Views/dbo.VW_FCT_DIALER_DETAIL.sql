SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_DIALER_DETAIL]
--WITH ENCRYPTION
AS
SELECT  *
FROM    [dbo].[VW_PARTITIONED_FCT_DIALER_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_DIALER_DETAIL]
	TO [portalreporting_role]
GO
