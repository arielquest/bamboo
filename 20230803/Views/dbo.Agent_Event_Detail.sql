SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Agent_Event_Detail]
AS
SELECT  [agentEventDetail].[EVENT_DATE_TIME] AS [DateTime],
        CAST([agent].[PKEY1] AS INT) AS [SkillTargetID],
        CAST([MRDomain].[PKEY1] AS INT) AS [MRDomainID],
        [agentEventDetail].[UTC_TIMEZONE] AS [TimeZone],
        [agentEventDetail].[LOGIN_DATE_TIME] AS [LoginDateTime],
        [agentEventDetail].[EVENT] AS [Event],
        [agentEventDetail].[RECOVERY_KEY] AS [RecoveryKey],
        [agentEventDetail].[DURATION] AS [Duration],
        [rCode].[INTERNAL_NAME] AS [ReasonCode],
        [agentEventDetail].[DB_DATETIME] AS [DbDateTime]
FROM    [dbo].[VW_PARTITIONED_FCT_AGENT_EVENT] agentEventDetail WITH ( NOLOCK )
JOIN    [dbo].[VW_DIM_AGENT_PKEY] agent WITH ( NOLOCK ) ON [agentEventDetail].[AGENT_URN] = [agent].[ITEM_URN]
                                                           AND [agent].[PKEY_LATEST] = 1
LEFT JOIN [dbo].[VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY] MRDomain WITH ( NOLOCK ) ON [MRDomain].[ITEM_URN] = [agentEventDetail].[MEDIA_ROUTING_DOMAIN_URN]
                                                              AND [MRDomain].[PKEY_LATEST] = 1
LEFT JOIN [dbo].[VW_DIM_REASON_CODE_PKEY] AS rCode ON [rCode].[ITEM_URN] = [agentEventDetail].[REASON_CODE_URN];
GO
