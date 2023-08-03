SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_VA_CHANNEL_CUBE]
AS
SELECT  [VA_CHANNEL_URN],
        CAST([VA_CHANNEL_NAME] AS NVARCHAR(50)) AS [VA_CHANNEL_NAME],
        CAST([DESCRIPTION] AS NVARCHAR(500)) AS [DESCRIPTION]
FROM    ( VALUES 
        (-1, 'Unknown', 'Unknown Channel'),
        ( 1, 'Chat', 'Chat Channel'),
        ( 2, 'Phone', 'Phone Channel'),
        ( 3, 'SMS', 'SMS Channel'),
        ( 4, 'Web', 'Web Channel')) [a] ( [VA_CHANNEL_URN], [VA_CHANNEL_NAME], [DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_VA_CHANNEL_CUBE]
	TO [portalapp_role]
GO
