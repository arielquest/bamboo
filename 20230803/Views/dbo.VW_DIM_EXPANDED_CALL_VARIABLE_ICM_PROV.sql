SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ICM_PROV]
AS
SELECT  expandedCallVariable.CLUSTER_RESOURCE_ID,
        expandedCallVariable.MODIFIED_DATE,
        expandedCallVariable.ITEM_BIZ_URN AS EXPANDED_CALL_VARIABLE_BUSINESS_URN,
        expandedCallVariable.PKEY1 AS EXPANDED_CALL_VARIABLE_ID,
        expandedCallVariable.PKEY_MAP_URN AS PKEY_MAP_URN,
        expandedCallVariable.PKEY_CHANGE_STAMP,
        CASE WHEN expandedCallVariable.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > expandedCallVariable.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE expandedCallVariable.STATUS
        END AS STATUS,
        CASE WHEN expandedCallVariable.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > expandedCallVariable.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        expandedCallVariable.DESCRIPTION,
        expandedCallVariable.INTERNAL_NAME AS ENTERPRISE_NAME,
        expandedCallVariable.ECC_ARRAY,
        expandedCallVariable.VARIABLE_ENABLED,
        expandedCallVariable.GEOTEL_PROVIDED,
        expandedCallVariable.MAXIMUM_ARRAY_SIZE,
        expandedCallVariable.MAXIMUM_LENGTH,
        expandedCallVariable.PERSISTENT,
        COALESCE(expandedCallVariable.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP
FROM    VW_DIM_EXPANDED_CALL_VARIABLE_PKEY expandedCallVariable
WHERE   (
          (
            expandedCallVariable.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN expandedCallVariable.PKEY_EFFECTIVE_FROM
                               AND     expandedCallVariable.PKEY_EFFECTIVE_TO )
          )
          OR ( expandedCallVariable.STATUS = 'P' )
          OR (
               expandedCallVariable.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > expandedCallVariable.PKEY_EFFECTIVE_TO
             )
        )
        AND expandedCallVariable.LATEST = 1
        AND expandedCallVariable.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ICM_PROV]
	TO [portalapp_role]
GO
