SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_PERSON_ICM_PROV]
AS
SELECT  [person].[CLUSTER_RESOURCE_ID],
        [person].[MODIFIED_DATE],
        [person].[ITEM_BIZ_URN] AS [PERSON_BUSINESS_URN],
        [person].[PKEY_MAP_URN],
        [person].[PKEY_CHANGE_STAMP],
        CASE WHEN [person].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [person].[PKEY_EFFECTIVE_TO] THEN 'P'
             ELSE [person].[STATUS]
        END AS [STATUS],
        CASE WHEN [person].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [person].[PKEY_EFFECTIVE_TO] THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS [EXPIRED],
        COALESCE([person].[SOURCE_CHANGE_STAMP], 0) AS [SOURCE_CHANGE_STAMP],
        [person].[DEPARTMENT_BIZ_URN],
        [department].[PKEY1] AS [DEPARTMENT_ID],
        [person].[PKEY1] AS [PERSON_ID],
        [person].[DESCRIPTION],
        [person].[FIRST_NAME],
        [person].[LAST_NAME],
        [person].[LOGIN_NAME],
        [person].[PASS_PHRASE],
        [person].[PASS_PHRASE_SHA],
        [person].[LOGIN_ENABLED],
        [person].[USER_ID],
        [person].[SSO_ENABLED]
FROM    [dbo].[VW_DIM_PERSON_PKEY] [person]
LEFT JOIN [dbo].[VW_DIM_DEPARTMENT_PKEY] [department] ON [department].[ITEM_BIZ_URN] = [person].[DEPARTMENT_BIZ_URN]
                                                         AND [department].[CLUSTER_RESOURCE_ID] = [person].[CLUSTER_RESOURCE_ID]
                                                         AND [department].[LATEST] = 1
                                                         AND [department].[PKEY_LATEST] = 1
                                                         AND [department].[PURGED] = 0
WHERE   (
          (
            [person].[STATUS] = 'S'
            AND ( GETUTCDATE() BETWEEN [person].[PKEY_EFFECTIVE_FROM] AND [person].[PKEY_EFFECTIVE_TO] )
          )
          OR ( [person].[STATUS] = 'P' )
          OR (
               [person].[STATUS] NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > [person].[PKEY_EFFECTIVE_TO]
             )
        )
        AND [person].[LATEST] = 1
        AND [person].[PKEY_LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_PERSON_ICM_PROV]
	TO [portalapp_role]
GO
