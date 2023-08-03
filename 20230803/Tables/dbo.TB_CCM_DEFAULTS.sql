SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CCM_DEFAULTS] (
		[CCM_DEFAULTS_URN]        [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NOT NULL,
		[MODEL_CODE_URN]          [int] NOT NULL,
		[PROTOCOL_CODE_URN]       [int] NOT NULL,
		[LOAD_INFORMATION]        [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[PKEY1]                   [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_CCM_DEFAULTS]
		PRIMARY KEY
		CLUSTERED
		([CCM_DEFAULTS_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	ADD
	CONSTRAINT [DF_TB_CCM_DEFAULTS_MODEL_CODE_URN]
	DEFAULT ((-1)) FOR [MODEL_CODE_URN]
GO
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	ADD
	CONSTRAINT [DF_TB_CCM_DEFAULTS_PROTOCOL_CODE_URN]
	DEFAULT ((-1)) FOR [PROTOCOL_CODE_URN]
GO
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	ADD
	CONSTRAINT [DF_TB_CCM_DEFAULTS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CCM_DEFAULTS_TB_DIM_CODE_MODEL]
	FOREIGN KEY ([MODEL_CODE_URN]) REFERENCES [dbo].[TB_DIM_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	CHECK CONSTRAINT [FK_TB_CCM_DEFAULTS_TB_DIM_CODE_MODEL]

GO
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CCM_DEFAULTS_TB_DIM_CODE_PROTOCOL]
	FOREIGN KEY ([PROTOCOL_CODE_URN]) REFERENCES [dbo].[TB_DIM_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CCM_DEFAULTS]
	CHECK CONSTRAINT [FK_TB_CCM_DEFAULTS_TB_DIM_CODE_PROTOCOL]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CCM_DEFAULTS_MODEL_CODE_URN]
	ON [dbo].[TB_CCM_DEFAULTS] ([MODEL_CODE_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CCM_DEFAULTS_PROTOCOL_CODE_URN]
	ON [dbo].[TB_CCM_DEFAULTS] ([PROTOCOL_CODE_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores default values from Cisco CallManager systems', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'CCM_DEFAULTS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a product code. Code type: CG_DEVICE_MODEL', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'MODEL_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a product code. Code type: CG_DEVICE_PROTOCOL', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'PROTOCOL_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Callmanager load information', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'LOAD_INFORMATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier of the item on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'PKEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_DEFAULTS', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CCM_DEFAULTS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CCM_DEFAULTS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CCM_DEFAULTS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CCM_DEFAULTS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_CCM_DEFAULTS] SET (LOCK_ESCALATION = TABLE)
GO
