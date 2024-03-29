SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_DIM_KB_ACCESS_TYPE_CUBE
AS
SELECT CAST(1 AS SMALLINT) AS ACCESS_TYPE_URN, 'Knowledge Agent' AS ACCESS_TYPE_NAME, 'Knowledge Agent' AS ACCESS_TYPE_DESCRIPTION  
UNION ALL 
SELECT CAST(2 AS SMALLINT) AS ACCESS_TYPE_URN, 'Self Service' AS ACCESS_TYPE_NAME, 'Self Service' AS ACCESS_TYPE_DESCRIPTION  
UNION ALL  
SELECT CAST(3 AS SMALLINT) AS ACCESS_TYPE_URN, 'Agent Console' AS ACCESS_TYPE_NAME, 'Agent Console' AS ACCESS_TYPE_DESCRIPTION 
UNION ALL
SELECT CAST(4 AS SMALLINT) AS ACCESS_TYPE_URN, 'Crawler' AS ACCESS_TYPE_NAME, 'Crawler' AS ACCESS_TYPE_DESCRIPTION 
UNION ALL
SELECT CAST(5 AS SMALLINT) AS ACCESS_TYPE_URN, 'Self Service VA' AS ACCESS_TYPE_NAME, 'Self Service VA' AS ACCESS_TYPE_DESCRIPTION 
UNION ALL
SELECT CAST(6 AS SMALLINT) AS ACCESS_TYPE_URN, 'Widget' AS ACCESS_TYPE_NAME, 'Widget' AS ACCESS_TYPE_DESCRIPTION 
UNION ALL 
SELECT CAST(7 AS SMALLINT) AS ACCESS_TYPE_URN, 'Secure Message' AS ACCESS_TYPE_NAME, 'Secure Message' AS ACCESS_TYPE_DESCRIPTION 
UNION ALL 
SELECT CAST(8 AS SMALLINT) AS ACCESS_TYPE_URN, 'Enterprise' AS ACCESS_TYPE_NAME, 'Enterprise' AS ACCESS_TYPE_DESCRIPTION
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ACCESS_TYPE_CUBE]
	TO [portalapp_role]
GO
