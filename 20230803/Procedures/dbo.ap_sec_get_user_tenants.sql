SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Gets all tenants that contain at least 1 older that the specified user can perform the specified operation on
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_sec_get_user_tenants]
    (
      @UserId UNIQUEIDENTIFIER,
      @IncludeHiddenFolders BIT = 1,
      @TaskCode BIGINT 
    )
AS
    BEGIN 
        SET NOCOUNT ON;

        IF OBJECT_ID('tempdb..#usersGroups') IS NOT NULL
        BEGIN
            DROP TABLE [#usersGroups];
        END;

        SELECT DISTINCT
                [a].[USER_ID],
                [a].[USER_OR_GROUP_ID]
        INTO    [#usersGroups]
        FROM    ( SELECT    [u].[USER_ID],
                            [u].[USER_ID] AS [USER_OR_GROUP_ID]
                  FROM      [dbo].[TB_SEC_USER] [u]
                  WHERE     [u].[USER_TYPE] = 'U'
                            AND [u].[DELETED] = 0
                            AND [u].[ENABLED] = 1
                  UNION
                  SELECT    [u].[USER_ID],
                            [g].[USER_ID] AS [USER_OR_GROUP_ID]
                  FROM      [dbo].[TB_SEC_USER] [u]
                  INNER JOIN [dbo].[TB_SEC_GROUP_MEMBER] [gm] ON [gm].[CHILD_ID] = [u].[USER_ID]
                  INNER JOIN [dbo].[TB_SEC_USER] [g] ON [g].[USER_ID] = [gm].[PARENT_ID]
                                                        AND [g].[USER_TYPE] = 'G'
                  WHERE     [u].[USER_TYPE] = 'U'
                            AND [g].[DELETED] = 0
                            AND [g].[ENABLED] = 1
                ) [a]
        WHERE   [a].[USER_ID] = @UserId;

        IF OBJECT_ID('tempdb..#tasks') IS NOT NULL
        BEGIN
            DROP TABLE [#tasks];
        END;

        SELECT DISTINCT
                [t].[TASK_ID],
                [r].[ROLE_ID],
                [t].[CODE],
                [t].[INTERNAL_NAME]
        INTO    [#tasks]
        FROM    [dbo].[TE_SEC_TASK] [t]
        INNER JOIN [dbo].[TB_SEC_ROLE_MAPPING] [rm] ON [rm].[TASK_ID] = [t].[TASK_ID]
        INNER JOIN [dbo].[TB_SEC_ROLE] [r] ON [r].[ROLE_ID] = [rm].[ROLE_ID]
        WHERE   [t].[DELETED] = 0
                AND [t].[ENABLED] = 1
                AND [r].[ENABLED] = 1
                AND [r].[GLOBAL_ROLE] = 0
                AND [t].[CODE] & @TaskCode = @TaskCode;

        SELECT DISTINCT
                [ft].[TENANT_ID]
        FROM    ( SELECT    [t].[FOLDER_ID] AS [TENANT_ID],
                            [f].[FOLDER_ID],
                            [f].[HIDDEN],
                            [t].[PATH],
                            [f].[POLICY_ID]
                  FROM      ( SELECT    SUBSTRING([WORK].[PATH], [WORK].[start], [WORK].[fromEnd] + 1) AS [PATH],
                                        [WORK].[FOLDER_ID],
                                        [WORK].[HIDDEN],
                                        [WORK].[POLICY_ID]
                              FROM      ( SELECT    PATINDEX([a].[Match], [PATH] + '/') AS [start],
                                                    PATINDEX([a].[ReverseMatch], [PATH] + '/') AS [fromEnd],
                                                    LEN([PATH] + '/|') AS [length],
                                                    [PATH] + '/' AS [PATH],
                                                    [FOLDER_ID],
                                                    [HIDDEN],
                                                    [POLICY_ID]
                                          FROM      ( SELECT    '/%' AS [Match],
                                                                '%_/%' AS [ReverseMatch]
                                                    ) [a]
                                          CROSS JOIN [dbo].[TB_SEC_FOLDER]
                                        ) [WORK]
                            ) [f]
                  LEFT OUTER JOIN [dbo].[TB_SEC_FOLDER] [t] ON [f].[PATH] = [t].[PATH] + '/'
                                                               AND [t].[FOLDER_TYPE] = 'T'
                ) [ft]
        INNER JOIN ( SELECT DISTINCT
                            [u].[USER_ID],
                            [t].[CODE],
                            [pur].[POLICY_ID]
                     FROM   [#usersGroups] [u]
                     INNER JOIN [dbo].[TB_SEC_POLICY_USER_ROLE] [pur] ON [pur].[USER_ID] = [u].[USER_OR_GROUP_ID]
                     INNER JOIN [#tasks] [t] ON [pur].[ROLE_ID] = [t].[ROLE_ID]
                   ) [upt] ON [upt].[POLICY_ID] = [ft].[POLICY_ID]
        WHERE   ( @IncludeHiddenFolders = 1
                  OR [ft].[HIDDEN] = 0
                )
                AND [ft].[TENANT_ID] IS NOT NULL;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec_get_user_tenants]
	TO [portalapp_role]
GO
