SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_ICM_PROV]
AS
SELECT  routingScriptMember.CLUSTER_RESOURCE_ID,
        routingScriptMember.MODIFIED_DATE,
        routingScriptMember.MEMBER_URN,
        routingScriptMember.PKEY_MAP_URN,
        routingScriptMember.PKEY_CHANGE_STAMP,
        routingScriptMember.PKEY1,
        routingScriptMember.PKEY2,
        routingScriptMember.SOURCE_CHANGE_STAMP,
        CASE WHEN routingScriptMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > routingScriptMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE routingScriptMember.STATUS
        END AS STATUS,
        CASE WHEN routingScriptMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > routingScriptMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        script.ITEM_BIZ_URN AS SCRIPT_BUSINESS_URN,
        script.PKEY1 AS SCRIPT_ID,
        CAST(scriptPkey.XML_DATA.query('/Columns/Column[@Name="VERSION"]/text()') AS NVARCHAR(10)) AS SCRIPT_VERSION,
        routingScript.ITEM_BIZ_URN AS ROUTING_SCRIPT_BUSINESS_URN,
        routingScript.PKEY1 AS ROUTING_SCRIPT_ID,
        routingScript.INTERNAL_NAME AS ROUTING_SCRIPT_INTERNAL_NAME,
        map.XML_DATA AS XML_DATA
FROM    VW_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY routingScriptMember
JOIN    TB_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY_MAP map ON map.PKEY_MAP_URN = routingScriptMember.PKEY_MAP_URN
JOIN    VW_DIM_SCRIPT_PKEY script ON script.ITEM_BIZ_URN = routingScriptMember.CHILD_ITEM_BIZ_URN
                                     AND script.CLUSTER_RESOURCE_ID = routingScriptMember.CLUSTER_RESOURCE_ID
JOIN    TB_DIM_SCRIPT_PKEY_MAP scriptPkey ON scriptPkey.PKEY_MAP_URN = script.PKEY_MAP_URN
JOIN    VW_DIM_ROUTING_SCRIPT_PKEY routingScript ON routingScript.ITEM_BIZ_URN = routingScriptMember.PARENT_ITEM_BIZ_URN
                                                    AND routingScript.CLUSTER_RESOURCE_ID = routingScriptMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            routingScriptMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN routingScriptMember.PKEY_EFFECTIVE_FROM
                               AND     routingScriptMember.PKEY_EFFECTIVE_TO )
          )
          OR ( routingScriptMember.STATUS = 'P' )
          OR (
               routingScriptMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > routingScriptMember.PKEY_EFFECTIVE_TO
             )
        )
        AND routingScriptMember.LATEST = 1
        AND routingScriptMember.PKEY_LATEST = 1
        AND script.LATEST = 1
        AND script.PKEY_LATEST = 1
        AND routingScript.LATEST = 1
        AND routingScript.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
