SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_SCRIPT] (
		[SCRIPT_ID]                  [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[MASTER_SCRIPT_ID]           [uniqueidentifier] NOT NULL,
		[VERSION]                    [int] NOT NULL,
		[COMMENT]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[SCRIPT_DATA]                [varchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[DATE_TIME]                  [datetime] NOT NULL,
		[SCRIPT_DATA_COMPRESSED]     [bit] NOT NULL,
		[SYSTEM]                     [bit] NOT NULL,
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ETL_SCRIPT]
		PRIMARY KEY
		CLUSTERED
		([SCRIPT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_SCRIPT_SCRIPT_ID]
	DEFAULT (newid()) FOR [SCRIPT_ID]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_SCRIPT_DATE_TIME]
	DEFAULT (getutcdate()) FOR [DATE_TIME]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_SCRIPT_SCRIPT_DATA_COMPRESSED]
	DEFAULT ((0)) FOR [SCRIPT_DATA_COMPRESSED]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_SCRIPT_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	ADD
	CONSTRAINT [DF_TB_ETL_SCRIPT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_SCRIPT_TB_ETL_MASTER_SCRIPT]
	FOREIGN KEY ([MASTER_SCRIPT_ID]) REFERENCES [dbo].[TB_ETL_MASTER_SCRIPT] ([MASTER_SCRIPT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_SCRIPT]
	CHECK CONSTRAINT [FK_TB_ETL_SCRIPT_TB_ETL_MASTER_SCRIPT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_SCRIPT_MASTER_SCRIPT_ID]
	ON [dbo].[TB_ETL_SCRIPT] ([MASTER_SCRIPT_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds physical dtsx package scripts used by components in TB_ETL_COMPONENT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'SCRIPT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ETL_MASTER_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'MASTER_SCRIPT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The version of this script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Brief comment indicating the reason for this script change', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'COMMENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The physical dtsx xml script. The scripts may be stored as compressed or normal. If stored as compressed then SCRIPT_DATA_COMRESSED flag will be set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'SCRIPT_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC datetime indicating when the script was loaded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Boolean flag indicating whether the dtsx script in column SCRIPT_DATA is compressed or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'SCRIPT_DATA_COMPRESSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating if this is a standard non-customised script.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_SCRIPT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_SCRIPT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_SCRIPT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_SCRIPT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_SCRIPT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ETL_SCRIPT] SET (LOCK_ESCALATION = TABLE)
GO
