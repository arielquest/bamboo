SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_BOOLEAN_VALUE_CUBE]
--WITH ENCRYPTION
AS
SELECT  CAST(0 AS BIT) AS BOOLEAN_VALUE_URN,
        'False' AS BOOLEAN_VALUE_NAME
UNION
SELECT  CAST(1 AS BIT) AS BOOLEAN_VALUE_URN,
        'True' AS BOOLEAN_VALUE_NAME;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_BOOLEAN_VALUE_CUBE]
	TO [portalapp_role]
GO
