SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_DIALER_DETAIL_CUBE]
--WITH ENCRYPTION
AS
SELECT  *
FROM    [dbo].[VW_FCT_DIALER_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_DIALER_DETAIL_CUBE]
	TO [portalapp_role]
GO
