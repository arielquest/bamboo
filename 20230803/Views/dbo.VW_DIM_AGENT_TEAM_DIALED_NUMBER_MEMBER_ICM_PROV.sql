SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_ICM_PROV]
AS
SELECT  agentTeamDialedNumberMember.CLUSTER_RESOURCE_ID,
        agentTeamDialedNumberMember.MODIFIED_DATE,
        agentTeamDialedNumberMember.MEMBER_URN,
        agentTeamDialedNumberMember.PKEY_MAP_URN,
        agentTeamDialedNumberMember.PKEY_CHANGE_STAMP,
        CASE WHEN agentTeamDialedNumberMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentTeamDialedNumberMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE agentTeamDialedNumberMember.STATUS
        END AS STATUS,
        CASE WHEN agentTeamDialedNumberMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentTeamDialedNumberMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        agentTeamDialedNumberMember.PKEY1,
        agentTeamDialedNumberMember.PKEY2,
        agentTeam.ITEM_BIZ_URN AS AGENT_TEAM_BUSINESS_URN,
        agentTeam.PKEY1 AS AGENT_TEAM_ID,
        agentTeam.PKEY_MAP_URN AS AGENT_TEAM_PKEY_MAP_URN,
        agentTeam.PKEY_CHANGE_STAMP AS AGENT_TEAM_CHANGE_STAMP,
        agentTeam.STATUS AS AGENT_TEAM_STATUS,
        COALESCE(agentTeam.SOURCE_CHANGE_STAMP, 0) AS AGENT_TEAM_SOURCE_CHANGE_STAMP,
        dialedNumber.ITEM_BIZ_URN AS DIALED_NUMBER_BUSINESS_URN,
        dialedNumber.PKEY1 AS DIALED_NUMBER_ID
FROM    VW_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PKEY AS agentTeamDialedNumberMember
JOIN    VW_DIM_AGENT_TEAM_PKEY agentTeam ON agentTeamDialedNumberMember.CHILD_ITEM_BIZ_URN = agentTeam.ITEM_BIZ_URN
                                            AND agentTeam.CLUSTER_RESOURCE_ID = agentTeamDialedNumberMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIALED_NUMBER_PKEY AS dialedNumber ON agentTeamDialedNumberMember.PARENT_ITEM_BIZ_URN = dialedNumber.ITEM_BIZ_URN
                                                     AND dialedNumber.CLUSTER_RESOURCE_ID = agentTeamDialedNumberMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            agentTeamDialedNumberMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN agentTeamDialedNumberMember.PKEY_EFFECTIVE_FROM
                               AND     agentTeamDialedNumberMember.PKEY_EFFECTIVE_TO )
          )
          OR ( agentTeamDialedNumberMember.STATUS = 'P' )
          OR (
               agentTeamDialedNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > agentTeamDialedNumberMember.PKEY_EFFECTIVE_TO
             )
        )
        AND agentTeamDialedNumberMember.LATEST = 1
        AND agentTeamDialedNumberMember.PKEY_LATEST = 1
        AND agentTeam.LATEST = 1
        AND agentTeam.PKEY_LATEST = 1
        AND dialedNumber.LATEST = 1
        AND dialedNumber.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
