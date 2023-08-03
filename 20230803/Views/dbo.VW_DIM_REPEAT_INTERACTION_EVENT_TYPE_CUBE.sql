SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_REPEAT_INTERACTION_EVENT_TYPE_CUBE]
AS
SELECT  CAST(1 AS TINYINT) AS EVENT_TYPE_URN,
        'ANI Based' AS [NAME],
        'ANI Based' AS [DESCRIPTION]
UNION
SELECT  CAST(2 AS TINYINT) AS EVENT_TYPE_URN,
        'Contact Based' AS [NAME],
        'Contact Based' AS [DESCRIPTION]
UNION
SELECT  CAST(3 AS TINYINT) AS EVENT_TYPE_URN,
        'ANI and Call Type Based' AS [NAME],
        'ANI and Contact Based' AS [DESCRIPTION]
UNION
SELECT  CAST(4 AS TINYINT) AS EVENT_TYPE_URN,
        'Contact and Call Type Based' AS [NAME],
        'Contact and Call Type Based' AS [DESCRIPTION]
UNION
SELECT  CAST(5 AS TINYINT) AS EVENT_TYPE_URN,
        'ANI and Call Driver Based' AS [NAME],
        'ANI and Call Driver Based' AS [DESCRIPTION]
UNION
SELECT  CAST(6 AS TINYINT) AS EVENT_TYPE_URN,
        'Contact and Call Driver Based' AS [NAME],
        'Contact and Call Driver Based' AS [DESCRIPTION];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_REPEAT_INTERACTION_EVENT_TYPE_CUBE]
	TO [portalapp_role]
GO
