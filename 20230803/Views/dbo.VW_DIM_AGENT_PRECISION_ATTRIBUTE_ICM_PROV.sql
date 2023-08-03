SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_PRECISION_ATTRIBUTE_ICM_PROV]
AS
SELECT DISTINCT
        agent.CLUSTER_RESOURCE_ID,
        agent.MODIFIED_DATE,
        agent.ITEM_URN AS AGENT_ITEM_URN,
        agent.ITEM_BIZ_URN AS AGENT_BUSINESS_URN,
        agent.PKEY_MAP_URN AS AGENT_PKEY_MAP_URN,
        agent.PKEY_CHANGE_STAMP AS AGENT_PKEY_CHANGE_STAMP,
        CASE WHEN GETUTCDATE() > agent.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE agent.STATUS
        END AS AGENT_STATUS,
        CASE WHEN GETUTCDATE() > agent.PKEY_EFFECTIVE_TO THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS AGENT_EXPIRED,
        COALESCE(agent.SOURCE_CHANGE_STAMP, 0) AS AGENT_SOURCE_CHANGE_STAMP,
        agent.PKEY1 AS AGENT_PKEY1,
        agent.PKEY2 AS AGENT_PKEY2
FROM    dbo.VW_DIM_AGENT_PKEY agent
WHERE   agent.STATUS IN ( 'R', 'S', 'P', 'E' )
        AND agent.LATEST = 1
        AND agent.PKEY_LATEST = 1
        AND EXISTS ( SELECT 1
                     FROM   [dbo].[TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER] m
                     INNER JOIN [dbo].[TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP] pk
                            WITH ( INDEX ( IX_TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_CLUSTER_RESOURCE_STATUS ) ) ON pk.[MEMBER_BIZ_URN] = m.[MEMBER_BIZ_URN]
                     WHERE  (
                              (
                                pk.STATUS = 'S'
                                AND ( GETUTCDATE() BETWEEN pk.[EFFECTIVE_FROM]
                                                   AND     pk.[EFFECTIVE_TO] )
                              )
                              OR ( pk.STATUS = 'P' )
                              OR (
                                   pk.STATUS NOT IN ( 'D', 'E' )
                                   AND GETUTCDATE() > pk.[EFFECTIVE_TO]
                                 )
                            )
                            AND m.LATEST = 1
                            AND pk.LATEST = 1
                            AND agent.ITEM_BIZ_URN = m.CHILD_ITEM_BIZ_URN
                            AND agent.CLUSTER_RESOURCE_ID = pk.CLUSTER_RESOURCE_ID );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_PRECISION_ATTRIBUTE_ICM_PROV]
	TO [portalapp_role]
GO
