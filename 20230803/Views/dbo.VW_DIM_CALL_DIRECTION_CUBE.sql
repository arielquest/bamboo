SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CALL_DIRECTION_CUBE]
AS
SELECT  [CALL_DIRECTION_URN],
        CAST([CALL_DIRECTION_NAME] AS NVARCHAR(50)) AS [CALL_DIRECTION_NAME],
        CAST([DESCRIPTION] AS NVARCHAR(500)) AS [DESCRIPTION]
FROM    ( VALUES 
        (-1, 'Unknown', 'Unknown'),
        ( 1, 'Inbound', 'Inbound Calls'),
        ( 2, 'Outbound', 'Outbound Calls')) [a] ( [CALL_DIRECTION_URN], [CALL_DIRECTION_NAME], [DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALL_DIRECTION_CUBE]
	TO [portalapp_role]
GO