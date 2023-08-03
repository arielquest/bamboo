SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_CALL_DETAIL_LEG]
--WITH ENCRYPTION
AS
     SELECT * 
    FROM [dbo].[TB_FCT_CALL_DETAIL_LEG];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CALL_DETAIL_LEG]
	TO [portalreporting_role]
GO
