SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CALL_ORIGIN_CUBE]
AS
SELECT  [CALL_ORIGIN_URN],
        CAST([CALL_ORIGIN_NAME] AS NVARCHAR(50)) AS [CALL_ORIGIN_NAME],
        CAST([DESCRIPTION] AS NVARCHAR(500)) AS [DESCRIPTION]
FROM    ( VALUES 
        (-1, 'Unknown', 'Unknown'),
        ( 1, 'Inbound Incoming', 'Inbound Incoming'),
        ( 2, 'Inbound Transfer', 'Inbound Transfer'),
        ( 3, 'Inbound Queue Transfer', 'Inbound Queue Transfer'),
        ( 4, 'Inbound Callback', 'Inbound Callback'),
        ( 5, 'Outbound', 'Outbound'),
        ( 6, 'Outbound Transfer', 'Inbound Transfer')) [a] ( [CALL_ORIGIN_URN], [CALL_ORIGIN_NAME], [DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CALL_ORIGIN_CUBE]
	TO [portalapp_role]
GO
