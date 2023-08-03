SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_RESERVED_NAME] (
		[RESERVED_NAME_ID]        [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_ID]            [uniqueidentifier] NOT NULL,
		[PARENT_URN]              [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[OWNER_ID]                [uniqueidentifier] NULL,
		[COLUMN_NAME]             [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[RESERVED_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_DIM_RESERVED_NAME]
		UNIQUE
		NONCLUSTERED
		([ITEM_TYPE_ID], [COLUMN_NAME], [RESERVED_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_RESERVED_NAME]
		PRIMARY KEY
		CLUSTERED
		([RESERVED_NAME_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	ADD
	CONSTRAINT [DF_TB_DIM_RESERVED_NAME_RESERVED_NAME_ID]
	DEFAULT (newid()) FOR [RESERVED_NAME_ID]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	ADD
	CONSTRAINT [DF_TB_DIM_RESERVED_NAME_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TE_DIM_ITEM_TYPE]

GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TB_SEC_FOLDER_FOLDER_ID]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TB_SEC_FOLDER_FOLDER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TB_SEC_FOLDER_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TB_SEC_FOLDER_OWNER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NAME_TB_CLU_RESOURCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_RESERVED_NAME_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_DIM_RESERVED_NAME] ([CLUSTER_RESOURCE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_RESERVED_NAME_FOLDER_ID]
	ON [dbo].[TB_DIM_RESERVED_NAME] ([FOLDER_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_RESERVED_NAME_OWNER_ID]
	ON [dbo].[TB_DIM_RESERVED_NAME] ([OWNER_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds the details of the last used reserved numbers or names. This table complements TB_DIM_RESERVED_NUMBER table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'RESERVED_NAME_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_TYPE that indicates the item type associated with the reserved name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the parent item (usually peripheral) to which this reserved name belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'PARENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE that indicates the equipment associated with the reserved name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the place holder for the reserved name in the resource tree. This defaults to the Unallocated folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the owner for the reserved name in the resource tree. This defaults to Unallocated folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the field name of the item type on which the reserved name is to be applied.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'COLUMN_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the actual reserved name for the column as mentioned in COLUMN_NAME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'RESERVED_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_RESERVED_NAME]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_RESERVED_NAME]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_RESERVED_NAME]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_RESERVED_NAME]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME] SET (LOCK_ESCALATION = TABLE)
GO
