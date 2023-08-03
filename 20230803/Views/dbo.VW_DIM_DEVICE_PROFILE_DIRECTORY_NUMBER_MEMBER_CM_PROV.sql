SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_CM_PROV]
AS
SELECT DISTINCT
        deviceProfile.CLUSTER_RESOURCE_ID,
        deviceProfile.ITEM_URN AS DEVICE_PROFILE_URN,
        deviceProfile.ITEM_BIZ_URN AS DEVICE_PROFILE_BUSINESS_URN,
        deviceProfile.PKEY_MAP_URN AS DEVICE_PROFILE_PKEY_MAP_URN,
        deviceProfile.PKEY1 AS DEVICE_PROFILE_ID,
        deviceProfile.INTERNAL_NAME
FROM    VW_DIM_DEVICE_PROFILE_PKEY deviceProfile
JOIN    VW_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY deviceProfileDirectoryNumberMember ON deviceProfileDirectoryNumberMember.CHILD_ITEM_BIZ_URN = deviceProfile.ITEM_BIZ_URN
                                                              AND deviceProfileDirectoryNumberMember.CLUSTER_RESOURCE_ID = deviceProfile.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIRECTORY_NUMBER_PKEY dn ON dn.ITEM_BIZ_URN = deviceProfileDirectoryNumberMember.PARENT_ITEM_BIZ_URN
                                           AND dn.CLUSTER_RESOURCE_ID = deviceProfileDirectoryNumberMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            deviceProfileDirectoryNumberMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_FROM
                               AND     deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_TO )
          )
          OR ( deviceProfileDirectoryNumberMember.STATUS = 'P' )
          OR (
               deviceProfileDirectoryNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > deviceProfileDirectoryNumberMember.PKEY_EFFECTIVE_TO
             )
        )
        AND deviceProfile.LATEST = 1
        AND deviceProfile.PKEY_LATEST = 1
        AND deviceProfileDirectoryNumberMember.LATEST = 1
        AND deviceProfileDirectoryNumberMember.PKEY_LATEST = 1
        AND dn.LATEST = 1
        AND dn.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
