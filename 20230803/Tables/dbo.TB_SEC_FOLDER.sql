SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_FOLDER] (
		[FOLDER_ID]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_URN]              [bigint] IDENTITY(5, 4) NOT FOR REPLICATION NOT NULL,
		[OWNER_ID]                [uniqueidentifier] NULL,
		[PARENT_ID]               [uniqueidentifier] NULL,
		[LINK_SOURCE_ID]          [uniqueidentifier] NULL,
		[POLICY_ID]               [uniqueidentifier] NOT NULL,
		[FOLDER_TYPE]             [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[PATH]                    [nvarchar](450) COLLATE Latin1_General_CI_AS NOT NULL,
		[DEPTH]                   [tinyint] NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[EFFECTIVE_FROM]          [datetime] NOT NULL,
		[EFFECTIVE_TO]            [datetime] NULL,
		[POLICY_ROOT]             [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NULL,
		[CREATION_DATE]           [smalldatetime] NOT NULL,
		[MODIFIED_DATE]           [smalldatetime] NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[CONTAINER]               [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[TEMPLATE]                [bit] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SEC_FOLDER_FOLDER_URN]
		UNIQUE
		NONCLUSTERED
		([FOLDER_URN])
		ON [SECINDEXGROUP],
		CONSTRAINT [PK_TB_SEC_FOLDER]
		PRIMARY KEY
		CLUSTERED
		([FOLDER_ID])
	ON [SECGROUP]
) ON [SECGROUP] TEXTIMAGE_ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [CK_TB_SEC_FOLDER_TYPE]
	CHECK
	([FOLDER_TYPE]='L' OR ([FOLDER_TYPE]='F' OR [FOLDER_TYPE]='T'))
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
CHECK CONSTRAINT [CK_TB_SEC_FOLDER_TYPE]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_FOLDER_ID]
	DEFAULT (newid()) FOR [FOLDER_ID]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_DEPTH]
	DEFAULT ((255)) FOR [DEPTH]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_NAME]
	DEFAULT (N'') FOR [NAME]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_POLICY_ROOT]
	DEFAULT ((0)) FOR [POLICY_ROOT]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_CONTAINER]
	DEFAULT ((0)) FOR [CONTAINER]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_TEMPLATE]
	DEFAULT ((0)) FOR [TEMPLATE]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_FOLDER_TB_SEC_FOLDER_PARENT]
	FOREIGN KEY ([PARENT_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	CHECK CONSTRAINT [FK_TB_SEC_FOLDER_TB_SEC_FOLDER_PARENT]

GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_FOLDER_TB_SEC_FOLDER_LINK_SOURCE]
	FOREIGN KEY ([LINK_SOURCE_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	CHECK CONSTRAINT [FK_TB_SEC_FOLDER_TB_SEC_FOLDER_LINK_SOURCE]

GO
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_FOLDER_TB_SEC_POLICY]
	FOREIGN KEY ([POLICY_ID]) REFERENCES [dbo].[TB_SEC_POLICY] ([POLICY_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_FOLDER]
	CHECK CONSTRAINT [FK_TB_SEC_FOLDER_TB_SEC_POLICY]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_FOLDER_LINK_SOURCE_ID]
	ON [dbo].[TB_SEC_FOLDER] ([LINK_SOURCE_ID])
	ON [SECGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_FOLDER_PARENT_ID]
	ON [dbo].[TB_SEC_FOLDER] ([PARENT_ID])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_FOLDER_FOLDER_TYPE]
	ON [dbo].[TB_SEC_FOLDER] ([FOLDER_TYPE])
	INCLUDE ([PATH], [HIDDEN])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_FOLDER_HIDDEN_PATH_POLICY_ID]
	ON [dbo].[TB_SEC_FOLDER] ([HIDDEN])
	INCLUDE ([PATH], [POLICY_ID])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_FOLDER_POLICY_DELETED_PATH_PARENT_ID_FOLDER_TYPE]
	ON [dbo].[TB_SEC_FOLDER] ([POLICY_ID], [DELETED])
	INCLUDE ([PATH], [PARENT_ID], [FOLDER_TYPE])
	ON [SECINDEXGROUP]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_SEC_FOLDER]
	ON [dbo].[TB_SEC_FOLDER] ([PATH])
	INCLUDE ([POLICY_ID], [DELETED])
	ON [SECINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the security folders in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an auto generated unique number for each record. This is used to process dimension in analysis services database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the tenant folder that is the root for the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from the same table corresponding to the immediate parent of the current folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'PARENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from the same table corresponding one other folder that the current folder is linked to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'LINK_SOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the security policy associated with the folder. This is a foreign key to TB_SEC_POLICY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'POLICY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the type of the folder. F: Folder, T: Tenant, L: Linked folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'FOLDER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the full path of the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'PATH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the depth of the folder in the hierarchy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'DEPTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the the folder will be become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the folder will seize to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security policy associated with the folder is the root. Value of 1 indicates root policy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'POLICY_ROOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user in TB_SEC_USER who created the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user in TB_SEC_USER who last modified the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time when the folder was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time when the folder was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the folder has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the folder has been set as a container. Value of 1 indicates container.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'CONTAINER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the folder has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the folder is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the folder is owned by system or not. Value of 1 indicates system owned folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the folder is a template or not. Value of 1 indicates template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'TEMPLATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this folder', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer maintained XML data block for this folder', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_FOLDER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_FOLDER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_FOLDER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_FOLDER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_FOLDER]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_FOLDER]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_SEC_FOLDER]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_FOLDER]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_FOLDER]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_FOLDER]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER] SET (LOCK_ESCALATION = TABLE)
GO
