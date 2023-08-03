SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
--Fact for Cube in OLAP 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_FCT_IVR_LEG_NODE_PATH_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  x.[PARTITION_URN] AS [SUMMARIZED_URN],
        x.[PARTITION_GLOBAL_URN],
        -1 AS [IVR_LEG_URN],
        x.[DIALED_NUMBER_URN],
        x.[DATE_URN] AS [STARTDATE_URN],
        x.[TIME_URN] AS [STARTTIME_URN],
        t.[HOUR],
        t.[HALFHOUR],
        t.[QUARTERHOUR],
        t.[FIVEMINUTE],
        x.[DATE_UTC_URN] AS [STARTDATE_UTC_URN],
        x.[TIME_UTC_URN] AS [STARTTIME_UTC_URN],
        CAST(x.DATE_UTC_URN AS BIGINT) * 86400
        + CAST(tt.HALF_HOUR_URN AS BIGINT) AS [DATETIME_UTC_URN],
        [IVR_SCRIPT_NODE_URN],
        [SEQUENCE] AS [Sequence],
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
        CAST([Occurence] AS BIGINT) AS [Occurence],
        [DEFLECTION],
        [BARGED_IN],
        [PARTITION_ID]
FROM    [dbo].[VW_FCT_IVR_LEG_NODE_PATH] x
JOIN    [dbo].[VW_DIM_TIME_CUBE] t ON x.[TIME_URN] = t.[TIME_URN]
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_LEG_NODE_PATH_CUBE]
	TO [portalapp_role]
GO
