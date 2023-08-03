SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_ICM_PROV]
AS
SELECT  entSkillGroupMember.CLUSTER_RESOURCE_ID,
        entSkillGroupMember.MODIFIED_DATE,
        entSkillGroupMember.MEMBER_URN,
        entSkillGroupMember.PKEY_MAP_URN,
        entSkillGroupMember.PKEY_CHANGE_STAMP,
        CASE WHEN entSkillGroupMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > entSkillGroupMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE entSkillGroupMember.STATUS
        END AS STATUS,
        CASE WHEN entSkillGroupMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > entSkillGroupMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        entSkillGroupMember.PKEY1,
        entSkillGroupMember.PKEY2,
        skillGroup.ITEM_BIZ_URN AS SKILLGROUP_BUSINESS_URN,
        skillGroup.PKEY1 AS SKILLGROUP_ID,
        entSkillGroup.ITEM_BIZ_URN AS ENTERPRISE_SKILLGROUP_BUSINESS_URN,
        entSkillGroup.PKEY1 AS ENTERPRISE_SKILLGROUP_ID
FROM    VW_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_PKEY entSkillGroupMember
JOIN    VW_DIM_SKILLGROUP_PKEY skillGroup ON entSkillGroupMember.CHILD_ITEM_BIZ_URN = skillGroup.ITEM_BIZ_URN
                                             AND skillGroup.CLUSTER_RESOURCE_ID = entSkillGroupMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_ENTERPRISE_SKILLGROUP_PKEY entSkillGroup ON entSkillGroupMember.PARENT_ITEM_BIZ_URN = entSkillGroup.ITEM_BIZ_URN
                                                           AND entSkillGroup.CLUSTER_RESOURCE_ID = entSkillGroupMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            entSkillGroupMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN entSkillGroupMember.PKEY_EFFECTIVE_FROM
                               AND     entSkillGroupMember.PKEY_EFFECTIVE_TO )
          )
          OR ( entSkillGroupMember.STATUS = 'P' )
          OR (
               entSkillGroupMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > entSkillGroupMember.PKEY_EFFECTIVE_TO
             )
        )
        AND entSkillGroupMember.LATEST = 1
        AND entSkillGroupMember.PKEY_LATEST = 1
        AND skillGroup.LATEST = 1
        AND skillGroup.PKEY_LATEST = 1
        AND entSkillGroup.LATEST = 1
        AND entSkillGroup.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
