SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_GROUP_MEMBER_GC]
AS
    SELECT  [datagc].[GUID_KEY] AS [RESOURCE_ID],
            [tbl].[PARENT_ID],
            [tbl].[CHILD_ID],
            [tbl].[CALCULATED],
            [tbl].[CALCULATED_PARENT_ID],
            [datagc].[GENERATION_COUNT],
            [datagc].[CREATE_GENERATION_COUNT],
            [datagc].[LAST_OPERATION]
    FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] [datagc]
    JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] [tablegc] ON [tablegc].[TABLE_GENERATION_COUNT_URN] = [datagc].[TABLE_GENERATION_COUNT_URN]
    LEFT OUTER JOIN [dbo].[TB_SEC_GROUP_MEMBER] [tbl] ON [tbl].[MEMBER_ID] = [datagc].[GUID_KEY]
    WHERE   [tablegc].[TABLE_NAME] = 'TB_SEC_GROUP_MEMBER';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_GROUP_MEMBER_GC]
	TO [portalapp_role]
GO
