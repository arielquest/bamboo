SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CHANNEL]
AS
    SELECT  [a].[ITEM_URN],
            [a].[INTERNAL_NAME]
    FROM    ( VALUES ( -2, 'None'), ( -1, 'Unknown'), ( 1, 'Phone') ) [a] ( [ITEM_URN], [INTERNAL_NAME] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CHANNEL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CHANNEL]
	TO [portal_default_mediator_role]
GO
