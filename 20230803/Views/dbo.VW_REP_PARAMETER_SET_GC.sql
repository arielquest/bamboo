SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_REP_PARAMETER_SET_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
        parameterset.[LINKED_PARAMETER_SET_ID],
        parameterset.[FOLDER_ID] AS CONTAINER_ID,
        parameterset.[ITEM_TYPE_ID],
        parameterset.[USER_ID],
        parameterset.[NAME],
        parameterset.[PARAMETERS],
        parameterset.[ARCHIVED],
        parameterset.[ENABLED],
        parameterset.[HIDDEN],
        parameterset.[SYSTEM],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_REP_PARAMETER_SET] parameterset ON parameterset.PARAMETER_SET_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'TB_REP_PARAMETER_SET';
GO
GRANT SELECT
	ON [dbo].[VW_REP_PARAMETER_SET_GC]
	TO [portalapp_role]
GO
