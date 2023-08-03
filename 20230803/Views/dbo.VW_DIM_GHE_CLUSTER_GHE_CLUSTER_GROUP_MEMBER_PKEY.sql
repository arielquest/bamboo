SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY]
WITH SCHEMABINDING
AS
    SELECT
        m.[MEMBER_URN],
        m.[MEMBER_BIZ_URN],
        CAST('9c60c5d4-400c-47e2-ad9a-bcda2244b79b' AS UNIQUEIDENTIFIER) AS [MEMBER_TYPE_ID],
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
        pk.[PKEY_1_HASH],
        pk.[SOURCE_CHANGE_STAMP],
        pk.[PURGED],
        pk.[LATEST] AS [PKEY_LATEST],
        pk.[CHANGE_STAMP] AS [PKEY_CHANGE_STAMP],
        pk.[MODIFIED_DATE]
    FROM [dbo].[TB_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER] m
    JOIN [dbo].[TB_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY_MAP] AS pk ON pk.[MEMBER_BIZ_URN] = m.[MEMBER_BIZ_URN];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY]
	TO [portalapp_role]
GO
