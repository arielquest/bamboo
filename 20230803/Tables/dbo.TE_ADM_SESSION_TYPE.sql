SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_SESSION_TYPE] (
		[SESSION_TYPE_ID]         [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_ADM_SESSION_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TE_ADM_SESSION_TYPE]
		PRIMARY KEY
		CLUSTERED
		([SESSION_TYPE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_SESSION_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_SESSION_TYPE_SESSION_TYPE_ID]
	DEFAULT (newid()) FOR [SESSION_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_ADM_SESSION_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_SESSION_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_ADM_SESSION_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_SESSION_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the possible audit session types in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', 'COLUMN', N'SESSION_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the session type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the session type. This is unique. This name is prefixed with ST_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the session type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates whether the session type is system defined or not.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_SESSION_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_ADM_SESSION_TYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_ADM_SESSION_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_SESSION_TYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_ADM_SESSION_TYPE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_ADM_SESSION_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
