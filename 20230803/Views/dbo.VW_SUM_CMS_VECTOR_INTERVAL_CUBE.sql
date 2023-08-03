SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_CMS_VECTOR_INTERVAL_CUBE]
AS
SELECT  [PARTITION_URN],
        [PARTITION_GLOBAL_URN],
        [PARTITION_ID],
        [ACD_URN],
        [VECTOR_URN],
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
        CAST(ANS_TIME AS BIGINT) AS [Ans_Time],
        CAST(ACD_CALLS AS BIGINT) AS [Acd_Calls],
        CAST(BACKUP_CALLS AS BIGINT) AS [Backup_Calls],
        CAST(ABN_CALLS AS BIGINT) AS [Abn_Calls],
        CAST(ABN_TIME AS BIGINT) AS [Abn_Time],
        CAST(ABN_QUE_CALLS AS BIGINT) AS [Abn_Que_Calls],
        CAST(BUSY_CALLS AS BIGINT) AS [Busy_Calls],
        CAST(BUSY_TIME AS BIGINT) AS [Busy_Time],
        CAST(DISC_CALLS AS BIGINT) AS [Disc_Calls],
        CAST(DISC_TIME AS BIGINT) AS [Disc_Time],
        CAST(OTHER_CALLS AS BIGINT) AS [Other_Calls],
        CAST(OTHER_TIME AS BIGINT) AS [Other_Time],
        CAST(OUT_FLOW_CALLS AS BIGINT) AS [Out_Flow_Calls],
        CAST(OUT_FLOW_TIME AS BIGINT) AS [Out_Flow_Time],
        CAST(INTERFLOW_CALLS AS BIGINT) AS [Interflow_Calls],
        CAST(GOTO_CALLS AS BIGINT) AS [Goto_Calls],
        CAST(GOTO_TIME AS BIGINT) AS [Goto_Time],
        CAST(LOOK_ATTEMPTS AS BIGINT) AS [Look_Attempts],
        CAST(LOOKFLOW_CALLS AS BIGINT) AS [Lookflow_Calls],
        CAST(ADJ_ATTEMPTS AS BIGINT) AS [Adj_Attempts],
        CAST(ADJ_ROUTED AS BIGINT) AS [Adj_Routed],
        CAST(IN_FLOW_CALLS AS BIGINT) AS [In_Flow_Calls],
        CAST(ABN_RING_CALLS AS BIGINT) AS [Abn_Ring_Calls],
        CAST(RING_TIME AS BIGINT) AS [Ring_Time],
        CAST(RING_CALLS AS BIGINT) AS [Ring_Calls],
        CAST(INCOMPLETE AS BIGINT) AS [Incomplete],
        CAST(PHANTOM_ABNS AS BIGINT) AS [Phantom_Abns],
        CAST(VDISC_CALLS AS BIGINT) AS [VDisc_Calls],
        CAST(DEFLECT_CALLS AS BIGINT) AS [Deflect_Calls],
        CAST(NET_DISC_CALLS AS BIGINT) AS [Net_Disc_Calls],
        CAST(NET_POLLS AS BIGINT) AS [Net_Polls],
        CAST(ACD_CALLS_R1 AS BIGINT) AS [Acd_Calls_R1],
        CAST(ACD_CALLS_R2 AS BIGINT) AS [Acd_Calls_R2],
        CAST(ICR_PULL_CALLS AS BIGINT) AS [ICR_Pull_Calls],
        CAST(ICR_PULL_TIME AS BIGINT) AS [ICR_Pull_Time],
        CAST(ICR_PULL_QUE_CALLS AS BIGINT) AS [ICR_Pull_Que_Calls],
        CAST(ICR_PULL_RING_CALLS AS BIGINT) AS [ICR_Pull_Ring_Calls],
        [Row Count] AS [Row Count]
FROM    [dbo].[VW_SUM_CMS_VECTOR_INTERVAL] x
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] t ON x.TIME_UTC_URN = t.[TIME_URN]
JOIN    [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.DATE_UTC_URN
                                             AND tzd.[TIME_UTC_URN] = t.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_CMS_VECTOR_INTERVAL_CUBE]
	TO [portalapp_role]
GO
