SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_PERSON_MEMBER_ICM_PROV]
AS
SELECT  sMember.CLUSTER_RESOURCE_ID,
        sMember.MODIFIED_DATE,
        sMember.MEMBER_URN AS S_MEMBER_URN,
        sMember.PKEY_MAP_URN AS S_MEMBER_PEY_MAP_URN,
        sMember.PKEY_CHANGE_STAMP AS S_MEMBER_PKEY_CHANGE_STAMP,
        CASE WHEN sMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > sMember.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE sMember.STATUS
        END AS S_MEMBER_STATUS,
        CASE WHEN sMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > sMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS S_MEMBER_EXPIRED,
        sMember.PKEY1 AS S_MEMBER_PKEY1,
        sMember.PKEY2 AS S_MEMBER_PKEY2,
        pMember.MEMBER_URN AS P_MEMBER_URN,
        pMember.PKEY_MAP_URN AS P_MEMBER_PEY_MAP_URN,
        pMember.PKEY_CHANGE_STAMP AS P_MEMBER_PKEY_CHANGE_STAMP,
        CASE WHEN pMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > pMember.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE pMember.STATUS
        END AS P_MEMBER_STATUS,
        CASE WHEN pMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > pMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS P_MEMBER_EXPIRED,
        pMember.PKEY1 AS P_MEMBER_PKEY1,
        pMember.PKEY2 AS P_MEMBER_PKEY2,
        agent.ITEM_BIZ_URN AS AGENT_BUSINESS_URN,
        agent.PKEY1 AS AGENT_ID,
        agent.PKEY_MAP_URN AS AGENT_PKEY_MAP_URN,
        agent.PKEY_CHANGE_STAMP AS AGENT_CHANGE_STAMP,
        agent.STATUS AS AGENT_STATUS,
        COALESCE(agent.SOURCE_CHANGE_STAMP, 0) AS AGENT_SOURCE_CHANGE_STAMP,
        sPerson.ITEM_BIZ_URN AS S_PERSON_BUSINESS_URN,
        sPerson.PKEY1 AS S_PERSON_ID,
        pPerson.ITEM_BIZ_URN AS P_PERSON_BUSINESS_URN,
        pPerson.PKEY1 AS P_PERSON_ID
FROM    VW_DIM_AGENT_PERSON_MEMBER_PKEY sMember
JOIN    VW_DIM_AGENT_PERSON_MEMBER_PKEY pMember ON pMember.CHILD_ITEM_BIZ_URN = sMember.CHILD_ITEM_BIZ_URN
                                                   AND sMember.MEMBER_URN <> pMember.MEMBER_URN
JOIN    VW_DIM_AGENT_PKEY agent ON sMember.CHILD_ITEM_BIZ_URN = agent.ITEM_BIZ_URN
                                   AND agent.CLUSTER_RESOURCE_ID = sMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_PERSON_PKEY AS sPerson ON sMember.PARENT_ITEM_BIZ_URN = sPerson.ITEM_BIZ_URN
                                         AND sPerson.CLUSTER_RESOURCE_ID = sMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_PERSON_PKEY AS pPerson ON pMember.PARENT_ITEM_BIZ_URN = pPerson.ITEM_BIZ_URN
                                         AND pPerson.CLUSTER_RESOURCE_ID = pMember.CLUSTER_RESOURCE_ID
WHERE   sMember.STATUS = 'S'
        AND pMember.STATUS = 'P'
        AND sMember.LATEST = 1
        AND pMember.LATEST = 1
        AND sMember.PKEY_LATEST = 1
        AND pMember.PKEY_LATEST = 1
        AND agent.LATEST = 1
        AND agent.PKEY_LATEST = 1
        AND sPerson.LATEST = 1
        AND sPerson.PKEY_LATEST = 1
        AND pPerson.LATEST = 1
        AND pPerson.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_PERSON_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
