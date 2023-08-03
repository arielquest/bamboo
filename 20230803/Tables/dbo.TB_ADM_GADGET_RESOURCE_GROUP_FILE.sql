SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[RESOURCE_GROUP_ID]       [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[USAGE_TYPE]              [tinyint] NOT NULL,
		[RELATIVE_PATH]           [nvarchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[FILE_DATA]               [varbinary](max) NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_GADGET_RESOURCE_GROUP_FILE]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_RESOURCE_GROUP_FILE_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_RESOURCE_GROUP_FILE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_RESOURCE_GROUP_FILE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_RESOURCE_GROUP_FILE_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_RESOURCE_GROUP_FILE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_RESOURCE_GROUP_FILE_TB_ADM_RESOURCE_GROUP_RESOURCE_GROUP_ID]
	FOREIGN KEY ([RESOURCE_GROUP_ID]) REFERENCES [dbo].[TB_ADM_RESOURCE_GROUP] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_RESOURCE_GROUP_FILE_TB_ADM_RESOURCE_GROUP_RESOURCE_GROUP_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores files that are related to a group. For example common files under /Gadgets/Common/<group path>/.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for this file.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_RESOURCE_GROUP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'RESOURCE_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the file (with extension).', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Defines the type of file. 0: Common File', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'USAGE_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Relative path of the file.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'RELATIVE_PATH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The file data (compressed)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'FILE_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_RESOURCE_GROUP_FILE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_RESOURCE_GROUP_FILE] SET (LOCK_ESCALATION = TABLE)
GO
