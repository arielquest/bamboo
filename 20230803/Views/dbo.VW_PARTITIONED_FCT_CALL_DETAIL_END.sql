SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_CALL_DETAIL_END]
--WITH ENCRYPTION
AS
    SELECT * 
    FROM [dbo].[TB_FCT_CALL_DETAIL_END];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CALL_DETAIL_END]
	TO [portalreporting_role]
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_CALL_DETAIL_END]
	TO [portal_default_mediator_role]
GO
