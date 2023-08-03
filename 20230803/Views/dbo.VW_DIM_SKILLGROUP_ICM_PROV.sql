SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SKILLGROUP_ICM_PROV]
AS
SELECT  skillgroup.CLUSTER_RESOURCE_ID,
        skillgroup.MODIFIED_DATE,
        skillgroup.ITEM_BIZ_URN AS SKILLGROUP_BUSINESS_URN,
        skillgroup.PKEY1 AS SKILLGROUP_ID,
        skillgroup.PKEY_MAP_URN,
        skillgroup.PKEY_CHANGE_STAMP,
        CASE WHEN skillgroup.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > skillgroup.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE skillgroup.STATUS
        END AS STATUS,
        CASE WHEN skillgroup.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > skillgroup.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        skillgroup.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        skillgroup.INTERNAL_NAME AS ENTERPRISE_NAME,
        skillgroup.PERIPHERAL_NUMBER AS PERIPHERAL_NUMBER,
        skillgroup.PERIPHERAL_NAME AS PERIPHERAL_NAME,
        skillgroup.AVAILABLE_HOLDOFF_DELAY AS AVAILABLE_HOLDOFF_DELAY,
        skillgroup.PRIORITY AS PRIORITY,
        skillgroup.EXTENSION AS EXTENSION,
        skillgroup.SERVICE_LEVEL_THRESHOLD AS SERVICE_LEVEL_THRESHOLD,
        skillgroup.SERVICE_LEVEL_TYPE AS SERVICE_LEVEL_TYPE,
        skillgroup.DESCRIPTION AS DESCRIPTION,
        skillgroup.IPTA AS IPTA,
        skillgroup.SUB_SKILLGROUP_MASK AS SUB_SKILLGROUP_MASK,
        COALESCE(skillgroup.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        peripheral.PKEY1 AS PERIPHERAL_ID,
        peripheral.ITEM_BIZ_URN AS PERIPHERAL_BUSINESS_URN,
        peripheral.SUB_SKILLGROUP_MASK AS DEFAULT_SUB_SKILLGROUP_MASK,
        mrd.PKEY1 AS MEDIA_ROUTING_DOMAIN_ID,
        mrd.ITEM_BIZ_URN AS MEDIA_ROUTING_DOMAIN_BUSINESS_URN,
        skillgroupPeripheralMember.MEMBER_URN AS SKILLGROUP_PERIPHERAL_MEMBER_URN,
        skillgroupPeripheralMember.PKEY_MAP_URN AS SKILLGROUP_PERIPHERAL_PKEY_MAP_URN,
        skillgroupPeripheralMember.PKEY_CHANGE_STAMP AS SKILLGROUP_PERIPHERAL_CHANGE_STAMP,
        skillgroupPeripheralMember.STATUS AS SKILLGROUP_PERIPHERAL_STATUS,
        skillgroupMRDMember.MEMBER_URN AS SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_URN,
        skillgroupMRDMember.PKEY_MAP_URN AS SKILLGROUP_MEDIA_ROUTING_DOMAIN_PKEY_MAP_URN,
        skillgroupMRDMember.PKEY_CHANGE_STAMP AS SKILLGROUP_MEDIA_ROUTING_DOMAIN_CHANGE_STAMP,
        skillgroupMRDMember.STATUS AS SKILLGROUP_MEDIA_ROUTING_DOMAIN_STATUS
FROM    VW_DIM_SKILLGROUP_PKEY skillgroup
JOIN    VW_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY skillgroupPeripheralMember ON skillgroup.ITEM_BIZ_URN = skillgroupPeripheralMember.CHILD_ITEM_BIZ_URN
                                                              AND skillgroupPeripheralMember.CLUSTER_RESOURCE_ID = skillgroup.CLUSTER_RESOURCE_ID
                                                              AND skillgroupPeripheralMember.PURGED = 0
JOIN    VW_DIM_PERIPHERAL_PKEY peripheral ON skillgroupPeripheralMember.PARENT_ITEM_BIZ_URN = peripheral.ITEM_BIZ_URN
                                             AND peripheral.CLUSTER_RESOURCE_ID = skillgroup.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY skillgroupMRDMember ON skillgroup.ITEM_BIZ_URN = skillgroupMRDMember.CHILD_ITEM_BIZ_URN
                                                              AND skillgroupMRDMember.CLUSTER_RESOURCE_ID = skillgroup.CLUSTER_RESOURCE_ID
                                                              AND skillgroupMRDMember.PURGED = 0
JOIN    VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY mrd ON skillgroupMRDMember.PARENT_ITEM_BIZ_URN = mrd.ITEM_BIZ_URN
                                                AND mrd.CLUSTER_RESOURCE_ID = skillgroup.CLUSTER_RESOURCE_ID
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = skillgroup.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = skillgroup.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            skillgroup.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN skillgroup.PKEY_EFFECTIVE_FROM
                               AND     skillgroup.PKEY_EFFECTIVE_TO )
          )
          OR ( skillgroup.STATUS = 'P' )
          OR (
               skillgroup.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > skillgroup.PKEY_EFFECTIVE_TO
             )
        )
        AND skillgroup.LATEST = 1
        AND skillgroup.PKEY_LATEST = 1
        AND skillgroupPeripheralMember.LATEST = 1
        AND skillgroupPeripheralMember.PKEY_LATEST = 1
        AND peripheral.LATEST = 1
        AND peripheral.PKEY_LATEST = 1
        AND skillgroupMRDMember.LATEST = 1
        AND skillgroupMRDMember.PKEY_LATEST = 1
        AND mrd.LATEST = 1
        AND mrd.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SKILLGROUP_ICM_PROV]
	TO [portalapp_role]
GO
