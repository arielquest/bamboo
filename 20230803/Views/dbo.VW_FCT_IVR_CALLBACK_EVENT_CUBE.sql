SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_IVR_CALLBACK_EVENT_CUBE]
AS
SELECT  *
FROM    [dbo].[VW_FCT_IVR_CALLBACK_EVENT] x;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_CALLBACK_EVENT_CUBE]
	TO [portalapp_role]
GO
