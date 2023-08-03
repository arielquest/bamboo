SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_ITEM_TYPE] (
		[ITEM_TYPE_ID]            [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[VIEW_NAME]               [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[TABLE_NAME]              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[SMALL_ICON]              [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[LARGE_ICON]              [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[PREFIXED]                [bit] NOT NULL,
		[PROVISIONABLE]           [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[TAXONOMY_ENABLED]        [bit] NOT NULL,
		[ITEM_TYPE_URN]           [int] NOT NULL,
		[PURGE_PERIOD]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_ITEM_TYPE_ITEM_TYPE_URN]
		UNIQUE
		NONCLUSTERED
		([ITEM_TYPE_URN])
		ON [DIMINDEXGROUP],
		CONSTRAINT [UN_TE_DIM_ITEM_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TE_DIM_ITEM_TYPE]
		PRIMARY KEY
		CLUSTERED
		([ITEM_TYPE_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_TYPE]
	DEFAULT (newid()) FOR [ITEM_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_PREFIXED]
	DEFAULT ((0)) FOR [PREFIXED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_PROVISIONABLE]
	DEFAULT ((0)) FOR [PROVISIONABLE]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_TAXONOMY_ENABLED]
	DEFAULT ((0)) FOR [TAXONOMY_ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_PURGE_PERIOD]
	DEFAULT ((90)) FOR [PURGE_PERIOD]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'TThis table holds information about all the possible item types in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the item type. This is unique. This name is prefixed with IT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the database view that stores data for the item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'VIEW_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the database table that stores derived data for the item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field stores the file name of the small icon, if an icon is to be placed besides the item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'SMALL_ICON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field stores the file name of the large icon, if an icon is to be placed besides the item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'LARGE_ICON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item type can take part in prefix management or not. Value of 1 indicates that the item type can be prefixed.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'PREFIXED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item type can take part in provisioning or not. Value of 1 indicates that the item type is provisionable.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'PROVISIONABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item type has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item type is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item type is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item type is owned by system or not. Value of 1 indicates system owned item type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether items of this type are enabled for taxonomy mappings.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'TAXONOMY_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is another primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'ITEM_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of days a deleted membership will be stored before being purged.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'PURGE_PERIOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TE_DIM_ITEM_TYPE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
