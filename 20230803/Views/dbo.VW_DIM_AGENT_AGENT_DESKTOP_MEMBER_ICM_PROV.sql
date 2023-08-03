SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_AGENT_DESKTOP_MEMBER_ICM_PROV]
AS
SELECT  agentDeskSettingsMember.CLUSTER_RESOURCE_ID,
        agentDeskSettingsMember.MODIFIED_DATE,
        agentDeskSettingsMember.MEMBER_URN,
        agentDeskSettingsMember.PKEY_MAP_URN,
        agentDeskSettingsMember.PKEY_CHANGE_STAMP,
        CASE WHEN agentDeskSettingsMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentDeskSettingsMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE agentDeskSettingsMember.STATUS
        END AS STATUS,
        CASE WHEN agentDeskSettingsMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentDeskSettingsMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        agentDeskSettingsMember.PKEY1,
        agentDeskSettingsMember.PKEY2,
        agent.ITEM_BIZ_URN AS AGENT_BIZ_URN,
        agent.PKEY1 AS AGENT_ID,
        agent.PKEY_MAP_URN AS AGENT_PKEY_MAP_URN,
        agent.PKEY_CHANGE_STAMP AS AGENT_CHANGE_STAMP,
        agent.STATUS AS AGENT_STATUS,
        COALESCE(agent.SOURCE_CHANGE_STAMP, 0) AS AGENT_SOURCE_CHANGE_STAMP,
        agentDeskSettings.ITEM_BIZ_URN AS AGENT_DESKTOP_BIZ_URN,
        agentDeskSettings.PKEY1 AS AGENT_DESKTOP_ID
FROM    VW_DIM_AGENT_AGENT_DESKTOP_MEMBER_PKEY AS agentDeskSettingsMember
JOIN    VW_DIM_AGENT_PKEY agent ON agent.ITEM_BIZ_URN = agentDeskSettingsMember.CHILD_ITEM_BIZ_URN
                                   AND agent.CLUSTER_RESOURCE_ID = agentDeskSettingsMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_AGENT_DESKTOP_PKEY AS agentDeskSettings ON agentDeskSettings.ITEM_BIZ_URN = agentDeskSettingsMember.PARENT_ITEM_BIZ_URN
                                                          AND agentDeskSettings.CLUSTER_RESOURCE_ID = agentDeskSettingsMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            agentDeskSettingsMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN agentDeskSettingsMember.PKEY_EFFECTIVE_FROM
                               AND     agentDeskSettingsMember.PKEY_EFFECTIVE_TO )
          )
          OR ( agentDeskSettingsMember.STATUS = 'P' )
          OR (
               agentDeskSettingsMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > agentDeskSettingsMember.PKEY_EFFECTIVE_TO
             )
        )
        AND agentDeskSettingsMember.LATEST = 1
        AND agentDeskSettingsMember.PKEY_LATEST = 1
        AND agent.LATEST = 1
        AND agent.PKEY_LATEST = 1
        AND agentDeskSettings.LATEST = 1
        AND agentDeskSettings.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_AGENT_DESKTOP_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
