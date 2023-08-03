SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_REPORT_EXTRA] (
		[REPORT_EXTRA_ID]         [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[SEQUENCE]                [int] NOT NULL,
		[XML_DATA]                [nvarchar](2000) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_REPORT_EXTRA_REPORT_ID_SEQUENCE]
		UNIQUE
		NONCLUSTERED
		([REPORT_ID], [SEQUENCE])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_REPORT_EXTRA]
		PRIMARY KEY
		CLUSTERED
		([REPORT_EXTRA_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_EXTRA]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_EXTRA_REPORT_EXTRA_ID]
	DEFAULT (newid()) FOR [REPORT_EXTRA_ID]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_EXTRA]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_EXTRA_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_EXTRA]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_EXTRA_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_EXTRA]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_EXTRA_TB_REP_REPORT]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds any custom xml information associated with any report that requires XML information.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_EXTRA', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_EXTRA', 'COLUMN', N'REPORT_EXTRA_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_REPORT corresponding to the report for which the custom information is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_EXTRA', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the sequence in which the xml string is segmented. This sequence is used to rebuild the entire xml information together.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_EXTRA', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual xml segment corresponding to the sequence for the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_EXTRA', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_EXTRA', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_REPORT_EXTRA]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_REPORT_EXTRA]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT_EXTRA]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_REPORT_EXTRA]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_EXTRA] SET (LOCK_ESCALATION = TABLE)
GO
