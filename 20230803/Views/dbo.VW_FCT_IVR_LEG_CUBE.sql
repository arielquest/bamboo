SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- 
------------------------------------------------------------------------------- 
CREATE VIEW [dbo].[VW_FCT_IVR_LEG_CUBE] 
--WITH ENCRYPTION 
AS
SELECT  x.[PARTITION_URN] AS [IVR_LEG_URN],
        x.[PARTITION_GLOBAL_URN],
        x.[CALL_DETAIL_URN],
        x.[CALL_REC_LINK],
        x.[SEQUENCE_NUMBER],
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
        x.[DIALED_NUMBER_URN],
        x.[IVR_SCRIPT_URN],
        x.[CALL_OUTCOME_URN],
        x.[INITIAL_IVR_SCRIPT_NODE_URN],
        x.[FINAL_IVR_SCRIPT_NODE_URN] AS [FINAL_LOCATION_URN],
        x.[IVR_ROUTING_TARGET_URN],
        x.[DEFLECTION_LEVEL_URN],
        x.[TRANSFER_TARGET_URN],
        x.[TRANSFER_STATUS_URN],
        x.[SECURITY_STATUS_URN],
        x.[TERMINATION_REASON_URN],
        x.[DESTINATION_ANI_URN],
        x.[ORGANIZATION_URN],
        x.[LOCATION_URN],
        x.[DURATION_TIMEBAND_URN],
        x.[NETWORK_TIME_TIMEBAND_URN],
        x.[RING_TIME_TIMEBAND_URN],
        x.[HOLD_TIME_TIMEBAND_URN],
        x.[TALK_TIME_TIMEBAND_URN],
        x.[QUEUE_TIME_TIMEBAND_URN],
        x.[CALL_TYPE_URN],
        x.[CLI_NNG_URN],
        x.[VALUE_URN] AS [Value],
        x.[SATISFACTION_URN] AS [Satisfaction],
        x.[CALL_REASON_URN],
        x.[CALL_SOURCE_URN],
        x.[PERIPHERAL_URN],
        x.[CUSTOM_DIMENSION_0],
        x.[CUSTOM_DIMENSION_1],
        x.[CUSTOM_DIMENSION_2],
        x.[CUSTOM_DIMENSION_3],
        x.[CUSTOM_DIMENSION_4],
        x.[CUSTOM_DIMENSION_5],
        x.[CUSTOM_DIMENSION_6],
        x.[CUSTOM_DIMENSION_7],
        x.[CUSTOM_DIMENSION_8],
        x.[CUSTOM_DIMENSION_9],
        -1 AS [FLEXIBLE_DIMENSION_0],
        -1 AS [FLEXIBLE_DIMENSION_1],
        -1 AS [FLEXIBLE_DIMENSION_2],
        -1 AS [FLEXIBLE_DIMENSION_3],
        -1 AS [FLEXIBLE_DIMENSION_4],
  
            -- Date/Times  
        x.[DATE_TIME] AS [START_DATE_TIME],
        x.[UTC_TIMEZONE] AS [START_UTC_TIMEZONE],
        [PORT] AS [Port],
        [DIRECTION] AS [Direction],
        [VERSION] AS [Version],  
  
            -- Measures  
        [Call Volume Total] AS [Call Volume Total],
        CAST([IVR_SCRIPT_NODE_COUNT] AS BIGINT) AS [Ivr Script Node Count],
        CAST([DEFLECTION_COUNT] AS BIGINT) AS [Deflection Count],
        CAST([GRAMMAR_REJECTS] AS BIGINT) AS [Grammar Rejects],
        CAST([INPUT_TIMEOUTS] AS BIGINT) AS [Input Timeouts],
        CAST([REPEAT_REQUESTS] AS BIGINT) AS [Repeat Requests],
        CAST([LOST_INFO] AS BIGINT) AS [Lost Info],
        CAST([NETWORK_TIME] AS BIGINT) AS [Network Time],
        CAST([DURATION] AS BIGINT) AS [Duration],
        CAST([RING_TIME] AS BIGINT) AS [Ring Time],
        CAST([HOLD_TIME] AS BIGINT) AS [Hold Time],
        CAST([TALK_TIME] AS BIGINT) AS [Talk Time],
        CAST([QUEUE_TIME] AS BIGINT) AS [Queue Time],
        [COST] AS [Cost],
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
        [PARTITION_ID]
FROM    [dbo].[VW_FCT_IVR_LEG] x
JOIN    [dbo].[VW_DIM_TIME_CUBE] t ON x.[TIME_URN] = t.[TIME_URN]
JOIN    [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_LEG_CUBE]
	TO [portalapp_role]
GO
