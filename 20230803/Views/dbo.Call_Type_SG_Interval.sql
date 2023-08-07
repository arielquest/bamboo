SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Call_Type_SG_Interval]
AS
SELECT  [callTypeSkillGroupInterval].[DATE_TIME] AS DateTime,
        CAST([callType].[PKEY1] AS INT) AS [CallTypeID],
        CAST([skillGroup].[PKEY1] AS INT) AS [SkillGroupSkillTargetID],
        [callTypeSkillGroupInterval].[TIME_ZONE] AS TimeZone,
        [callTypeSkillGroupInterval].[RECOVERY_KEY] AS RecoveryKey,
        [callTypeSkillGroupInterval].[ANSWER_WAIT_TIME] AS AnswerWaitTime,
        [callTypeSkillGroupInterval].[AVG_ROUTER_DELAY_Q] AS AvgRouterDelayQ,
        [callTypeSkillGroupInterval].[CALL_DELAY_ABAND_TIME] AS CallDelayAbandTime,
        [callTypeSkillGroupInterval].[CALLS_ANSWERED] AS CallsAnswered,
        [callTypeSkillGroupInterval].[CALLS_HANDLED] AS CallsHandled,
        [callTypeSkillGroupInterval].[CALLS_REPORT_AGAINST_OTHER] AS CallsReportAgainstOther,
        [callTypeSkillGroupInterval].[CALLS_Q_HANDLED] AS CallsQHandled,
        [callTypeSkillGroupInterval].[CALLS_RONA] AS CallsRONA,
        [callTypeSkillGroupInterval].[CALLS_REQUERIED] AS CallsRequeried,
        [callTypeSkillGroupInterval].[CALLS_ROUTED_NON_AGENT] AS CallsRoutedNonAgent,
        [callTypeSkillGroupInterval].[CALLS_HANDLED_NOT_ROUTED] AS CallsHandledNotRouted,
        [callTypeSkillGroupInterval].[DELAY_AGENT_ABAND_TIME] AS DelayAgentAbandTime,
        [callTypeSkillGroupInterval].[DELAY_Q_ABAND_TIME] AS DelayQAbandTime,
        [callTypeSkillGroupInterval].[HANDLED_TIME] AS HandleTime,
        [callTypeSkillGroupInterval].[TALK_TIME] AS TalkTime,
        [callTypeSkillGroupInterval].[HOLD_TIME] AS HoldTime,
        [callTypeSkillGroupInterval].[INCOMPLETE_CALLS] AS IncompleteCalls,
        [callTypeSkillGroupInterval].[CALLS_OFFERED_ROUTED] AS CallsOfferedRouted,
        [callTypeSkillGroupInterval].[CALLS_OFFERED_NOT_ROUTED] AS CallsOfferedNotRouted,
        [callTypeSkillGroupInterval].[ROUTER_CALLS_ABAND_Q] AS RouterCallsAbandQ,
        [callTypeSkillGroupInterval].[ROUTER_CALLS_ABAND_TO_AGENT] AS RouterCallsAbandToAgent,
        [callTypeSkillGroupInterval].[ROUTER_QUEUE_WAIT_TIME] AS RouterQueueWaitTime,
        [callTypeSkillGroupInterval].[ROUTER_QUEUE_CALLS] AS RouterQueueCalls,
        [callTypeSkillGroupInterval].[ROUTER_CALLS_DEQUEUED] AS RouterCallsDequeued,
        [callTypeSkillGroupInterval].[SHORT_CALLS] AS ShortCalls,
        [callTypeSkillGroupInterval].[AGENT_ERROR_COUNT] AS AgentErrorCount,
        [callTypeSkillGroupInterval].[ERROR_COUNT] AS ErrorCount,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_ABAND] AS ServiceLevelAband,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_CALLS] AS ServiceLevelCalls,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_CALLS_OFFERED] AS ServiceLevelCallsOffered,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL] AS ServiceLevel,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_ERROR] AS ServiceLevelError,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_RONA] AS ServiceLevelRONA,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_TYPE] AS ServiceLevelType,
        [callTypeSkillGroupInterval].[SERVICE_LEVEL_CALLS_DEQUEUE] AS ServiceLevelCallsDequeue,
        [callTypeSkillGroupInterval].[DB_DATETIME] AS DbDateTime,
        [callTypeSkillGroupInterval].[CALLS_ON_HOLD] AS CallsOnHold,
        [callTypeSkillGroupInterval].[ROUTER_CALLS_ABAND_DEQUEUED] AS RouterCallsAbandDequeued,
        [callTypeSkillGroupInterval].[MAX_HOLD_TIME] AS MaxHoldTime,
        0 AS Reserved1,
        0 AS Reserved2,
        0 AS Reserved3,
        0 AS Reserved4,
        0 AS Reserved5,
        [callTypeSkillGroupInterval].[OVERFLOW_OUT] AS OverflowOut,
        [callTypeSkillGroupInterval].[REPORTING_HALF_HOUR] AS ReportingHalfHour,
        [callTypeSkillGroupInterval].[REPORTING_INTERVAL] AS ReportingInterval,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_1] AS AbandInterval1,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_2] AS AbandInterval2,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_3] AS AbandInterval3,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_4] AS AbandInterval4,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_5] AS AbandInterval5,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_6] AS AbandInterval6,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_7] AS AbandInterval7,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_8] AS AbandInterval8,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_9] AS AbandInterval9,
        [callTypeSkillGroupInterval].[ABAND_INTERVAL_10] AS AbandInterval10,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_1] AS AnsInterval1,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_2] AS AnsInterval2,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_3] AS AnsInterval3,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_4] AS AnsInterval4,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_5] AS AnsInterval5,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_6] AS AnsInterval6,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_7] AS AnsInterval7,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_8] AS AnsInterval8,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_9] AS AnsInterval9,
        [callTypeSkillGroupInterval].[ANS_INTERVAL_10] AS AnsInterval10,
        CAST([bucketInterval].[PKEY1] AS INT) AS BucketIntervalID,
        [callTypeSkillGroupInterval].[MAX_CALL_WAIT_TIME] AS MaxCallWaitTime,
        [callTypeSkillGroupInterval].[MAX_CALLS_QUEUED] AS MaxCallsQueued,
        [callTypeSkillGroupInterval].[RESERVATION_CALLS] AS ReservationCalls
FROM    [dbo].[VW_PARTITIONED_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] callTypeSkillGroupInterval
JOIN    [dbo].[VW_DIM_CALL_TYPE_PKEY] callType WITH ( NOLOCK ) ON [callType].[ITEM_URN] = [callTypeSkillGroupInterval].[CALL_TYPE_URN]
JOIN    [dbo].[VW_DIM_SKILLGROUP_PKEY] skillGroup WITH ( NOLOCK ) ON [skillGroup].[ITEM_URN] = [callTypeSkillGroupInterval].[SKILLGROUP_URN]
LEFT JOIN [dbo].[VW_DIM_BUCKET_INTERVAL_PKEY] bucketInterval WITH ( NOLOCK ) ON [bucketInterval].[ITEM_URN] = [callTypeSkillGroupInterval].[BUCKET_INTERVAL_URN];
GO