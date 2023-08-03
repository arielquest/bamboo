SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_DIM_COBROWSE_SESSION_INITIATION_TYPE_CUBE
AS
SELECT  CONVERT(TINYINT, [a].[TYPE_URN]) AS [TYPE_URN],
        [a].[NAME],
        [a].[DESCRIPTION]
FROM    ( VALUES ( 0, 'Unknown', 'The session initiation type is not known.'),
        ( 1, 'Agent', 'This is the type where cobrowse sessions are initiated by the agent.'),
        ( 2, 'Customer', 'This is the type where cobrowse sessions are initiated by the customer.') ) a ( [TYPE_URN], [NAME], [DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_COBROWSE_SESSION_INITIATION_TYPE_CUBE]
	TO [portalapp_role]
GO
