SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CUSTOMER_CUBE]
WITH SCHEMABINDING
AS

    SELECT  -1 AS [ITEM_URN],
            'Unknown' AS [NAME],
            '' AS [EGAIN_CUSTOMER_ID]
    UNION ALL
    SELECT  -2 AS [ITEM_URN],
            'None' AS [NAME],
            '' AS [EGAIN_CUSTOMER_ID]
    UNION ALL
    SELECT  [it].[ITEM_URN],
            [it].[NAME],
            -1  AS [EGAIN_CUSTOMER_ID]
    FROM    [dbo].[TB_DIM_CUSTOMER] AS [it]
    
;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CUSTOMER_CUBE]
	TO [portalapp_role]
GO
