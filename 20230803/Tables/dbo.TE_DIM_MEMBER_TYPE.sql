SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_MEMBER_TYPE] (
		[MEMBER_TYPE_ID]          [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[PARENT_ITEM_TYPE_ID]     [uniqueidentifier] NOT NULL,
		[CHILD_ITEM_TYPE_ID]      [uniqueidentifier] NOT NULL,
		[MEMBER_TYPE]             [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[TABLE_NAME]              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[SMALL_ICON]              [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[LARGE_ICON]              [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[VIEW_NAME]               [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[MEMBER_TYPE_URN]         [int] NOT NULL,
		[PURGE_PERIOD]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_MEMBER_TYPE_MEMBER_TYPE_URN]
		UNIQUE
		NONCLUSTERED
		([MEMBER_TYPE_URN])
		ON [DIMINDEXGROUP],
		CONSTRAINT [UN_TE_DIM_MEMBER_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [UN_TE_DIM_MEMBER_TYPE_PARENT_CHILD]
		UNIQUE
		NONCLUSTERED
		([PARENT_ITEM_TYPE_ID], [CHILD_ITEM_TYPE_ID], [MEMBER_TYPE])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TE_DIM_MEMBER_TYPE]
		PRIMARY KEY
		CLUSTERED
		([MEMBER_TYPE_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [CK_TE_DIM_MEMBER_TYPE_MEMBER_TYPE]
	CHECK
	([MEMBER_TYPE]=N'M' OR ([MEMBER_TYPE]=N'P' OR [MEMBER_TYPE]=N'O'))
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
CHECK CONSTRAINT [CK_TE_DIM_MEMBER_TYPE_MEMBER_TYPE]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_TYPE]
	DEFAULT (newid()) FOR [MEMBER_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_MEMBER_TYPE]
	DEFAULT ('M') FOR [MEMBER_TYPE]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_PURGE_PERIOD]
	DEFAULT ((90)) FOR [PURGE_PERIOD]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_MEMBER_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_DIM_MEMBER_TYPE_PARENT]
	FOREIGN KEY ([PARENT_ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	CHECK CONSTRAINT [FK_TE_DIM_MEMBER_TYPE_PARENT]

GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_DIM_MEMBER_TYPE_CHILD]
	FOREIGN KEY ([CHILD_ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE]
	CHECK CONSTRAINT [FK_TE_DIM_MEMBER_TYPE_CHILD]

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TE_DIM_MEMBER_TYPE_INTERNAL_NAME]
	ON [dbo].[TE_DIM_MEMBER_TYPE] ([INTERNAL_NAME])
	ON [DIMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TE_DIM_MEMBER_TYPE_CHILD_ITEM_TYPE_ID]
	ON [dbo].[TE_DIM_MEMBER_TYPE] ([CHILD_ITEM_TYPE_ID])
	ON [DIMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the possible memberships between various item types (in TE_DIM_ITEM_TYPE) in the system. These memberships can be of type many to many or parent child.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'MEMBER_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the item type in TE_DIM_ITEM_TYPE that is taking part as the parent in the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'PARENT_ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the item type in TE_DIM_ITEM_TYPE that is taking part as the child in the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'CHILD_ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This defines the type of membership. M: Many to Many, P: Parent Child.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'MEMBER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the member type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the member type. This is unique. This name is prefixed with MT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the member type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the table that stores membership data for the member type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field stores the file name of the small icon, if an icon is to be placed besides the Member Type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'SMALL_ICON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field stores the file name of the large icon, if an icon is to be placed besides the Member Type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'LARGE_ICON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the member type has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the member type has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the member type is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the member type is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the member type is owned by system or not. Value of 1 indicates system owned member type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the view that stores membership data for the member type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'VIEW_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is another primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'MEMBER_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of days a deleted membership will be stored before being purged.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'PURGE_PERIOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_MEMBER_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TE_DIM_MEMBER_TYPE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TE_DIM_MEMBER_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
