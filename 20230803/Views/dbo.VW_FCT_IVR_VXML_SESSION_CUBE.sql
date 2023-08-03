SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_IVR_VXML_SESSION_CUBE]
AS
SELECT  [PARTITION_URN],
            
            -- Date Time Dimensions
        [START_DATE_UTC_URN],
        [START_TIME_UTC_URN],
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
        [END_DATE_UTC_URN],
        [END_TIME_UTC_URN],
            
            -- Dimensions
        [DIALED_NUMBER_URN],
        [IVR_SERVER_URN],
        [IVR_SCRIPT_URN],
        [SOURCE_IVR_SCRIPT_URN],
        [CAUSE_CODE_URN],
        [EVENT_TYPE_CODE_URN],
        [CLUSTER_RESOURCE_URN],
            
            -- Measures
        CAST([DURATION] AS BIGINT) AS [DURATION],
        CAST(( CASE [SOURCE_IVR_SCRIPT_URN]
                 WHEN -1 THEN NULL
                 ELSE 1
               END ) AS BIGINT) AS [Transfer From App],
        CAST(( CASE [SOURCE_IVR_SCRIPT_URN]
                 WHEN -1 THEN 1
                 ELSE NULL
               END ) AS BIGINT) AS [Direct],
                        
            --Custom Stuff
        [CUSTOM_DIMENSION_0],
        [CUSTOM_DIMENSION_1],
        [CUSTOM_DIMENSION_2],
        [CUSTOM_DIMENSION_3],
        [CUSTOM_DIMENSION_4],
        [CUSTOM_DIMENSION_5],
        [CUSTOM_DIMENSION_6],
        [CUSTOM_DIMENSION_7],
        [CUSTOM_DIMENSION_8],
        [CUSTOM_DIMENSION_9],
        CAST([CUSTOM_MEASURE_0] AS BIGINT) AS [CUSTOM_MEASURE_0],
        CAST([CUSTOM_MEASURE_1] AS BIGINT) AS [CUSTOM_MEASURE_1],
        CAST([CUSTOM_MEASURE_2] AS BIGINT) AS [CUSTOM_MEASURE_2],
        CAST([CUSTOM_MEASURE_3] AS BIGINT) AS [CUSTOM_MEASURE_3],
        CAST([CUSTOM_MEASURE_4] AS BIGINT) AS [CUSTOM_MEASURE_4],
        CAST([CUSTOM_MEASURE_5] AS BIGINT) AS [CUSTOM_MEASURE_5],
        CAST([CUSTOM_MEASURE_6] AS BIGINT) AS [CUSTOM_MEASURE_6],
        CAST([CUSTOM_MEASURE_7] AS BIGINT) AS [CUSTOM_MEASURE_7],
        CAST([CUSTOM_MEASURE_8] AS BIGINT) AS [CUSTOM_MEASURE_8],
        CAST([CUSTOM_MEASURE_9] AS BIGINT) AS [CUSTOM_MEASURE_9],
        [PARTITION_ID] AS [PARTITION_ID],
        [Row Count] AS [Row Count]
FROM    [dbo].[VW_FCT_IVR_VXML_SESSION] x
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] t ON x.[START_TIME_UTC_URN] = t.[TIME_URN]
JOIN    [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[START_DATE_UTC_URN]
                                             AND tzd.[TIME_UTC_URN] = t.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_VXML_SESSION_CUBE]
	TO [portalapp_role]
GO
