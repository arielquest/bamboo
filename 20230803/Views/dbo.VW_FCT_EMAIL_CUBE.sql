SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_EMAIL_CUBE]
--WITH ENCRYPTION
AS
SELECT  *
FROM    VW_FCT_EMAIL;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_EMAIL_CUBE]
	TO [portalapp_role]
GO