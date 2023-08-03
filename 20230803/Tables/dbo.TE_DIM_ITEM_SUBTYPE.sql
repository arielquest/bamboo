SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_ITEM_SUBTYPE] (
		[ITEM_SUBTYPE_ID]                [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ITEM_TYPE_ID]                   [uniqueidentifier] NOT NULL,
		[NAME]                           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]                  [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                    [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[DEPENDS_ON_ITEM_SUBTYPE_ID]     [uniqueidentifier] NULL,
		[ARCHIVED]                       [bit] NOT NULL,
		[DELETED]                        [bit] NOT NULL,
		[ENABLED]                        [bit] NOT NULL,
		[HIDDEN]                         [bit] NOT NULL,
		[SYSTEM]                         [bit] NOT NULL,
		[IS_HIERARCHY_FIXED_LEVEL]       [bit] NOT NULL,
		[TOTAL_HIERARCHY_LEVELS]         [int] NOT NULL,
		[HIERARCHY_MAX_PRECEDENCE]       [int] NOT NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_ITEM_SUBTYPE_NAME]
		UNIQUE
		NONCLUSTERED
		([ITEM_TYPE_ID], [NAME])
		ON [SECINDEXGROUP],
		CONSTRAINT [UN_TE_DIM_ITEM_SUBTYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMGROUP],
		CONSTRAINT [PK_TE_DIM_ITEM_SUBTYPE]
		PRIMARY KEY
		CLUSTERED
		([ITEM_SUBTYPE_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_TYPE]
	DEFAULT (newid()) FOR [ITEM_SUBTYPE_ID]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_IS_HIERARCHY_FIXED_LEVEL]
	DEFAULT ((0)) FOR [IS_HIERARCHY_FIXED_LEVEL]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_TOTAL_HIERARCHY_LEVELS]
	DEFAULT ((0)) FOR [TOTAL_HIERARCHY_LEVELS]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_HIERARCHY_MAX_PRECEDENCE]
	DEFAULT ((1)) FOR [HIERARCHY_MAX_PRECEDENCE]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_ITEM_SUBTYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_ID]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	CHECK CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_ITEM_TYPE_ID]

GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_DEPENDS_ON_ITEM_SUBTYPE_ID]
	FOREIGN KEY ([DEPENDS_ON_ITEM_SUBTYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_SUBTYPE] ([ITEM_SUBTYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE]
	CHECK CONSTRAINT [FK_TE_DIM_ITEM_SUBTYPE_DEPENDS_ON_ITEM_SUBTYPE_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TE_DIM_ITEM_SUBTYPE_DEPENDS_ON_ITEM_SUBTYPE_ID]
	ON [dbo].[TE_DIM_ITEM_SUBTYPE] ([DEPENDS_ON_ITEM_SUBTYPE_ID])
	ON [DIMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the possible sub types for the item types (in TE_DIM_ITEM_TYPE) in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'ITEM_SUBTYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the item type for the item sub type. This refers to ITEM_TYPE_ID in TE_DIM_ITEM_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item sub type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the item sub type. This is unique. This name is prefixed with ST_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the item sub type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the ITEM_SUBTYPE_ID from the same table that indicates the dependency of the current item sub type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'DEPENDS_ON_ITEM_SUBTYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item sub type has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item sub type has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item sub type is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item sub type is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item sub type is owned by system or not. Value of 1 indicates system owned item sub type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the hierarchy subtype supports fixed level or parent/child. This flag is used only for subtypes of item type IT_HIERARCHY.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'IS_HIERARCHY_FIXED_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of levels for a fixed level hierarchy if the hierarchy subtype supports fixed levels. This is used only for subtypes of item type IT_HIERARCHY.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'TOTAL_HIERARCHY_LEVELS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of times a single item can be mapped to node for the hierarchy subtype (used in conjunction with PRESCEDENCE on TB_DIM_HIERARCHY_HIERARCHY_NODE_MEMBER). This is used only for subtypes of item type IT_HIERARCHY.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'HIERARCHY_MAX_PRECEDENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_ITEM_SUBTYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_DIM_ITEM_SUBTYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_DIM_ITEM_SUBTYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_SUBTYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_DIM_ITEM_SUBTYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_ITEM_SUBTYPE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_DIM_ITEM_SUBTYPE] SET (LOCK_ESCALATION = TABLE)
GO
