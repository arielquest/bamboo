SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PURGE_ACTIVITY_PKEY_ROWS]
AS
    SELECT TOP 100000
            [actPkey].*
    FROM    [dbo].[TB_DIM_ACTIVITY_PKEY_MAP] AS [actPkey]
    WHERE   NOT EXISTS ( SELECT 1
                         FROM   [dbo].[TS_PURGE_ACTIVITY_ROWS] AS [act]
                         WHERE  [act].[URN] = [actPkey].[ITEM_BIZ_URN] )
    ORDER BY [actPkey].[PKEY_MAP_URN];
GO
GRANT DELETE
	ON [dbo].[VW_PURGE_ACTIVITY_PKEY_ROWS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_PURGE_ACTIVITY_PKEY_ROWS]
	TO [portalapp_role]
GO
