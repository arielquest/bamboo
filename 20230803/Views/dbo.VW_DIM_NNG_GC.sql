SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_NNG_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        dimNng.[PARENT_URN],
        dimNng.[SKIP_LEVEL],
        dimNng.[MEMBER] AS INTERNAL_NAME,
        dimNng.[MEMBER_LENGTH],
        dimNng.[DESCRIPTION],
        dimNng.[FIELD1],
        dimNng.[FIELD2],
        dimNng.[FIELD3],
        dimNng.[EFFECTIVE_FROM],
        dimNng.[EFFECTIVE_TO],
        dimNng.[CREATED_BY_ID],
        dimNng.[MODIFIED_BY_ID],
        dimNng.[CREATION_DATE],
        dimNng.[MODIFIED_DATE],
        dimNng.[ARCHIVED],
        dimNng.[DELETED],
        dimNng.[ENABLED],
        dimNng.[EXPORT],
        dimNng.[HIDDEN],
        dimNng.[LATEST],
        dimNng.[SYSTEM],
        dimNng.[LENGTH],
        dimNng.[OSGRID],
        dimNng.[LAT_LONG],
        dimNng.[REGION],
        dimNng.[TIMEZONE_OFFSET],
        dimNng.[DAYLIGHT_SAVINGS],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_DIM_NNG] dimNng ON dimNng.NNG_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_DIM_NNG';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NNG_GC]
	TO [portalapp_role]
GO
