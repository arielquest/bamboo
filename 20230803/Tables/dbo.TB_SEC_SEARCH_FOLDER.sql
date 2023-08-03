SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_SEARCH_FOLDER] (
		[SEARCH_FOLDER_ID]        [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[PARENT_FOLDER_ID]        [uniqueidentifier] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[SEARCH_QUERY]            [nvarchar](1000) COLLATE Latin1_General_CI_AS NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [smalldatetime] NOT NULL,
		[MODIFIED_DATE]           [smalldatetime] NOT NULL,
		[GLOBAL]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SEC_SEARCH_FOLDER]
		PRIMARY KEY
		CLUSTERED
		([SEARCH_FOLDER_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_SEARCH_FOLDER_SEARCH_FOLDER_ID]
	DEFAULT (newid()) FOR [SEARCH_FOLDER_ID]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_SEARCH_FOLDER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_SEARCH_FOLDER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_SEARCH_FOLDER_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_SEARCH_FOLDER_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	ADD
	CONSTRAINT [DF_TB_SEC_SEARCH_FOLDER_GLOBAL]
	DEFAULT ((1)) FOR [GLOBAL]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_SEARCH_FOLDER_TB_SEC_FOLDER]
	FOREIGN KEY ([PARENT_FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER]
	CHECK CONSTRAINT [FK_TB_SEC_SEARCH_FOLDER_TB_SEC_FOLDER]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_SEC_SEARCH_FOLDER_NON_GLOBAL_UNIQUE_NAME]
	ON [dbo].[TB_SEC_SEARCH_FOLDER] ([PARENT_FOLDER_ID], [NAME], [CREATED_BY_ID])
	WHERE (([GLOBAL]=(0)))
	ON [SECINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_SEC_SEARCH_FOLDER_GLOBAL_UNIQUE_NAME]
	ON [dbo].[TB_SEC_SEARCH_FOLDER] ([PARENT_FOLDER_ID], [NAME])
	WHERE (([GLOBAL]=(1)))
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_SEARCH_FOLDER_PARENT_FOLDER_ID]
	ON [dbo].[TB_SEC_SEARCH_FOLDER] ([PARENT_FOLDER_ID])
	ON [SECGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds definitions for user specific search folders diaplayed in system manager.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'SEARCH_FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_SEC_FOLDER. Defines the folder that the search folder belongs to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'PARENT_FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name for this search folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Description for this search folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The search engine query used to retrieve items displayed in this folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'SEARCH_QUERY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this folder can be managed by the end user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user in TB_SEC_USER who created the search folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user in TB_SEC_USER who last modified the search folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time when the search folder was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time when the search folder was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is a global or user based search folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'GLOBAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_SEARCH_FOLDER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_SEARCH_FOLDER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_SEARCH_FOLDER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_SEARCH_FOLDER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_SEARCH_FOLDER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_SEARCH_FOLDER]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_SEC_SEARCH_FOLDER] SET (LOCK_ESCALATION = TABLE)
GO
