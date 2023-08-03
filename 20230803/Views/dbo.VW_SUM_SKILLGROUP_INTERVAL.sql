SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SUM_SKILLGROUP_INTERVAL]
AS
SELECT  [SUMMARIZED_URN],
        [DATE_URN],
        [TIME_URN],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        [SKILLGROUP_URN],
        [BUCKET_INTERVAL_URN],
        [CAMPAIGN_URN],
        [CLUSTER_RESOURCE_URN],
        [DATE_TIME],
        [TIME_ZONE],
        [CALLBACK_MESSAGES],
        [CALLBACK_MESSAGES_TIME],
        [AVG_HANDLED_CALLS_TALK_TIME],
        [HOLD_TIME],
        [HANDLED_CALLS_TALK_TIME],
        [INTERNAL_CALLS],
        [INTERNAL_CALLS_TIME],
        [CALLS_HANDLED],
        [SUPERV_ASSIST_CALLS],
        [AVG_HANDLED_CALLS_TIME],
        [SUPERV_ASSIST_CALLS_TIME],
        [HANDLED_CALLS_TIME],
        [PERCENT_UTILIZATION],
        [AGENT_OUT_CALLS_TIME],
        [TALK_IN_TIME],
        [LOGGED_ON_TIME],
        [AGENT_OUT_CALLS],
        [TALK_OUT_TIME],
        [TALK_OTHER_TIME],
        [AVAIL_TIME],
        [NOT_READY_TIME],
        [TRANSFER_IN_CALLS],
        [TALK_TIME],
        [TRANSFER_IN_CALLS_TIME],
        [WORK_READY_TIME],
        [TRANSFER_OUT_CALLS],
        [WORK_NOT_READY_TIME],
        [BUSY_OTHER_TIME],
        [CALLS_ANSWERED],
        [RESERVED_STATE_TIME],
        [ANSWER_WAIT_TIME],
        [ABANDON_RING_CALLS],
        [ABANDON_RING_TIME],
        [ABANDON_HOLD_CALLS],
        [AGENT_OUT_CALLS_TALK_TIME],
        [AGENT_OUT_CALLS_ON_HOLD],
        [AGENT_OUT_CALLS_ON_HOLD_TIME],
        [AGENT_TERMINATED_CALLS],
        [CONSULTATIVE_CALLS],
        [CONSULTATIVE_CALLS_TIME],
        [CONFERENCED_IN_CALLS],
        [CONFERENCED_IN_CALLS_TIME],
        [CONFERENCED_OUT_CALLS],
        [CONFERENCED_OUT_CALLS_TIME],
        [INCOMING_CALLS_ON_HOLD_TIME],
        [INCOMING_CALLS_ON_HOLD],
        [INTERNAL_CALLS_ON_HOLD_TIME],
        [INTERNAL_CALLS_ON_HOLD],
        [INTERNAL_CALLS_RCVD_TIME],
        [INTERNAL_CALLS_RCVD],
        [REDIRECT_NO_ANS_CALLS],
        [REDIRECT_NO_ANS_CALLS_TIME],
        [SHORT_CALLS],
        [ROUTER_CALLS_ABAND_Q],
        [ROUTER_QUEUE_CALLS],
        [AUTO_OUT_CALLS],
        [AUTO_OUT_CALLS_TIME],
        [AUTO_OUT_CALLS_TALK_TIME],
        [AUTO_OUT_CALLS_ON_HOLD],
        [AUTO_OUT_CALLS_ON_HOLD_TIME],
        [PREVIEW_CALLS],
        [PREVIEW_CALLS_TIME],
        [PREVIEW_CALLS_TALK_TIME],
        [PREVIEW_CALLS_ON_HOLD],
        [PREVIEW_CALLS_ON_HOLD_TIME],
        [RESERVE_CALLS],
        [RESERVE_CALLS_TIME],
        [RESERVE_CALLS_TALK_TIME],
        [RESERVE_CALLS_ON_HOLD],
        [RESERVE_CALLS_ON_HOLD_TIME],
        [TALK_AUTO_OUT_TIME],
        [TALK_PREVIEW_TIME],
        [TALK_RESERVE_TIME],
        [BARGE_IN_CALLS],
        [INTERCEPT_CALLS],
        [MONITOR_CALLS],
        [WHISPER_CALLS],
        [EMERGENCY_ASSISTS],
        [CALLS_OFFERED],
        [CALLS_QUEUED],
        [ABANDON_HOLD_CALLS_OUT],
        [NET_CONSULTATIVE_CALLS],
        [NET_CONSULTATIVE_CALLS_TIME],
        [NET_CONFERENCED_OUT_CALLS],
        [NET_CONFERENCED_OUT_CALLS_TIME],
        [NET_TRANSFER_OUT_CALLS],
        [ROUTER_CALLS_OFFERED],
        [ROUTER_CALLS_ABANDON_TO_AGENT],
        [ROUTER_CALLS_DEQUEUED],
        [ROUTER_ERROR],
        [SERVICE_LEVEL],
        [SERVICE_LEVEL_CALLS],
        [SERVICE_LEVEL_CALLS_ABANDON],
        [SERVICE_LEVEL_CALLS_DEQUEUED],
        [SERVICE_LEVEL_ERROR],
        [SERVICE_LEVEL_RONA],
        [SERVICE_LEVEL_CALLS_OFFERED],
        CASE d.[SERVICE_LEVEL_TYPE]
          WHEN 0 THEN 1
          ELSE d.[SERVICE_LEVEL_TYPE]
        END AS [SERVICE_LEVEL_TYPE],
        [CONSULT_OUT_CALLS],
        [CONSULT_OUT_CALLS_TIME],
        [INTERRUPTED_TIME],
        [ROUTER_DELAY_Q_ABAND_TIME],
        [ROUTER_MAX_CALLS_QUEUED],
        [ROUTER_MAX_CALL_WAIT_TIME],
        [ROUTER_CALLS_ABAND_DEQUEUED],
        [ROUTER_ABAND_INTERVAL_1],
        [ROUTER_ABAND_INTERVAL_2],
        [ROUTER_ABAND_INTERVAL_3],
        [ROUTER_ABAND_INTERVAL_4],
        [ROUTER_ABAND_INTERVAL_5],
        [ROUTER_ABAND_INTERVAL_6],
        [ROUTER_ABAND_INTERVAL_7],
        [ROUTER_ABAND_INTERVAL_8],
        [ROUTER_ABAND_INTERVAL_9],
        [ROUTER_ABAND_INTERVAL_10],
        [ROUTER_ANS_INTERVAL_1],
        [ROUTER_ANS_INTERVAL_2],
        [ROUTER_ANS_INTERVAL_3],
        [ROUTER_ANS_INTERVAL_4],
        [ROUTER_ANS_INTERVAL_5],
        [ROUTER_ANS_INTERVAL_6],
        [ROUTER_ANS_INTERVAL_7],
        [ROUTER_ANS_INTERVAL_8],
        [ROUTER_ANS_INTERVAL_9],
        [ROUTER_ANS_INTERVAL_10],
        [REPORTING_HALF_HOUR],
        [REPORTING_INTERVAL],
        ( CAST([HANDLED_CALLS_TALK_TIME] AS BIGINT) + CAST([INCOMING_CALLS_ON_HOLD_TIME] AS BIGINT) ) AS [PHONE_TIME_IN],
        ( CAST([AGENT_OUT_CALLS_TALK_TIME] AS BIGINT) + CAST([AGENT_OUT_CALLS_ON_HOLD_TIME] AS BIGINT) ) AS [PHONE_TIME_OUT],
        ( CAST([HANDLED_CALLS_TALK_TIME] AS BIGINT) + CAST([INCOMING_CALLS_ON_HOLD_TIME] AS BIGINT)
          + CAST([AGENT_OUT_CALLS_TALK_TIME] AS BIGINT) + CAST([AGENT_OUT_CALLS_ON_HOLD_TIME] AS BIGINT) ) AS [PHONE_TIME_TOTAL],
        ( CAST([CALLS_HANDLED] AS BIGINT) + CAST([AGENT_OUT_CALLS] AS BIGINT) ) AS [CALLS_HANDLED_TOTAL], -- Denominator for [Avg Phone Time Total]
        [PARTITION_ID],
        [PRECISION_QUEUE_URN],
        [MEDIA_CLASS_URN],
        [MEDIA_ROUTING_DOMAIN_URN],
        1 AS [Row Count]
FROM    [dbo].[VW_PARTITIONED_SUM_SKILLGROUP_INTERVAL] AS f
INNER JOIN [dbo].[TB_DIM_SKILLGROUP] AS tds ON f.SKILLGROUP_URN = tds.[ITEM_URN]
INNER JOIN [dbo].[TB_DIM_SKILLGROUP_PKEY_MAP] AS d ON [tds].[ITEM_BIZ_URN] = [d].[ITEM_BIZ_URN]
                                                      AND d.[LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_SUM_SKILLGROUP_INTERVAL]
	TO [portalreporting_role]
GO
