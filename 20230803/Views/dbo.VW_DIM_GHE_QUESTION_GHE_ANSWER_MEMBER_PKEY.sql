SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY]
WITH SCHEMABINDING
AS
    SELECT
        m.[MEMBER_URN],
        m.[MEMBER_BIZ_URN],
        CAST('645ac84a-d580-4c9c-ad36-3ec15a86e82c' AS UNIQUEIDENTIFIER) AS [MEMBER_TYPE_ID],
        m.[PARENT_ITEM_BIZ_URN],
        m.[CHILD_ITEM_BIZ_URN],
        m.[EFFECTIVE_FROM],
        m.[EFFECTIVE_TO],
        pk.[EFFECTIVE_FROM] AS [PKEY_EFFECTIVE_FROM],
        pk.[EFFECTIVE_TO] AS [PKEY_EFFECTIVE_TO],
        m.[DELETED],
        m.[HIDDEN],
        m.[SYSTEM],
        m.[LATEST],
        m.[CHANGE_STAMP] AS [BASE_CHANGE_STAMP],
        pk.[PKEY_MAP_URN],
        pk.[CLUSTER_RESOURCE_ID],
        pk.[STATUS],
        pk.[PKEY1],
        pk.[PKEY2],
        pk.[SOURCE_CHANGE_STAMP],
        pk.[PURGED],
        pk.[LATEST] AS [PKEY_LATEST],
        pk.[CHANGE_STAMP] AS [PKEY_CHANGE_STAMP],
        pk.[MODIFIED_DATE]
    FROM [dbo].[TB_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER] m
    JOIN [dbo].[TB_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY_MAP] AS pk ON pk.[MEMBER_BIZ_URN] = m.[MEMBER_BIZ_URN];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY]
	TO [portalapp_role]
GO
