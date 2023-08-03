SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_SKILLGROUP_CAMPAIGN_MEMBER_ICM_PROV]
AS
SELECT  campaignMember.CLUSTER_RESOURCE_ID,
        campaignMember.MODIFIED_DATE,
        campaignMember.MEMBER_URN,
        campaignMember.PKEY_MAP_URN,
        campaignMember.PKEY_CHANGE_STAMP,
        CASE WHEN campaignMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > campaignMember.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE campaignMember.STATUS
        END AS STATUS,
        CASE WHEN campaignMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > campaignMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        campaignMember.PKEY1,
        campaignMember.PKEY2,
        campaignMember.OVERFLOW_AGENTS,
        campaign.ITEM_BIZ_URN AS CAMPAIGN_BUSINESS_URN,
        campaign.PKEY1 AS CAMPAIGN_ID,
        skillGroup.ITEM_BIZ_URN AS SKILLGROUP_BUSINESS_URN,
        skillGroup.PKEY1 AS SKILLGROUP_ID
FROM    VW_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY campaignMember
JOIN    VW_DIM_CAMPAIGN_PKEY campaign ON campaignMember.PARENT_ITEM_BIZ_URN = campaign.ITEM_BIZ_URN
                                         AND campaignMember.CLUSTER_RESOURCE_ID = campaign.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_SKILLGROUP_PKEY skillGroup ON campaignMember.CHILD_ITEM_BIZ_URN = skillGroup.ITEM_BIZ_URN
                                             AND campaignMember.CLUSTER_RESOURCE_ID = skillGroup.CLUSTER_RESOURCE_ID
WHERE   (
          (
            campaignMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN campaignMember.PKEY_EFFECTIVE_FROM
                               AND     campaignMember.PKEY_EFFECTIVE_TO )
          )
          OR ( campaignMember.STATUS = 'P' )
          OR (
               campaignMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > campaignMember.PKEY_EFFECTIVE_TO
             )
        )
        AND campaignMember.LATEST = 1
        AND campaignMember.PKEY_LATEST = 1
        AND campaign.LATEST = 1
        AND campaign.PKEY_LATEST = 1
        AND skillGroup.LATEST = 1
        AND skillGroup.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SKILLGROUP_CAMPAIGN_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
