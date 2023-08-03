SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SCRIPT_ICM_PROV]
AS
SELECT  script.CLUSTER_RESOURCE_ID,
        script.MODIFIED_DATE,
        script.ITEM_BIZ_URN AS SCRIPT_BUSINESS_URN,
        script.PKEY_MAP_URN,
        script.PKEY_CHANGE_STAMP,
        script.PKEY1 AS SCRIPT_ID,
        COALESCE(script.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        CASE WHEN script.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > script.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE script.STATUS
        END AS STATUS,
        CASE WHEN script.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > script.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        script.NAME,
        script.DESCRIPTION,
        sMap.XML_DATA AS XML_DATA,
        routingScript.PKEY1 AS ROUTING_SCRIPT_ID,
        routingScript.INTERNAL_NAME AS ROUTING_SCRIPT_NAME,
        routingScript.PKEY_MAP_URN AS ROUTING_SCRIPT_PKEY_MAP_URN,
        rsMap.STATUS AS ROUTING_SCRIPT_STATUS,
        rsMap.XML_DATA AS ROUTING_SCRIPT_XML_DATA,
        member.PKEY_MAP_URN AS ROUTING_SCRIPT_MEMBER_PKEY_MAP_URN,
        member.PKEY_CHANGE_STAMP AS ROUTING_SCRIPT_MEMBER_CHANGE_STAMP,
        member.STATUS AS ROUTING_SCRIPT_MEMBER_STATUS
FROM    VW_DIM_SCRIPT_PKEY script
JOIN    TB_DIM_SCRIPT_PKEY_MAP sMap ON sMap.PKEY_MAP_URN = script.PKEY_MAP_URN
JOIN    VW_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY member ON script.ITEM_BIZ_URN = member.CHILD_ITEM_BIZ_URN
                                                           AND member.PURGED = 0
JOIN    VW_DIM_ROUTING_SCRIPT_PKEY routingScript ON routingScript.ITEM_BIZ_URN = member.PARENT_ITEM_BIZ_URN
JOIN    TB_DIM_ROUTING_SCRIPT_PKEY_MAP rsMap ON rsMap.PKEY_MAP_URN = routingScript.PKEY_MAP_URN
WHERE   (
          (
            script.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN script.PKEY_EFFECTIVE_FROM
                               AND     script.PKEY_EFFECTIVE_TO )
          )
          OR (
               script.STATUS = 'P'
               AND script.PKEY1 IS NOT NULL
             )
          OR (
               script.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > script.PKEY_EFFECTIVE_TO
             )
        )
        AND script.LATEST = 1
        AND script.PKEY_LATEST = 1
        AND member.LATEST = 1
        AND member.PKEY_LATEST = 1
        AND routingScript.LATEST = 1
        AND routingScript.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SCRIPT_ICM_PROV]
	TO [portalapp_role]
GO
