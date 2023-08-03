SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_USER_VARIABLE_ICM_PROV]
AS
SELECT  userVariable.CLUSTER_RESOURCE_ID,
        userVariable.MODIFIED_DATE,
        userVariable.ITEM_BIZ_URN AS USER_VARIABLE_BUSINESS_URN,
        userVariable.PKEY_MAP_URN,
        userVariable.PKEY_CHANGE_STAMP,
        userVariable.PKEY1 AS USER_VARIABLE_ID,
        CASE WHEN userVariable.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > userVariable.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE userVariable.STATUS
        END AS STATUS,
        CASE WHEN userVariable.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > userVariable.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(userVariable.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        userVariable.DESCRIPTION,
        userVariable.INTERNAL_NAME AS VARIABLE_NAME,
        userVariable.OBJECT_TYPE,
        userVariable.DATA_TYPE,
        userVariable.PERSISTENT
FROM    VW_DIM_USER_VARIABLE_PKEY userVariable
WHERE   (
          (
            userVariable.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN userVariable.PKEY_EFFECTIVE_FROM
                               AND     userVariable.PKEY_EFFECTIVE_TO )
          )
          OR ( userVariable.STATUS = 'P' )
          OR (
               userVariable.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > userVariable.PKEY_EFFECTIVE_TO
             )
        )
        AND userVariable.LATEST = 1
        AND userVariable.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_USER_VARIABLE_ICM_PROV]
	TO [portalapp_role]
GO
