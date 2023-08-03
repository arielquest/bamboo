SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_FOLDER_GC]
AS
    SELECT  [datagc].[GUID_KEY] AS [RESOURCE_ID],
            [folder].[PARENT_ID] AS [CONTAINER_ID],
            [folder].[OWNER_ID],
            [folder].[POLICY_ID],
            [folder].[FOLDER_TYPE],
            [folder].[FOLDER_URN],
            [folder].[POLICY_ROOT],
            [folder].[PATH],
            [folder].[NAME],
            [folder].[DESCRIPTION],
            [folder].[CREATION_DATE],
            [folder].[MODIFIED_DATE],
            [folder].[CREATED_BY_ID],
            [folder].[MODIFIED_BY_ID],
            [folder].[DELETED],
            [folder].[HIDDEN],
            [folder].[SYSTEM],
            [folder].[XML_DATA],
            [datagc].[GENERATION_COUNT],
            [datagc].[CREATE_GENERATION_COUNT],
            [datagc].[LAST_OPERATION]
    FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] [datagc]
    JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] [tablegc] ON [tablegc].[TABLE_GENERATION_COUNT_URN] = [datagc].[TABLE_GENERATION_COUNT_URN]
    LEFT OUTER JOIN [dbo].[TB_SEC_FOLDER] [folder] ON [folder].[FOLDER_ID] = [datagc].[GUID_KEY]
    WHERE   [tablegc].[TABLE_NAME] = 'TB_SEC_FOLDER';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_FOLDER_GC]
	TO [portalapp_role]
GO
