SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE     VIEW [dbo].[VW_SEC_USER_ROLES]
AS
SELECT  [a].[POLICY_ID],
        [a].[USER_TYPE],
        [a].[USER_ID],
        [a].[LOGIN_NAME],
        [a].[ROLE_ID],
        [a].[ROLE_NAME],
        [a].[PATH],
        ISNULL([a].[POLICY_ROOT], 0) AS [POLICY_ROOT],
        ISNULL([a].[GLOBAL_POLICY], 0) AS [GLOBAL_POLICY],
        [a].[GROUP_ID],
        [a].[GROUP_NAME],
        [a].[GROUP_FOLDER_ID],
        [a].[ENABLED]
FROM    ( SELECT DISTINCT
                    [pur].[POLICY_ID] AS [POLICY_ID],
                    [u].[USER_TYPE],
                    [u].[USER_ID],
                    [u].[LOGIN_NAME],
                    [r].[ROLE_ID] AS [ROLE_ID],
                    [r].[NAME] AS [ROLE_NAME],
                    [s].[PATH],
                    [s].[POLICY_ROOT],
                    CAST(0 AS BIT) [GLOBAL_POLICY],
                    [g].[USER_ID] AS [GROUP_ID],
                    [g].[LOGIN_NAME] AS [GROUP_NAME],
                    [g].[FOLDER_ID] AS [GROUP_FOLDER_ID],
                    [r].[ENABLED] & [g].[ENABLED] & [u].[ENABLED] AS [ENABLED]
          FROM      [dbo].[TB_SEC_ROLE] [r]
          INNER JOIN [dbo].[TB_SEC_POLICY_USER_ROLE] [pur] ON [pur].[ROLE_ID] = [r].[ROLE_ID]
          INNER JOIN [dbo].[TB_SEC_FOLDER] [s] ON [s].[POLICY_ID] = [pur].[POLICY_ID]
          INNER JOIN [dbo].[TB_SEC_USER] [g] ON [g].[USER_ID] = [pur].[USER_ID]
          LEFT OUTER JOIN [dbo].[TB_SEC_GROUP_MEMBER] [gm] ON [gm].[PARENT_ID] = [g].[USER_ID]
          INNER JOIN [dbo].[TB_SEC_USER] [u] ON [u].[USER_ID] = [gm].[CHILD_ID]
                                                OR [u].[USER_ID] = [pur].[USER_ID]
          WHERE     -- Note: This view will return role mappings to disabled roles, users & groups, by design. 
        -- These roles are not effective however with reguards to security access.
                    [u].[DELETED] = 0
                    AND [g].[DELETED] = 0
                    AND [s].[DELETED] = 0
                    AND [s].[TEMPLATE] = 0

--Global Permissions (NULL folder PATH identifies global)
          UNION
          SELECT DISTINCT
                    [pur].[POLICY_ID],
                    [u].[USER_TYPE],
                    [u].[USER_ID],
                    [u].[LOGIN_NAME],
                    [r].[ROLE_ID] AS [ROLE_ID],
                    [r].[NAME] AS [ROLE_NAME],
                    NULL AS [PATH],
                    CAST(1 AS BIT) AS [POLICY_ROOT],
                    [p].[GLOBAL_POLICY],
                    [g].[USER_ID] AS [GROUP_ID],
                    [g].[LOGIN_NAME] AS [GROUP_NAME],
                    [g].[FOLDER_ID] AS [GROUP_FOLDER_ID],
                    [r].[ENABLED] & [g].[ENABLED] & [u].[ENABLED] AS [ENABLED]
          FROM      [dbo].[TB_SEC_ROLE] [r]
          INNER JOIN [dbo].[TB_SEC_POLICY_USER_ROLE] [pur] ON [pur].[ROLE_ID] = [r].[ROLE_ID]
          INNER JOIN [dbo].[TB_SEC_POLICY] [p] ON [p].[POLICY_ID] = [pur].[POLICY_ID]
          INNER JOIN [dbo].[TB_SEC_USER] [g] ON [g].[USER_ID] = [pur].[USER_ID]
          LEFT OUTER JOIN [dbo].[TB_SEC_GROUP_MEMBER] [gm] ON [gm].[PARENT_ID] = [g].[USER_ID]
          INNER JOIN [dbo].[TB_SEC_USER] [u] ON [u].[USER_ID] = [gm].[CHILD_ID]
                                                OR [u].[USER_ID] = [pur].[USER_ID]
          WHERE     [u].[DELETED] = 0
                    AND [g].[DELETED] = 0
                    AND [p].[GLOBAL_POLICY] = 1
        ) a;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_ROLES]
	TO [portalapp_role]
GO
