SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_CALL_DETAIL_LEG_OUTCOME]
--WITH ENCRYPTION
AS
SELECT  [CALL_DETAIL_LEG_OUTCOME_URN],
        [CALL_DETAIL_LEG_URN],
        [SEQUENCE_NUMBER],
        [CLUSTER_RESOURCE_URN],
        [LABEL_TEXT],
        [CALL_OUTCOME],
        [PARTITION_ID],
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_FCT_CALL_DETAIL_LEG_OUTCOME;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CALL_DETAIL_LEG_OUTCOME]
	TO [portalreporting_role]
GO
