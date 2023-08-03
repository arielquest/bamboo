SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_INFORMATION_NOTICE] (
		[INFORMATION_NOTICE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]                 [uniqueidentifier] NOT NULL,
		[SUBJECT]                   [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[CONTENT]                   [nvarchar](2830) COLLATE Latin1_General_CI_AS NOT NULL,
		[EFFECTIVE_FROM]            [datetime] NOT NULL,
		[EFFECTIVE_TO]              [datetime] NOT NULL,
		[CREATED_BY_ID]             [uniqueidentifier] NULL,
		[MODIFIED_BY_ID]            [uniqueidentifier] NULL,
		[CREATION_DATE]             [smalldatetime] NOT NULL,
		[MODIFIED_DATE]             [smalldatetime] NOT NULL,
		[DELETED]                   [bit] NOT NULL,
		[ENABLED]                   [bit] NOT NULL,
		[SYSTEM]                    [bit] NOT NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SEC_INFORMATION_NOTICE]
		PRIMARY KEY
		CLUSTERED
		([INFORMATION_NOTICE_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_INFORMATION_NOTICE_ID]
	DEFAULT (newid()) FOR [INFORMATION_NOTICE_ID]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_SUBJECT]
	DEFAULT (N'') FOR [SUBJECT]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_CONTENT]
	DEFAULT (N'') FOR [CONTENT]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	ADD
	CONSTRAINT [DF_TB_SEC_INFORMATION_NOTICE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_INFORMATION_NOTICE_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	CHECK CONSTRAINT [FK_TB_SEC_INFORMATION_NOTICE_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_INFORMATION_NOTICE_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	CHECK CONSTRAINT [FK_TB_SEC_INFORMATION_NOTICE_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_INFORMATION_NOTICE_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE]
	CHECK CONSTRAINT [FK_TB_SEC_INFORMATION_NOTICE_MODIFIED_BY_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_INFORMATION_NOTICE_CREATED_BY_ID]
	ON [dbo].[TB_SEC_INFORMATION_NOTICE] ([CREATED_BY_ID])
	ON [SECGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_INFORMATION_NOTICE_FOLDER_ID]
	ON [dbo].[TB_SEC_INFORMATION_NOTICE] ([FOLDER_ID])
	ON [SECGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_INFORMATION_NOTICE_MODIFIED_BY_ID]
	ON [dbo].[TB_SEC_INFORMATION_NOTICE] ([MODIFIED_BY_ID])
	ON [SECGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the security information notices created in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'INFORMATION_NOTICE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the folder from TB_SEC_FOLDER which is the place holder for the information notice in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the subject for the information notice.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'SUBJECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the main content for the information notice. The data may or may not be stored in HTML style.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'CONTENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the information notice becomes active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the information notice will expire.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user from TB_SEC_USER who created the information notice.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user from TB_SEC_USER who last modified the information notice.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp when the information notice was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp when the information notice was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the information notice has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the information notice is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the information notice is owned by system or not. Value of 1 indicates system owned information notice.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_INFORMATION_NOTICE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_INFORMATION_NOTICE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_INFORMATION_NOTICE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_INFORMATION_NOTICE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_INFORMATION_NOTICE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_INFORMATION_NOTICE] SET (LOCK_ESCALATION = TABLE)
GO
