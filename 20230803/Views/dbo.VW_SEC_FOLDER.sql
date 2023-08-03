SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_SEC_FOLDER
AS
SELECT  [FOLDER_ID],
        [FOLDER_URN],
        [PARENT_ID],
        [LINK_SOURCE_ID],
        [POLICY_ID],
        [FOLDER_TYPE],
        [PATH],
        [DEPTH],
        [NAME],
        [DESCRIPTION],
        [EFFECTIVE_FROM],
        [EFFECTIVE_TO],
        [POLICY_ROOT],
        [CREATED_BY_ID],
        [MODIFIED_BY_ID],
        [CREATION_DATE],
        [MODIFIED_DATE],
        [ARCHIVED],
        [CONTAINER],
        [DELETED],
        [HIDDEN],
        [SYSTEM],
        [TEMPLATE]
FROM    TB_SEC_FOLDER;
GO
GRANT SELECT
	ON [dbo].[VW_SEC_FOLDER]
	TO [portalapp_role]
GO
