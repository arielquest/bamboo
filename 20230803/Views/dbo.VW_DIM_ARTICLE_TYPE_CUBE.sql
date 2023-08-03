SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_DIM_ARTICLE_TYPE_CUBE
AS
SELECT  CAST([ARTICLE_TYPE_URN] AS SMALLINT) AS [ARTICLE_TYPE_URN],
        [ARTICLE_TYPE_NAME],
        [ARTICLE_TYPE_DESCRIPTION]
FROM    ( VALUES ( -1, 'Unknown', 'Article type not known'),
        ( 1, 'Data Link', 'Data Link'), 
        ( 2, 'General', 'General'), 
        ( 3, 'Guidance', 'Guidance'),
        ( 4, 'Guided Help Session', 'Guided Help Session'), 
        ( 5, 'Suggestion', 'Suggestion'),
        ( 6, 'Topic Home', 'Topic Home'), 
        ( 7, 'Virtual Assistant Action', 'Virtual Assistant Action'),
        ( 8, 'Custom', 'Custom Article Type'),
        ( 9, 'Rich Message', 'Rich Message') ) a ( [ARTICLE_TYPE_URN], [ARTICLE_TYPE_NAME], [ARTICLE_TYPE_DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ARTICLE_TYPE_CUBE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ARTICLE_TYPE_CUBE]
	TO [portal_default_mediator_role]
GO
