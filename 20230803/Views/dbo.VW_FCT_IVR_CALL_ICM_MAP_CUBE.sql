SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_IVR_CALL_ICM_MAP_CUBE]
AS
    SELECT  * FROM dbo.VW_FCT_IVR_CALL_ICM_MAP;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_CALL_ICM_MAP_CUBE]
	TO [portalapp_role]
GO