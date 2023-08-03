SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_TRUNK_GROUP_HH]
--WITH ENCRYPTION
AS
SELECT  [SUMMARIZED_URN],
        [DATE_URN],
        [TIME_URN],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        [TRUNK_GROUP_URN],
        [CLUSTER_RESOURCE_URN],
        [CALLS_ABANDONED_TH],
        [CALLS_IN_TH],
        [TRUNKS_IN_SERVICE],
        [CALLS_OUT_TH],
        [ALL_TRUNKS_BUSY_TH],
        [IN_SERVICE_TTH],
        [TRUNKS_IDLE],
        [IN_USE_INBOUND_TTH],
        [IN_USE_OUTBOUND_TTH],
        [PARTITION_ID],
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_SUM_TRUNK_GROUP_HH;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_TRUNK_GROUP_HH]
	TO [portalreporting_role]
GO
