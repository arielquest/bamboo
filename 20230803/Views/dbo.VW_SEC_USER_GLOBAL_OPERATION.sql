SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_SEC_USER_GLOBAL_OPERATION 
--WITH SCHEMABINDING
AS
SELECT DISTINCT
        u.USER_TYPE,
        u.LOGIN_NAME,
        o.NAME AS OPERATION
FROM    dbo.TE_SEC_OPERATION o
INNER JOIN dbo.TE_SEC_TASK t ON t.TASK_ID = o.TASK_ID
INNER JOIN dbo.TB_SEC_ROLE_MAPPING rm ON rm.TASK_ID = t.TASK_ID
INNER JOIN dbo.TB_SEC_ROLE r ON r.ROLE_ID = rm.ROLE_ID
INNER JOIN ( SELECT DISTINCT
                    u.USER_ID,
                    pur.POLICY_ID,
                    pur.ROLE_ID,
                    u.USER_TYPE,
                    u.LOGIN_NAME
             FROM   ( SELECT    u.USER_ID,
                                u.USER_ID AS USER_OR_GROUP_ID,
                                u.USER_TYPE,
                                u.LOGIN_NAME
                      FROM      TB_SEC_USER u
                      WHERE     u.DELETED = 0
                                AND u.ENABLED = 1
                      UNION
                      SELECT    u.USER_ID,
                                g.USER_ID AS USER_OR_GROUP_ID,
                                u.USER_TYPE,
                                u.LOGIN_NAME
                      FROM      TB_SEC_USER u
                      INNER JOIN TB_SEC_GROUP_MEMBER gm ON gm.CHILD_ID = u.USER_ID
                      INNER JOIN TB_SEC_USER g ON g.USER_ID = gm.PARENT_ID
                      WHERE     g.DELETED = 0
                                AND g.ENABLED = 1
                                AND u.DELETED = 0
                                AND u.ENABLED = 1
                    ) u
             INNER JOIN dbo.TB_SEC_POLICY_USER_ROLE pur ON pur.USER_ID = u.USER_OR_GROUP_ID
           ) u ON u.ROLE_ID = r.ROLE_ID
WHERE   o.DELETED = 0
        AND o.ENABLED = 1 -------------------------------------------FROM  dbo.TE_SEC_OPERATION
        AND t.DELETED = 0
        AND t.ENABLED = 1 -------------------------------------------FROM  dbo.TE_SEC_TASK
        AND r.ENABLED = 1
        AND r.GLOBAL_ROLE = 1;
 --FROM  dbo.TB_SEC_ROLE
GO
GRANT SELECT
	ON [dbo].[VW_SEC_USER_GLOBAL_OPERATION]
	TO [portalapp_role]
GO
