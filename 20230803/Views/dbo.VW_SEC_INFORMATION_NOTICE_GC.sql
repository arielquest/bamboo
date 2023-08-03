SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_INFORMATION_NOTICE_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        infoNotice.[FOLDER_ID] AS CONTAINER_ID,
        infoNotice.[SUBJECT] AS NAME,
        infoNotice.[CONTENT],
        infoNotice.[EFFECTIVE_FROM],
        infoNotice.[EFFECTIVE_TO],
        infoNotice.[CREATION_DATE],
        infoNotice.[MODIFIED_DATE],
        infoNotice.[CREATED_BY_ID],
        infoNotice.[MODIFIED_BY_ID],
        infoNotice.[DELETED],
        infoNotice.[ENABLED],
        infoNotice.[SYSTEM],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_SEC_INFORMATION_NOTICE] infoNotice ON infoNotice.INFORMATION_NOTICE_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_SEC_INFORMATION_NOTICE';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_INFORMATION_NOTICE_GC]
	TO [portalapp_role]
GO
