SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_IN_CALL_VOLUME_BY_TLI_NNG]
--WITH ENCRYPTION
AS
SELECT  [SUMMARIZED_URN],
        [CDR_SESSION_URN],
        [TLI_URN],
        [NNG_URN],
        [RATING_PERIOD_URN],
        [DATE_URN],
        [TIME_URN],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        [PRESENTED_TOT],
        [EFFECTIVE_TOT],
        [INEFFECTIVE_TOT],
        [NETWORK_FAILURE_TOT],
        [BUSY_TOT],
        [NA_TOT],
        [TTA_MAX],
        [TTA_MIN],
        [TTA_TOT],
        [TT_MAX],
        [TT_MIN],
        [TT_TOT],
        [NA_RINGTIME_MAX],
        [NA_RINGTIME_MIN],
        [NA_RINGTIME_TOT],
        [PARTITION_ID],
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_SUM_IN_CALL_VOLUME_BY_TLI_NNG;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_IN_CALL_VOLUME_BY_TLI_NNG]
	TO [portalapp_role]
GO
