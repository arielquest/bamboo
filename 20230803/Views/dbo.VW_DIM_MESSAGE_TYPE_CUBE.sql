SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_MESSAGE_TYPE_CUBE]  
AS  
SELECT  CAST([MESSAGE_TYPE_URN] AS INT) AS [MESSAGE_TYPE_URN],  
        CAST([MESSAGE_TYPE_NAME] AS NVARCHAR(50)) AS [MESSAGE_TYPE_NAME],  
        CAST([MESSAGE_TYPE_DESCRIPTION] AS NVARCHAR(500)) AS [MESSAGE_TYPE_DESCRIPTION]  
FROM    ( VALUES ( -1, 'Unknown', 'Unknown'), ( 1, 'Incoming', 'Incoming'),    
        ( 2, 'Compose', 'Compose'),    
        ( 3, 'Temporary Undeliverable', 'Temporary Undeliverable') ,    
        ( 4, 'Permanent Undeliverable', 'Permanent Undeliverable'),   
        ( 5, 'Secure', 'Secure'),    
        ( 6, 'Secure Compose', 'Secure Compose'),    
        ( 7, 'Webform', 'Webform')
        ) [a] ( [MESSAGE_TYPE_URN], [MESSAGE_TYPE_NAME], [MESSAGE_TYPE_DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_MESSAGE_TYPE_CUBE]
	TO [portalapp_role]
GO
