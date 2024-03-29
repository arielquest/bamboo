SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE     VIEW [dbo].[VW_SEC_GROUPS_BY_USER]
--WITH SCHEMABINDING
AS
SELECT  u.USER_ID,
        u.USER_ID AS USER_OR_GROUP_ID
FROM    TB_SEC_USER u
WHERE   u.USER_TYPE = 'U'
        AND u.DELETED = 0
        AND u.ENABLED = 1
UNION
SELECT  u.USER_ID,
        g.USER_ID AS USER_OR_GROUP_ID
FROM    TB_SEC_USER u
JOIN    TB_SEC_GROUP_MEMBER gm ON gm.CHILD_ID = u.USER_ID
JOIN    TB_SEC_USER g ON g.USER_ID = gm.PARENT_ID
                         AND g.USER_TYPE = 'G'
WHERE   u.USER_TYPE = 'U'
        AND g.DELETED = 0
        AND g.ENABLED = 1;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_GROUPS_BY_USER]
	TO [portalapp_role]
GO
