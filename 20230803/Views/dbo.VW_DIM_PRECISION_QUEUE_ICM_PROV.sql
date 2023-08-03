SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_PRECISION_QUEUE_ICM_PROV]
AS
SELECT  [pk].[CLUSTER_RESOURCE_ID],
        [di].[MODIFIED_DATE],
        [di].[ITEM_URN] AS [QUEUE_ITEM_URN],
        [di].[ITEM_BIZ_URN] AS [QUEUE_BUSINESS_URN],
        [pk].[PKEY_MAP_URN] AS [QUEUE_PKEY_MAP_URN],
        [pk].[CHANGE_STAMP] AS [QUEUE_PKEY_CHANGE_STAMP],
        CASE WHEN [pk].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [pk].[EFFECTIVE_TO] THEN 'P'
             ELSE [pk].[STATUS]
        END AS [QUEUE_STATUS],
        CASE WHEN [pk].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [pk].[EFFECTIVE_TO] THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS [QUEUE_EXPIRED],
        COALESCE([pk].[SOURCE_CHANGE_STAMP], 0) AS [QUEUE_SOURCE_CHANGE_STAMP],
        [di].[DEPARTMENT_BIZ_URN],
        [department].[PKEY1] AS [DEPARTMENT_ID],
        [di].[DESCRIPTION] AS [QUEUE_DESCRIPTION],
        [pk].[INTERNAL_NAME] AS [QUEUE_INTERNAL_NAME],
        [pk].[PKEY1] AS [QUEUE_PKEY1],
        [pk].[PKEY2] AS [QUEUE_PKEY2],
        [pk].[AGENT_ORDERING] AS [QUEUE_AGENT_ORDERING],
        [pk].[CALL_ORDERING] AS [QUEUE_CALL_ORDERING],
        [pk].[SERVICE_LEVEL_THRESHOLD] AS [QUEUE_SERVICE_LEVEL_THRESHOLD],
        [pk].[SERVICE_LEVEL_TYPE] AS [QUEUE_SERVICE_LEVEL_TYPE]
FROM    [dbo].[TB_DIM_PRECISION_QUEUE] [di]
INNER JOIN [dbo].[TB_DIM_PRECISION_QUEUE_PKEY_MAP] [pk] ON [di].[ITEM_BIZ_URN] = [pk].[ITEM_BIZ_URN]
LEFT OUTER JOIN [dbo].[TB_DIM_DEPARTMENT_PKEY_MAP] [department] ON [department].[ITEM_BIZ_URN] = [di].[DEPARTMENT_BIZ_URN]
                                                                   AND [department].[CLUSTER_RESOURCE_ID] = [pk].[CLUSTER_RESOURCE_ID]
                                                                   AND [department].[LATEST] = 1
                                                                   AND [department].[PURGED] = 0
WHERE   (
          EXISTS (
                          -- Any related bucket interval records need provisioning
          SELECT    1
          FROM      [dbo].[TB_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_PKEY_MAP] [mem]
          INNER JOIN [dbo].[TB_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER] [item] ON [item].[MEMBER_BIZ_URN] = [mem].[MEMBER_BIZ_URN]
          WHERE     (
                      (
                        [mem].[STATUS] = 'S'
                        AND ( GETUTCDATE() BETWEEN [mem].[EFFECTIVE_FROM] AND [mem].[EFFECTIVE_TO] )
                      )
                      OR ( [mem].[STATUS] = 'P' )
                      OR (
                           [mem].[STATUS] NOT IN ( 'D', 'E' )
                           AND GETUTCDATE() > [mem].[EFFECTIVE_TO]
                         )
                    )
                    AND [mem].[LATEST] = 1
                    AND [item].[LATEST] = 1
                    AND [di].[ITEM_BIZ_URN] = [item].[CHILD_ITEM_BIZ_URN] )
          OR EXISTS (
                          -- Any related precision queue step records need provisioning
          SELECT    1
          FROM      [dbo].[TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER] [m]
          INNER JOIN [dbo].[TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_PKEY_MAP] AS [p] ON [p].[MEMBER_BIZ_URN] = [m].[MEMBER_BIZ_URN]
          LEFT OUTER JOIN ( SELECT /* Ignore TopOrderBy() Unit Test */TOP 9223372036854775807
                                    [step].[ITEM_BIZ_URN]
                            FROM    [dbo].[TB_DIM_PRECISION_QUEUE_STEP_PKEY_MAP] [step]
                            INNER JOIN [dbo].[TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER] [attr] ON [attr].[CHILD_ITEM_BIZ_URN] = [step].[ITEM_BIZ_URN]
                            INNER JOIN [dbo].[TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP] [attrMem] ON [attrMem].[MEMBER_BIZ_URN] = [attr].[MEMBER_BIZ_URN]
                            WHERE   CASE WHEN [step].[LATEST] = 1
                                         THEN CASE WHEN [step].[STATUS] = 'S'
                                                        AND GETUTCDATE() BETWEEN [step].[EFFECTIVE_FROM] AND [step].[EFFECTIVE_TO] THEN 1
                                                   WHEN [step].[STATUS] = 'P' THEN 1
                                                   WHEN [step].[STATUS] NOT IN ( 'D', 'E' )
                                                        AND GETUTCDATE() > [step].[EFFECTIVE_TO] THEN 1
                                                   ELSE 0
                                              END
                                         ELSE 0
                                    END = 1
                                    OR CASE WHEN [attrMem].[LATEST] = 1
                                                 AND [attr].[LATEST] = 1
                                            THEN CASE WHEN [attrMem].[STATUS] = 'S'
                                                           AND GETUTCDATE() BETWEEN [attrMem].[EFFECTIVE_FROM] AND [attrMem].[EFFECTIVE_TO] THEN 1
                                                      WHEN [attrMem].[STATUS] = 'P' THEN 1
                                                      WHEN [attrMem].[STATUS] NOT IN ( 'D', 'E' )
                                                           AND GETUTCDATE() > [attrMem].[EFFECTIVE_TO] THEN 1
                                                      ELSE 0
                                                 END
                                            ELSE 0
                                       END = 1
                          ) [precisionQueueSteps] ON [m].[CHILD_ITEM_BIZ_URN] = [precisionQueueSteps].[ITEM_BIZ_URN]
          WHERE     [m].[PARENT_ITEM_BIZ_URN] = [di].[ITEM_BIZ_URN]
                    AND (
                          [precisionQueueSteps].[ITEM_BIZ_URN] IS NOT NULL
                          OR CASE WHEN [m].[LATEST] = 1
                                       AND [p].[LATEST] = 1 THEN CASE WHEN [p].[STATUS] = 'S'
                                                                           AND GETUTCDATE() BETWEEN [p].[EFFECTIVE_FROM] AND [p].[EFFECTIVE_TO] THEN 1
                                                                      WHEN [p].[STATUS] = 'P' THEN 1
                                                                      WHEN [p].[STATUS] NOT IN ( 'D', 'E' )
                                                                           AND GETUTCDATE() > [p].[EFFECTIVE_TO] THEN 1
                                                                      ELSE 0
                                                                 END
                                  ELSE 0
                             END = 1
                        ) )
          OR (
               -- The actual PQ needs updating
            (
              (
                [pk].[STATUS] = 'S'
                AND ( GETUTCDATE() BETWEEN [pk].[EFFECTIVE_FROM] AND [pk].[EFFECTIVE_TO] )
              )
              OR ( [pk].[STATUS] = 'P' )
              OR (
                   [pk].[STATUS] NOT IN ( 'D', 'E' )
                   AND GETUTCDATE() > [pk].[EFFECTIVE_TO]
                 )
            )
               AND [di].[LATEST] = 1
               AND [pk].[LATEST] = 1
             )
        )
        AND ( [pk].[STATUS] <> 'E' );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_PRECISION_QUEUE_ICM_PROV]
	TO [portalapp_role]
GO
