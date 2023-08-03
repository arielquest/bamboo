SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_GC]
AS
    SELECT 
        datagc.[MEMBER_URN] AS [RESOURCE_ID], 
        member.[MEMBER_BIZ_URN],
        member.[PARENT_ITEM_BIZ_URN] AS [PARENT_RESOURCE_ID],
        member.[CHILD_ITEM_BIZ_URN] AS [CHILD_RESOURCE_ID],
        CAST('00003200-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [PARENT_RESOURCE_TYPE_ID],
        CAST('00005400-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [CHILD_RESOURCE_TYPE_ID],
        member.[EFFECTIVE_FROM],
        member.[EFFECTIVE_TO],        
        member.[MODIFIED_DATE],
        member.[MODIFIED_BY_ID],
        member.[CREATION_DATE],
        member.[CREATED_BY_ID],
        member.[DELETED],
        member.[HIDDEN],
        member.[SYSTEM],
        member.[LATEST],
        member.[CHANGE_STAMP],
        member.[XML_DATA],
        member.[CUSTOM_XML_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
        
    FROM [dbo].[TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_GC] datagc 
    
    LEFT JOIN [dbo].[TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER] member
    ON member.MEMBER_URN = datagc.MEMBER_URN

    WHERE datagc.[MEMBER_URN] > 0;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_GC]
	TO [portalapp_role]
GO
