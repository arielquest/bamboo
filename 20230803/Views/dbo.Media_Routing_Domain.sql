SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Media_Routing_Domain]
AS
SELECT  CAST([MRDomain].[PKEY1] AS INT) AS [MRDomainID],
        CAST([MediaClass].[PKEY1] AS INT) AS [MediaClassID],
        [MRDomain].[NAME] AS [EnterpriseName],
        [MRDomain].[DESCRIPTION] AS [Description],
        [MRDomain].[INTERRUPTIBLE] AS [Interruptible],
        NULL AS [TaskLife],
        NULL AS [TaskStartTimeout],
        [MRDomain].[SERVICE_LEVEL_THRESHOLD] AS [ServiceLevelThreshold],
        NULL AS [ServiceLevelType],
        [MRDomain].[MAX_TASK_DURATION] AS [MaxTaskDuration],
        [MRDomain].[MAX_CALLS_IN_QUEUE] AS [MaxCallsInQueue],
        [MRDomain].[MAX_CALLS_IN_QUEUE_PER_CALLTYPE] AS [MaxCallsInQueuePerCallType],
        [MRDomain].[MAX_TIME_INQUEUE] AS [MaxTimeInQueue],
        [MRDomain].[SOURCE_CHANGE_STAMP] AS [ChangeStamp]
FROM    [dbo].[VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY] AS MRDomain
JOIN    [dbo].[VW_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER] AS MRDomainMediaClassMember ON [MRDomainMediaClassMember].[CHILD_ITEM_BIZ_URN] = [MRDomain].[ITEM_URN]
JOIN    [dbo].[VW_DIM_MEDIA_CLASS_PKEY] AS MediaClass ON [MediaClass].[ITEM_URN] = [MRDomainMediaClassMember].[PARENT_ITEM_BIZ_URN]
WHERE   [MRDomain].[PKEY_LATEST] = 1
        AND [MediaClass].[PKEY_LATEST] = 1
        AND [MRDomain].[ITEM_URN] = [MRDomain].[ITEM_BIZ_URN]
        AND [MediaClass].[ITEM_URN] = [MediaClass].[ITEM_BIZ_URN];
GO
