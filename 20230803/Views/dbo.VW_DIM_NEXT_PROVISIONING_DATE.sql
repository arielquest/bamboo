SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_NEXT_PROVISIONING_DATE]
AS
SELECT  minDates.CLUSTER_RESOURCE_ID,
        minDates.RESOURCE_TYPE_URN,
        MIN(minDates.MIN_DATE) AS NEXT_RUN_DATE
FROM    ( SELECT    CLUSTER_RESOURCE_ID,
                    ITEM_TYPE_URN AS RESOURCE_TYPE_URN,
                    MIN(EFFECTIVE_FROM) AS MIN_DATE
          FROM      VW_DIM_ITEM_PKEY_MAP
          WHERE     STATUS = 'S'
                    AND LATEST = 1
          GROUP BY  CLUSTER_RESOURCE_ID,
                    ITEM_TYPE_URN
          UNION ALL
          SELECT    CLUSTER_RESOURCE_ID,
                    ITEM_TYPE_URN,
                    MIN(EFFECTIVE_TO)
          FROM      VW_DIM_ITEM_PKEY_MAP
          WHERE     STATUS NOT IN ( 'D', 'E' )
                    AND LATEST = 1
          GROUP BY  CLUSTER_RESOURCE_ID,
                    ITEM_TYPE_URN
          UNION ALL
          SELECT    CLUSTER_RESOURCE_ID,
                    MEMBER_TYPE_URN,
                    MIN(EFFECTIVE_FROM)
          FROM      VW_DIM_MEMBER_PKEY_MAP
          WHERE     STATUS = 'S'
                    AND LATEST = 1
          GROUP BY  CLUSTER_RESOURCE_ID,
                    MEMBER_TYPE_URN
          UNION ALL
          SELECT    CLUSTER_RESOURCE_ID,
                    MEMBER_TYPE_URN,
                    MIN(EFFECTIVE_TO)
          FROM      VW_DIM_MEMBER_PKEY_MAP memberPkey
          WHERE     STATUS NOT IN ( 'D', 'E' )
                    AND LATEST = 1
          GROUP BY  CLUSTER_RESOURCE_ID,
                    MEMBER_TYPE_URN
        ) AS minDates
WHERE   CLUSTER_RESOURCE_ID IS NOT NULL
GROUP BY CLUSTER_RESOURCE_ID,
        RESOURCE_TYPE_URN;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NEXT_PROVISIONING_DATE]
	TO [portalapp_role]
GO
