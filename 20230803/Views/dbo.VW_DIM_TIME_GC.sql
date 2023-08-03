SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_TIME_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        dimTime.[FIVE_MINUTE_URN],
        dimTime.[HOUR],
        dimTime.[MINUTE],
        dimTime.[SHIFT],
        dimTime.[NAME],
        dimTime.[INTERNAL_NAME],
        dimTime.[EVENING],
        dimTime.[TIME_VALUE],
        dimTime.[TIME_FORMULA],
        dimTime.[TIME_OPTIONS],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_DIM_TIME] dimTime ON dimTime.TIME_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_DIM_TIME';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_TIME_GC]
	TO [portalapp_role]
GO
