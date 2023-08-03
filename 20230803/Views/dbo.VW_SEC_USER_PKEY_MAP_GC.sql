SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_USER_PKEY_MAP_GC]
AS
SELECT  datagc.[INT_KEY] AS [RESOURCE_ID],
        pkey.[USER_ID] AS [CHILD_RESOURCE_ID],
        pkey.[CLUSTER_RESOURCE_ID] AS [PARENT_RESOURCE_ID],
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID], -- IT_CLUSTER_RESOURCE
        CAST('EEE2E0E2-C672-4f3c-A84F-59800D8565E4' AS UNIQUEIDENTIFIER) AS [CHILD_RESOURCE_TYPE_ID],
        pkey.[STATUS],
        pkey.[CHANGE_STAMP],
        pkey.[PKEY1],
        pkey.[PKEY2],
        pkey.[EFFECTIVE_FROM],
        pkey.[EFFECTIVE_TO],
        pkey.[INTERNAL_NAME],
        pkey.[DESCRIPTION],
        pkey.[ROLE],
        pkey.[MODIFIED_DATE],
        pkey.[MODIFIED_BY_ID],
        pkey.[CREATION_DATE],
        pkey.[CREATED_BY_ID],
        pkey.[PURGED],
        pkey.[SYSTEM],
        pkey.[LATEST],
        pkey.[XML_DATA],
        pkey.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_SEC_USER_PKEY_MAP] pkey ON pkey.PKEY_MAP_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_SEC_USER_PKEY_MAP';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_PKEY_MAP_GC]
	TO [portalapp_role]
GO
