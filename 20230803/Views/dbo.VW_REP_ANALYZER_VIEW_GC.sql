SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_ANALYZER_VIEW_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        t.[ANALYZER_MODEL_URN],
        t.[FOLDER_ID] AS [CONTAINER_ID],
        t.[NAME],
        t.[DESCRIPTION],
        t.[DELETED],
        t.[DEFAULT_VIEW],
        t.[SYSTEM],
        t.[CREATION_DATE],
        t.[MODIFIED_DATE],
        t.[CREATED_BY_ID],
        t.[MODIFIED_BY_ID],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_REP_ANALYZER_VIEW] t ON t.ANALYZER_VIEW_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_ANALYZER_VIEW';
GO
GRANT SELECT
	ON [dbo].[VW_REP_ANALYZER_VIEW_GC]
	TO [portalapp_role]
GO
