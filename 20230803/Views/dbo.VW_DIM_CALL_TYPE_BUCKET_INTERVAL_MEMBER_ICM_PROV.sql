SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_ICM_PROV]
AS
SELECT  callTypeBucketIntervalMember.CLUSTER_RESOURCE_ID,
        callTypeBucketIntervalMember.MODIFIED_DATE,
        callTypeBucketIntervalMember.MEMBER_URN,
        callTypeBucketIntervalMember.PKEY_MAP_URN,
        callTypeBucketIntervalMember.PKEY_CHANGE_STAMP,
        CASE WHEN callTypeBucketIntervalMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > callTypeBucketIntervalMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE callTypeBucketIntervalMember.STATUS
        END AS STATUS,
        CASE WHEN callTypeBucketIntervalMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > callTypeBucketIntervalMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        callTypeBucketIntervalMember.PKEY1,
        callTypeBucketIntervalMember.PKEY2,
        callType.ITEM_BIZ_URN AS CALL_TYPE_BUSINESS_URN,
        callType.PKEY_MAP_URN AS CALL_TYPE_PKEY_MAP_URN,
        callType.PKEY_CHANGE_STAMP AS CALL_TYPE_CHANGE_STAMP,
        callType.STATUS AS CALL_TYPE_STATUS,
        callType.PKEY1 AS CALL_TYPE_ID,
        COALESCE(callType.SOURCE_CHANGE_STAMP, 0) AS CALL_TYPE_SOURCE_CHANGE_STAMP,
        bucketInterval.ITEM_BIZ_URN AS BUCKET_INTERVAL_BUSINESS_URN,
        bucketInterval.PKEY1 AS BUCKET_INTERVAL_ID
FROM    VW_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_PKEY callTypeBucketIntervalMember
JOIN    VW_DIM_CALL_TYPE_PKEY callType ON callTypeBucketIntervalMember.CHILD_ITEM_BIZ_URN = callType.ITEM_BIZ_URN
                                          AND callTypeBucketIntervalMember.CLUSTER_RESOURCE_ID = callType.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_BUCKET_INTERVAL_PKEY AS bucketInterval ON callTypeBucketIntervalMember.PARENT_ITEM_BIZ_URN = bucketInterval.ITEM_BIZ_URN
                                                         AND bucketInterval.CLUSTER_RESOURCE_ID = callType.CLUSTER_RESOURCE_ID
WHERE   (
          (
            callTypeBucketIntervalMember.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN callTypeBucketIntervalMember.PKEY_EFFECTIVE_FROM
                               AND     callTypeBucketIntervalMember.PKEY_EFFECTIVE_TO )
          )
          OR ( callTypeBucketIntervalMember.STATUS = 'P' )
          OR (
               callTypeBucketIntervalMember.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > callTypeBucketIntervalMember.PKEY_EFFECTIVE_TO
             )
        )
        AND callTypeBucketIntervalMember.LATEST = 1
        AND callTypeBucketIntervalMember.PKEY_LATEST = 1
        AND callType.LATEST = 1
        AND callType.PKEY_LATEST = 1
        AND bucketInterval.LATEST = 1
        AND bucketInterval.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
