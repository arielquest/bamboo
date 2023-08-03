SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SEC_POLICY_GC]
AS
    SELECT  [datagc].[GUID_KEY] AS [RESOURCE_ID],
            [tbl].[NAME],
            [tbl].[DESCRIPTION],
            [tbl].[GLOBAL_POLICY],
            [datagc].[GENERATION_COUNT],
            [datagc].[CREATE_GENERATION_COUNT],
            [datagc].[LAST_OPERATION]
    FROM    [dbo].[TS_ADM_DATA_GENERATION_COUNT] [datagc]
    JOIN    [dbo].[TS_ADM_TABLE_GENERATION_COUNT] [tablegc] ON [tablegc].[TABLE_GENERATION_COUNT_URN] = [datagc].[TABLE_GENERATION_COUNT_URN]
    LEFT OUTER JOIN [dbo].[TB_SEC_POLICY] [tbl] ON [tbl].[POLICY_ID] = [datagc].[GUID_KEY]
    WHERE   [tablegc].[TABLE_NAME] = 'TB_SEC_POLICY';
GO
GRANT SELECT
	ON [dbo].[VW_SEC_POLICY_GC]
	TO [portalapp_role]
GO
