SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_MAP_FACT_COLUMN_MAPPING]
--WITH ENCRYPTION
AS
SELECT  'ORIGINATING_AGENT_URN' AS [FACT_COLUMN_NAME],
        'AGENT_URN' AS [MAPPING_DIMENSION_COLUMN]
UNION
SELECT  'SUPERVISOR_AGENT_URN' AS [FACT_COLUMN_NAME],
        'AGENT_URN' AS [MAPPING_DIMENSION_COLUMN];
GO
GRANT SELECT
	ON [dbo].[VW_MAP_FACT_COLUMN_MAPPING]
	TO [portalapp_role]
GO
