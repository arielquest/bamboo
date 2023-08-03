SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_REPORT_PARAMETER] (
		[REPORT_PARAMETER_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[SCH_REPORT_ID]           [uniqueidentifier] NOT NULL,
		[PARAMETER_ID]            [uniqueidentifier] NOT NULL,
		[VALUE]                   [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[PARAMETER_SET_ID]        [uniqueidentifier] NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_REPORT_PARAMETER]
		PRIMARY KEY
		CLUSTERED
		([REPORT_PARAMETER_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SCH_REPORT_PARAMETER_REPORT_PARAMETER_ID]
	DEFAULT (newid()) FOR [REPORT_PARAMETER_ID]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SCH_REPORT_PARAMETER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_REPORT_PARAMETER_TB_REP_PARAMETER_SET]
	FOREIGN KEY ([PARAMETER_SET_ID]) REFERENCES [dbo].[TB_REP_PARAMETER_SET] ([PARAMETER_SET_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	CHECK CONSTRAINT [FK_TB_SCH_REPORT_PARAMETER_TB_REP_PARAMETER_SET]

GO
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_REPORT_PARAMETER_TB_REP_PARAMETER]
	FOREIGN KEY ([PARAMETER_ID]) REFERENCES [dbo].[TB_REP_PARAMETER] ([PARAMETER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	CHECK CONSTRAINT [FK_TB_SCH_REPORT_PARAMETER_TB_REP_PARAMETER]

GO
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_REPORT_PARAMETER_TB_SCH_REPORT]
	FOREIGN KEY ([SCH_REPORT_ID]) REFERENCES [dbo].[TB_SCH_REPORT] ([SCH_REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER]
	CHECK CONSTRAINT [FK_TB_SCH_REPORT_PARAMETER_TB_SCH_REPORT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_REPORT_PARAMETER_PARAMETER_ID]
	ON [dbo].[TB_SCH_REPORT_PARAMETER] ([PARAMETER_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_REPORT_PARAMETER_PARAMETER_SET_ID]
	ON [dbo].[TB_SCH_REPORT_PARAMETER] ([PARAMETER_SET_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_REPORT_PARAMETER_SCH_REPORT_ID]
	ON [dbo].[TB_SCH_REPORT_PARAMETER] ([SCH_REPORT_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores information about the report parameters to be used for scheduled reports.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', 'COLUMN', N'REPORT_PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SCH_REPORT indicating the scheduled report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', 'COLUMN', N'SCH_REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_REP_PARAMETER indicating the report parameter to be used when executing the scheduled report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', 'COLUMN', N'PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the value for the parameter to the used when executing the scheduled report. This can be absolute value or the ID of a report parameter set from TB_REP_PARAMETER_SET if the parameter is of type parameter set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', 'COLUMN', N'VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_REP_PARAMETER_SET indicating the parameter set to be used when executing the scheduled report. This is set only if PARAMETER_ID points to a paramter of type Set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', 'COLUMN', N'PARAMETER_SET_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_PARAMETER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_REPORT_PARAMETER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_REPORT_PARAMETER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_REPORT_PARAMETER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_REPORT_PARAMETER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_REPORT_PARAMETER]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_PARAMETER] SET (LOCK_ESCALATION = TABLE)
GO
