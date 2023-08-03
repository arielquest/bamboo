SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_SYS_MON_DATA_IMPORT_STATUS]
AS
SELECT  [cs].[SERVER_NAME] AS [SERVER_NAME],
        [cri].[RESOURCE_INSTANCE_ID],
        [cri].[NAME] AS [RESOURCE_INSTANCE_NAME],
        [cri].[XML_DATA].[value](N'(/Columns/Column[@Name="LAST_IMPORT_END"]/text())[1]', N'datetime') AS [LAST_IMPORT_END],
        [cri].[XML_DATA].[value](N'(/Columns/Column[@Name="LAST_IMPORT_START"]/text())[1]', N'datetime') AS [LAST_IMPORT_START],
        [cri].[XML_DATA].[value](N'(/Columns/Column[@Name="LAST_IMPORT_TYPE"]/text())[1]', N'nvarchar(max)') AS [LAST_IMPORT_TYPE],
        [cri].[XML_DATA].[value](N'(/Columns/Column[@Name="LAST_IMPORT_EXCEPTION_COUNT"]/text())[1]', N'int') AS [LAST_IMPORT_EXCEPTION_COUNT]
FROM    [dbo].[TB_CLU_RESOURCE_INSTANCE] AS [cri]
INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] AS [cric] ON [cric].[RESOURCE_INSTANCE_ID] = [cri].[RESOURCE_INSTANCE_ID]
INNER JOIN [dbo].[TB_CLU_SERVER] AS [cs] ON [cs].[SERVER_ID] = [cric].[SERVER_ID]
INNER JOIN [dbo].[TB_CLU_RESOURCE] AS [cr] ON [cr].[RESOURCE_ID] = [cri].[RESOURCE_ID]
INNER JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] AS [crt] ON [crt].[CLUSTER_RESOURCE_TYPE_ID] = [cr].[RESOURCE_TYPE_ID]
WHERE   [crt].[INTERNAL_NAME] = 'CRT_EXONY_DATA_IMPORT_SERVER'
        AND [cri].[IS_PUBLISHER] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_SYS_MON_DATA_IMPORT_STATUS]
	TO [portalapp_role]
GO
