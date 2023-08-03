SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_CLU_CONNECTION_TYPE] (
		[CONNECTION_TYPE_ID]      [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_CLU_CONNECTION_TYPE]
		PRIMARY KEY
		CLUSTERED
		([CONNECTION_TYPE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_CLU_CONNECTION_TYPE]
	ADD
	CONSTRAINT [DF_TE_CLU_CONNECTION_TYPE_CONNECTION_TYPE_ID]
	DEFAULT (newid()) FOR [CONNECTION_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_CLU_CONNECTION_TYPE]
	ADD
	CONSTRAINT [DF_TE_CLU_CONNECTION_TYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_CLU_CONNECTION_TYPE]
	ADD
	CONSTRAINT [DF_TE_CLU_CONNECTION_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_CLU_CONNECTION_TYPE]
	ADD
	CONSTRAINT [DF_TE_CLU_CONNECTION_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an enumeration table that stores the possible audit types associated with ETL operations.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'CONNECTION_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The display name for the connection type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The systems internal name for the connection type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the connection type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates that this item was created by the installer.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this item is deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_CONNECTION_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_CLU_CONNECTION_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_CLU_CONNECTION_TYPE]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TE_CLU_CONNECTION_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TE_CLU_CONNECTION_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TE_CLU_CONNECTION_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TE_CLU_CONNECTION_TYPE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TE_CLU_CONNECTION_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
