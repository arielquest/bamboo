SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_XML] (
		[XML_ID]                  [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]               [uniqueidentifier] NULL,
		[TYPE]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[XML_DATA]                [varbinary](max) NULL,
		[ENABLED]                 [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_XML]
		PRIMARY KEY
		CLUSTERED
		([XML_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_XML_ID]
	DEFAULT (newid()) FOR [XML_ID]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_XML]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_XML_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_XML]
	CHECK CONSTRAINT [FK_TB_ADM_XML_TB_SEC_FOLDER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_XML_FOLDER_ID]
	ON [dbo].[TB_ADM_XML] ([FOLDER_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds system configuration XML data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'XML_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the place holder for the configuration XML in the resource tree if specified. This is the foreign key from the TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the type of configuration xml data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the configuration xml data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the configuration xml data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the configuration xml data is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the configuration xml data has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the configuration xml data is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the configuration xml data is owned by system or not. Value of 1 indicates system owned configuration xml data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_XML]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_XML]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_XML]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_XML]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_XML]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ADM_XML] SET (LOCK_ESCALATION = TABLE)
GO
