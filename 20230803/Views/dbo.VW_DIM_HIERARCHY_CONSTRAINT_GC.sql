SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_HIERARCHY_CONSTRAINT_GC]
WITH SCHEMABINDING
AS
SELECT  datagc.[INT_KEY] AS RESOURCE_ID,
        hierarchyConstraint.[HIERARCHY_BUSINESS_URN],
        hierarchyConstraint.[CONSTRAINT_TYPE],
        hierarchyConstraint.[CONSTRAINT_DATA],
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT JOIN [dbo].[TB_DIM_HIERARCHY_CONSTRAINT] hierarchyConstraint ON hierarchyConstraint.HIERARCHY_CONSTRAINT_URN = datagc.INT_KEY
WHERE   tablegc.TABLE_NAME = 'TB_DIM_HIERARCHY_CONSTRAINT';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_HIERARCHY_CONSTRAINT_GC]
	TO [portalapp_role]
GO