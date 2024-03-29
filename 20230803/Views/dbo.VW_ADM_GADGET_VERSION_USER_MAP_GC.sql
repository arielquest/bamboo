SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_GADGET_VERSION_USER_MAP_GC]
WITH SCHEMABINDING
AS
    SELECT  datagc.[GUID_KEY] AS RESOURCE_ID,
            member.[GADGET_VERSION_ID] AS CHILD_RESOURCE_ID,
            CAST('A0B3F057-C364-42BB-AFD1-E9107CFF8F48' AS UNIQUEIDENTIFIER) AS CHILD_RESOURCE_TYPE_ID, -- IT_GADGET_VERSION
            member.[USER_ID] AS PARENT_RESOURCE_ID,
            CASE WHEN userGroup.USER_TYPE = 'U' THEN CAST('EEE2E0E2-C672-4f3c-A84F-59800D8565E4' AS UNIQUEIDENTIFIER) 
                ELSE CAST('E1C14D2E-7DF8-45ec-87CC-2687BA0A7CA2' AS UNIQUEIDENTIFIER) END AS PARENT_RESOURCE_TYPE_ID, -- IT_USER or IT_GROUP
            member.[CHANGE_STAMP],
            member.[CREATION_DATE],
            member.[MODIFIED_DATE],
            member.[CREATED_BY_ID],
            member.[MODIFIED_BY_ID],
            member.[BROWSE_ENABLED],
            datagc.[GENERATION_COUNT],
            datagc.[CREATE_GENERATION_COUNT],
            datagc.[LAST_OPERATION]
    FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] datagc
    JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] tablegc ON tablegc.TABLE_GENERATION_COUNT_URN = datagc.TABLE_GENERATION_COUNT_URN
    LEFT JOIN [dbo].[TB_ADM_GADGET_VERSION_USER_MAP] member ON member.ID = datagc.GUID_KEY
    LEFT JOIN [dbo].[TB_SEC_USER] userGroup ON userGroup.USER_ID = member.USER_ID
    WHERE   tablegc.TABLE_NAME = 'TB_ADM_GADGET_VERSION_USER_MAP';
GO
GRANT SELECT
	ON [dbo].[VW_ADM_GADGET_VERSION_USER_MAP_GC]
	TO [portalapp_role]
GO
