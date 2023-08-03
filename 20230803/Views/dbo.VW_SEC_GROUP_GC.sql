SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_GROUP_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS [RESOURCE_ID],
        secGroup.[FOLDER_ID] AS CONTAINER_ID,
        secGroup.[LOGIN_NAME] AS NAME,
        secGroup.[DESCRIPTION],
        secGroup.[EMAIL],
        secGroup.[EFFECTIVE_FROM],
        secGroup.[EFFECTIVE_TO],
        secGroup.[CREATED_BY] AS CREATED_BY_ID,
        secGroup.[CREATED_DATE] AS CREATION_DATE,
        secGroup.[LAST_MODIFIED_BY] AS MODIFIED_BY_ID,
        secGroup.[LAST_MODIFIED_DATE] AS MODIFIED_DATE,
        secGroup.[EXPERT],
        secGroup.[ARCHIVED],
        secGroup.[DELETED],
        secGroup.[ENABLED],
        secGroup.[HIDDEN],
        secGroup.[SYSTEM],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_SEC_USER] secGroup ON secGroup.USER_ID = datagc.GUID_KEY
                                          AND secGroup.USER_TYPE = 'G'
WHERE   tablegc.TABLE_NAME = 'TB_SEC_GROUP';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_GROUP_GC]
	TO [portalapp_role]
GO
