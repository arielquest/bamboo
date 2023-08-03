SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_CUSTOM_ATTRIBUTE0_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[ITEM_URN] AS [CUSTOM_URN],
        it.[ITEM_BIZ_URN] AS [CUSTOM_PARENT_URN],
        CAST('460A7F59-F897-4D3B-BDF3-53ED8662CEAB' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        it.[ITEM_SUBTYPE_ID],
        it.[OWNER_ID],
        it.[FOLDER_ID] AS [CUSTOM_FOLDER_ID],
        fl.[FOLDER_URN] AS [CUSTOM_FOLDER_URN],
        fl.[PARENT_ID] AS [CUSTOM_FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [CUSTOM_FOLDER_DEPTH],
        fl.[NAME] AS [CUSTOM_FOLDER_NAME],
        it.[NAME] AS [CUSTOM_NAME],
        COALESCE(NULLIF(RTRIM(LTRIM(pk.[INTERNAL_NAME])), ''), LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(pk.[PKEY1], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''))), 'Not Known') COLLATE Latin1_General_100_CI_AS_SC AS [CUSTOM_INTERNAL_NAME],
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [CUSTOM_DESCRIPTION],
        it.[EFFECTIVE_FROM],
        it.[EFFECTIVE_TO],
        it.[HIERARCHY_PARENT_URN],
        it.[TIME_ZONE_URN],
        it.[SKIP_LEVEL],
        it.[DELETED],
        it.[HIDDEN],
        it.[SYSTEM],
        it.[LATEST],
        it.[CHANGE_STAMP]
FROM    [dbo].[TB_DIM_CUSTOM_ATTRIBUTE0] it
JOIN    [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
LEFT JOIN [dbo].[TB_DIM_CUSTOM_ATTRIBUTE0_PKEY_MAP] pk ON it.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN]
                                                AND pk.[LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_CUSTOM_ATTRIBUTE0_CUBE]
	TO [portalapp_role]
GO
