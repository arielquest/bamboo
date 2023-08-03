SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_REPORT_RDL] (
		[REPORT_RDL_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[REPORT_RDL]              [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_REPORT_RDL_REPORT_ID]
		UNIQUE
		NONCLUSTERED
		([REPORT_ID])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_REPORT_RDL]
		PRIMARY KEY
		CLUSTERED
		([REPORT_RDL_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_RDL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_RDL_REPORT_RDL_ID]
	DEFAULT (newid()) FOR [REPORT_RDL_ID]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_RDL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_RDL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_RDL]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_RDL_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_RDL]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_RDL_TB_REP_REPORT]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all RDL definition for all the reports.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_RDL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_RDL', 'COLUMN', N'REPORT_RDL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_REPORT indicating the report for which the RDL is stored. This is uniqiue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_RDL', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the complete RDL definition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_RDL', 'COLUMN', N'REPORT_RDL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_RDL', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_REPORT_RDL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_REPORT_RDL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT_RDL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_REPORT_RDL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_RDL] SET (LOCK_ESCALATION = TABLE)
GO
