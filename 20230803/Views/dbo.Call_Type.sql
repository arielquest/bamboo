SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Call_Type]
AS
SELECT  CAST([callType].[PKEY1] AS INT) AS CallTypeID,
        CAST([tenant].[PKEY1] AS INT) AS CustomerDefinitionID,
        [callType].[NAME] AS EnterpriseName,
        [callType].[DESCRIPTION] AS Description,
        [callType].[SERVICE_LEVEL_THRESHOLD] AS ServiceLevelThreshold,
        [callType].[SERVICE_LEVEL_TYPE] AS ServiceLevel,
        [callType].[DELETED] AS Deleted,
        CAST([bucketInterval].[PKEY1] AS INT) AS BucketIntervalID,
        [callType].[SOURCE_CHANGE_STAMP] AS ChangeStamp
FROM    [dbo].[VW_DIM_CALL_TYPE_PKEY] callType
LEFT JOIN [dbo].[VW_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER] AS callTypeBucketIntervalMember ON [callTypeBucketIntervalMember].[CHILD_ITEM_BIZ_URN] = [callType].[ITEM_URN]
                                                              AND [callTypeBucketIntervalMember].[LATEST] = 1
LEFT JOIN [dbo].[VW_DIM_BUCKET_INTERVAL_PKEY] AS bucketInterval ON [bucketInterval].[ITEM_URN] = [callTypeBucketIntervalMember].[PARENT_ITEM_BIZ_URN]
                                                              AND [bucketInterval].[PKEY_LATEST] = 1
                                                              AND [bucketInterval].[ITEM_URN] = [bucketInterval].[ITEM_BIZ_URN]
LEFT JOIN [dbo].[VW_DIM_TENANT_PKEY] AS tenant ON [tenant].[ITEM_BIZ_URN] = [callType].[TENANT_BIZ_URN]
                                                  AND [tenant].[PKEY_LATEST] = 1
WHERE   [callType].[ITEM_URN] = [callType].[ITEM_BIZ_URN];
GO
