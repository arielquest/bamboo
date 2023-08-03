SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_FLEXIBLE_DIMENSION_3_CUBE]
--WITH ENCRYPTION
AS
SELECT  -1 AS [FLEXIBLE_DIMENSION_URN],
        CAST('None' AS VARCHAR(100)) AS [FLEXIBLE_DIMENSION_NAME];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_FLEXIBLE_DIMENSION_3_CUBE]
	TO [portalapp_role]
GO
