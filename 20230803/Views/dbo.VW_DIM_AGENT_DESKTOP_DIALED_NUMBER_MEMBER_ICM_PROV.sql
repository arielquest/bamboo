SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_ICM_PROV]
AS
SELECT  agentDesktopDialedNumberMember.CLUSTER_RESOURCE_ID,
        agentDesktopDialedNumberMember.MODIFIED_DATE,
        agentDesktopDialedNumberMember.MEMBER_URN,
        agentDesktopDialedNumberMember.PKEY_MAP_URN,
        agentDesktopDialedNumberMember.PKEY_CHANGE_STAMP,
        CASE WHEN agentDesktopDialedNumberMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentDesktopDialedNumberMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE agentDesktopDialedNumberMember.STATUS
        END AS STATUS,
        CASE WHEN agentDesktopDialedNumberMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > agentDesktopDialedNumberMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        agentDesktopDialedNumberMember.PKEY1,
        agentDesktopDialedNumberMember.PKEY2,
        agentDesktop.ITEM_BIZ_URN AS AGENT_DESKTOP_BUSINESS_URN,
        agentDesktop.PKEY1 AS AGENT_DESKTOP_ID,
        agentDesktop.PKEY_MAP_URN AS AGENT_DESKTOP_PKEY_MAP_URN,
        agentDesktop.PKEY_CHANGE_STAMP AS AGENT_DESKTOP_CHANGE_STAMP,
        agentDesktop.STATUS AS AGENT_DESKTOP_STATUS,
        COALESCE(agentDesktop.SOURCE_CHANGE_STAMP, 0) AS AGENT_DESKTOP_SOURCE_CHANGE_STAMP,
        dialedNumber.ITEM_BIZ_URN AS DIALED_NUMBER_BUSINESS_URN,
        dialedNumber.PKEY1 AS DIALED_NUMBER_ID
FROM    VW_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_PKEY AS agentDesktopDialedNumberMember
JOIN    VW_DIM_AGENT_DESKTOP_PKEY agentDesktop ON agentDesktopDialedNumberMember.CHILD_ITEM_BIZ_URN = agentDesktop.ITEM_BIZ_URN
                                                  AND agentDesktop.CLUSTER_RESOURCE_ID = agentDesktopDialedNumberMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIALED_NUMBER_PKEY AS dialedNumber ON agentDesktopDialedNumberMember.PARENT_ITEM_BIZ_URN = dialedNumber.ITEM_BIZ_URN
                                                     AND dialedNumber.CLUSTER_RESOURCE_ID = agentDesktopDialedNumberMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            agentDesktopDialedNumberMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN agentDesktopDialedNumberMember.PKEY_EFFECTIVE_FROM
                               AND     agentDesktopDialedNumberMember.PKEY_EFFECTIVE_TO )
          )
          OR ( agentDesktopDialedNumberMember.STATUS = 'P' )
          OR (
               agentDesktopDialedNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > agentDesktopDialedNumberMember.PKEY_EFFECTIVE_TO
             )
        )
        AND agentDesktopDialedNumberMember.LATEST = 1
        AND agentDesktopDialedNumberMember.PKEY_LATEST = 1
        AND agentDesktop.LATEST = 1
        AND agentDesktop.PKEY_LATEST = 1
        AND dialedNumber.LATEST = 1
        AND dialedNumber.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
