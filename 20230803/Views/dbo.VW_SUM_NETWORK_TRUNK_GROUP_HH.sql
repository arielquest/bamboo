SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_NETWORK_TRUNK_GROUP_HH]
--WITH ENCRYPTION
AS
SELECT  [SUMMARIZED_URN],
        [DATE_URN],
        [TIME_URN],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        [NETWORK_TRUNK_GROUP_URN],
        [CLUSTER_RESOURCE_URN],
        [ALL_TRUNKS_BUSY_TTH],
        [CALLS_ABANDONED_TTH],
        [CALLS_IN_TTH],
        [CALLS_OUT_TTH],
        [IN_SERVICE_TIME_TTH],
        [IN_USE_INBOUND_TIME_TTH],
        [IN_USE_OUTBOUND_TIME_TTH],
        [TRUNKS_IDLE],
        [TRUNKS_IN_SERVICE],
        [PARTITION_ID],
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_SUM_NETWORK_TRUNK_GROUP_HH;
GO
