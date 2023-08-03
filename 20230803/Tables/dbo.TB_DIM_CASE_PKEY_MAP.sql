SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CASE_PKEY_MAP] (
		[PKEY_MAP_URN]             [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]             [int] NOT NULL,
		[PKEY1]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PKEY2]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CASE_PKEY_MAP]
		PRIMARY KEY
		CLUSTERED
		([PKEY_MAP_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CASE_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_PKEY_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_CASE_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CASE_PKEY_MAP_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_URN]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CASE_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CASE_PKEY_MAP_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_DIM_CASE_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CASE_PKEY_MAP_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CASE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CASE_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CASE_PKEY_MAP_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CASE_PKEY_MAP_CLUSTER_RESOURCE_URN]
	ON [dbo].[TB_DIM_CASE_PKEY_MAP] ([CLUSTER_RESOURCE_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CASE_PKEY_MAP_ITEM_BIZ_URN]
	ON [dbo].[TB_DIM_CASE_PKEY_MAP] ([ITEM_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CASE_PKEY_MAP_PKEY1_CLUSTER_RESOURCE_URN]
	ON [dbo].[TB_DIM_CASE_PKEY_MAP] ([PKEY1], [CLUSTER_RESOURCE_URN])
	INCLUDE ([ITEM_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the mappings for Cases in TB_DIM_CASE corresponding to the items on various sources for the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', 'COLUMN', N'PKEY_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CASE corresponding to the item for which the mapping is defined. This is unique for a given source specified by the column CLUSTER_RESOURCE_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier of the item on the specified source. This has to be unique on the specified source. For example, this can be a primary key value on any source database table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', 'COLUMN', N'PKEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the secondary identifier of the item on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', 'COLUMN', N'PKEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE_PKEY_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CASE_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CASE_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CASE_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CASE_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CASE_PKEY_MAP]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CASE_PKEY_MAP]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_CASE_PKEY_MAP] SET (LOCK_ESCALATION = TABLE)
GO
