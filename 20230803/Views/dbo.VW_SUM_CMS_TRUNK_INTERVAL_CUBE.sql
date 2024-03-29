SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_CMS_TRUNK_INTERVAL_CUBE]
AS
SELECT  [PARTITION_URN],
        [PARTITION_GLOBAL_URN],
        [PARTITION_ID],
        [ACD_URN],
        [TRUNKGROUP_URN],
        [TRUNK_URN],
        [LOC_ID],
        [CLUSTER_RESOURCE_URN],
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
        CAST(IN_CALLS AS BIGINT) AS [In_Calls],
        CAST(IN_TIME AS BIGINT) AS [In_Time],
        CAST(I_IN_OCC AS BIGINT) AS [I_In_Occ],
        CAST(ABN_CALLS AS BIGINT) AS [Abn_Calls],
        CAST(O_ABN_CALLS AS BIGINT) AS [O_Abn_Calls],
        CAST(OUT_CALLS AS BIGINT) AS [Out_Calls],
        CAST(OUT_TIME AS BIGINT) AS [Out_Time],
        CAST(I_OUT_OCC AS BIGINT) AS [I_Out_Occ],
        CAST(FAILURES AS BIGINT) AS [Failures],
        CAST(AUDIO AS BIGINT) AS [Audio],
        CAST(MBUSY_TIME AS BIGINT) AS [MBusy_Time],
        CAST(ACD_CALLS AS BIGINT) AS [Acd_Calls],
        CAST(OTHER_CALLS AS BIGINT) AS [Other_Calls],
        CAST(SHORT_CALLS AS BIGINT) AS [Short_Calls],
        CAST(O_ACD_CALLS AS BIGINT) AS [O_Acd_Calls],
        CAST(O_OTHER_CALLS AS BIGINT) AS [O_Other_Calls],
        CAST(INCOMPLETE AS BIGINT) AS [Incomplete],
        CAST(ACD_CALLS_R1 AS BIGINT) AS [Acd_Calls_R1],
        CAST(ACD_CALLS_R2 AS BIGINT) AS [Acd_Calls_R2],
        CAST(ICR_PULL_CALLS AS BIGINT) AS [ICR_Pull_Calls],
        [Row Count] AS [Row Count]
FROM    [dbo].[VW_SUM_CMS_TRUNK_INTERVAL] x
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] t ON x.[TIME_UTC_URN] = t.[TIME_URN]
JOIN    [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                             AND tzd.[TIME_UTC_URN] = t.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_CMS_TRUNK_INTERVAL_CUBE]
	TO [portalapp_role]
GO
