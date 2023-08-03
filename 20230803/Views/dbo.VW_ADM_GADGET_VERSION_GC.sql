SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_GADGET_VERSION_GC]
WITH SCHEMABINDING
AS
    SELECT  [datagc].[GUID_KEY] AS [RESOURCE_ID],
            [g].[GADGET_ID],
            [g].[MAJOR_VERSION],
            [g].[MINOR_VERSION],
            [g].[BUILD_VERSION],
            [g].[REVISION_NUMBER],
            [g].[NAME],
            [g].[DESCRIPTION],
            [g].[GADGET_VERSION],
            [g].[FRAMEWORK_VERSION],
            [g].[DEFAULT_WIDTH],
            [g].[DEFAULT_HEIGHT],
            [g].[MIN_WIDTH],
            [g].[MIN_HEIGHT],
            [g].[MAX_WIDTH],
            [g].[MAX_HEIGHT],
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
    LEFT JOIN [dbo].[TB_ADM_GADGET_VERSION] [g] ON [g].[ID] = [datagc].[GUID_KEY]
    WHERE   [tablegc].[TABLE_NAME] = 'TB_ADM_GADGET_VERSION';
GO
GRANT SELECT
	ON [dbo].[VW_ADM_GADGET_VERSION_GC]
	TO [portalapp_role]
GO
