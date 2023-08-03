SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_XML_H_GC]
WITH SCHEMABINDING
AS
SELECT
--From [dbo].[TS_ADM_DATA_GENERATION_COUNT]
        datagc.[GUID_KEY] AS RESOURCE_ID, 
--From [dbo].[TB_ADM_XML]
        report.FOLDER_ID AS CONTAINER_ID,
        report.TYPE,
        report.NAME,
        report.XML_DATA AS REPORT_XML_DATA,
        report.ENABLED,
        report.DELETED,
        report.HIDDEN,
        report.SYSTEM,
--From [dbo].[TS_ADM_DATA_GENERATION_COUNT]
        datagc.[GENERATION_COUNT],
        datagc.[CREATE_GENERATION_COUNT],
        datagc.[LAST_OPERATION]
FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
INNER JOIN [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
LEFT OUTER JOIN ( SELECT    [XML_ID],
                            [FOLDER_ID],
                            [TYPE],
                            [NAME],
                            [XML_DATA],
                            [ENABLED],
                            [DELETED],
                            [HIDDEN],
                            [SYSTEM]
                  FROM      [dbo].[TB_ADM_XML]
                  WHERE     TYPE = 'H'
                ) report ON report.XML_ID = datagc.GUID_KEY
WHERE   tablegc.TABLE_NAME = 'VW_ADM_XML_H_GC';
GO
GRANT SELECT
	ON [dbo].[VW_ADM_XML_H_GC]
	TO [portalapp_role]
GO
