SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_MASTER_SCRIPT] (
		[MASTER_SCRIPT_ID]        [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[CURRENT_VERSION]         [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ETL_MASTER_SCRIPT]
		PRIMARY KEY
		CLUSTERED
		([MASTER_SCRIPT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_MASTER_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_MASTER_SCRIPT_MASTER_SCRIPT_ID]
	DEFAULT (newid()) FOR [MASTER_SCRIPT_ID]
GO
ALTER TABLE [dbo].[TB_ETL_MASTER_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_MASTER_SCRIPT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the logical dtsx package scripts used by components in TB_ETL_COMPONENT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_MASTER_SCRIPT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_MASTER_SCRIPT', 'COLUMN', N'MASTER_SCRIPT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the master script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_MASTER_SCRIPT', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A brief description about the master script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_MASTER_SCRIPT', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The current version of this master script. This maps to a physical record in TB_ETL_SCRIPT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_MASTER_SCRIPT', 'COLUMN', N'CURRENT_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_MASTER_SCRIPT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_MASTER_SCRIPT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_MASTER_SCRIPT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_MASTER_SCRIPT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_MASTER_SCRIPT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ETL_MASTER_SCRIPT] SET (LOCK_ESCALATION = TABLE)
GO
