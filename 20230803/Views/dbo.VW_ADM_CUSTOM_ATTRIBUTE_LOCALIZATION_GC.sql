SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_CUSTOM_ATTRIBUTE_LOCALIZATION_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        [gc].[CUSTOM_ATTRIBUTE_LOCALIZATION_URN],
        [gc].[CUSTOM_ATTRIBUTE_URN],
        [cul].CULTURE_NAME,
        [gc].[CULTURE_URN],
        [gc].[LOCALIZED_VALUE],
        [gc].[CREATED_BY_ID],
        [gc].[MODIFIED_BY_ID],
        [gc].[CREATION_DATE],
        [gc].[MODIFIED_DATE],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_ADM_CUSTOM_ATTRIBUTE_LOCALIZATION] gc ON gc.[CUSTOM_ATTRIBUTE_LOCALIZATION_URN] = datagc.[INT_KEY]
LEFT JOIN [dbo].[TE_ADM_CULTURE] cul ON cul.[CULTURE_URN] = gc.[CULTURE_URN]
WHERE   tablegc.TABLE_NAME = 'TB_ADM_CUSTOM_ATTRIBUTE_LOCALIZATION';
GO
GRANT SELECT
	ON [dbo].[VW_ADM_CUSTOM_ATTRIBUTE_LOCALIZATION_GC]
	TO [portalapp_role]
GO
