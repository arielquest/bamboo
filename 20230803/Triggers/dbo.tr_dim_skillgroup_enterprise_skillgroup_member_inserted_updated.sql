SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_dim_skillgroup_enterprise_skillgroup_member_inserted_updated] ON [dbo].[TB_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER] FOR INSERT, UPDATE AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;

    INSERT [dbo].[TS_IMP_SUMMARIZED]
    SELECT *
    FROM (
        SELECT oo.[OLAP_OBJECT_URN], oo.[PRIMARY_TABLE]
        FROM [dbo].[TB_ADM_OLAP_OBJECT] oo
        INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] ocm ON oo.OLAP_OBJECT_URN = ocm.OLAP_OBJECT_URN
        WHERE oo.[OLAP_OBJECT_NAME] = 'Skillgroup Enterprise Skillgroup Member'
            AND ocm.[ENABLED] = 1
        ) a
    CROSS JOIN (
        SELECT [MEMBER_URN] AS [ROW_URN], 'I' AS [ACTION], 0 AS [STATUS]
        FROM inserted
        ) b;
END;
GO
