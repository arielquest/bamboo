SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_IVR_CALL_EVENT]
AS
SELECT  *
FROM    dbo.TB_FCT_IVR_CALL_EVENT;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_IVR_CALL_EVENT]
	TO [portalreporting_role]
GO
