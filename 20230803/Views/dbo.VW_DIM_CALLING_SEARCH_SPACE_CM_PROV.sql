SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CALLING_SEARCH_SPACE_CM_PROV]
AS
SELECT  callingSearchSpace.CLUSTER_RESOURCE_ID,
        callingSearchSpace.MODIFIED_DATE,
        callingSearchSpace.ITEM_BIZ_URN AS CALLING_SEARCH_SPACE_BUSINESS_URN,
        callingSearchSpace.PKEY_MAP_URN,
        CASE WHEN callingSearchSpace.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > callingSearchSpace.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE callingSearchSpace.STATUS
        END AS STATUS,
        CASE WHEN callingSearchSpace.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > callingSearchSpace.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        callingSearchSpace.PKEY1 AS CALLING_SEARCH_SPACE_ID,
        callingSearchSpace.DESCRIPTION,
        callingSearchSpace.INTERNAL_NAME,
        callingSearchSpace.PKEY_CHANGE_STAMP
FROM    VW_DIM_CALLING_SEARCH_SPACE_PKEY callingSearchSpace
WHERE   (
          (
            callingSearchSpace.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN callingSearchSpace.PKEY_EFFECTIVE_FROM
                               AND     callingSearchSpace.PKEY_EFFECTIVE_TO )
          )
          OR ( callingSearchSpace.STATUS = 'P' )
          OR (
               callingSearchSpace.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > callingSearchSpace.PKEY_EFFECTIVE_TO
             )
        )
        AND callingSearchSpace.LATEST = 1
        AND callingSearchSpace.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALLING_SEARCH_SPACE_CM_PROV]
	TO [portalapp_role]
GO
