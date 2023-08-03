SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Bucket_Intervals]
AS
SELECT  CAST([bucketInterval].[PKEY1] AS INT) AS BucketIntervalID,
        [bucketInterval].[NAME] AS EnterpriseName,
        [bucketInterval].[INTERVAL_UPPER_BOUND_1] AS IntervalUpperBound1,
        [bucketInterval].[INTERVAL_UPPER_BOUND_2] AS IntervalUpperBound2,
        [bucketInterval].[INTERVAL_UPPER_BOUND_3] AS IntervalUpperBound3,
        [bucketInterval].[INTERVAL_UPPER_BOUND_4] AS IntervalUpperBound4,
        [bucketInterval].[INTERVAL_UPPER_BOUND_5] AS IntervalUpperBound5,
        [bucketInterval].[INTERVAL_UPPER_BOUND_6] AS IntervalUpperBound6,
        [bucketInterval].[INTERVAL_UPPER_BOUND_7] AS IntervalUpperBound7,
        [bucketInterval].[INTERVAL_UPPER_BOUND_8] AS IntervalUpperBound8,
        [bucketInterval].[INTERVAL_UPPER_BOUND_9] AS IntervalUpperBound9,
        [bucketInterval].[DELETED] AS Deleted,
        [bucketInterval].[SOURCE_CHANGE_STAMP] AS ChangeStamp
FROM    [dbo].[VW_DIM_BUCKET_INTERVAL_PKEY] bucketInterval
WHERE   [bucketInterval].[LATEST] = 1
        AND [bucketInterval].[PKEY_LATEST] = 1;
GO
