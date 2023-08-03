SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_REPORT_OWC_DATA] (
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[SEQUENCE]                [int] NOT NULL,
		[TYPE]                    [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[VALUE]                   [nvarchar](2800) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_REPORT_OWC_DATA]
		PRIMARY KEY
		CLUSTERED
		([REPORT_ID], [SEQUENCE], [TYPE])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_OWC_DATA]
	ADD
	CONSTRAINT [CK_TB_REP_REPORT_OWC_DATA]
	CHECK
	([TYPE]='O' OR ([TYPE]='D' OR ([TYPE]='C' OR [TYPE]='Q')))
GO
ALTER TABLE [dbo].[TB_REP_REPORT_OWC_DATA]
CHECK CONSTRAINT [CK_TB_REP_REPORT_OWC_DATA]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_OWC_DATA]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_OWC_DATA_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_OWC_DATA]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_OWC_DATA_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_OWC_DATA]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_OWC_DATA_TB_REP_REPORT]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the office web component data set for Analyzer reports.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_OWC_DATA', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier for the record. This is the id in TB_REP_REPORT corresponding to the analyzer report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_OWC_DATA', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier for the record. This is the sequence in which the string in the VALUE column is broken down for the current report and current Type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_OWC_DATA', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier for the record. This is a charactor flag indicating the type of the OWC data. O: OWC Data, D: DA Data, C: Charts, Q: Query', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_OWC_DATA', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the string value corresponding to the Report, the sequence and the type. This can be a fragment of there are more than one sequence for a Report and a type of OWC data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_OWC_DATA', 'COLUMN', N'VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_OWC_DATA', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_REPORT_OWC_DATA]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_REPORT_OWC_DATA]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT_OWC_DATA]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_REPORT_OWC_DATA]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_OWC_DATA] SET (LOCK_ESCALATION = TABLE)
GO
