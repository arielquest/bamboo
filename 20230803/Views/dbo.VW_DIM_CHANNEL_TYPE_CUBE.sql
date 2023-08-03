SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CHANNEL_TYPE_CUBE]
AS
SELECT  [CHANNEL_TYPE_URN],
        CAST([CHANNEL_TYPE_NAME] AS NVARCHAR(50)) AS [CHANNEL_TYPE_NAME],
        CAST([CHANNEL_TYPE_DESCRIPTION] AS NVARCHAR(500)) AS [CHANNEL_TYPE_DESCRIPTION]
FROM    ( VALUES ( 1, 'UCCE', 'UCCE'), ( 2, 'eGain Chat', 'eGain - Covers CHATPLUS, application_id 77'),  
        ( 3, 'eGain MailPlus', 'eGain - Covers MAILPLUS , application_id 76'),  
        ( 4, 'eGain Knowledge + AI', 'eGain - Covers KNOWLEDGE + AI, application_id 78') ,  
        ( 5, 'eGain CobrowsePlus', 'eGain - Covers COBROWSEPLUS, application_id 83'), 
        ( 6, 'eGain CallTrackPlus', 'eGain - Covers CALLTRACKPLUS, application_id 82'),  
        ( 7, 'eGain ClickToCall', 'eGain - Covers CLICKTOCALL, application_id 35'),  
        ( 8, 'eGain Content Offers', 'eGain - Covers CONTENT OFFERS, application_id 36'),  
        ( 9, 'eGain Social Monitoring', 'eGain - Covers SOCIAL MONITORING, application_id 31'),
        ( 10, 'eGain Platform', 'eGain - Covers PLATFORM, application_id 6'),
        ( 11, 'eGain Advisor Desktop', 'eGain - Covers ADVISOR DESKTOP, application_id 81'),
        ( 12, 'eGain SelfService + AI', 'eGain - Covers SELF SERVICE + AI, application_id 79'),
        ( 13, 'eGain Hot Leads', 'eGain - Covers HOT LEADS, application_id 37'),
        ( 14, 'eGain Advanced Workflow', 'eGain - Covers ADVANCED WORKFLOW, application_id 10'),
        ( 15, 'eGain Messaging', 'eGain - Covers MESSAGING, application_id 11'),
        ( 16, 'eGain Document Search', 'eGain - Covers DOCUMENT SEARCH, application_id 12'),
        ( 17, 'eGain Cobrowse & ChatPlus', 'eGain - Covers Cobrowse and ChatPlus, application_id 84')
        ) [a] ( [CHANNEL_TYPE_URN], [CHANNEL_TYPE_NAME], [CHANNEL_TYPE_DESCRIPTION] );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CHANNEL_TYPE_CUBE]
	TO [portalapp_role]
GO
