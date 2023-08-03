SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CHANNEL_ADDRESS_CUBE]
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
        it.ADDRESS,
        cat.INTERNAL_NAME AS CHANNEL_TYPE,
        cat.CHANNEL_TYPE_ID AS CHANNEL_TYPE_ID
FROM    [dbo].[TB_DIM_CHANNEL_ADDRESS] it
INNER JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
LEFT OUTER JOIN dbo.TE_DIM_CHANNEL_ADDRESS_TYPE AS cat ON cat.CHANNEL_TYPE_ID = it.CHANNEL_ADDRESS_TYPE_ID;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CHANNEL_ADDRESS_CUBE]
	TO [portalapp_role]
GO
