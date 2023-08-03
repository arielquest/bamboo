SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEVICE_PROFILE_BUTTON_TEMPLATE_MEMBER_CM_PROV]
AS
SELECT  deviceProfileButtonTemplateMember.CLUSTER_RESOURCE_ID,
        deviceProfileButtonTemplateMember.MODIFIED_DATE,
        deviceProfileButtonTemplateMember.MEMBER_URN,
        deviceProfileButtonTemplateMember.PKEY_MAP_URN,
        deviceProfileButtonTemplateMember.PKEY_CHANGE_STAMP,
        CASE WHEN deviceProfileButtonTemplateMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > deviceProfileButtonTemplateMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE deviceProfileButtonTemplateMember.STATUS
        END AS STATUS,
        CASE WHEN deviceProfileButtonTemplateMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > deviceProfileButtonTemplateMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        deviceProfileButtonTemplateMember.PKEY1,
        deviceProfileButtonTemplateMember.PKEY2,
        deviceProfile.ITEM_BIZ_URN AS DEVICE_PROFILE_BUSINESS_URN,
        deviceProfile.PKEY1 AS DEVICE_PROFILE_ID,
        buttonTemplate.ITEM_BIZ_URN AS BUTTON_TEMPLATE_BUSINESS_URN,
        buttonTemplate.PKEY1 AS BUTTON_TEMPLATE_ID
FROM    VW_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY deviceProfileButtonTemplateMember
JOIN    VW_DIM_DEVICE_PROFILE_PKEY deviceProfile ON deviceProfile.ITEM_BIZ_URN = deviceProfileButtonTemplateMember.CHILD_ITEM_BIZ_URN
                                                    AND deviceProfile.CLUSTER_RESOURCE_ID = deviceProfileButtonTemplateMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY AS buttonTemplate ON buttonTemplate.ITEM_BIZ_URN = deviceProfileButtonTemplateMember.PARENT_ITEM_BIZ_URN
                                                              AND buttonTemplate.CLUSTER_RESOURCE_ID = deviceProfileButtonTemplateMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            deviceProfileButtonTemplateMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN deviceProfileButtonTemplateMember.PKEY_EFFECTIVE_FROM
                               AND     deviceProfileButtonTemplateMember.PKEY_EFFECTIVE_TO )
          )
          OR ( deviceProfileButtonTemplateMember.STATUS = 'P' )
          OR (
               deviceProfileButtonTemplateMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > deviceProfileButtonTemplateMember.PKEY_EFFECTIVE_TO
             )
        )
        AND deviceProfileButtonTemplateMember.LATEST = 1
        AND deviceProfileButtonTemplateMember.PKEY_LATEST = 1
        AND deviceProfile.LATEST = 1
        AND deviceProfile.PKEY_LATEST = 1
        AND buttonTemplate.LATEST = 1
        AND buttonTemplate.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_PROFILE_BUTTON_TEMPLATE_MEMBER_CM_PROV]
	TO [portalapp_role]
GO
