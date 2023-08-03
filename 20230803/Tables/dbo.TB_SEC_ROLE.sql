SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_ROLE] (
		[ROLE_ID]                 [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[GLOBAL_ROLE]             [bit] NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SEC_ROLE_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME], [GLOBAL_ROLE])
		ON [SECINDEXGROUP],
		CONSTRAINT [PK_TB_SEC_ROLE]
		PRIMARY KEY
		CLUSTERED
		([ROLE_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_ROLE_ID]
	DEFAULT (newid()) FOR [ROLE_ID]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_SYSTEM_ROLE]
	DEFAULT ((0)) FOR [GLOBAL_ROLE]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the security roles defined in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'ROLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the security role. This is unique along with the column GLOBAL_ROLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the security role.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the role is global or path based. Value of 1 indicates global role.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'GLOBAL_ROLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security role has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security role is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security role is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security role is owned by the system or not. Value of 1 indicates system owned security role.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_ROLE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_ROLE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_ROLE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_ROLE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE] SET (LOCK_ESCALATION = TABLE)
GO
