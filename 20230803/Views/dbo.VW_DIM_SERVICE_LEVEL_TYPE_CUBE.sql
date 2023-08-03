SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_SERVICE_LEVEL_TYPE_CUBE]
--WITH ENCRYPTION
AS
SELECT  -1 AS SERVICE_LEVEL_TYPE_URN,
        'Unknown' AS SERVICE_LEVEL_TYPE_NAME,
        'Unknown Service Level Type.' AS DESCRIPTION
UNION
SELECT  0 AS SERVICE_LEVEL_TYPE_URN,
        '0 (Default)' AS SERVICE_LEVEL_TYPE_NAME,
        'Use default value from Peripheral record.' AS DESCRIPTION
UNION
SELECT  1 AS SERVICE_LEVEL_TYPE_URN,
        '1 (Ignore Aban)' AS SERVICE_LEVEL_TYPE_NAME,
        'Remove the abandoned calls from the calculation' AS DESCRIPTION
UNION
SELECT  2 AS SERVICE_LEVEL_TYPE_URN,
        '2 (Aban -ve)' AS SERVICE_LEVEL_TYPE_NAME,
        'Treat abandoned calls as though they exceeded the service level threshold.' AS DESCRIPTION
UNION
SELECT  3 AS SERVICE_LEVEL_TYPE_URN,
        '3 (Aban +ve)' AS SERVICE_LEVEL_TYPE_NAME,
        'Treat abandoned calls as though they were answered within the service level threshold.' AS DESCRIPTION;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_SERVICE_LEVEL_TYPE_CUBE]
	TO [portalapp_role]
GO
