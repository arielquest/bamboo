SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_IVR_CALL_15_CUBE]
AS
SELECT  *
FROM    dbo.VW_SUM_IVR_CALL_15;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_IVR_CALL_15_CUBE]
	TO [portalapp_role]
GO
