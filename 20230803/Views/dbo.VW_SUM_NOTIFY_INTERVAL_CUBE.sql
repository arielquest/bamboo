SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_NOTIFY_INTERVAL_CUBE]
AS
SELECT  [PARTITION_URN],

        [CLUSTER_RESOURCE_URN],
        [TENANT_URN],
        [NOTIFY_ORIGIN_URN],
        [NOTIFY_CHANNEL_URN],
        [NOTIFY_CATEGORY_URN],
        [NOTIFY_MESSAGE_TYPE_URN],
        [LANGUAGE_URN],

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

        [PARTITION_ID],
        [Row Count],

        [NOTIFICATION_DELIVERY_ACKED] AS [Notification Delivery Acked],
        [NOTIFICATION_DELIVERY_CLICKS] AS [Notification Delivery Clicks],
        [NOTIFICATION_DELIVERY_DELIVERED] AS [Notification Delivery Delivered],
        [NOTIFICATION_DELIVERY_EXPIRED] AS [Notification Delivery Expired],
        [NOTIFICATION_DELIVERY_FAILED] AS [Notification Delivery Failed],
        [NOTIFICATION_DELIVERY_OTHER] AS [Notification Delivery Other],
        [NOTIFICATION_DELIVERY_READ] AS [Notification Delivery Read],
        [NOTIFICATION_DELIVERY_RETRIED] AS [Notification Delivery Retried],
        [NOTIFICATION_DELIVERY_UNIQUE_CLICKS] AS [Notification Delivery Unique Clicks],
        [NOTIFICATION_DELIVERY_UNSUBSCRIBED] AS [Notification Delivery Unsubscribed],

        [NOTIFICATION_FAILURE] AS [Notification Failure],
        [NOTIFICATION_FAILURE_DISPATCHER] AS [Notification Failure Dispatcher],
        [NOTIFICATION_GENERATED] AS [Notification Generated],
        [NOTIFICATION_MAX_DISPATCH_TIME] AS [Notification Max Dispatch Time],
        [NOTIFICATION_FAILURE_MAX_RETRY] AS [Notification Max Retry], 
        [NOTIFICATION_MIN_DISPATCH_TIME] AS [Notification Min Dispatch Time],
        [NOTIFICATION_RECEIVED] AS [Notification Received],
        [NOTIFICATION_SLA_MET] AS [Notification Sla Met],
        [NOTIFICATION_SLA_NOT_MET] AS [Notification Sla Not Met],
        [NOTIFICATION_SUCCESS] AS [Notification Success],
        [NOTIFICATION_SUCCESS_FIRST_TIME] AS [Notification Success First Time],
        [NOTIFICATION_TOTAL_DISPATCH_TIME] AS [Notification Total Dispatch Time],

        -- Custom Dimension columns
        [CUSTOM_ATTRIBUTE_0] AS [CUSTOM_ATTRIBUTE_0],
        [CUSTOM_ATTRIBUTE_1] AS [CUSTOM_ATTRIBUTE_1],
        [CUSTOM_ATTRIBUTE_2] AS [CUSTOM_ATTRIBUTE_2],
        [CUSTOM_ATTRIBUTE_3] AS [CUSTOM_ATTRIBUTE_3],
        [CUSTOM_ATTRIBUTE_4] AS [CUSTOM_ATTRIBUTE_4],
        [CUSTOM_ATTRIBUTE_5] AS [CUSTOM_ATTRIBUTE_5],
        [CUSTOM_ATTRIBUTE_6] AS [CUSTOM_ATTRIBUTE_6],
        [CUSTOM_ATTRIBUTE_7] AS [CUSTOM_ATTRIBUTE_7],
        [CUSTOM_ATTRIBUTE_8] AS [CUSTOM_ATTRIBUTE_8],
        [CUSTOM_ATTRIBUTE_9] AS [CUSTOM_ATTRIBUTE_9],
        CAST([CUSTOM_MEASURE_0] AS BIGINT) AS [Custom Measure 0],
        CAST([CUSTOM_MEASURE_1] AS BIGINT) AS [Custom Measure 1],
        CAST([CUSTOM_MEASURE_2] AS BIGINT) AS [Custom Measure 2],
        CAST([CUSTOM_MEASURE_3] AS BIGINT) AS [Custom Measure 3],
        CAST([CUSTOM_MEASURE_4] AS BIGINT) AS [Custom Measure 4],
        CAST([CUSTOM_MEASURE_5] AS BIGINT) AS [Custom Measure 5],
        CAST([CUSTOM_MEASURE_6] AS BIGINT) AS [Custom Measure 6],
        CAST([CUSTOM_MEASURE_7] AS BIGINT) AS [Custom Measure 7],
        CAST([CUSTOM_MEASURE_8] AS BIGINT) AS [Custom Measure 8],
        CAST([CUSTOM_MEASURE_9] AS BIGINT) AS [Custom Measure 9]
FROM    [dbo].[VW_SUM_NOTIFY_INTERVAL] x
INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                                AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_SUM_NOTIFY_INTERVAL_CUBE]
	TO [portalapp_role]
GO
