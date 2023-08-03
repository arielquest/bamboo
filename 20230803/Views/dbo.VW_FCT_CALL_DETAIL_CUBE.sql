SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_CALL_DETAIL_CUBE]
--WITH ENCRYPTION
AS
SELECT  CAST([CALL_DETAIL_URN] AS BIGINT) * 86400
        + CAST([PARTITION_ID] AS BIGINT) AS [CALL_DETAIL_URN],
        [STARTDATE_URN] AS [STARTDATE_URN],
        [STARTTIME_URN] AS [STARTTIME_URN],
        [STARTDATE_UTC_URN] AS [STARTDATE_UTC_URN],
        [STARTTIME_UTC_URN] AS [STARTTIME_UTC_URN],
        [START_DATE_TIME] AS [START_DATE_TIME],
        [START_UTC_TIMEZONE] AS [START_UTC_TIMEZONE],
        [CALL_KEY1] AS [CALL_KEY1],
        [CALL_KEY2] AS [CALL_KEY2],
        [PARTITION_ID] AS [PARTITION_ID],
        [RECOVERY_KEY] AS [RECOVERY_KEY],
        [CLUSTER_RESOURCE_ID] AS [CLUSTER_RESOURCE_ID],
        [CLUSTER_RESOURCE_URN] AS [CLUSTER_RESOURCE_URN]
FROM    [dbo].[VW_FCT_CALL_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CALL_DETAIL_CUBE]
	TO [portalapp_role]
GO
