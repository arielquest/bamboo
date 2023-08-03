SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CATEGORY_MAP] (
		[CATEGORY_MAP_URN]        [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]            [int] NOT NULL,
		[ITEM_TYPE_URN]           [int] NOT NULL,
		[CATEGORY_BIZ_URN]        [int] NOT NULL,
		[RELATIONSHIP]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[PRIORITY]                [int] NOT NULL,
		[EFFECTIVE_FROM]          [datetime] NOT NULL,
		[EFFECTIVE_TO]            [datetime] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CATEGORY_MAP]
		PRIMARY KEY
		CLUSTERED
		([CATEGORY_MAP_URN])
	ON [DIMINDEXGROUP]
) ON [DIMINDEXGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_PRIORITY]
	DEFAULT ((0)) FOR [PRIORITY]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_RELATIONSHIP]
	DEFAULT (N'') FOR [RELATIONSHIP]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CATEGORY_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CATEGORY_MAP_TB_DIM_CATEGORY]
	FOREIGN KEY ([CATEGORY_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CATEGORY] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CATEGORY_MAP_TB_DIM_CATEGORY]

GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CATEGORY_MAP_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_URN]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CATEGORY_MAP_TE_DIM_ITEM_TYPE]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_DIM_CATEGORY_MAP_UNIQUE_MAPPING]
	ON [dbo].[TB_DIM_CATEGORY_MAP] ([CATEGORY_BIZ_URN], [ITEM_BIZ_URN], [ITEM_TYPE_URN])
	WHERE (([DELETED]=(0)))
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CATEGORY_MAP_ITEM_TYPE_URN]
	ON [dbo].[TB_DIM_CATEGORY_MAP] ([ITEM_TYPE_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the mappings between various dimension items and defined categories.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'CATEGORY_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_BIZ_URN from the corresponding dimension table e.g. TB_DIM_AGENT to the item being associated with a category.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_TYPE_URN in TE_DIM_ITEM_TYPE of the dimension being associated with a category.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'ITEM_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_BIZ_URN from TB_DIM_CATEGORY which references the category of this mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'CATEGORY_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Specifies the relationship between the item and category.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'RELATIONSHIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'PRIORITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the mapping between the parent and child items will be active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the mapping between the parent and child items will be cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the mapping was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the mapping was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the mapping is deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indiciates whether the mapping is active and observed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the mapping is visible in the UI.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if the mapping is system provided and whether or not it can be edited.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CATEGORY_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CATEGORY_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CATEGORY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CATEGORY_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CATEGORY_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_CATEGORY_MAP] SET (LOCK_ESCALATION = TABLE)
GO
