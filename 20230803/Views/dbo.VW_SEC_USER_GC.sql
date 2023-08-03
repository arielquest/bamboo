SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_USER_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS [RESOURCE_ID],
        secUser.[FOLDER_ID] AS CONTAINER_ID,
        secUser.[LOGIN_NAME] AS NAME,
        secUser.[DESCRIPTION],
        secUser.[EMAIL],
        secUser.[FIRST_NAME],
        secUser.[LAST_NAME],
        secUser.[PASS_PHRASE_HINT],
        secUser.[LAST_LOGIN],
        secUser.[FAILED_ATTEMPTS],
        secUser.[ACCOUNT_LOCKED],
        secUser.[PASS_PHRASE_EXPIRED],
        secUser.[PASS_PHRASE_NEVER_EXPIRES],
        secUser.[PASS_PHRASE_CHANGE_ENABLED],
        secUser.[LOCAL_LOGIN_ENABLED],
        secUser.[HOME_FOLDER_ID] AS [HOME_FOLDER_ID],
        secUser.[EFFECTIVE_FROM],
        secUser.[EFFECTIVE_TO],
        secUser.[CREATED_BY] AS CREATED_BY_ID,
        secUser.[CREATED_DATE] AS CREATION_DATE,
        secUser.[LAST_MODIFIED_BY] AS MODIFIED_BY_ID,
        secUser.[LAST_MODIFIED_DATE] AS MODIFIED_DATE,
        secUser.[EXPERT],
        secUser.[ARCHIVED],
        secUser.[TENANT_BIZ_URN],
        secUser.[DELETED],
        secUser.[ENABLED],
        secUser.[HIDDEN],
        secUser.[SYSTEM],
        secUser.[XML_DATA],
        secUser.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
INNER JOIN [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT OUTER JOIN [dbo].[TB_SEC_USER] secUser ON secUser.USER_ID = datagc.GUID_KEY
                                               AND secUser.USER_TYPE = 'U'
WHERE   tablegc.TABLE_NAME = 'TB_SEC_USER';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_GC]
	TO [portalapp_role]
GO
