SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CASE_STATE_CUBE]
AS
SELECT  CAST(-1 AS SMALLINT) AS CASE_STATE_URN,
        'Unknown' AS [NAME],
        'Unknown State' AS [DESCRIPTION]
UNION
SELECT  CAST(1 AS SMALLINT) AS CASE_STATE_URN,
        'Open' AS [NAME],
        'Open State' AS [DESCRIPTION]
UNION
SELECT  CAST(2 AS SMALLINT) AS CASE_STATE_URN,
        'Closed' AS [NAME],
        'Closed State' AS [DESCRIPTION]
UNION
SELECT  CAST(4 AS SMALLINT) AS CASE_STATE_URN,
        'Reopened' AS [NAME],
        'Reopened State' AS [DESCRIPTION];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CASE_STATE_CUBE]
	TO [portalapp_role]
GO
