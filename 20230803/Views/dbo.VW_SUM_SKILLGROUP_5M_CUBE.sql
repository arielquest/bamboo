SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_SUM_SKILLGROUP_5M_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  [SUMMARIZED_URN],
        [SKILLGROUP_URN],
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
        CAST([LOGGED_ON] AS BIGINT) AS [Logged On],
        CAST([AVAIL] AS BIGINT) AS [Available],
        CAST([READY] AS BIGINT) AS [Ready],
        CAST([NOT_READY] AS BIGINT) AS [Not Ready],
        CAST([TALKING_IN] AS BIGINT) AS [Talking In],
        CAST([TALKING_OUT] AS BIGINT) AS [Talking Out],
        CAST([TALKING_OTHER] AS BIGINT) AS [Talking Other],
        CAST([WORK_READY] AS BIGINT) AS [Work Ready],
        CAST([WORK_NOT_READY] AS BIGINT) AS [Work Not Ready],
        CAST([AVG_HANDLED_CALLS_TALK_TIME_TO5] AS BIGINT) AS [Avg Handled Talk Time],
        CAST([CALLS_HANDLED_TO5] AS BIGINT) AS [Calls Handled],
        CAST([AVG_HANDLED_CALLS_TIME_TO5] AS BIGINT) AS [Avg Handled Calls Time],
        CAST([PERCENT_UTILIZATION_TO5] AS BIGINT) AS [Percent Utilization],
        CAST([AVAIL_TIME_TO5] AS BIGINT) AS [Available Time],
        CAST([NOT_READY_TIME_TO5] AS BIGINT) AS [Not Ready Time],
        CAST([TALK_TIME_TO5] AS BIGINT) AS [Talk Time],
        CAST([WORK_READY_TIME_TO5] AS BIGINT) AS [Work Ready Time],
        CAST([WORK_NOT_READY_TIME_TO5] AS BIGINT) AS [Work Not Ready Time],
        CAST([BUSY_OTHER] AS BIGINT) AS [Busy Other],
        CAST([BUSY_OTHER_TIME_TO5] AS BIGINT) AS [Busy Other Time],
        CAST([CALLS_ANSWERED_TO5] AS BIGINT) AS [Calls Answered],
        CAST([RESERVED_STATE_TIME_TO5] AS BIGINT) AS [Reserved Time],
        CAST([LONGEST_AVAIL_AGENT] AS BIGINT) AS [Longest Available Agent],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_SKILLGROUP_5M] x
JOIN    [dbo].[VW_DIM_TIME_CUBE] t ON x.[TIME_URN] = t.[TIME_URN]
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_SKILLGROUP_5M_CUBE]
	TO [portalapp_role]
GO
