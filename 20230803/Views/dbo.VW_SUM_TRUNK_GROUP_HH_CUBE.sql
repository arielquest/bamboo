SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_SUM_TRUNK_GROUP_HH_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  [SUMMARIZED_URN] AS [PARTITION_URN],
        [TRUNK_GROUP_URN],
        [CLUSTER_RESOURCE_URN],
        [DATE_URN],
        x.[TIME_URN],
        x.[DATE_UTC_URN],
        x.[TIME_UTC_URN],
        tzd.[OLAP_DATETIME_UTC] AS [DATETIME_UTC_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_0] AS [TIME_ZONE_0_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_1] AS [TIME_ZONE_1_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_2] AS [TIME_ZONE_2_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_3] AS [TIME_ZONE_3_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_4] AS [TIME_ZONE_4_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_5] AS [TIME_ZONE_5_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_6] AS [TIME_ZONE_6_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_7] AS [TIME_ZONE_7_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_8] AS [TIME_ZONE_8_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_9] AS [TIME_ZONE_9_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_10] AS [TIME_ZONE_10_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_11] AS [TIME_ZONE_11_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_12] AS [TIME_ZONE_12_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_13] AS [TIME_ZONE_13_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_14] AS [TIME_ZONE_14_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_15] AS [TIME_ZONE_15_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_16] AS [TIME_ZONE_16_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_17] AS [TIME_ZONE_17_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_18] AS [TIME_ZONE_18_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_19] AS [TIME_ZONE_19_URN],
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
        CAST([CALLS_ABANDONED_TH] AS BIGINT) AS [Call Abandoned],
        CAST([CALLS_IN_TH] AS BIGINT) AS [Call In],
        CAST([TRUNKS_IN_SERVICE] AS BIGINT) AS [Trunk In Service],
        CAST([CALLS_OUT_TH] AS BIGINT) AS [Call Out],
        CAST([ALL_TRUNKS_BUSY_TH] AS BIGINT) AS [All Trunk Busy],
        CAST([IN_SERVICE_TTH] AS BIGINT) AS [In Service Time],
        CAST([TRUNKS_IDLE] AS BIGINT) AS [Trunk Idle],
        CAST([IN_USE_INBOUND_TTH] AS BIGINT) AS [In Use Inbound Time],
        CAST([IN_USE_OUTBOUND_TTH] AS BIGINT) AS [In Use Outbound Time],
        [Row Count] AS [Row Count],
        [PARTITION_ID]
FROM    [dbo].[VW_SUM_TRUNK_GROUP_HH] x
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
JOIN    [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                             AND tzd.[TIME_UTC_URN] = x.[TIME_UTC_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_TRUNK_GROUP_HH_CUBE]
	TO [portalapp_role]
GO
