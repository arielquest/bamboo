SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Agent_Interval]
AS
SELECT  [agentInterval].[DATE_TIME] AS [DateTime],
        CAST([agent].[PKEY1] AS INT) AS [SkillTargetID],
        [agentInterval].[TIME_ZONE] AS [TimeZone],
        CAST([MRDomain].[PKEY1] AS INT) AS [MRDomainID],
        [agentInterval].[RECOVERY_KEY] AS [RecoveryKey],
        [agentInterval].[LOGGED_ON_TIME] AS [LoggedOnTime],
        [agentInterval].[AVAIL_TIME] AS [AvailTime],
        [agentInterval].[NOT_READY_TIME] AS [NotReadyTime],
        [agentInterval].[TALK_OTHER_TIME] AS [TalkOtherTime],
        [agentInterval].[AVAILABLE_IN_MRD_TIME] AS [AvailableInMRDTime],
        [agentInterval].[ROUTABLE_IN_MRD_TIME] AS [RoutableInMRDTime],
        [agentInterval].[ROUTER_CALLS_ABAND_Q] AS [RouterCallsAbandQ],
        [agentInterval].[ROUTER_Q_CALLS] AS [RouterQueueCalls],
        [agentInterval].[DB_DATETIME] AS [DbDateTime],
        [agentInterval].[ROUTER_CALLS_OFFERED] AS [RouterCallsOffered],
        [agentInterval].[ROUTER_CALLS_ABAND] AS [RouterCallsAband],
        [agentInterval].[ROUTER_CALLS_DEQUEUED] AS [RouterCallsDequeued],
        [agentInterval].[ROUTER_CALLS_REDIRECTED] AS [RouterCallsRedirected],
        [agentInterval].[ROUTER_CALLS_ANSWERED] AS [RouterCallsAnswered],
        [agentInterval].[ROUTER_CALLS_HANDLED] AS [RouterCallsHandled],
        [agentInterval].[ROUTER_ERROR] AS [RouterError],
        NULL AS [Reserved1],
        NULL AS [Reserved2],
        NULL AS [Reserved3],
        NULL AS [Reserved4],
        NULL AS [Reserved5],
        [agentInterval].[REPORTING_HALF_HOUR] AS ReportingHalfHour,
        [agentInterval].[REPORTING_INTERVAL] AS ReportingInterval,
        [agentInterval].[NON_ACD_LINE_CALLS_IN_COUNT] AS NonACDLineCallsInCount,
        [agentInterval].[NON_ACD_LINE_CALLS_OUT_COUNT] AS NonACDLineCallsOutCount,
        [agentInterval].[NON_ACD_LINE_CALLS_IN_TIME] AS NonACDLineCallsInTime,
        [agentInterval].[NON_ACD_LINE_CALLS_OUT_TIME] AS NonACDLineCallsOutTime
FROM    [dbo].[VW_PARTITIONED_SUM_AGENT_INTERVAL] agentInterval WITH ( NOLOCK )
JOIN    [dbo].[VW_DIM_AGENT_PKEY] agent ON [agent].[ITEM_URN] = [agentInterval].[AGENT_URN]
                                           AND [agent].[PKEY_LATEST] = 1
LEFT JOIN [dbo].[VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY] AS MRDomain ON [MRDomain].[ITEM_URN] = [agentInterval].[MEDIA_ROUTING_DOMAIN_URN]
                                                              AND [MRDomain].[PKEY_LATEST] = 1;
GO
