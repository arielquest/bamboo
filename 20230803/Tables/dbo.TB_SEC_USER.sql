SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_USER] (
		[USER_ID]                        [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]                      [uniqueidentifier] NOT NULL,
		[OWNER_ID]                       [uniqueidentifier] NULL,
		[USER_TYPE]                      [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[LOGIN_NAME]                     [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PASS_PHRASE]                    [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[DESCRIPTION]                    [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[EMAIL]                          [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[FIRST_NAME]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAST_NAME]                      [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[PASS_PHRASE_HINT]               [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[HOME_FOLDER_ID]                 [uniqueidentifier] NULL,
		[DEFAULT_GADGET_SET_ID]          [uniqueidentifier] NULL,
		[LAST_LOGIN]                     [datetime] NULL,
		[FAILED_ATTEMPTS]                [smallint] NOT NULL,
		[ACCOUNT_LOCKED]                 [bit] NOT NULL,
		[PASS_PHRASE_EXPIRED]            [bit] NOT NULL,
		[PASS_PHRASE_NEVER_EXPIRES]      [bit] NOT NULL,
		[PASS_PHRASE_CHANGE_ENABLED]     [bit] NOT NULL,
		[EFFECTIVE_FROM]                 [smalldatetime] NOT NULL,
		[EFFECTIVE_TO]                   [smalldatetime] NOT NULL,
		[CREATED_BY]                     [uniqueidentifier] NULL,
		[CREATED_DATE]                   [smalldatetime] NOT NULL,
		[LAST_MODIFIED_BY]               [uniqueidentifier] NULL,
		[LAST_MODIFIED_DATE]             [smalldatetime] NULL,
		[EXPERT]                         [bit] NOT NULL,
		[ARCHIVED]                       [bit] NOT NULL,
		[TENANT_BIZ_URN]                 [int] NOT NULL,
		[DELETED]                        [bit] NOT NULL,
		[ENABLED]                        [bit] NOT NULL,
		[HIDDEN]                         [bit] NOT NULL,
		[SYSTEM]                         [bit] NOT NULL,
		[LOCAL_LOGIN_ENABLED]            [bit] NOT NULL,
		[XML_DATA]                       [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SEC_USER]
		PRIMARY KEY
		CLUSTERED
		([USER_ID])
	ON [SECGROUP]
) ON [SECGROUP] TEXTIMAGE_ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [CK_TB_SEC_USER_EMAIL]
	CHECK
	([EMAIL]=N'' OR [EMAIL] like N'%@%')
GO
ALTER TABLE [dbo].[TB_SEC_USER]
CHECK CONSTRAINT [CK_TB_SEC_USER_EMAIL]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [CK_TB_SEC_USER_USER_TYPE]
	CHECK
	([USER_TYPE]=N'U' OR ([USER_TYPE]=N'G' OR ([USER_TYPE]=N'D' OR [USER_TYPE]=N'C')))
GO
ALTER TABLE [dbo].[TB_SEC_USER]
CHECK CONSTRAINT [CK_TB_SEC_USER_USER_TYPE]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_USER_ID]
	DEFAULT (newid()) FOR [USER_ID]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_USER_TYPE]
	DEFAULT ('U') FOR [USER_TYPE]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_EMAIL]
	DEFAULT (N'') FOR [EMAIL]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_FIRST_NAME]
	DEFAULT (N'') FOR [FIRST_NAME]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_LAST_NAME]
	DEFAULT (N'') FOR [LAST_NAME]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_PASS_PHRASE_HINT]
	DEFAULT (N'') FOR [PASS_PHRASE_HINT]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_FAILED_ATTEMPTS]
	DEFAULT ((0)) FOR [FAILED_ATTEMPTS]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_ACCOUNT_LOCKED]
	DEFAULT ((0)) FOR [ACCOUNT_LOCKED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_PASS_PHRASE_EXPIRED]
	DEFAULT ((0)) FOR [PASS_PHRASE_EXPIRED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_PASS_PHRASE_NEVER_EXPIRES]
	DEFAULT ((0)) FOR [PASS_PHRASE_NEVER_EXPIRES]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_PASS_PHRASE_CHANGE_ENABLED]
	DEFAULT ((1)) FOR [PASS_PHRASE_CHANGE_ENABLED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_CREATED_DATE]
	DEFAULT (getutcdate()) FOR [CREATED_DATE]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_EXPERT]
	DEFAULT ((0)) FOR [EXPERT]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_LOCAL_LOGIN_ENABLED]
	DEFAULT ((0)) FOR [LOCAL_LOGIN_ENABLED]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	ADD
	CONSTRAINT [DF_TB_SEC_USER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_SEC_USER_CREATED_BY]
	FOREIGN KEY ([CREATED_BY]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_SEC_USER_CREATED_BY]

GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_SEC_USER_LAST_MODIFIED_BY]
	FOREIGN KEY ([LAST_MODIFIED_BY]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_SEC_USER_LAST_MODIFIED_BY]

GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_SEC_FOLDER_HOME_FOLDER_ID]
	FOREIGN KEY ([HOME_FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_SEC_FOLDER_HOME_FOLDER_ID]

GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_SEC_FOLDER_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_SEC_FOLDER_OWNER_ID]

GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_ADM_GADGET_SET_GADGET_SET_ID]
	FOREIGN KEY ([DEFAULT_GADGET_SET_ID]) REFERENCES [dbo].[TB_ADM_GADGET_SET] ([GADGET_SET_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_ADM_GADGET_SET_GADGET_SET_ID]

GO
ALTER TABLE [dbo].[TB_SEC_USER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_USER_TB_DIM_TENANT_TENANT_BIZ_URN]
	FOREIGN KEY ([TENANT_BIZ_URN]) REFERENCES [dbo].[TB_DIM_TENANT] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_USER]
	CHECK CONSTRAINT [FK_TB_SEC_USER_TB_DIM_TENANT_TENANT_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_CREATED_BY]
	ON [dbo].[TB_SEC_USER] ([CREATED_BY])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_DEFAULT_GADGET_SET_ID]
	ON [dbo].[TB_SEC_USER] ([DEFAULT_GADGET_SET_ID])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_HOME_FOLDER_ID]
	ON [dbo].[TB_SEC_USER] ([HOME_FOLDER_ID])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_LAST_MODIFIED_BY]
	ON [dbo].[TB_SEC_USER] ([LAST_MODIFIED_BY])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_LOGIN_NAME]
	ON [dbo].[TB_SEC_USER] ([LOGIN_NAME])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_FOLDER_ID_USER_TYPE_DELETED]
	ON [dbo].[TB_SEC_USER] ([FOLDER_ID], [USER_TYPE], [DELETED])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_USER_TYPE_DELETED_ENABLED]
	ON [dbo].[TB_SEC_USER] ([USER_TYPE], [DELETED], [ENABLED])
	INCLUDE ([LOGIN_NAME], [FOLDER_ID], [EFFECTIVE_TO], [USER_ID])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_DELETED_ENABLED]
	ON [dbo].[TB_SEC_USER] ([DELETED], [ENABLED])
	INCLUDE ([USER_TYPE], [LOGIN_NAME], [FOLDER_ID], [EFFECTIVE_TO], [USER_ID])
	ON [SECINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_SEC_USER_GROUPS_LOGIN_NAME_FOLDER_ID]
	ON [dbo].[TB_SEC_USER] ([LOGIN_NAME], [FOLDER_ID])
	WHERE (([DELETED]=(0) AND [USER_TYPE]='G'))
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_USER_TENANT_BIZ_URN]
	ON [dbo].[TB_SEC_USER] ([TENANT_BIZ_URN])
	ON [SECINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the secirty users and groups of the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is id of the folder from TB_SEC_FOLDER. This is the place holder for the user in the security tree.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the tenant folder that is the root for the folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the type of the user. U: Normal user, G: Security Group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'USER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name for a normal user or the name of security group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'LOGIN_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the pass phrase for the normal user. This is not relavant for security groups.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'PASS_PHRASE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the security user or group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the email address associated with the security user or the group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'EMAIL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the first name of the security user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'FIRST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the last name of the security user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'LAST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the security hint for users in case of a forgotten pass phrase.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'PASS_PHRASE_HINT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This home folder ID of the user from TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'HOME_FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the default set of gadgets identifier from TB_ADM_GADGET_SET.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'DEFAULT_GADGET_SET_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the user last logged in.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'LAST_LOGIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the number of failed login attempts by the sercurity user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'FAILED_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user''s account has been locked or not. Value of 1 indicates account locked.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'ACCOUNT_LOCKED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user''s pass phrase has expired or not. Value of 1 indicated pass phrase expired.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'PASS_PHRASE_EXPIRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user''s pass phrase will never expire. Value of 1 indicated pass phrase never expires.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'PASS_PHRASE_NEVER_EXPIRES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag idicating whether the security user can change their pass phrase or not. Value of 1 indicates that the user can change their pass phrase.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'PASS_PHRASE_CHANGE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the security user or group will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the security user or group will seize to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the security user from the same table who created the current security user or group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'CREATED_BY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp when the security user or group was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'CREATED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the security user from the same table who last modified the current security user or group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'LAST_MODIFIED_BY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp when the security user or group was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'LAST_MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating when the security user has expert mode enabled. Value of 1 indicated expert mode enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'EXPERT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user is set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The tenant that this user is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user or group has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user or group is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user or group is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security user or group is owned by the system or not. Value of 1 indicates system owned security user or group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This flag indicates whether local logins are enabled for the user. This only applies for users and not for groups.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'LOCAL_LOGIN_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_USER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_USER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_USER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_USER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_USER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_USER]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_USER]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_SEC_USER]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_USER]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_USER]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_USER]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_SEC_USER] SET (LOCK_ESCALATION = TABLE)
GO
