SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_PREFIX_MAPPING] (
		[PREFIX_MAPPING_ID]       [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_ID]            [uniqueidentifier] NOT NULL,
		[PREFIX]                  [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[TARGET_FOLDER_ID]        [uniqueidentifier] NOT NULL,
		[PRIORITY]                [int] NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_DIM_PREFIX_MAPPING_PRIORITY]
		UNIQUE
		NONCLUSTERED
		([FOLDER_ID], [ITEM_TYPE_ID], [PRIORITY])
		ON [DIMINDEXGROUP],
		CONSTRAINT [UN_TB_DIM_PREFIX_MAPPING]
		UNIQUE
		NONCLUSTERED
		([FOLDER_ID], [ITEM_TYPE_ID], [PREFIX])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_PREFIX_MAPPING]
		PRIMARY KEY
		CLUSTERED
		([PREFIX_MAPPING_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_PREFIX_MAPPING_ID]
	DEFAULT (newid()) FOR [PREFIX_MAPPING_ID]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_PREFIX]
	DEFAULT (N'') FOR [PREFIX]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_PREFIX_MAPPING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_PREFIX_MAPPING_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	CHECK CONSTRAINT [FK_TB_DIM_PREFIX_MAPPING_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_PREFIX_MAPPING_TB_SEC_FOLDER_TARGET]
	FOREIGN KEY ([TARGET_FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	CHECK CONSTRAINT [FK_TB_DIM_PREFIX_MAPPING_TB_SEC_FOLDER_TARGET]

GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_PREFIX_MAPPING_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING]
	CHECK CONSTRAINT [FK_TB_DIM_PREFIX_MAPPING_TE_DIM_ITEM_TYPE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_PREFIX_MAPPING_ITEM_TYPE_ID]
	ON [dbo].[TB_DIM_PREFIX_MAPPING] ([ITEM_TYPE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_PREFIX_MAPPING_TARGET_FOLDER_ID]
	ON [dbo].[TB_DIM_PREFIX_MAPPING] ([TARGET_FOLDER_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the item prefix mappings configured in the application. These prefixes are used to move items into specified target security folders in the folder hierarchy. Multiple prefixes can be defined for a particular item type. The prefix management job reads all these prefix mappings and moves the items of the specified types into the relavant target security folder. The prefixes are always matched to the internal name of the item i.e. the INTERNAL_NAME field in the specific dimension table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'PREFIX_MAPPING_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER which is place holder folder for the prefixes. This is also the root folder where all the items should exist by default so that the prefix mapping job will move them. This is usually the tenant folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_TYPE corresponding to the item type for which the prefix is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual prefix string. This should be of the SQL format so that a like comparison can be done. For example, ''ASD%'' prefix will be used for all items whos internal name begin with the string ''ASD'', or ''%ASD_%'' will lookup for all the items whos internal name contains the string ''ASD_'' and so on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'PREFIX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER which is the target place holder folder for all items of the specified item type and the specified prefix.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'TARGET_FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the priority in which the prefix matching should be executed. Lower the number higher is the priority of execution.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'PRIORITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the prefix mapping information is set for archive or not. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the prefix mapping is enabled or not. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the prefix mapping is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the prefix mapping is owned by the system or not. Value 1 indicates system owned prefix mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_PREFIX_MAPPING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_PREFIX_MAPPING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_PREFIX_MAPPING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_PREFIX_MAPPING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_PREFIX_MAPPING]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_PREFIX_MAPPING] SET (LOCK_ESCALATION = TABLE)
GO
