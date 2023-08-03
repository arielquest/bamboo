SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_LABEL_DIALED_NUMBER_MEMBER_ICM_PROV]
AS
SELECT  dialedNumberMember.CLUSTER_RESOURCE_ID,
        dialedNumberMember.MODIFIED_DATE,
        dialedNumberMember.MEMBER_URN,
        dialedNumberMember.PKEY_MAP_URN,
        dialedNumberMember.PKEY_CHANGE_STAMP,
        CASE WHEN dialedNumberMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > dialedNumberMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE dialedNumberMember.STATUS
        END AS STATUS,
        CASE WHEN dialedNumberMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > dialedNumberMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        dialedNumberMember.PKEY1,
        dialedNumberMember.PKEY2,
        label.ITEM_BIZ_URN AS LABEL_BUSINESS_URN,
        label.PKEY1 AS LABEL_ID,
        dialedNumber.ITEM_BIZ_URN AS DIALED_NUMBER_BUSINESS_URN,
        dialedNumber.PKEY1 AS DIALED_NUMBER_ID
FROM    VW_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY dialedNumberMember
JOIN    VW_DIM_LABEL_PKEY label ON dialedNumberMember.CHILD_ITEM_BIZ_URN = label.ITEM_BIZ_URN
                                   AND label.CLUSTER_RESOURCE_ID = dialedNumberMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_DIALED_NUMBER_PKEY dialedNumber ON dialedNumberMember.PARENT_ITEM_BIZ_URN = dialedNumber.ITEM_BIZ_URN
                                                  AND dialedNumber.CLUSTER_RESOURCE_ID = dialedNumberMember.CLUSTER_RESOURCE_ID
WHERE   (
          (
            dialedNumberMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN dialedNumberMember.PKEY_EFFECTIVE_FROM
                               AND     dialedNumberMember.PKEY_EFFECTIVE_TO )
          )
          OR ( dialedNumberMember.STATUS = 'P' )
          OR (
               dialedNumberMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > dialedNumberMember.PKEY_EFFECTIVE_TO
             )
        )
        AND dialedNumberMember.LATEST = 1
        AND dialedNumberMember.PKEY_LATEST = 1
        AND label.LATEST = 1
        AND label.PKEY_LATEST = 1
        AND dialedNumber.LATEST = 1
        AND dialedNumber.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_LABEL_DIALED_NUMBER_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
