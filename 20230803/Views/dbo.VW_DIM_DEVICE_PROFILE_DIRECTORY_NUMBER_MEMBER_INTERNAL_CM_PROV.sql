SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_INTERNAL_CM_PROV]
AS
SELECT  deviceProfile.ITEM_URN AS DEVICE_PROFILE_URN,
        deviceProfile.CLUSTER_RESOURCE_ID,
        deviceProfileDirectoryNumberMember.MEMBER_URN,
        deviceProfileDirectoryNumberMember.PKEY_CHANGE_STAMP,
        deviceProfileDirectoryNumberMember.PKEY_MAP_URN,
        deviceProfileDirectoryNumberMember.LINE_INDEX,
        deviceProfileDirectoryNumberMember.PKEY1,
        pkeyMap.XML_DATA,
        directoryNumber.ITEM_BIZ_URN AS DIRECTORY_NUMBER_BUSINESS_URN,
        directoryNumber.PKEY1 AS DIRECTORY_NUMBER_ID,
        CASE WHEN (
                    deviceProfileDirectoryNumberMember.STATUS NOT IN ( 'D',
                                                              'E' )
                    AND GETUTCDATE() > deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_TO
                  ) THEN 'P'
             ELSE deviceProfileDirectoryNumberMember.STATUS
        END AS STATUS,
        CASE WHEN (
                    deviceProfileDirectoryNumberMember.STATUS NOT IN ( 'D',
                                                              'E' )
                    AND GETUTCDATE() > deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_TO
                  ) THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED
FROM    VW_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY deviceProfileDirectoryNumberMember
JOIN    TB_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY_MAP pkeyMap ON deviceProfileDirectoryNumberMember.PKEY_MAP_URN = pkeyMap.PKEY_MAP_URN
JOIN    VW_DIM_DEVICE_PROFILE_PKEY deviceProfile ON deviceProfile.ITEM_URN = deviceProfileDirectoryNumberMember.CHILD_ITEM_BIZ_URN
                                                    AND deviceProfile.CLUSTER_RESOURCE_ID = deviceProfileDirectoryNumberMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIRECTORY_NUMBER_PKEY directoryNumber ON directoryNumber.ITEM_URN = deviceProfileDirectoryNumberMember.PARENT_ITEM_BIZ_URN
                                                        AND directoryNumber.CLUSTER_RESOURCE_ID = deviceProfileDirectoryNumberMember.CLUSTER_RESOURCE_ID
WHERE   (
          deviceProfileDirectoryNumberMember.STATUS = 'R'
          OR deviceProfileDirectoryNumberMember.STATUS = 'P'
          OR (
               deviceProfileDirectoryNumberMember.STATUS = 'S'
               AND ( GETUTCDATE() BETWEEN deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_FROM
                                  AND     deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_TO )
             )
          OR (
               deviceProfileDirectoryNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_TO
             )
        );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_INTERNAL_CM_PROV]
	TO [portalapp_role]
GO
