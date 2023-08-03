SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_SEC_USER_PKEY
WITH SCHEMABINDING
AS
SELECT  u.[USER_ID],
        u.[FOLDER_ID],
        u.[USER_TYPE],
        u.[LOGIN_NAME],
        u.[PASS_PHRASE],
        u.[DESCRIPTION] AS [BASE_DESCRIPTION],
        u.[EMAIL],
        u.[FIRST_NAME],
        u.[LAST_NAME],
        u.[PASS_PHRASE_HINT],
        u.[HOME_FOLDER_ID],
        u.[DEFAULT_GADGET_SET_ID],
        u.[LAST_LOGIN],
        u.[FAILED_ATTEMPTS],
        u.[ACCOUNT_LOCKED],
        u.[PASS_PHRASE_EXPIRED],
        u.[PASS_PHRASE_NEVER_EXPIRES],
        u.[PASS_PHRASE_CHANGE_ENABLED],
        u.[LOCAL_LOGIN_ENABLED],
        u.[TENANT_BIZ_URN],
        u.[EFFECTIVE_FROM],
        u.[EFFECTIVE_TO],
        u.[DELETED],
        u.[ENABLED],
        u.[HIDDEN],
        u.[SYSTEM],
        pk.[PKEY_MAP_URN],
        pk.[PKEY_MAP_BIZ_URN],
        pk.[CLUSTER_RESOURCE_ID],
        pk.[STATUS],
        pk.[PKEY1],
        pk.[PKEY2],
        pk.[SOURCE_CHANGE_STAMP],
        pk.[INTERNAL_NAME],
        pk.[DESCRIPTION] AS [PKEY_DESCRIPTION],
        pk.[ROLE],
        pk.[EFFECTIVE_FROM] AS [PKEY_EFFECTIVE_FROM],
        pk.[EFFECTIVE_TO] AS [PKEY_EFFECTIVE_TO],
        pk.[PURGED],
        pk.[LATEST] AS [PKEY_LATEST],
        pk.[CHANGE_STAMP] AS [PKEY_CHANGE_STAMP],
        pk.[MODIFIED_DATE]
FROM    [dbo].[TB_SEC_USER] u
JOIN    [dbo].[TB_SEC_USER_PKEY_MAP] pk ON u.USER_ID = pk.USER_ID;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_PKEY]
	TO [portalapp_role]
GO
