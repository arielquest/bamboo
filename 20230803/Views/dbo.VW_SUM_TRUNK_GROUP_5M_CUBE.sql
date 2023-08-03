SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_SUM_TRUNK_GROUP_5M_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  [SUMMARIZED_URN],
        [TRUNK_GROUP_URN],
        [CLUSTER_RESOURCE_URN],
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
        CAST([TRUNKS_IN_SERVICE] AS BIGINT) AS [Trunk In Service],
        CAST([ALL_TRUNKS_BUSY_TH] AS BIGINT) AS [All Trunk Busy],
        CAST([TRUNKS_IDLE] AS BIGINT) AS [Trunk Idle],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_TRUNK_GROUP_5M] x
JOIN    [dbo].[VW_DIM_TIME_CUBE] t ON x.[TIME_URN] = t.[TIME_URN]
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_TRUNK_GROUP_5M_CUBE]
	TO [portalapp_role]
GO
