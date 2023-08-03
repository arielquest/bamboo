SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CLU_SERVER] (
		[SERVER_ID]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[SERVER_NAME]             [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DEFAULT_ADDRESS]         [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_CLU_SERVER_SERVER_NAME]
		UNIQUE
		NONCLUSTERED
		([SERVER_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_CLU_SERVER]
		PRIMARY KEY
		CLUSTERED
		([SERVER_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_SERVER]
	ADD
	CONSTRAINT [DF_TB_CLU_SERVER_SERVER_ID]
	DEFAULT (newid()) FOR [SERVER_ID]
GO
ALTER TABLE [dbo].[TB_CLU_SERVER]
	ADD
	CONSTRAINT [DF_TB_CLU_SERVER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_CLU_SERVER]
	ADD
	CONSTRAINT [DF_TB_CLU_SERVER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the physical servers configured under cluster management.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', 'COLUMN', N'SERVER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the machine name of the physical server.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', 'COLUMN', N'SERVER_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the default address on the network for the physical server. It can be either a domain name or IP address.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', 'COLUMN', N'DEFAULT_ADDRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the physical server is owned by system or not. Value of 1 indicates system owned physical server.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this server', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_SERVER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_SERVER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_SERVER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_SERVER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_SERVER]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_SERVER]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_SERVER]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_SERVER]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_SERVER]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_SERVER] SET (LOCK_ESCALATION = TABLE)
GO
