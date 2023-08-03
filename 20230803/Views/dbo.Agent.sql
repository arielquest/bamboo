SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Agent]
AS
SELECT  CAST([agent].[PKEY1] AS INT) AS [SkillTargetID],
        CAST([person].[PKEY1] AS INT) AS [PersonID],
        CAST([agentDesktop].[PKEY1] AS INT) AS [AgentDeskSettingsID],
        NULL AS [ScheduleID],
        CAST([peripheral].[PKEY1] AS INT) AS [PeripheralID],
        [agent].[INTERNAL_NAME] AS [EnterpriseName],
        [agent].[PERIPHERAL_NUMBER] AS [PeripheralNumber],
        NULL AS [ConfigParam],
        [agent].[DESCRIPTION] AS [Description],
        CASE [agent].[DELETED]
          WHEN 0 THEN 'N'
          ELSE 'Y'
        END AS [Deleted],
        [agent].[PERIPHERAL_NAME] AS [PeripheralName],
        'N' AS [TemporaryAgent],
        CASE [agent].[AGENT_STATE_TRACE]
          WHEN 0 THEN 'N'
          ELSE 'Y'
        END AS [AgentStateTrace],
        CASE [agent].[SUPERVISOR]
          WHEN 0 THEN 'N'
          ELSE 'Y'
        END AS [SupervisorAgent],
        [agent].[SOURCE_CHANGE_STAMP] AS [ChangeStamp],
        [agent].[USER_DELETABLE] AS [UserDeletable]
FROM    [dbo].[VW_DIM_AGENT_PKEY] agent WITH ( NOLOCK )
JOIN    [dbo].[VW_DIM_AGENT_PERSON_MEMBER] AS agentPersonMember ON [agentPersonMember].[CHILD_ITEM_BIZ_URN] = [agent].[ITEM_URN]
                                                              AND [agentPersonMember].[LATEST] = 1
JOIN    [dbo].[VW_DIM_PERSON_PKEY] AS person ON [person].[ITEM_URN] = [agentPersonMember].[PARENT_ITEM_BIZ_URN]
JOIN    [dbo].[VW_DIM_AGENT_PERIPHERAL_MEMBER] AS agentPeripheralMember ON [agentPeripheralMember].[CHILD_ITEM_BIZ_URN] = [agent].[ITEM_URN]
                                                              AND [agentPeripheralMember].[LATEST] = 1
JOIN    [dbo].[VW_DIM_PERIPHERAL_PKEY] AS peripheral ON [peripheral].[ITEM_URN] = [agentPeripheralMember].[PARENT_ITEM_BIZ_URN]
LEFT JOIN [dbo].[VW_DIM_AGENT_AGENT_DESKTOP_MEMBER] AS agentAgentDesktopMember ON [agentAgentDesktopMember].[CHILD_ITEM_BIZ_URN] = [agent].[ITEM_URN]
                                                              AND [agentAgentDesktopMember].[LATEST] = 1
LEFT JOIN [dbo].[VW_DIM_AGENT_DESKTOP_PKEY] AS agentDesktop ON [agentDesktop].[ITEM_URN] = [agentAgentDesktopMember].[PARENT_ITEM_BIZ_URN]
                                                              AND [agentDesktop].[PKEY_LATEST] = 1;
GO
