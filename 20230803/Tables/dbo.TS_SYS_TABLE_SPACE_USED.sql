SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_SYS_TABLE_SPACE_USED] (
		[URN]                      [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[TYPE]                     [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]            [varchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NULL,
		[BASE_ROW_COUNT]           [int] NOT NULL,
		[PKEY_ROW_COUNT]           [int] NULL,
		[BASE_SPACE_PER_ROW]       [decimal](22, 6) NOT NULL,
		[PKEY_SPACE_PER_ROW]       [decimal](22, 6) NULL,
		[CALCULATION_DATE]         [datetime2](7) NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TS_SYS_TABLE_SPACE_USED]
		PRIMARY KEY
		CLUSTERED
		([URN])
	ON [STGGROUP]
) ON [STGGROUP]
GO
ALTER TABLE [dbo].[TS_SYS_TABLE_SPACE_USED]
	ADD
	CONSTRAINT [CK_TS_SYS_TABLE_SPACE_USED_TYPE]
	CHECK
	([TYPE]='F' OR [TYPE]='S' OR [TYPE]='M' OR [TYPE]='D')
GO
ALTER TABLE [dbo].[TS_SYS_TABLE_SPACE_USED]
CHECK CONSTRAINT [CK_TS_SYS_TABLE_SPACE_USED_TYPE]
GO
ALTER TABLE [dbo].[TS_SYS_TABLE_SPACE_USED]
	ADD
	CONSTRAINT [DF_TS_SYS_TABLE_SPACE_USED_CALCULATION_DATE]
	DEFAULT (sysutcdatetime()) FOR [CALCULATION_DATE]
GO
ALTER TABLE [dbo].[TS_SYS_TABLE_SPACE_USED]
	ADD
	CONSTRAINT [DF_TS_SYS_TABLE_SPACE_USED_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to record the space used per table type', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', 'COLUMN', N'URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This records the type that the row is identifying.  Dimension (D), Member (M), Fact (F), Sum (S).', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This records the name of the record type.  For example, for dimension see INTERNAL_NAME in TE_DIM_ITEM, for fact see name IN TB_IMP_FCT_PARTITION_METADATA.', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the DATETIME, in UTC, that the calculation for this record type on this cluster was performed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', 'COLUMN', N'CALCULATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TS_SYS_TABLE_SPACE_USED', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TS_SYS_TABLE_SPACE_USED]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TS_SYS_TABLE_SPACE_USED]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_SYS_TABLE_SPACE_USED]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TS_SYS_TABLE_SPACE_USED]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_SYS_TABLE_SPACE_USED] SET (LOCK_ESCALATION = TABLE)
GO
