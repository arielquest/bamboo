SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ETL_AUDIT_TYPE] (
		[AUDIT_TYPE_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_ETL_AUDIT_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TE_ETL_AUDIT_TYPE]
		PRIMARY KEY
		CLUSTERED
		([AUDIT_TYPE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ETL_AUDIT_TYPE]
	ADD
	CONSTRAINT [DF_TE_ETL_AUDIT_TYPE_AUDIT_TYPE_ID]
	DEFAULT (newid()) FOR [AUDIT_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_ETL_AUDIT_TYPE]
	ADD
	CONSTRAINT [DF_TE_ETL_AUDIT_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an enumeration table that stores the possible audit types associated with ETL operations.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ETL_AUDIT_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ETL_AUDIT_TYPE', 'COLUMN', N'AUDIT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The display name for the audit type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ETL_AUDIT_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The systems internal name for the audit type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ETL_AUDIT_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the audit type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ETL_AUDIT_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ETL_AUDIT_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_ETL_AUDIT_TYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_ETL_AUDIT_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ETL_AUDIT_TYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_ETL_AUDIT_TYPE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_ETL_AUDIT_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
