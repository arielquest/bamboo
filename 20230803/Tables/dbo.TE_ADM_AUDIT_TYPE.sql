SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_AUDIT_TYPE] (
		[AUDIT_TYPE_ID]           [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_ADM_AUDIT_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TE_ADM_AUDIT_TYPE]
		PRIMARY KEY
		CLUSTERED
		([AUDIT_TYPE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_AUDIT_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_AUDIT_TYPE_AUDIT_TYPE_ID]
	DEFAULT (newid()) FOR [AUDIT_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_ADM_AUDIT_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_AUDIT_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the possible audit types in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_AUDIT_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_AUDIT_TYPE', 'COLUMN', N'AUDIT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the audit type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_AUDIT_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the audit type. This is unique. This name is prefixed with AT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_AUDIT_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the audit type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_AUDIT_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_AUDIT_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_ADM_AUDIT_TYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_ADM_AUDIT_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_AUDIT_TYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_ADM_AUDIT_TYPE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_ADM_AUDIT_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
