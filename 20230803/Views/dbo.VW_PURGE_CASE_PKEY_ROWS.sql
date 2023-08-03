SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PURGE_CASE_PKEY_ROWS]
AS
    SELECT TOP 100000
            [casePkey].*
    FROM    [dbo].[TB_DIM_CASE_PKEY_MAP] AS [casePkey]
    WHERE   NOT EXISTS ( SELECT 1
                         FROM   [dbo].[TS_PURGE_CASE_ROWS] AS [act]
                         WHERE  [act].[URN] = [casePkey].[ITEM_BIZ_URN] )
    ORDER BY [casePkey].[PKEY_MAP_URN];
GO
GRANT DELETE
	ON [dbo].[VW_PURGE_CASE_PKEY_ROWS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_PURGE_CASE_PKEY_ROWS]
	TO [portalapp_role]
GO
