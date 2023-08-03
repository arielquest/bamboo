SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_PASS_PHRASE_HISTORY] (
		[USER_ID]                 [uniqueidentifier] NOT NULL,
		[CHANGE_TIME]             [datetime] NOT NULL,
		[PASS_PHRASE]             [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SEC_PASS_PHRASE_HISTORY]
		PRIMARY KEY
		CLUSTERED
		([USER_ID], [CHANGE_TIME])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	ADD
	CONSTRAINT [DF_TB_SEC_PASS_PHRASE_HISTORY_CHANGE_TIME]
	DEFAULT (getutcdate()) FOR [CHANGE_TIME]
GO
ALTER TABLE [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	ADD
	CONSTRAINT [DF_TB_SEC_PASS_PHRASE_HISTORY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_PASS_PHRASE_HISTORY_TB_SEC_USER]
	FOREIGN KEY ([USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	CHECK CONSTRAINT [FK_TB_SEC_PASS_PHRASE_HISTORY_TB_SEC_USER]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores a histroy of changed pass phrases for all the users of the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_PASS_PHRASE_HISTORY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier. This is the id of the user in TB_SEC_USER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_PASS_PHRASE_HISTORY', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier. This the UTC date time when the pass phrase was changed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_PASS_PHRASE_HISTORY', 'COLUMN', N'CHANGE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the pass phrase for the user before it was changed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_PASS_PHRASE_HISTORY', 'COLUMN', N'PASS_PHRASE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_PASS_PHRASE_HISTORY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_PASS_PHRASE_HISTORY]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_SEC_PASS_PHRASE_HISTORY] SET (LOCK_ESCALATION = TABLE)
GO
