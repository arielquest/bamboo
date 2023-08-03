SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PURGE_ACTIVITY_ROWS]
AS
    SELECT TOP 100000
            [act].*
    FROM    [dbo].[TB_DIM_ACTIVITY] AS [act]
    WHERE   NOT EXISTS ( SELECT 1
                         FROM   [dbo].[TS_PURGE_ACTIVITY_ROWS] AS [ts]
                         WHERE  [ts].[URN] = [act].[ITEM_BIZ_URN] )
    ORDER BY [act].[ITEM_URN];
GO
GRANT DELETE
	ON [dbo].[VW_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
