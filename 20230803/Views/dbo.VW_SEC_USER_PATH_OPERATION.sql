SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE    VIEW dbo.VW_SEC_USER_PATH_OPERATION
--WITH SCHEMABINDING
AS
SELECT DISTINCT
        u.USER_TYPE,
        u.LOGIN_NAME,
        o.NAME AS OPERATION,
        s.PATH,
        s.FOLDER_ID,
        s.PARENT_ID,
        s.HIDDEN AS FOLDER_HIDDEN,
        s.FOLDER_TYPE
FROM    dbo.TE_SEC_OPERATION o
JOIN    dbo.TE_SEC_TASK t ON t.TASK_ID = o.TASK_ID
JOIN    dbo.TB_SEC_ROLE_MAPPING rm ON rm.TASK_ID = t.TASK_ID
JOIN    dbo.TB_SEC_ROLE r ON r.ROLE_ID = rm.ROLE_ID
JOIN    dbo.TB_SEC_POLICY_USER_ROLE pur ON pur.ROLE_ID = r.ROLE_ID
JOIN    dbo.TB_SEC_FOLDER s ON s.POLICY_ID = pur.POLICY_ID
JOIN    dbo.TB_SEC_USER g ON g.USER_ID = pur.USER_ID
LEFT JOIN dbo.TB_SEC_GROUP_MEMBER gm ON gm.PARENT_ID = g.USER_ID
JOIN    dbo.TB_SEC_USER u ON u.USER_ID = gm.CHILD_ID
                             OR u.USER_ID = pur.USER_ID
WHERE   o.DELETED = 0
        AND t.DELETED = 0
        AND s.DELETED = 0
        AND u.DELETED = 0
        AND g.DELETED = 0
        AND o.ENABLED = 1
        AND t.ENABLED = 1
        AND r.ENABLED = 1
        AND u.ENABLED = 1
        AND g.ENABLED = 1
        AND r.GLOBAL_ROLE = 0;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_PATH_OPERATION]
	TO [portalapp_role]
GO
