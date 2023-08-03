SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ENTERPRISE_SKILLGROUP_ICM_PROV]
AS
SELECT  entSkillGroup.CLUSTER_RESOURCE_ID,
        entSkillGroup.MODIFIED_DATE,
        entSkillGroup.ITEM_BIZ_URN AS ENTERPRISE_SKILLGROUP_BUSINESS_URN,
        entSkillGroup.PKEY1 AS ENTERPRISE_SKILLGROUP_ID,
        entSkillGroup.PKEY_MAP_URN,
        entSkillGroup.PKEY_CHANGE_STAMP,
        CASE WHEN entSkillGroup.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > entSkillGroup.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE entSkillGroup.STATUS
        END AS STATUS,
        CASE WHEN entSkillGroup.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > entSkillGroup.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        entSkillGroup.DEPARTMENT_BIZ_URN,
        department.PKEY1 AS DEPARTMENT_ID,
        entSkillGroup.DESCRIPTION,
        entSkillGroup.INTERNAL_NAME AS ENTERPRISE_NAME,
        COALESCE(entSkillGroup.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP
FROM    VW_DIM_ENTERPRISE_SKILLGROUP_PKEY entSkillGroup
LEFT JOIN VW_DIM_DEPARTMENT_PKEY department ON department.ITEM_BIZ_URN = entSkillGroup.DEPARTMENT_BIZ_URN
                                               AND department.CLUSTER_RESOURCE_ID = entSkillGroup.CLUSTER_RESOURCE_ID
                                               AND department.LATEST = 1
                                               AND department.PKEY_LATEST = 1
                                               AND department.PURGED = 0
WHERE   (
          (
            entSkillGroup.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN entSkillGroup.PKEY_EFFECTIVE_FROM
                               AND     entSkillGroup.PKEY_EFFECTIVE_TO )
          )
          OR ( entSkillGroup.STATUS = 'P' )
          OR (
               entSkillGroup.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > entSkillGroup.PKEY_EFFECTIVE_TO
             )
        )
        AND entSkillGroup.LATEST = 1
        AND entSkillGroup.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ENTERPRISE_SKILLGROUP_ICM_PROV]
	TO [portalapp_role]
GO
