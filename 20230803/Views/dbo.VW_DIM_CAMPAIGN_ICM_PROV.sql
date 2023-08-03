SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CAMPAIGN_ICM_PROV]
AS
SELECT  campaign.CLUSTER_RESOURCE_ID,
        campaign.MODIFIED_DATE,
        campaign.ITEM_BIZ_URN AS CAMPAIGN_BUSINESS_URN,
        campaign.PKEY_MAP_URN,
        campaign.PKEY_CHANGE_STAMP,
        CASE WHEN campaign.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > campaign.PKEY_EFFECTIVE_TO THEN 'P'
             ELSE campaign.STATUS
        END AS STATUS,
        CASE WHEN campaign.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > campaign.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        COALESCE(campaign.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP,
        campaign.PKEY1 AS CAMPAIGN_ID,
        campaign.LINES_PER_AGENT,
        campaign.MAXIMUM_LINE_AGENT,
        campaign.ABANDON_ENABLED,
        campaign.ABANDON_PERCENT,
        campaign.MAXIMUM_ATTEMPTS,
        campaign.ICM_ENABLED,
        campaign.DESCRIPTION,
        campaign.INTERNAL_NAME AS ENTERPRISE_NAME
FROM    VW_DIM_CAMPAIGN_PKEY campaign
WHERE   (
          (
            campaign.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN campaign.PKEY_EFFECTIVE_FROM
                               AND     campaign.PKEY_EFFECTIVE_TO )
          )
          OR ( campaign.STATUS = 'P' )
          OR (
               campaign.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > campaign.PKEY_EFFECTIVE_TO
             )
        )
        AND campaign.LATEST = 1
        AND campaign.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CAMPAIGN_ICM_PROV]
	TO [portalapp_role]
GO
