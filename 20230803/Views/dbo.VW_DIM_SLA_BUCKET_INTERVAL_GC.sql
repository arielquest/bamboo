SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_SLA_BUCKET_INTERVAL_GC]
AS
    SELECT 
        datagc.[ITEM_URN] AS [RESOURCE_ID], 
        item.[ITEM_BIZ_URN],
        item.[TIME_ZONE_URN],
        item.[TENANT_BIZ_URN],
        item.[HIERARCHY_PARENT_URN],
        item.[FOLDER_ID] AS CONTAINER_ID,
        item.[OWNER_ID],    
        item.[ITEM_SUBTYPE_ID],
        item.[NAME],
        item.[DESCRIPTION],
        item.[EFFECTIVE_FROM],
        item.[EFFECTIVE_TO],        
        item.[ACTIVITY_TYPE_CODE_BIZ_URN],
        item.[INTERVAL_UPPER_BOUND_1],
        item.[INTERVAL_UPPER_BOUND_2],
        item.[INTERVAL_UPPER_BOUND_3],
        item.[INTERVAL_UPPER_BOUND_4],
        item.[INTERVAL_UPPER_BOUND_5],
        item.[INTERVAL_UPPER_BOUND_6],
        item.[INTERVAL_UPPER_BOUND_7],
        item.[INTERVAL_UPPER_BOUND_8],
        item.[INTERVAL_UPPER_BOUND_9],
        item.[MODIFIED_DATE],
        item.[MODIFIED_BY_ID],
        item.[CREATION_DATE],
        item.[CREATED_BY_ID],
        item.[DELETED],
        item.[HIDDEN],
        item.[SYSTEM],
        item.[LATEST],
        item.[CHANGE_STAMP],
        item.[XML_DATA],
        item.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
        
    FROM [dbo].[TS_DIM_SLA_BUCKET_INTERVAL_GC] datagc 
        
    LEFT JOIN [dbo].[TB_DIM_SLA_BUCKET_INTERVAL] item
    ON item.ITEM_URN = datagc.ITEM_URN

    WHERE datagc.[ITEM_URN] > 0;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SLA_BUCKET_INTERVAL_GC]
	TO [portalapp_role]
GO
