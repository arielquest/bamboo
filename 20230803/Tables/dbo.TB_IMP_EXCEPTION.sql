SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_EXCEPTION] (
		[EXCEPTION_ID]            [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[SESSION_ID]              [uniqueidentifier] NOT NULL,
		[SOURCE_FILE]             [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[LINE_NUMBER]             [int] NULL,
		[STACK_TRACE]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[EXCEPTION_MESSAGE]       [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_IMP_EXCEPTION]
		PRIMARY KEY
		CLUSTERED
		([EXCEPTION_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_EXCEPTION]
	ADD
	CONSTRAINT [DF_TB_IMP_EXCEPTIONE_EXCEPTION_ID]
	DEFAULT (newid()) FOR [EXCEPTION_ID]
GO
ALTER TABLE [dbo].[TB_IMP_EXCEPTION]
	ADD
	CONSTRAINT [DF_TB_IMP_EXCEPTION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_EXCEPTION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_EXCEPTION_TB_ADM_SESSION]
	FOREIGN KEY ([SESSION_ID]) REFERENCES [dbo].[TB_ADM_SESSION] ([SESSION_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_EXCEPTION]
	CHECK CONSTRAINT [FK_TB_IMP_EXCEPTION_TB_ADM_SESSION]

GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_EXCEPTION_SESSION_ID]
	ON [dbo].[TB_IMP_EXCEPTION] ([SESSION_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores runtime exceptions that have occured in the data importer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'EXCEPTION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the session from TB_ADM_SESSION during which the exception occured. This is a foreign key to TB_ADM_SESSION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the source code file where the exception occured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'SOURCE_FILE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the line number in the source code file where the exception occured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'LINE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the stack trace of the exception.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'STACK_TRACE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the exception message.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'EXCEPTION_MESSAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the cluster resource from TB_CLU_RESOURCE associated with the exception. This can be used to find out if the exception is specific to a particular source or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_EXCEPTION', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_IMP_EXCEPTION]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_IMP_EXCEPTION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_EXCEPTION]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_IMP_EXCEPTION]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_EXCEPTION] SET (LOCK_ESCALATION = TABLE)
GO
