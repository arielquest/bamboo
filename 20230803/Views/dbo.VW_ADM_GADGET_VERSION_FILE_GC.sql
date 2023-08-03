SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_GADGET_VERSION_FILE_GC]
WITH SCHEMABINDING
AS
    SELECT  [datagc].[GUID_KEY] AS [RESOURCE_ID],
            [g].[GADGET_VERSION_ID],
            [g].[NAME],
            [g].[USAGE_TYPE],
            [g].[RELATIVE_PATH],
            [g].[FILE_DATA],
            [g].[CHANGE_STAMP],
            [g].[CREATION_DATE],
            [g].[MODIFIED_DATE],
            [g].[CREATED_BY_ID],
            [g].[MODIFIED_BY_ID],
            [datagc].[GENERATION_COUNT],
            [datagc].[CREATE_GENERATION_COUNT],
            [datagc].[LAST_OPERATION]
    FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] [datagc]
    JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] [tablegc] ON [tablegc].[TABLE_GENERATION_COUNT_URN] = [datagc].[TABLE_GENERATION_COUNT_URN]
    LEFT JOIN [dbo].[TB_ADM_GADGET_VERSION_FILE] [g] ON [g].[ID] = [datagc].[GUID_KEY]
    WHERE   [tablegc].[TABLE_NAME] = 'TB_ADM_GADGET_VERSION_FILE';
GO
GRANT SELECT
	ON [dbo].[VW_ADM_GADGET_VERSION_FILE_GC]
	TO [portalapp_role]
GO
