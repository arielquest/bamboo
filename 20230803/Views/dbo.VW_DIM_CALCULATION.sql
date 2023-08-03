SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_CALCULATION]
--WITH ENCRYPTION
AS
SELECT  1 AS [CALCULATION_URN],
        'None' AS [Calculation];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALCULATION]
	TO [portalapp_role]
GO
