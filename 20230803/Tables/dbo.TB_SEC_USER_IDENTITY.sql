SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_USER_IDENTITY] (
		[USER_IDENTITY_ID]                  [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[USER_ID]                           [uniqueidentifier] NOT NULL,
		[IDENTITY_PROVIDER_TYPE]            [nvarchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
		[IDENTITY_SUBJECT_ID]               [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[IDENTITY_SUBJECT_DISPLAY_NAME]     [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]               [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SEC_USER_IDENTITY]
		PRIMARY KEY
		CLUSTERED
		([USER_IDENTITY_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_USER_IDENTITY]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_IDENTITY_USER_IDENTITY_ID]
	DEFAULT (newid()) FOR [USER_IDENTITY_ID]
GO
ALTER TABLE [dbo].[TB_SEC_USER_IDENTITY]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_IDENTITY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_USER_IDENTITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_IDENTITY_TB_SEC_USER_USER_ID]
	FOREIGN KEY ([USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER_IDENTITY]
	CHECK CONSTRAINT [FK_TB_SEC_USER_IDENTITY_TB_SEC_USER_USER_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_IDENTITY_USER_ID]
	ON [dbo].[TB_SEC_USER_IDENTITY] ([USER_ID])
	ON [SECINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the security authentication identity provider details for users of the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', 'COLUMN', N'USER_IDENTITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to the table TB_SEC_USER. This identifies the user for which the authentication identity is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This identifies the user identity provider type. Current supported values are idsrv: Local login, windows: Active Directory, adfs: Active Directory Federation Services, azuread: Azure Active Directory', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', 'COLUMN', N'IDENTITY_PROVIDER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'String representing the users unique identification for the corresponding identity provider type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', 'COLUMN', N'IDENTITY_SUBJECT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'String representing the users friendly display name for the corresponding identity provider type. For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', 'COLUMN', N'IDENTITY_SUBJECT_DISPLAY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER_IDENTITY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_USER_IDENTITY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_USER_IDENTITY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_USER_IDENTITY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_USER_IDENTITY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_USER_IDENTITY] SET (LOCK_ESCALATION = TABLE)
GO
