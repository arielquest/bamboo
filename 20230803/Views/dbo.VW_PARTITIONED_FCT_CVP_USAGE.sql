SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_CVP_USAGE]
AS
SELECT  *
FROM    dbo.TB_FCT_CVP_USAGE;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CVP_USAGE]
	TO [portalreporting_role]
GO
