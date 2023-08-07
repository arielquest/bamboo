SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_KB_FOLDER_PKEY_MAP_GC]
AS
   SELECT 
        datagc.[PKEY_MAP_URN] AS [RESOURCE_ID],
        pkey.[ITEM_BIZ_URN] AS [CHILD_RESOURCE_ID],
        pkey.[CLUSTER_RESOURCE_ID] AS [PARENT_RESOURCE_ID],
        CAST('0BD86837-0E52-4116-B8FD-857F6BE3CBD6' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID], -- IT_CLUSTER_RESOURCE
        CAST('1efc44cf-d313-4bf5-9be7-a4a893d68d2c' AS UNIQUEIDENTIFIER) AS [CHILD_RESOURCE_TYPE_ID],
        pkey.[STATUS],
        pkey.[CHANGE_STAMP],
        pkey.[PKEY1],
        pkey.[PKEY2],
        pkey.[EFFECTIVE_FROM],
        pkey.[EFFECTIVE_TO],
        pkey.[INTERNAL_NAME],
        pkey.[DESCRIPTION],
        
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

    FROM [dbo].[TS_DIM_KB_FOLDER_PKEY_MAP_GC] datagc
    
    LEFT JOIN [dbo].[TB_DIM_KB_FOLDER_PKEY_MAP] pkey
    ON pkey.PKEY_MAP_URN = datagc.PKEY_MAP_URN;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_FOLDER_PKEY_MAP_GC]
	TO [portalapp_role]
GO