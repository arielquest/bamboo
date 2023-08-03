SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_ROUTER_QUEUE_INTERVAL_CUBE]
AS
SELECT  [PARTITION_URN],
        [PRECISION_QUEUE_URN],
        [MEDIA_CLASS_URN],
        [MEDIA_ROUTING_DOMAIN_URN],
        [BUCKET_INTERVAL_URN],
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
        CAST([CALLS_ABAND_DEQUEUED] AS BIGINT) AS [Calls Abandoned Dequeued],
        CAST([CALLS_ABAND_Q] AS BIGINT) AS [Calls Abandoned Queued],
        CAST([CALLS_ABAND_TO_AGENT] AS BIGINT) AS [Calls Abandoned To Agent],
        CAST([CALLS_ANSWERED] AS BIGINT) AS [Calls Answered],
        CAST([CALLS_DEQUEUED] AS BIGINT) AS [Calls Dequeued],
        CAST([CALLS_OFFERED] AS BIGINT) AS [Calls Offered],
        CAST([DELAY_Q_ABAND_TIME] AS BIGINT) AS [Delay Queue Abandon Time],
        CAST([MAX_CALLS_QUEUED] AS BIGINT) AS [Max Call Queued],
        CAST([MAX_CALL_WAIT_TIME] AS BIGINT) AS [Max Calls Wait Time],
        CAST([QUEUE_CALLS] AS BIGINT) AS [Queue Calls],
        CAST([ROUTED_TO_AGENT] AS BIGINT) AS [Routed To Agent],
        CAST([ROUTER_ERROR] AS BIGINT) AS [Router Error],
        CAST([SERVICE_LEVEL] AS BIGINT) AS [Service Level],
        CAST([SERVICE_LEVEL_CALLS] AS BIGINT) AS [Service Level Calls],
        CAST([SERVICE_LEVEL_CALLS_ABAND] AS BIGINT) AS [Service Level Calls Abandoned],
        CAST([SERVICE_LEVEL_CALLS_DEQUEUE] AS BIGINT) AS [Service Level Calls Dequeued],
        CAST([SERVICE_LEVEL_CALLS_OFFERED] AS BIGINT) AS [Service Level Calls Offered],
        CAST([SERVICE_LEVEL_ERROR] AS BIGINT) AS [Service Level Calls Error],
        CAST([SERVICE_LEVEL_RONA] AS BIGINT) AS [Service Level Calls RONA],
        CAST([SERVICE_LEVEL_TYPE] AS INT) AS [SERVICE_LEVEL_TYPE],
        CAST([ABAND_INTERVAL_1] AS BIGINT) AS [Abandon Interval 1],
        CAST([ABAND_INTERVAL_2] AS BIGINT) AS [Abandon Interval 2],
        CAST([ABAND_INTERVAL_3] AS BIGINT) AS [Abandon Interval 3],
        CAST([ABAND_INTERVAL_4] AS BIGINT) AS [Abandon Interval 4],
        CAST([ABAND_INTERVAL_5] AS BIGINT) AS [Abandon Interval 5],
        CAST([ABAND_INTERVAL_6] AS BIGINT) AS [Abandon Interval 6],
        CAST([ABAND_INTERVAL_7] AS BIGINT) AS [Abandon Interval 7],
        CAST([ABAND_INTERVAL_8] AS BIGINT) AS [Abandon Interval 8],
        CAST([ABAND_INTERVAL_9] AS BIGINT) AS [Abandon Interval 9],
        CAST([ABAND_INTERVAL_10] AS BIGINT) AS [Abandon Interval 10],
        CAST([ANS_INTERVAL_1] AS BIGINT) AS [Answer Interval 1],
        CAST([ANS_INTERVAL_2] AS BIGINT) AS [Answer Interval 2],
        CAST([ANS_INTERVAL_3] AS BIGINT) AS [Answer Interval 3],
        CAST([ANS_INTERVAL_4] AS BIGINT) AS [Answer Interval 4],
        CAST([ANS_INTERVAL_5] AS BIGINT) AS [Answer Interval 5],
        CAST([ANS_INTERVAL_6] AS BIGINT) AS [Answer Interval 6],
        CAST([ANS_INTERVAL_7] AS BIGINT) AS [Answer Interval 7],
        CAST([ANS_INTERVAL_8] AS BIGINT) AS [Answer Interval 8],
        CAST([ANS_INTERVAL_9] AS BIGINT) AS [Answer Interval 9],
        CAST([ANS_INTERVAL_10] AS BIGINT) AS [Answer Interval 10],
        [PRECISION_ATTRIBUTE_URN_1],
        [PRECISION_ATTRIBUTE_URN_2],
        [PRECISION_ATTRIBUTE_URN_3],
        [PRECISION_ATTRIBUTE_URN_4],
        [PRECISION_ATTRIBUTE_URN_5],
        [PRECISION_ATTRIBUTE_URN_6],
        [PRECISION_ATTRIBUTE_URN_7],
        [PRECISION_ATTRIBUTE_URN_8],
        [PRECISION_ATTRIBUTE_URN_9],
        [PRECISION_ATTRIBUTE_URN_10],
        CAST([ABAND_PRECISION_QUEUE_STEP_1] AS BIGINT) AS [Abandoned Precision Queue Step 1],
        CAST([ABAND_PRECISION_QUEUE_STEP_2] AS BIGINT) AS [Abandoned Precision Queue Step 2],
        CAST([ABAND_PRECISION_QUEUE_STEP_3] AS BIGINT) AS [Abandoned Precision Queue Step 3],
        CAST([ABAND_PRECISION_QUEUE_STEP_4] AS BIGINT) AS [Abandoned Precision Queue Step 4],
        CAST([ABAND_PRECISION_QUEUE_STEP_5] AS BIGINT) AS [Abandoned Precision Queue Step 5],
        CAST([ABAND_PRECISION_QUEUE_STEP_6] AS BIGINT) AS [Abandoned Precision Queue Step 6],
        CAST([ABAND_PRECISION_QUEUE_STEP_7] AS BIGINT) AS [Abandoned Precision Queue Step 7],
        CAST([ABAND_PRECISION_QUEUE_STEP_8] AS BIGINT) AS [Abandoned Precision Queue Step 8],
        CAST([ABAND_PRECISION_QUEUE_STEP_9] AS BIGINT) AS [Abandoned Precision Queue Step 9],
        CAST([ABAND_PRECISION_QUEUE_STEP_10] AS BIGINT) AS [Abandoned Precision Queue Step 10],
        CAST([ANS_PRECISION_QUEUE_STEP_1] AS BIGINT) AS [Answered Precision Queue Step 1],
        CAST([ANS_PRECISION_QUEUE_STEP_2] AS BIGINT) AS [Answered Precision Queue Step 2],
        CAST([ANS_PRECISION_QUEUE_STEP_3] AS BIGINT) AS [Answered Precision Queue Step 3],
        CAST([ANS_PRECISION_QUEUE_STEP_4] AS BIGINT) AS [Answered Precision Queue Step 4],
        CAST([ANS_PRECISION_QUEUE_STEP_5] AS BIGINT) AS [Answered Precision Queue Step 5],
        CAST([ANS_PRECISION_QUEUE_STEP_6] AS BIGINT) AS [Answered Precision Queue Step 6],
        CAST([ANS_PRECISION_QUEUE_STEP_7] AS BIGINT) AS [Answered Precision Queue Step 7],
        CAST([ANS_PRECISION_QUEUE_STEP_8] AS BIGINT) AS [Answered Precision Queue Step 8],
        CAST([ANS_PRECISION_QUEUE_STEP_9] AS BIGINT) AS [Answered Precision Queue Step 9],
        CAST([ANS_PRECISION_QUEUE_STEP_10] AS BIGINT) AS [Answered Precision Queue Step 10],
        CAST([OFFERED_PRECISION_QUEUE_STEP_1] AS BIGINT) AS [Offered Precision Queue Step 1],
        CAST([OFFERED_PRECISION_QUEUE_STEP_2] AS BIGINT) AS [Offered Precision Queue Step 2],
        CAST([OFFERED_PRECISION_QUEUE_STEP_3] AS BIGINT) AS [Offered Precision Queue Step 3],
        CAST([OFFERED_PRECISION_QUEUE_STEP_4] AS BIGINT) AS [Offered Precision Queue Step 4],
        CAST([OFFERED_PRECISION_QUEUE_STEP_5] AS BIGINT) AS [Offered Precision Queue Step 5],
        CAST([OFFERED_PRECISION_QUEUE_STEP_6] AS BIGINT) AS [Offered Precision Queue Step 6],
        CAST([OFFERED_PRECISION_QUEUE_STEP_7] AS BIGINT) AS [Offered Precision Queue Step 7],
        CAST([OFFERED_PRECISION_QUEUE_STEP_8] AS BIGINT) AS [Offered Precision Queue Step 8],
        CAST([OFFERED_PRECISION_QUEUE_STEP_9] AS BIGINT) AS [Offered Precision Queue Step 9],
        CAST([OFFERED_PRECISION_QUEUE_STEP_10] AS BIGINT) AS [Offered Precision Queue Step 10],
        CAST([SKIP_PRECISION_QUEUE_STEP_1] AS BIGINT) AS [Skipped Precision Queue Step 1],
        CAST([SKIP_PRECISION_QUEUE_STEP_2] AS BIGINT) AS [Skipped Precision Queue Step 2],
        CAST([SKIP_PRECISION_QUEUE_STEP_3] AS BIGINT) AS [Skipped Precision Queue Step 3],
        CAST([SKIP_PRECISION_QUEUE_STEP_4] AS BIGINT) AS [Skipped Precision Queue Step 4],
        CAST([SKIP_PRECISION_QUEUE_STEP_5] AS BIGINT) AS [Skipped Precision Queue Step 5],
        CAST([SKIP_PRECISION_QUEUE_STEP_6] AS BIGINT) AS [Skipped Precision Queue Step 6],
        CAST([SKIP_PRECISION_QUEUE_STEP_7] AS BIGINT) AS [Skipped Precision Queue Step 7],
        CAST([SKIP_PRECISION_QUEUE_STEP_8] AS BIGINT) AS [Skipped Precision Queue Step 8],
        CAST([SKIP_PRECISION_QUEUE_STEP_9] AS BIGINT) AS [Skipped Precision Queue Step 9],
        CAST([SKIP_PRECISION_QUEUE_STEP_10] AS BIGINT) AS [Skipped Precision Queue Step 10],
        [Row Count] AS [Row Count],
        [PARTITION_ID] AS [PARTITION_ID]
FROM    [dbo].[VW_SUM_ROUTER_QUEUE_INTERVAL] x
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
JOIN    [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                             AND tzd.[TIME_UTC_URN] = x.[TIME_UTC_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_ROUTER_QUEUE_INTERVAL_CUBE]
	TO [portalapp_role]
GO
