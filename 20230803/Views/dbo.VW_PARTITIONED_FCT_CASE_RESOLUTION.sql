SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_CASE_RESOLUTION]
AS
SELECT  *
FROM    [dbo].[TB_FCT_CASE_RESOLUTION];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CASE_RESOLUTION]
	TO [portalreporting_role]
GO