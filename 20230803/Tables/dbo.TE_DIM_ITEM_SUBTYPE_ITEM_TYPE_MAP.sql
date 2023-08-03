SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP] (
		[ITEM_SUBTYPE_ITEM_TYPE_MAP_ID]     [int] IDENTITY(1, 4) NOT NULL,
		[ITEM_SUBTYPE_ID]                   [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_ID]                      [uniqueidentifier] NOT NULL,
		[DELETED]                           [bit] NOT NULL,
		[SYSTEM]                            [bit] NOT NULL,
		[CREATED_BY_ID]                     [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                    [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                     [datetime] NOT NULL,
		[MODIFIED_DATE]                     [datetime] NOT NULL,
		[msrepl_tran_version]               [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
		PRIMARY KEY
		CLUSTERED
		([ITEM_SUBTYPE_ITEM_TYPE_MAP_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_TE_DIM_ITEM_TYPE_ITEM_SUBTYPE_ID]
	FOREIGN KEY ([ITEM_SUBTYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_SUBTYPE] ([ITEM_SUBTYPE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	CHECK CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_TE_DIM_ITEM_TYPE_ITEM_SUBTYPE_ID]

GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_TE_DIM_ITEM_TYPE_ITEM_TYPE_ID]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	CHECK CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_TE_DIM_ITEM_TYPE_ITEM_TYPE_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_ITEM_SUBTYPE_ID]
	ON [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP] ([ITEM_SUBTYPE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP_ITEM_TYPE_ID]
	ON [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP] ([ITEM_TYPE_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table maps Item Types and Item SubTypes to allow restriction by type', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'ITEM_SUBTYPE_ITEM_TYPE_MAP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key from TE_DIM_ITEM_SUBTYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'ITEM_SUBTYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key from TE_DIM_ITEM_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_MAP] SET (LOCK_ESCALATION = TABLE)
GO
