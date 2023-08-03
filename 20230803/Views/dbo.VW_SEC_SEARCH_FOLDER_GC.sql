SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_SEARCH_FOLDER_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        folder.[PARENT_FOLDER_ID] AS CONTAINER_ID,
        folder.[NAME],
        folder.[DESCRIPTION],
        folder.[SEARCH_QUERY],
        folder.[SYSTEM],
        folder.[CREATED_BY_ID],
        folder.[MODIFIED_BY_ID],
        folder.[CREATION_DATE],
        folder.[MODIFIED_DATE],
        folder.[GLOBAL],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_SEC_SEARCH_FOLDER] folder ON folder.SEARCH_FOLDER_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_SEC_SEARCH_FOLDER';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_SEARCH_FOLDER_GC]
	TO [portalapp_role]
GO
