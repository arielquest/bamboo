SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_STATE_CUBE]
AS
SELECT  [AGENT_STATE_URN],
        CAST([AGENT_STATE_NAME] AS NVARCHAR(50)) AS [AGENT_STATE_NAME],
        CAST([DESCRIPTION] AS NVARCHAR(500)) AS [DESCRIPTION]
FROM    ( VALUES 
        (-1, 'Unknown', 'Unknown'),
        ( 1, 'Login', 'Login'),
        ( 2, 'Logout', 'Logout'),
        ( 3, 'Available', 'Available Start'),
        ( 4, 'Unavailable', 'Unavailable Start'),
        ( 5, 'Ring', 'Ring Start'),
        ( 6, 'Talk', 'Talk Start'),
        ( 7, 'Hold', 'Hold Start'),
        ( 8, 'Wrap', 'Wrap Start'),
        ( 9, 'Idle', 'Idle Start')) [a] ( [AGENT_STATE_URN], [AGENT_STATE_NAME], [DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_STATE_CUBE]
	TO [portalapp_role]
GO
