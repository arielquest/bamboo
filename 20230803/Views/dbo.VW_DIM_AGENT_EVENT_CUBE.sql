SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_AGENT_EVENT_CUBE]
--WITH ENCRYPTION
AS
SELECT  1 AS AGENT_EVENT_URN,
        'Login Event' AS AGENT_EVENT_NAME,
        'Agent logged in to the Media Routing Domain.' AS DESCRIPTION
UNION
SELECT  2 AS AGENT_EVENT_URN,
        'Logout Event' AS AGENT_EVENT_NAME,
        'Agent logged out of the Media Routing Domain.' AS DESCRIPTION
UNION
SELECT  3 AS AGENT_EVENT_URN,
        'Not Ready Event' AS AGENT_EVENT_NAME,
        'Agent transitioned out of the not ready state.' AS DESCRIPTION;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_EVENT_CUBE]
	TO [portalapp_role]
GO
