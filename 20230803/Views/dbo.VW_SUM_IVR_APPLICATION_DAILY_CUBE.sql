SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_IVR_APPLICATION_DAILY_CUBE]
AS
SELECT  *
FROM    dbo.VW_SUM_IVR_APPLICATION_DAILY;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_IVR_APPLICATION_DAILY_CUBE]
	TO [portalapp_role]
GO
