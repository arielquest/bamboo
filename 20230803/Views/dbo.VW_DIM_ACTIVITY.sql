SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ACTIVITY]
WITH SCHEMABINDING
AS
SELECT  [it].[ITEM_URN],
        [it].[ITEM_BIZ_URN],
        [it].[TENANT_BIZ_URN],
        [tn].[NAME] AS [TENANT_NAME],
        [it].[CASE_BIZ_URN],
        [cs].[NAME] AS [CASE_NAME],
        [it].[ACTIVITY_TYPE_BIZ_URN],
        [it].[ACTIVITY_SUB_TYPE_BIZ_URN],
        [it].[CREATION_DATE],
        [it].[MODIFIED_DATE],
        [it].[EFFECTIVE_FROM],
        [it].[EFFECTIVE_TO],
        [it].[DELETED],
        [it].[LATEST],
        [it].[NAME],
        [it].[CUSTOM_XML_DATA]
FROM    [dbo].[TB_DIM_ACTIVITY] [it]
INNER JOIN [dbo].[TB_DIM_TENANT] [tn] ON [tn].[ITEM_URN] = [it].[TENANT_BIZ_URN]
INNER JOIN [dbo].[TB_DIM_CASE] [cs] ON [cs].[ITEM_URN] = [it].[CASE_BIZ_URN];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ACTIVITY]
	TO [portalapp_role]
GO
