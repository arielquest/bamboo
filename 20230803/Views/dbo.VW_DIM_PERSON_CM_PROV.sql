SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_PERSON_CM_PROV]
AS
SELECT  person.CLUSTER_RESOURCE_ID,
        person.MODIFIED_DATE,
        person.ITEM_BIZ_URN AS PERSON_BUSINESS_URN,
        person.PKEY_MAP_URN,
        person.PKEY_CHANGE_STAMP,
        CASE WHEN person.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > person.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE person.STATUS
        END AS STATUS,
        CASE WHEN person.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > person.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(person.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        person.PKEY1 AS PERSON_ID,
        person.FIRST_NAME,
        person.LAST_NAME,
        person.LOGIN_NAME,
        person.HOME_CLUSTER,
        person.ENABLE_USER,
        person.MEETING_INFORMATION,
        ucprofile.ITEM_BIZ_URN AS UC_SERVICE_PROFILE_BUSINESS_URN ,
        ucprofile.PKEY1 AS UC_SERVICE_PROFILE_ID,
        ucprofile.Name AS UC_SERVICE_PROFILE
FROM    VW_DIM_PERSON_PKEY person  LEFT JOIN VW_DIM_UC_SERVICE_PROFILE_PKEY ucprofile ON person.UC_SERVICE_PROFILE_BIZ_URN=ucprofile.ITEM_URN
        and person.CLUSTER_RESOURCE_ID=ucprofile.CLUSTER_RESOURCE_ID
        and ucprofile.LATEST=1
        and ucprofile.PKEY_LATEST=1    
WHERE   (
          (
            person.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN person.PKEY_EFFECTIVE_FROM
                               AND     person.PKEY_EFFECTIVE_TO )
          )
          OR ( person.STATUS = 'P' )
          OR (
               person.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > person.PKEY_EFFECTIVE_TO
             )
        )
        AND person.LATEST = 1
        AND person.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_PERSON_CM_PROV]
	TO [portalapp_role]
GO
