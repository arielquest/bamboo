SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE] (
		[ITEM_URN]                 [bigint] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[SCRIPT_URN]               [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[RESOURCE_TYPE_URN]        [int] NOT NULL,
		[PKEY]                     [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_SCRIPT_CROSS_REFERENCE]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE]
	ADD
	CONSTRAINT [DF_TB_DIM_SCRIPT_CROSS_REFERENCE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_DIM_SCRIPT_CROSS_REFERENCE_SCRIPT_URN_PKEY_RESOURCE]
	ON [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE] ([SCRIPT_URN], [PKEY], [RESOURCE_TYPE_URN])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to map scripts to their referenced objects', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SCRIPT_CROSS_REFERENCE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SCRIPT_CROSS_REFERENCE', 'COLUMN', N'SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the CLUSTER_RESOURCE_URN from the corresponding dimension table e.g. TB_DIM_QUEUE to the item being associated with a script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SCRIPT_CROSS_REFERENCE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RESOURCE_TYPE_URN in TE_DIM_ITEM_TYPE of the dimension being associated with a script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SCRIPT_CROSS_REFERENCE', 'COLUMN', N'RESOURCE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier from the source of the referenced dimension being associated with a script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SCRIPT_CROSS_REFERENCE', 'COLUMN', N'PKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SCRIPT_CROSS_REFERENCE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_SCRIPT_CROSS_REFERENCE] SET (LOCK_ESCALATION = TABLE)
GO
