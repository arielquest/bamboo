SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--  
--VW_DIM_AGENTTEAMS_BY_SUPERVISOR
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_AGENT_TEAMS_BY_SUPERVISOR]
AS
SELECT  team.ITEM_URN,
        team.NAME,
        team.FOLDER_ID,
        _user.LOGIN_NAME,
        _user.USER_ID,
        team.HIDDEN,
        team.EFFECTIVE_TO,
        team.EFFECTIVE_FROM,
        team.DELETED
FROM    VW_DIM_AGENT_TEAM_PKEY team
JOIN    VW_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY agentTeamMember ON team.[ITEM_BIZ_URN] = agentTeamMember.[PARENT_ITEM_BIZ_URN]
                                                              AND agentTeamMember.LATEST = 1
                                                              AND agentTeamMember.PKEY_LATEST = 1
JOIN    VW_DIM_AGENT_PERSON_MEMBER_PKEY agentPersonMember ON agentTeamMember.[CHILD_ITEM_BIZ_URN] = agentPersonMember.[CHILD_ITEM_BIZ_URN]
                                                             AND agentPersonMember.LATEST = 1
JOIN    VW_DIM_PERSON person ON agentPersonMember.[PARENT_ITEM_BIZ_URN] = person.[ITEM_BIZ_URN]
                                AND person.LATEST = 1
JOIN    TB_SEC_USER _user ON person.[USER_ID] = _user.[USER_ID]
WHERE   (
          agentTeamMember.[SUPERVISOR] = 1
          OR agentTeamMember.[PRIMARY_SUPERVISOR] = 1
        )
        AND agentTeamMember.STATUS <> 'D'
        AND agentPersonMember.STATUS <> 'D'
        AND GETUTCDATE() BETWEEN agentTeamMember.EFFECTIVE_FROM
                         AND     agentTeamMember.EFFECTIVE_TO
        AND team.LATEST = 1
        AND team.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_TEAMS_BY_SUPERVISOR]
	TO [portalapp_role]
GO
