SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CLU_CONNECTION_STATUS] (
		[CONNECTION_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[STATUS]                  [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAST_STATUS_CHANGE]      [datetime] NOT NULL,
		[LAST_STATUS_CHECK]       [datetime] NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_CLU_CONNECTION_STATUS]
		PRIMARY KEY
		CLUSTERED
		([CONNECTION_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
	ADD
	CONSTRAINT [CK_TB_CLU_CONNECTION_STATUS_STATUS]
	CHECK
	([STATUS]='I' OR [STATUS]='A')
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
CHECK CONSTRAINT [CK_TB_CLU_CONNECTION_STATUS_STATUS]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_STATUS_STATUS]
	DEFAULT ('I') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_STATUS_LAST_STATUS_CHANGE]
	DEFAULT (getutcdate()) FOR [LAST_STATUS_CHECK]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_STATUS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_CONNECTION_STATUS_TB_CLU_CONNECTION_ID]
	FOREIGN KEY ([CONNECTION_ID]) REFERENCES [dbo].[TB_CLU_CONNECTION] ([CONNECTION_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS]
	CHECK CONSTRAINT [FK_TB_CLU_CONNECTION_STATUS_TB_CLU_CONNECTION_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the connection status information for physical connections. It is updated by the connection monitoring code for each of the separate system components', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION_STATUS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier. Foreign key to TB_CLU_CONNECTION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION_STATUS', 'COLUMN', N'CONNECTION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the current connection status. A: Active, I: Inactive', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION_STATUS', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC datetime stamp when the status for the connection was last changed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION_STATUS', 'COLUMN', N'LAST_STATUS_CHANGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC datetime stamp when the status of the connection was last tested.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION_STATUS', 'COLUMN', N'LAST_STATUS_CHECK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION_STATUS', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_CONNECTION_STATUS]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION_STATUS] SET (LOCK_ESCALATION = TABLE)
GO
