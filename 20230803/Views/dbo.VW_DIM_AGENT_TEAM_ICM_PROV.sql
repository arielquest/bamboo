SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_TEAM_ICM_PROV]
AS
SELECT  agentteam.CLUSTER_RESOURCE_ID,
        agentteam.MODIFIED_DATE,
        agentteam.ITEM_BIZ_URN AS AGENT_TEAM_BUSINESS_URN,
        agentteam.PKEY_MAP_URN,
        agentteam.PKEY_CHANGE_STAMP,
        CASE WHEN agentteam.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentteam.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE agentteam.STATUS
        END AS STATUS,
        CASE WHEN agentteam.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentteam.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        agentteam.PKEY1 AS AGENT_TEAM_ID,
        COALESCE(agentteam.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        agentteam.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        agentteam.INTERNAL_NAME AS ENTERPRISE_NAME,
        agentteam.DESCRIPTION AS DESCRIPTION,
        agentteamPeripheralMember.MEMBER_URN AS AGENT_TEAM_PERIPHERAL_MEMBER_URN,
        agentteamPeripheralMember.PKEY_MAP_URN AS AGENT_TEAM_PERIPHERAL_PKEY_MAP_URN,
        agentteamPeripheralMember.PKEY_CHANGE_STAMP AS AGENT_TEAM_PERIPHERAL_CHANGE_STAMP,
        agentteamPeripheralMember.STATUS AS AGENT_TEAM_PERIPHERAL_STATUS,
        peripheral.PKEY1 AS PERIPHERAL_ID,
        peripheral.ITEM_BIZ_URN AS PERIPHERAL_BUSINESS_URN
FROM    VW_DIM_AGENT_TEAM_PKEY agentteam
JOIN    VW_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_PKEY agentteamPeripheralMember ON agentteam.ITEM_BIZ_URN = agentteamPeripheralMember.CHILD_ITEM_BIZ_URN
                                                              AND agentteam.CLUSTER_RESOURCE_ID = agentteamPeripheralMember.CLUSTER_RESOURCE_ID
                                                              AND agentteamPeripheralMember.PURGED = 0
JOIN    VW_DIM_PERIPHERAL_PKEY peripheral ON agentteamPeripheralMember.PARENT_ITEM_BIZ_URN = peripheral.ITEM_BIZ_URN
                                             AND agentteam.CLUSTER_RESOURCE_ID = peripheral.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = agentteam.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = agentteam.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            agentteam.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN agentteam.PKEY_EFFECTIVE_FROM
                               AND     agentteam.PKEY_EFFECTIVE_TO )
          )
          OR ( agentteam.STATUS = 'P' )
          OR (
               agentteam.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > agentteam.PKEY_EFFECTIVE_TO
             )
        )
        AND agentteam.LATEST = 1
        AND agentteam.PKEY_LATEST = 1
        AND agentteamPeripheralMember.LATEST = 1
        AND agentteamPeripheralMember.PKEY_LATEST = 1
        AND peripheral.LATEST = 1
        AND peripheral.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_TEAM_ICM_PROV]
	TO [portalapp_role]
GO
