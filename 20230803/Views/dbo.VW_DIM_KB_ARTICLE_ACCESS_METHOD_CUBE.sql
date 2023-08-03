SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_DIM_KB_ARTICLE_ACCESS_METHOD_CUBE
AS
SELECT  CAST([ACCESS_METHOD_URN] AS SMALLINT) AS [ACCESS_METHOD_URN],
        [ACCESS_METHOD_NAME],
        [ACCESS_METHOD_DESCRIPTION],
        [MAPPED_ENTRY_TYPES]
FROM    ( VALUES ( -1, 'Unknown', 'Access method not known', NULL),
        ( 1, 'Direct', NULL, '1'), ( 2, 'Search', NULL,'7,9,101,102'), ( 3, 'Guided Help', NULL,'29,30,103'),
        ( 4, 'Topic', NULL,'104'), ( 5, 'Topic Tree', NULL,'105'),
        ( 6, 'Popular Article', NULL,'106'), ( 7, 'Lists', NULL,'107'),
        ( 8, 'Suggested', NULL,'108'), ( 9, 'Calltrack', NULL,'109'),
        ( 10, 'Related Articles', NULL,'52'), ( 11, 'Widget', NULL,'115'),
        ( 12, 'Multisearch', NULL,'60'), ( 13, 'Announcement', NULL,'121'),
        ( 14, 'Bookmarks', NULL,'205'), ( 15, 'Offers', NULL,NULL), ( 16, 'Guided Help Info', NULL,'206'), ( 17, 'Subscription', NULL,'214,215') ) a ( [ACCESS_METHOD_URN], [ACCESS_METHOD_NAME], [ACCESS_METHOD_DESCRIPTION],[MAPPED_ENTRY_TYPES] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ARTICLE_ACCESS_METHOD_CUBE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_DIM_KB_ARTICLE_ACCESS_METHOD_CUBE]
	TO [portal_default_mediator_role]
GO
