SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CONTACT_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[FOLDER_ID],
        fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [FOLDER_DEPTH],
        fl.[NAME] AS [FOLDER_NAME],
        fl.[FOLDER_URN],
        it.[ITEM_URN],
        it.[OWNER_ID],
        COALESCE(it.[LAST_NAME] + ', ' + it.[FIRST_NAME], it.[FIRST_NAME],
                 it.[LAST_NAME]) AS [NAME],
        it.TITLE,
        it.FIRST_NAME,
        it.LAST_NAME
FROM    [dbo].[TB_DIM_CONTACT] it
JOIN    [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CONTACT_CUBE]
	TO [portalapp_role]
GO
