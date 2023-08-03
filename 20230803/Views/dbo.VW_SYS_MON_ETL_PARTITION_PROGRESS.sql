SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_SYS_MON_ETL_PARTITION_PROGRESS]
AS
    SELECT  [etlProgress].[SERVER],
            [etlProgress].[PARTITION_VIEW],
            [etlProgress].[PROCESSED_ROW_COUNT],
            [etlProgress].[WRITTEN_ROW_COUNT],
            FORMAT(ISNULL(( NULLIF(( [etlProgress].[WRITTEN_ROW_COUNT] * 1.0 ), 0) / NULLIF(( [etlProgress].[PROCESSED_ROW_COUNT] * 1.0 ), 0) ) * 100, 0), 'N2') AS [WRITTEN_PERCENT]
    FROM    ( SELECT    [s].[DEFAULT_ADDRESS] AS [SERVER],
                        [m].[VIEW_NAME] AS [PARTITION_VIEW],
                        SUM(CAST([p].[NEXT_AVAILABLE_IDENTITY] AS BIGINT) - 1) AS [PROCESSED_ROW_COUNT],
                        ISNULL(SUM([pt].[HIGH_WATER_AFTER]), 0) AS [WRITTEN_ROW_COUNT]
              FROM      [dbo].[TB_IMP_FCT_PARTITION] AS [p]
              INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] [m] ON [p].[FACT_PARTITION_METADATA_ID] = [m].[FACT_PARTITION_METADATA_ID]
              INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] AS [ri] ON [ri].[RESOURCE_INSTANCE_ID] = [p].[RESOURCE_INSTANCE_ID]
              INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] AS [comp] ON [ri].[RESOURCE_INSTANCE_ID] = [comp].[RESOURCE_INSTANCE_ID]
              INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [rict] ON [rict].[COMPONENT_TYPE_ID] = [comp].[COMPONENT_TYPE_ID]
                                                                                   AND [rict].[INTERNAL_NAME] = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
              INNER JOIN [dbo].[TB_CLU_SERVER] AS [s] ON [s].[SERVER_ID] = [comp].[SERVER_ID]
              LEFT OUTER JOIN ( SELECT  [FACT_PARTITION_ID],
                                        MAX(CAST([HIGH_WATER_AFTER] AS BIGINT)) AS [HIGH_WATER_AFTER]
                                FROM    [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
                                GROUP BY [FACT_PARTITION_ID]
                              ) AS [pt] ON [p].[FACT_PARTITION_ID] = [pt].[FACT_PARTITION_ID]
              WHERE     [p].[DROP_DATE] IS NULL
              GROUP BY  [s].[DEFAULT_ADDRESS],
                        [m].[VIEW_NAME]
            ) [etlProgress];
GO
GRANT SELECT
	ON [dbo].[VW_SYS_MON_ETL_PARTITION_PROGRESS]
	TO [portalapp_role]
GO
