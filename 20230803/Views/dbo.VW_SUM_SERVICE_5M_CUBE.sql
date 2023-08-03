SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- 1 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_SUM_SERVICE_5M_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  [SUMMARIZED_URN],
        [SERVICE_URN],
        [CLUSTER_RESOURCE_URN] AS [CLUSTER_RESOURCE_URN],
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
        CAST([CALLS_IN_PROGRESS] AS BIGINT) AS [Calls In Progress],
        CAST([CALLS_OFFERED_TODAY] AS BIGINT) AS [Calls Offered Today],
        CAST([CALLS_INCOMING_TODAY] AS BIGINT) AS [Calls Incoming Today],
        CAST([CALLS_HANDLED_TODAY] AS BIGINT) AS [Calls Handled Today],
        CAST([CALLS_ROUTED_TODAY] AS BIGINT) AS [Calls Routed Today],
        CAST([CALLS_ABAND_Q_TODAY] AS BIGINT) AS [Calls Abandoned In Q Today],
        CAST([PERIPH_SERVICE_LEVEL_TODAY] AS BIGINT) AS [Perip Service Level Today],
        CAST([PERIPH_SERVICE_LEVEL_TO5] AS BIGINT) AS [Perip Service Level],
        CAST([SERVICE_LEVEL_TODAY] AS BIGINT) AS [Service Level Today],
        CAST([SERVICE_LEVEL_TO5] AS BIGINT) AS [Service Level],
        CAST([SERVICE_LEVEL_CALLS_TODAY] AS BIGINT) AS [Service Level Calls Today],
        CAST([SERVICE_LEVEL_CALLS_TO5] AS BIGINT) AS [Service Level Calls],
        CAST([SERVICE_LEVEL_ABAND_TODAY] AS BIGINT) AS [Service Level Abandoned Today],
        CAST([SERVICE_LEVEL_ABAND_TO5] AS BIGINT) AS [Service Level Abandoned],
        CAST([SERVICE_LEVEL_CALLS_OFFERED_TODAY] AS BIGINT) AS [Service Level Calls Offered Today],
        CAST([SERVICE_LEVEL_CALLS_OFFERED_TO5] AS BIGINT) AS [Service Level Calls Offered],
        CAST([SERVICE_LEVEL_CALLS_Q_HELD] AS BIGINT) AS [Service Level Calls Q Held],
        CAST([LONGEST_CALL_Q] AS BIGINT) AS [Longest Call In Q],
        CAST([AVG_DELAY_Q_ABAND_TO5] AS BIGINT) AS [Avg Delay Q Abandoned],
        CAST([EXPECTED_DELAY] AS BIGINT) AS [Expected Delay Time],
        CAST([AVG_SPEED_ANSWER_TO5] AS BIGINT) AS [Avg Speed Answer Time],
        CAST([CALLS_OFFERED_TO5] AS BIGINT) AS [Calls Offered],
        CAST([AVG_TALK_TIME_TO5] AS BIGINT) AS [Avg Talk Time],
        CAST([CALLS_HANDLED_TO5] AS BIGINT) AS [Calls Handled],
        CAST([AVG_HANDLE_TIME_TO5] AS BIGINT) AS [Avg Handle Time],
        CAST([AVG_DELAY_Q_NOW] AS BIGINT) AS [Avg Delay Q Now],
        CAST([CALLS_Q_NOW] AS BIGINT) AS [Calls Q Now],
        CAST([AGENTS_TALKING] AS BIGINT) AS [Agents Talking],
        CAST([CALLS_LEFT_Q_TO5] AS BIGINT) AS [Calls Left Q],
        CAST([OVERFLOW_IN_TO5] AS BIGINT) AS [Overflow In],
        CAST([OVERFLOW_OUT_TO5] AS BIGINT) AS [Overflow Out],
        CAST([CALLS_ANSWERED_TODAY] AS BIGINT) AS [Calls Answered Today],
        CAST([CALLS_ANSWERED_TO5] AS BIGINT) AS [Calls Answered],
        CAST([LONGEST_AVAIL_AGENT] AS BIGINT) AS [Longest Available Agent],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_SERVICE_5M] x
JOIN    [dbo].[VW_DIM_TIME_CUBE] t ON x.[TIME_URN] = t.[TIME_URN]
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_SERVICE_5M_CUBE]
	TO [portalapp_role]
GO
