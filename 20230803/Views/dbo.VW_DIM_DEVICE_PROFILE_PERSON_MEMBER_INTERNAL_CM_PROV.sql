SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEVICE_PROFILE_PERSON_MEMBER_INTERNAL_CM_PROV]
AS
SELECT  person.ITEM_URN AS PERSON_URN,
        deviceProfilePersonMember.CLUSTER_RESOURCE_ID,
        deviceProfilePersonMember.MEMBER_URN,
        deviceProfilePersonMember.PKEY_MAP_URN,
        deviceProfilePersonMember.PKEY_CHANGE_STAMP,
        deviceProfilePersonMember.PKEY1,
        deviceProfile.PKEY1 AS DEVICE_PROFILE_ID,
        deviceProfile.ITEM_BIZ_URN AS DEVICE_PROFILE_BUSINESS_URN,
        CASE WHEN (
                    deviceProfilePersonMember.STATUS NOT IN ( 'D', 'E' )
                    AND GETUTCDATE() > deviceProfilePersonMember.PKEY_EFFECTIVE_TO
                  ) THEN 'P'
             ELSE deviceProfilePersonMember.STATUS
        END AS STATUS,
        CASE WHEN (
                    deviceProfilePersonMember.STATUS NOT IN ( 'D', 'E' )
                    AND GETUTCDATE() > deviceProfilePersonMember.PKEY_EFFECTIVE_TO
                  ) THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED
FROM    VW_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY deviceProfilePersonMember
JOIN    VW_DIM_DEVICE_PROFILE_PKEY deviceProfile ON deviceProfile.ITEM_URN = deviceProfilePersonMember.CHILD_ITEM_BIZ_URN
                                                    AND deviceProfile.CLUSTER_RESOURCE_ID = deviceProfilePersonMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_PERSON_PKEY person ON person.ITEM_URN = deviceProfilePersonMember.PARENT_ITEM_BIZ_URN
                                     AND person.CLUSTER_RESOURCE_ID = deviceProfilePersonMember.CLUSTER_RESOURCE_ID
WHERE   (
          deviceProfilePersonMember.STATUS = 'R'
          OR deviceProfilePersonMember.STATUS = 'P'
          OR (
               deviceProfilePersonMember.STATUS = 'S'
               AND ( GETUTCDATE() BETWEEN deviceProfilePersonMember.PKEY_EFFECTIVE_FROM
                                  AND     deviceProfilePersonMember.PKEY_EFFECTIVE_TO )
             )
          OR (
               deviceProfilePersonMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > deviceProfilePersonMember.PKEY_EFFECTIVE_TO
             )
        );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_PROFILE_PERSON_MEMBER_INTERNAL_CM_PROV]
	TO [portalapp_role]
GO
