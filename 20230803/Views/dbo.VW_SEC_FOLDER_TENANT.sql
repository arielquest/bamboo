SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_SEC_FOLDER_TENANT
AS
SELECT  t.FOLDER_ID AS TENANT_ID,
        f.FOLDER_ID,
        f.HIDDEN
FROM    TB_SEC_FOLDER AS f
LEFT OUTER JOIN TB_SEC_FOLDER AS t ON LEFT(f.PATH + '/', LEN(t.PATH + '/')) = t.PATH
                                      + '/'
                                      AND t.FOLDER_TYPE = 'T';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_FOLDER_TENANT]
	TO [portalapp_role]
GO
