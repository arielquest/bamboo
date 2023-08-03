SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_ICM_PROV]
AS
SELECT  agent.CLUSTER_RESOURCE_ID,
        agent.MODIFIED_DATE,
        agent.ITEM_URN AS AGENT_URN,
        agent.ITEM_BIZ_URN AS AGENT_BIZ_URN,
        agent.PKEY_MAP_URN,
        agent.PKEY_CHANGE_STAMP,
        CASE WHEN agent.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agent.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE agent.STATUS
        END AS STATUS,
        CASE WHEN agent.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agent.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(agent.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        agent.PKEY1 AS AGENT_ID,
        agent.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        agent.INTERNAL_NAME AS ENTERPRISE_NAME,
        agent.DESCRIPTION,
        agent.PERIPHERAL_NAME,
        agent.PERIPHERAL_NUMBER,
        agent.SUPERVISOR,
        agent.AGENT_STATE_TRACE,
        agent.USER_GROUP_ID,
        agent.DOMAIN_NAME,
        agent.DOMAIN_LOGIN_NAME,
        agent.DOMAIN_USER_NAME,
        agent.DOMAIN_USER_GUID,
        agent.ENABLED_ASSIST_SERVICE_TYPES,
        agentPersonMember.MEMBER_URN AS AGENT_PERSON_MEMBER_URN,
        agentPersonMember.PKEY_MAP_URN AS AGENT_PERSON_PKEY_MAP_URN,
        agentPersonMember.PKEY_CHANGE_STAMP AS AGENT_PERSON_CHANGE_STAMP,
        agentPersonMember.STATUS AS AGENT_PERSON_STATUS,
        person.ITEM_BIZ_URN AS PERSON_BIZ_URN,
        person.PKEY1 AS PERSON_ID,
        person.STATUS AS PERSON_STATUS,
        agentPeripheralMember.MEMBER_URN AS AGENT_PERIPHERAL_MEMBER_URN,
        agentPeripheralMember.PKEY_MAP_URN AS AGENT_PERIPHERAL_PKEY_MAP_URN,
        agentPeripheralMember.PKEY_CHANGE_STAMP AS AGENT_PERIPHERAL_CHANGE_STAMP,
        agentPeripheralMember.STATUS AS AGENT_PERIPHERAL_STATUS,
        peripheral.ITEM_BIZ_URN AS PERIPHERAL_BIZ_URN,
        peripheral.PKEY1 AS PERIPHERAL_ID
FROM    VW_DIM_AGENT_PKEY agent
JOIN    VW_DIM_AGENT_PERSON_MEMBER_PKEY agentPersonMember ON agentPersonMember.CHILD_ITEM_BIZ_URN = agent.ITEM_BIZ_URN
                                                             AND agentPersonMember.CLUSTER_RESOURCE_ID = agent.CLUSTER_RESOURCE_ID
                                                             AND agentPersonMember.PURGED = 0
JOIN    VW_DIM_PERSON_PKEY person ON person.ITEM_BIZ_URN = agentPersonMember.PARENT_ITEM_BIZ_URN
                                     AND person.CLUSTER_RESOURCE_ID = agent.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_AGENT_PERIPHERAL_MEMBER_PKEY agentPeripheralMember ON agentPeripheralMember.CHILD_ITEM_BIZ_URN = agent.ITEM_BIZ_URN
                                                              AND agentPeripheralMember.CLUSTER_RESOURCE_ID = agent.CLUSTER_RESOURCE_ID
                                                              AND agentPeripheralMember.PURGED = 0
JOIN    VW_DIM_PERIPHERAL_PKEY peripheral ON peripheral.ITEM_BIZ_URN = agentPeripheralMember.PARENT_ITEM_BIZ_URN
                                             AND peripheral.CLUSTER_RESOURCE_ID = agent.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = agent.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = agent.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            agent.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN agent.PKEY_EFFECTIVE_FROM
                               AND     agent.PKEY_EFFECTIVE_TO )
          )
          OR ( agent.STATUS = 'P' )
          OR (
               agent.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > agent.PKEY_EFFECTIVE_TO
             )
        )
        AND agent.LATEST = 1
        AND agent.PKEY_LATEST = 1
        AND agentPersonMember.LATEST = 1
        AND agentPersonMember.PKEY_LATEST = 1
        AND person.LATEST = 1
        AND person.PKEY_LATEST = 1
        AND agentPeripheralMember.LATEST = 1
        AND agentPeripheralMember.PKEY_LATEST = 1
        AND peripheral.LATEST = 1
        AND peripheral.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_ICM_PROV]
	TO [portalapp_role]
GO
