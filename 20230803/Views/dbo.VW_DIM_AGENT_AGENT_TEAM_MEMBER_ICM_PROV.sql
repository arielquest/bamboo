SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_AGENT_TEAM_MEMBER_ICM_PROV]
AS
SELECT  agentTeamMember.MODIFIED_DATE,
        agentTeamMember.CLUSTER_RESOURCE_ID,
        agentTeamMember.MEMBER_URN,
        agentTeamMember.PKEY_MAP_URN,
        agentTeamMember.PKEY_CHANGE_STAMP,
        CASE WHEN agentTeamMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentTeamMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE agentTeamMember.STATUS
        END AS STATUS,
        CASE WHEN agentTeamMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentTeamMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        agentTeamMember.PKEY1,
        agentTeamMember.PKEY2,
        agentTeamMember.SUPERVISOR,
        agentTeamMember.PRIMARY_SUPERVISOR,
        agentTeamMember.PHYSICAL_MEMBER,
        agent.ITEM_BIZ_URN AS AGENT_BUSINESS_URN,
        agent.PKEY1 AS AGENT_ID,
        agentTeam.ITEM_BIZ_URN AS AGENT_TEAM_BUSINESS_URN,
        agentTeam.PKEY1 AS AGENT_TEAM_ID,
        agentTeam.SOURCE_CHANGE_STAMP AS AGENT_TEAM_SOURCE_CHANGE_STAMP
FROM    VW_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY AS agentTeamMember
JOIN    VW_DIM_AGENT_PKEY agent ON agentTeamMember.CHILD_ITEM_BIZ_URN = agent.ITEM_BIZ_URN
                                   AND agent.CLUSTER_RESOURCE_ID = agentTeamMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_AGENT_TEAM_PKEY agentTeam ON agentTeamMember.PARENT_ITEM_BIZ_URN = agentTeam.ITEM_BIZ_URN
                                            AND agentTeam.CLUSTER_RESOURCE_ID = agentTeamMember.CLUSTER_RESOURCE_ID
WHERE   agentTeamMember.LATEST = 1
        AND agentTeamMember.PKEY_LATEST = 1
        AND agent.LATEST = 1
        AND agent.PKEY_LATEST = 1
        AND agentTeam.LATEST = 1
        AND agentTeam.PKEY_LATEST = 1
        AND (
              (
                agentTeamMember.STATUS = 'S'
                AND ( GETUTCDATE() BETWEEN agentTeamMember.PKEY_EFFECTIVE_FROM
                                   AND     agentTeamMember.PKEY_EFFECTIVE_TO )
              )
              OR ( agentTeamMember.STATUS = 'P' )
              OR (
                   agentTeamMember.STATUS NOT IN ( 'D', 'E' )
                   AND GETUTCDATE() > agentTeamMember.PKEY_EFFECTIVE_TO
                 )
            );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_AGENT_TEAM_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
