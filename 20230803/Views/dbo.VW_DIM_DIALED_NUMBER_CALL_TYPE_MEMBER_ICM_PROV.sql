SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_ICM_PROV]
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
        region.PKEY1 AS REGION_ID,
        mem.ITEM,
        mem.CLI_WILD_CARD,
        mem.CLI_WILD_CARD_TYPE,
        mem.CED_WILD_CARD,
        mem.DESCRIPTION,
        dn.ITEM_BIZ_URN AS DIALED_NUMBER_BUSINESS_URN,
        dn.PKEY1 AS DIALED_NUMBER_ID,
        ct.ITEM_BIZ_URN AS CALL_TYPE_BUSINESS_URN,
        ct.PKEY1 AS CALL_TYPE_ID
FROM    VW_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY mem
JOIN    VW_DIM_DIALED_NUMBER_PKEY AS dn ON mem.CHILD_ITEM_BIZ_URN = dn.ITEM_BIZ_URN
                                           AND dn.CLUSTER_RESOURCE_ID = mem.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_CALL_TYPE_PKEY AS ct ON mem.PARENT_ITEM_BIZ_URN = ct.ITEM_BIZ_URN
                                       AND ct.CLUSTER_RESOURCE_ID = mem.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_REGION_PKEY region ON mem.REGION_BIZ_URN = region.ITEM_URN
                                       AND region.CLUSTER_RESOURCE_ID = mem.CLUSTER_RESOURCE_ID
WHERE   mem.CHILD_ITEM_BIZ_URN IN (
        SELECT  CHILD_ITEM_BIZ_URN
        FROM    VW_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY dnctm
        WHERE   (
                  (
                    dnctm.STATUS = 'S'
                    AND ( GETUTCDATE() BETWEEN dnctm.PKEY_EFFECTIVE_FROM
                                       AND     dnctm.PKEY_EFFECTIVE_TO )
                  )
                  OR ( dnctm.STATUS = 'P' )
                  OR (
                       dnctm.STATUS NOT IN ( 'D', 'E' )
                       AND GETUTCDATE() > dnctm.PKEY_EFFECTIVE_TO
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
        AND dn.LATEST = 1
        AND dn.PKEY_LATEST = 1
        AND ct.LATEST = 1
        AND ct.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
