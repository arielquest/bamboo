SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEVICE_PROFILE_PERSON_MEMBER_CM_PROV]
AS
SELECT DISTINCT
        person.CLUSTER_RESOURCE_ID,
        person.MODIFIED_DATE,
        person.ITEM_URN AS PERSON_URN,
        person.ITEM_BIZ_URN AS PERSON_BUSINESS_URN,
        person.PKEY_MAP_URN AS PERSON_PKEY_MAP_URN,
        person.PKEY1 AS PERSON_ID,
        person.LOGIN_NAME
FROM    VW_DIM_PERSON_PKEY person
JOIN    TB_DIM_PERSON_PKEY_MAP map ON map.PKEY_MAP_URN = person.PKEY_MAP_URN
JOIN    VW_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY deviceProfilePersonMember ON deviceProfilePersonMember.PARENT_ITEM_BIZ_URN = person.ITEM_BIZ_URN
                                                              AND deviceProfilePersonMember.CLUSTER_RESOURCE_ID = person.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DEVICE_PROFILE_PKEY dp ON dp.ITEM_BIZ_URN = deviceProfilePersonMember.CHILD_ITEM_BIZ_URN
                                         AND dp.CLUSTER_RESOURCE_ID = deviceProfilePersonMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            deviceProfilePersonMember.STATUS = 'S'
            AND GETUTCDATE() BETWEEN deviceProfilePersonMember.PKEY_EFFECTIVE_FROM
                             AND     deviceProfilePersonMember.PKEY_EFFECTIVE_TO
          )
          OR ( deviceProfilePersonMember.STATUS = 'P' )
          OR (
               deviceProfilePersonMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > deviceProfilePersonMember.PKEY_EFFECTIVE_TO
             )
        )
        AND person.LATEST = 1
        AND person.PKEY_LATEST = 1
        AND deviceProfilePersonMember.LATEST = 1
        AND deviceProfilePersonMember.PKEY_LATEST = 1
        AND dp.LATEST = 1
        AND dp.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_PROFILE_PERSON_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
