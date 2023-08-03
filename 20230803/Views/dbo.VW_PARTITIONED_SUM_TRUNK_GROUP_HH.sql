SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_SUM_TRUNK_GROUP_HH]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.TB_SUM_TRUNK_GROUP_HH;
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_SUM_TRUNK_GROUP_HH]
	TO [portalreporting_role]
GO
