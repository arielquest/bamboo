SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_ICM_PROV]
AS
SELECT  mem.CLUSTER_RESOURCE_ID,
        mem.MODIFIED_DATE,
        mem.MEMBER_URN,
        mem.PKEY_MAP_URN,
        mem.PKEY_CHANGE_STAMP,
        CASE WHEN mem.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > mem.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE mem.STATUS
        END AS STATUS,
        CASE WHEN mem.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > mem.PKEY_EFFECTIVE_TO THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        mem.PKEY1,
        mem.PKEY2,
        mem.ITEM,
        pkeyMap.XML_DATA,
        ct.ITEM_BIZ_URN AS CALL_TYPE_BUSINESS_URN,
        ct.PKEY1 AS CALL_TYPE_ID,
        rs.ITEM_BIZ_URN AS ROUTING_SCRIPT_BUSINESS_URN,
        rs.PKEY1 AS ROUTING_SCRIPT_ID
FROM    VW_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY mem
JOIN    VW_DIM_ROUTING_SCRIPT_PKEY AS rs ON mem.PARENT_ITEM_BIZ_URN = rs.ITEM_BIZ_URN
                                            AND rs.CLUSTER_RESOURCE_ID = mem.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_CALL_TYPE_PKEY AS ct ON mem.CHILD_ITEM_BIZ_URN = ct.ITEM_BIZ_URN
                                       AND ct.CLUSTER_RESOURCE_ID = mem.CLUSTER_RESOURCE_ID
JOIN    TB_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY_MAP pkeyMap ON pkeyMap.MEMBER_BIZ_URN = mem.MEMBER_BIZ_URN
WHERE   mem.CHILD_ITEM_BIZ_URN IN (
        SELECT  CHILD_ITEM_BIZ_URN
        FROM    VW_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY callTypeMap
        WHERE   (
                  (
                    callTypeMap.STATUS = 'S'
                    AND ( GETUTCDATE() BETWEEN callTypeMap.PKEY_EFFECTIVE_FROM
                                       AND     callTypeMap.PKEY_EFFECTIVE_TO )
                  )
                  OR ( callTypeMap.STATUS = 'P' )
                  OR (
                       callTypeMap.STATUS NOT IN ( 'D', 'E' )
                       AND GETUTCDATE() > callTypeMap.PKEY_EFFECTIVE_TO
                     )
                ) )
        AND (
              mem.STATUS = 'R'
              OR (
                   (
                     mem.STATUS = 'S'
                     AND ( GETUTCDATE() BETWEEN mem.PKEY_EFFECTIVE_FROM
                                        AND     mem.PKEY_EFFECTIVE_TO )
                   )
                   OR ( mem.STATUS = 'P' )
                   OR (
                        mem.STATUS NOT IN ( 'D', 'E' )
                        AND GETUTCDATE() > mem.PKEY_EFFECTIVE_TO
                      )
                 )
            )
        AND mem.LATEST = 1
        AND mem.PKEY_LATEST = 1
        AND ct.LATEST = 1
        AND ct.PKEY_LATEST = 1
        AND rs.LATEST = 1
        AND rs.PKEY_LATEST = 1
        AND pkeyMap.LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
