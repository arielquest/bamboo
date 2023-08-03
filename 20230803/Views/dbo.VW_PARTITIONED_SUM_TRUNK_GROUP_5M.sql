SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_TRUNK_GROUP_5M]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_SUM_TRUNK_GROUP_5M;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_TRUNK_GROUP_5M]
	TO [portalreporting_role]
GO
