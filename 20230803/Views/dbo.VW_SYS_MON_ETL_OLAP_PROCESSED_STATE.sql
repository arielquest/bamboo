SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_SYS_MON_ETL_OLAP_PROCESSED_STATE]
AS
    SELECT  [tidemark].[FACT_PARTITION_ID],
            [partition].[PARTITION_TABLE_NAME],
            [metadata].[NAME] AS [PARTITION_NAME],
            [metadata].[TEMPLATE_TABLE_NAME] AS [PARTITION_TEMPLATE_TABLE],
            [olapPartition].[OLAP_OBJECT_URN],
            [olapObject].[OLAP_OBJECT_NAME],
            [olapPartition].[OLAP_PARTITION_NAME],
            [tidemark].[HIGH_WATER] - ISNULL([olap].[LAST_HIGH_WATER], 0) AS [UNPROCESSED_PARTITION_DATA],
            [tidemark].[HIGH_WATER] AS [RDBMS_HIGH_WATER],
            ISNULL([olap].[LAST_HIGH_WATER], 0) AS [OLAP_HIGH_WATER]
    FROM    ( SELECT    [FACT_PARTITION_ID],
                        MAX([HIGH_WATER_AFTER]) AS [HIGH_WATER]
              FROM      [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
              GROUP BY  [FACT_PARTITION_ID]
            ) [tidemark]
    LEFT OUTER JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] [olap] ON [olap].[FACT_PARTITION_ID] = [tidemark].[FACT_PARTITION_ID]
    INNER JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION] [olapPartition] ON [olapPartition].[OLAP_PARTITION_ID] = [olap].[OLAP_PARTITION_ID]
    INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT] [olapObject] ON [olapObject].[OLAP_OBJECT_URN] = [olapPartition].[OLAP_OBJECT_URN]
    INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] [partition] ON [partition].[FACT_PARTITION_ID] = [tidemark].[FACT_PARTITION_ID]
    INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] [metadata] ON [metadata].[FACT_PARTITION_METADATA_ID] = [partition].[FACT_PARTITION_METADATA_ID];
GO
GRANT SELECT
	ON [dbo].[VW_SYS_MON_ETL_OLAP_PROCESSED_STATE]
	TO [portalapp_role]
GO
