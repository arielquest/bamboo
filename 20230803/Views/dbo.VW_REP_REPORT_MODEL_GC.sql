SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_REPORT_MODEL_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        reportModel.[FOLDER_ID] AS CONTAINER_ID,
        reportModel.[NAME],
        reportModel.[CREATED_BY_ID],
        reportModel.[MODIFIED_BY_ID],
        reportModel.[CREATION_DATE],
        reportModel.[MODIFIED_DATE],
        --reportModel.[ARCHIVED],
        reportModel.[DELETED],
        reportModel.[ENABLED],
        reportModel.[HIDDEN],
        reportModel.[SYSTEM],
        reportModel.[REPORT_MODEL],
        reportModel.[TIME_RANGE],
        reportModel.[DISPLAY_NAME_LOOKUP_VALUE],
        reportModel.[DESCRIPTION_LOOKUP_VALUE],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
INNER JOIN [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT OUTER JOIN [dbo].[TB_REP_REPORT_MODEL] reportModel ON reportModel.REPORT_MODEL_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_REPORT_MODEL';
GO
GRANT SELECT
	ON [dbo].[VW_REP_REPORT_MODEL_GC]
	TO [portalapp_role]
GO
