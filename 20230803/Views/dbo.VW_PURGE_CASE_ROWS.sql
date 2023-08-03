SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PURGE_CASE_ROWS]
AS
    SELECT TOP 100000
            [case].*
    FROM    [dbo].[TB_DIM_CASE] AS [case]
    WHERE   NOT EXISTS ( SELECT 1
                         FROM   [dbo].[TS_PURGE_CASE_ROWS] AS [ts]
                         WHERE  [ts].[URN] = [case].[ITEM_BIZ_URN] )
    ORDER BY [case].[ITEM_URN];
GO
GRANT DELETE
	ON [dbo].[VW_PURGE_CASE_ROWS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_PURGE_CASE_ROWS]
	TO [portalapp_role]
GO
