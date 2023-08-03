SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_CALL_TYPE_INTERVAL]
AS
SELECT  [SUMMARIZED_URN],
        [DATE_URN],
        [TIME_URN],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        [CALL_TYPE_URN],
        [BUCKET_INTERVAL_URN],
        [CLUSTER_RESOURCE_URN],
        [DATE_TIME],
        [TIME_ZONE],
        [ROUTER_QUEUE_WAIT_TIME],
        [ROUTER_QUEUE_CALLS],
        [AVG_ROUTER_DELAY_Q],
        [ROUTER_CALLS_ABAND_Q],
        [ROUTER_QUEUE_CALL_TYPE_LIMIT],
        [ROUTER_QUEUE_GLOBAL_LIMIT],
        [CALLS_ROUTED],
        [ERROR_COUNT],
        [ICR_DEFAULT_ROUTED],
        [NETWORK_DEFAULT_ROUTED],
        [RETURN_BUSY],
        [RETURN_RING],
        [NETWORK_ANNOUNCEMENT],
        [ANSWER_WAIT_TIME],
        [CALLS_HANDLED],
        [CALLS_OFFERED],
        [HANDLE_TIME],
        [SERVICE_LEVEL_ABANDONED],
        [SERVICE_LEVEL_CALLS],
        [SERVICE_LEVEL_CALLS_OFFERED],
        [SERVICE_LEVEL],
        [TALK_TIME],
        [OVERFLOW_OUT],
        [HOLD_TIME],
        [INCOMPLETE_CALLS],
        [CALLS_ANSWERED],
        [CALLS_ROUTED_NON_AGENT],
        [CALLS_RONA],
        [RETURN_RELEASE],
        [CALLS_Q_HANDLED],
        [VRU_UNHANDLED_CALLS],
        [VRU_HANDLED_CALLS],
        [VRU_ASSISTED_CALLS],
        [VRU_OPT_OUT_UNHANDLED_CALLS],
        [VRU_SCRIPTED_XFERRED_CALLS],
        [VRU_FORCED_XFERRED_CALLS],
        [VRU_OTHER_CALLS],
        [ABAND_INTERVAL_1],
        [ABAND_INTERVAL_2],
        [ABAND_INTERVAL_3],
        [ABAND_INTERVAL_4],
        [ABAND_INTERVAL_5],
        [ABAND_INTERVAL_6],
        [ABAND_INTERVAL_7],
        [ABAND_INTERVAL_8],
        [ABAND_INTERVAL_9],
        [ABAND_INTERVAL_10],
        [ANS_INTERVAL_1],
        [ANS_INTERVAL_2],
        [ANS_INTERVAL_3],
        [ANS_INTERVAL_4],
        [ANS_INTERVAL_5],
        [ANS_INTERVAL_6],
        [ANS_INTERVAL_7],
        [ANS_INTERVAL_8],
        [ANS_INTERVAL_9],
        [ANS_INTERVAL_10],
        [AGENT_ERROR_COUNT],
        [CALL_DELAY_ABAND_TIME],
        [CALLS_REQUERIED],
        [CT_DELAY_ABAND_TIME],
        [CT_VRU_TIME],
        [DELAY_AGENT_ABAND_TIME],
        [ROUTER_CALLS_ABAND_TO_AGENT],
        [SERVICE_LEVEL_ERROR],
        [SERVICE_LEVEL_RONA],
        [TOTAL_CALLS_ABAND],
        [VRU_TIME],
        [SHORT_CALLS],
        [DELAY_QUEUE_ABANDON_TIME],
        [SERVICE_LEVEL_TYPE],
        [CALLS_ON_HOLD],
        [MAX_HOLD_TIME],
        [MAX_CALLS_QUEUED],
        [MAX_CALL_WAIT_TIME],
        [RESERVATION_CALLS],
        [REPORTING_HALF_HOUR],
        [REPORTING_INTERVAL],
        [PARTITION_ID],
        ( CAST([TALK_TIME] AS BIGINT) + CAST([HOLD_TIME] AS BIGINT) ) AS [PHONE_TIME],
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_SUM_CALL_TYPE_INTERVAL;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_CALL_TYPE_INTERVAL]
	TO [portalreporting_role]
GO
