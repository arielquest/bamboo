SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SEC_USER_AGENT_PERIPHERAL_RELATION]
AS
SELECT  p.[ITEM_URN] AS PERIPHERAL_URN,
        p.[PERIPHERAL_NAME],
        agent.[ITEM_URN] AS AGENT_URN,
        person.[ITEM_URN] AS PERSON_URN,
        usr.[LOGIN_NAME],
        usr.[USER_ID],
        usr.[DELETED]
FROM    VW_DIM_PERIPHERAL_PKEY p
JOIN    VW_DIM_AGENT_PERIPHERAL_MEMBER_PKEY pam ON p.[ITEM_BIZ_URN] = pam.[PARENT_ITEM_BIZ_URN]
                                                   AND pam.LATEST = 1
                                                   AND pam.PKEY_LATEST = 1
JOIN    VW_DIM_AGENT_PKEY agent ON pam.[CHILD_ITEM_BIZ_URN] = agent.[ITEM_BIZ_URN]
                                   AND agent.LATEST = 1
                                   AND agent.PKEY_LATEST = 1
JOIN    VW_DIM_AGENT_PERSON_MEMBER_PKEY member ON agent.[ITEM_BIZ_URN] = member.[CHILD_ITEM_BIZ_URN]
                                                  AND member.LATEST = 1
                                                  AND member.PKEY_LATEST = 1
JOIN    VW_DIM_PERSON_PKEY person ON member.[PARENT_ITEM_BIZ_URN] = person.[ITEM_BIZ_URN]
                                     AND person.LATEST = 1
                                     AND person.PKEY_LATEST = 1
JOIN    TB_SEC_USER usr ON person.[USER_ID] = usr.[USER_ID]
WHERE   member.STATUS <> 'D'
        AND agent.STATUS <> 'D'
        AND person.STATUS <> 'D'
        AND p.LATEST = 1
        AND p.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_AGENT_PERIPHERAL_RELATION]
	TO [portalapp_role]
GO
