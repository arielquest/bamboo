SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE     VIEW dbo.VW_SEC_USER_PATH_TASKS
--WITH SCHEMABINDING
AS
    WITH    [CTE]
              AS ( 
                   -- Perform distinct upfront on as little as possible (do not include "PATH")
                   -- This reduces the amount of memory required to perform the distinct operation
                   -- which in turn reduces execution time
                   SELECT DISTINCT
                            [u].[USER_ID],
                            [pur].[POLICY_ID],
                            [t].[CODE]
                   FROM     [dbo].[VW_SEC_GROUPS_BY_USER] [u]
                   JOIN     [dbo].[TB_SEC_POLICY_USER_ROLE] [pur] ON [pur].[USER_ID] = [u].[USER_OR_GROUP_ID]
                   JOIN     [dbo].[VW_SEC_PATH_ROLE_TASK_MAPPING] [t] ON [pur].[ROLE_ID] = [t].[ROLE_ID]
                 )
    SELECT  [a].[USER_ID],
            [s].[FOLDER_ID],
            [a].[CODE],
            [s].[PATH],
            [s].[PARENT_ID],
            [s].[FOLDER_TYPE]
    FROM    [CTE] [a]
    JOIN    [dbo].[TB_SEC_FOLDER] [s] ON [s].[POLICY_ID] = [a].[POLICY_ID]
                                         AND [s].[DELETED] = 0;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_PATH_TASKS]
	TO [portalapp_role]
GO
