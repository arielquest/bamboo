SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_SESSION] (
		[SESSION_ID]                  [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[SESSION_TYPE_ID]             [uniqueidentifier] NOT NULL,
		[SESSION_COMPUTER]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[SESSION_CLIENT_COMPUTER]     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[SESSION_USER_NAME]           [nvarchar](70) COLLATE Latin1_General_CI_AS NOT NULL,
		[SESSION_USER_ID]             [uniqueidentifier] NULL,
		[SESSION_USER_AGENT]          [nvarchar](250) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]         [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_SESSION]
		PRIMARY KEY
		NONCLUSTERED
		([SESSION_ID])
	ON [ADMINDEXGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_SESSION]
	ADD
	CONSTRAINT [DF_TB_ADM_SESSION_SESSION_ID]
	DEFAULT (newid()) FOR [SESSION_ID]
GO
ALTER TABLE [dbo].[TB_ADM_SESSION]
	ADD
	CONSTRAINT [DF_TB_ADM_SESSION_SESSION_COMPUTER]
	DEFAULT (CONVERT([nvarchar](50),serverproperty('machinename'))) FOR [SESSION_COMPUTER]
GO
ALTER TABLE [dbo].[TB_ADM_SESSION]
	ADD
	CONSTRAINT [DF_TB_ADM_SESSION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_SESSION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_SESSION_TE_ADM_SESSION_TYPE]
	FOREIGN KEY ([SESSION_TYPE_ID]) REFERENCES [dbo].[TE_ADM_SESSION_TYPE] ([SESSION_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_SESSION]
	CHECK CONSTRAINT [FK_TB_ADM_SESSION_TE_ADM_SESSION_TYPE]

GO
ALTER TABLE [dbo].[TB_ADM_SESSION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_SESSION_TB_SEC_USER]
	FOREIGN KEY ([SESSION_USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_SESSION]
	CHECK CONSTRAINT [FK_TB_ADM_SESSION_TB_SEC_USER]

GO
CREATE CLUSTERED INDEX [IX_TB_ADM_SESSION_SESSION_COMPUTER_SESSION_USER_SESSION_TYPE]
	ON [dbo].[TB_ADM_SESSION] ([SESSION_COMPUTER], [SESSION_USER_NAME], [SESSION_TYPE_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_SESSION_SESSION_TYPE_ID]
	ON [dbo].[TB_ADM_SESSION] ([SESSION_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_SESSION_SESSION_USER_ID]
	ON [dbo].[TB_ADM_SESSION] ([SESSION_USER_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the audit session in the application. Session may be reused again based on the Session Type, Session Computer, Session Client Computer, Session User and Session User Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the session type. This is a foreign key to TE_ADM_SESSION_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the hostname or IP address of the machine where the session was originated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_COMPUTER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the hostname or IP address of the client of the machine where the session was originated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_CLIENT_COMPUTER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name of the user initiated the session. This may be a user defined in TB_SEC_USER table or any other windows user depending on the session type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_USER_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user initiated the session. This may be a user defined in TB_SEC_USER table or any other windows user depending on the session type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a device or software identifier that was used to initiate the session. Example may be Internet Explorer, Google Chrome etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'SESSION_USER_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SESSION', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_ADM_SESSION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_SESSION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_SESSION]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_ADM_SESSION]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_SESSION]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_SESSION]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_SESSION]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_SESSION]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_SESSION] SET (LOCK_ESCALATION = TABLE)
GO
