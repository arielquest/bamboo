SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_VA_SESSION_LABEL_CUBE]
AS
SELECT  [VA_SESSION_LABEL_URN],
        CAST([VA_SESSION_LABEL_NAME] AS NVARCHAR(50)) AS [VA_SESSION_LABEL_NAME],
        CAST([DESCRIPTION] AS NVARCHAR(500)) AS [DESCRIPTION]
FROM    ( VALUES 
        (-1, 'Unknown', 'Unknown'),
        ( 1, 'Bankers Bot', 'Bankers Bot'),
        ( 2, 'Sales App Wizard', 'Sales App Wizard'),
        ( 3, 'Virtual Assistant', 'Virtual Assistant')) [a] ( [VA_SESSION_LABEL_URN], [VA_SESSION_LABEL_NAME], [DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_VA_SESSION_LABEL_CUBE]
	TO [portalapp_role]
GO
