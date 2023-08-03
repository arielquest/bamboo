SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_CUBE]
--WITH ENCRYPTION
AS
SELECT  [SUMMARIZED_URN],
        [CDR_SESSION_URN],
        [DIALED_NUMBER_URN],
        [TLI_URN],
        [TLI_NNG_URN],
        [RATING_PERIOD_URN],
        [DATE_URN],
        x.[TIME_URN],
        t.[HOUR],
        t.[HALFHOUR],
        t.[QUARTERHOUR],
        t.[FIVEMINUTE],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        CAST(DATE_UTC_URN AS BIGINT) * 86400
        + CAST(tt.HALF_HOUR_URN AS BIGINT) AS [DATETIME_UTC_URN],
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
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
        [Row Count] AS [Row Count],
        [PARTITION_ID]
FROM    [dbo].[VW_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] x
JOIN    [dbo].[VW_DIM_TIME_CUBE] t ON x.[TIME_URN] = t.[TIME_URN]
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN];
GO
