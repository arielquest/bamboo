SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Peripheral]
AS
SELECT  CAST([peripheral].[PKEY1] AS INT) AS [PeripheralID],
        NULL AS [LogicalControllerID],
        [peripheral].[INTERNAL_NAME] AS [EnterpriseName],
        [peripheral].[PERIPHERAL_NAME] AS [PeripheralName],
        [peripheral].[LOCATION] AS [Location],
        [peripheral].[ANSWERED_SHORT_CALLS_THRESHOLD] AS [AnsweredShortCallsThreshold],
        NULL AS [ConfigParam],
        [peripheral].[ABANDONED_CALL_WAIT_TIME] AS [AbandonedCallWaitTime],
        [peripheral].[PERIPHERAL_SERVICE_LEVEL_TYPE] AS [PeripheralServiceLevelType],
        NULL AS [CallControlVariableMap],
        [peripheral].[AVAILABLE_HOLDOFF_DELAY] AS [AvailableHoldoffDelay],
        [peripheral].[DESCRIPTION] AS [Description],
        [peripheral].[DELETED] AS [Deleted],
        [peripheral].[SUB_SKILLGROUP_MASK] AS [SubSkillGroupMask],
        [peripheral].[CLIENT_TYPE] AS [ClientType],
        NULL AS [AgentDeskSettingsID],
        NULL AS [AgentReporting],
        NULL AS [AgentAutoConfig],
        NULL AS [NetworkTargetID],
        NULL AS [AgentEventDetail],
        CASE [peripheral].[AUTO_CONFIGURED]
          WHEN 1 THEN 'Y'
          ELSE 'N'
        END AS [PeripheralAutoConfig],
        NULL AS [InternalIPTAOnly],
        NULL AS [AgentTargetingMethod],
        [peripheral].[SOURCE_CHANGE_STAMP] AS [ChangeStamp]
FROM    [dbo].[VW_DIM_PERIPHERAL_PKEY] AS peripheral WITH ( NOLOCK )
WHERE   [peripheral].[PKEY_LATEST] = 1
        AND [peripheral].[ITEM_URN] = [peripheral].[ITEM_BIZ_URN];
GO
