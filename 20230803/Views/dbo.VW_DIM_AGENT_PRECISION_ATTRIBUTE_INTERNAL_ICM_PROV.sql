SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_PRECISION_ATTRIBUTE_INTERNAL_ICM_PROV]
AS
SELECT  apa.CLUSTER_RESOURCE_ID,
        apa.PKEY1 AS APA_PKEY1,
        apa.PKEY2 AS APA_PKEY2,
        apa.MEMBER_URN AS APA_MEMBER_URN,
        apa.PARENT_ITEM_BIZ_URN AS APA_PARENT_ITEM_BIZ_URN,
        apa.CHILD_ITEM_BIZ_URN AS APA_CHILD_ITEM_BIZ_URN,
        apa.MEMBER_BIZ_URN AS APA_BUSINESS_URN,
        apa.PKEY_MAP_URN AS APA_PKEY_MAP_URN,
        apa.PKEY_CHANGE_STAMP AS APA_PKEY_CHANGE_STAMP,
        CASE WHEN apa.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > apa.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE apa.STATUS
        END AS APA_STATUS,
        CASE WHEN apa.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > apa.PKEY_EFFECTIVE_TO THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS APA_EXPIRED,
        COALESCE(apa.SOURCE_CHANGE_STAMP, 0) AS APA_SOURCE_CHANGE_STAMP,
        apa.ATTRIBUTE_VALUE AS APA_ATTRIBUTE_VALUE,
        apa.DESCRIPTION AS APA_DESCRIPTION,
        attr.PKEY1 AS ATTRIBUTE_PKEY1,
        attr.PKEY2 AS ATTRIBUTE_PKEY2,
        attr.ITEM_URN AS ATTRIBUTE_ITEM_URN,
        attr.ITEM_BIZ_URN AS ATTRIBUTE_BUSINESS_URN,
        attr.PKEY_MAP_URN AS ATTRIBUTE_PKEY_MAP_URN,
        attr.PKEY_CHANGE_STAMP AS ATTRIBUTE_PKEY_CHANGE_STAMP,
        CASE WHEN attr.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > attr.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE attr.STATUS
        END AS ATTRIBUTE_STATUS,
        CASE WHEN attr.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > attr.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS ATTRIBUTE_EXPIRED,
        COALESCE(attr.SOURCE_CHANGE_STAMP, 0) AS ATTRIBUTE_SOURCE_CHANGE_STAMP
FROM    VW_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY apa
JOIN    VW_DIM_PRECISION_ATTRIBUTE_PKEY attr ON attr.ITEM_BIZ_URN = apa.PARENT_ITEM_BIZ_URN
                                                AND attr.CLUSTER_RESOURCE_ID = apa.CLUSTER_RESOURCE_ID
                                                AND attr.LATEST = 1
                                                AND attr.PKEY_LATEST = 1
WHERE   apa.LATEST = 1
        AND apa.PKEY_LATEST = 1
        AND apa.STATUS IN ( 'R', 'S', 'P', 'E' );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_PRECISION_ATTRIBUTE_INTERNAL_ICM_PROV]
	TO [portalapp_role]
GO
