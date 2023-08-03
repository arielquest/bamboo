SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--  
--VW_DIM_AGENTS_BY_SUPERVISOR
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_AGENTS_BY_SUPERVISOR]
AS
SELECT DISTINCT
        kidA.ITEM_URN,
        kidA.FOLDER_ID,
        kidA.OWNER_ID,
        kidA.ITEM_TYPE_ID,
        kidA.NAME,
        kidA.INTERNAL_NAME,
        kidA.DESCRIPTION,
        kidA.EFFECTIVE_FROM,
        kidA.EFFECTIVE_TO,
        kidA.HIDDEN,
        kidA.PERIPHERAL_NUMBER,
        usr.USER_ID,
        usr.LOGIN_NAME,
        kids.SUPERVISOR,
        kids.PRIMARY_SUPERVISOR,
        kids.PHYSICAL_MEMBER,
        periM.DELETED AS PERIPHERAL_DELETED,
        periM.PARENT_ITEM_BIZ_URN AS PERIPHERAL_URN
FROM    TB_SEC_USER usr
INNER JOIN VW_DIM_PERSON pr ON pr.USER_ID = usr.USER_ID
                               AND pr.LATEST = 1
INNER JOIN VW_DIM_AGENT_PERSON_MEMBER_PKEY apm ON apm.PARENT_ITEM_BIZ_URN = pr.ITEM_BIZ_URN
                                                  AND apm.LATEST = 1
INNER JOIN VW_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY atm ON atm.CHILD_ITEM_BIZ_URN = apm.CHILD_ITEM_BIZ_URN
                                                      AND atm.CLUSTER_RESOURCE_ID = apm.CLUSTER_RESOURCE_ID
                                                      AND atm.LATEST = 1
RIGHT JOIN VW_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY kids ON kids.PARENT_ITEM_BIZ_URN = atm.PARENT_ITEM_BIZ_URN
                                                       AND kids.CLUSTER_RESOURCE_ID = atm.CLUSTER_RESOURCE_ID
                                                       AND kids.LATEST = 1
INNER JOIN VW_DIM_AGENT_PKEY kidA ON kidA.ITEM_BIZ_URN = kids.CHILD_ITEM_BIZ_URN
                                     AND kidA.CLUSTER_RESOURCE_ID = kids.CLUSTER_RESOURCE_ID
                                     AND kidA.LATEST = 1
INNER JOIN VW_DIM_AGENT_PERIPHERAL_MEMBER periM ON periM.CHILD_ITEM_BIZ_URN = kidA.ITEM_BIZ_URN
                                                   AND periM.LATEST = 1
WHERE   (
          atm.PRIMARY_SUPERVISOR = 1
          OR atm.SUPERVISOR = 1
        )
        AND kids.DELETED = 0
        AND apm.DELETED = 0
        AND atm.DELETED = 0
        AND (
              kids.SUPERVISOR = 1
              OR kids.PRIMARY_SUPERVISOR = 1
              OR kids.PHYSICAL_MEMBER = 1
            );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENTS_BY_SUPERVISOR]
	TO [portalapp_role]
GO
