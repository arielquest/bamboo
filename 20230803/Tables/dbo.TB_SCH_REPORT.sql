SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_REPORT] (
		[SCH_REPORT_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[DELIVERY_TYPE]           [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[RENDER_ENGINE]           [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[RENDER_FORMAT]           [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[DELIVERY_XML]            [xml] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_REPORT]
		PRIMARY KEY
		CLUSTERED
		([SCH_REPORT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	ADD
	CONSTRAINT [CK_TB_SCH_REPORT_DELIVERY_TYPE]
	CHECK
	([DELIVERY_TYPE]='C' OR [DELIVERY_TYPE]='F' OR [DELIVERY_TYPE]='E')
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
CHECK CONSTRAINT [CK_TB_SCH_REPORT_DELIVERY_TYPE]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	ADD
	CONSTRAINT [CK_TB_SCH_REPORT_RENDER_ENGINE]
	CHECK
	([RENDER_ENGINE]='R' OR [RENDER_ENGINE]='F')
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
CHECK CONSTRAINT [CK_TB_SCH_REPORT_RENDER_ENGINE]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	ADD
	CONSTRAINT [CK_TB_SCH_REPORT_RENDER_FORMAT]
	CHECK
	([RENDER_FORMAT]='M' OR [RENDER_FORMAT]='C' OR [RENDER_FORMAT]='E' OR [RENDER_FORMAT]='P' OR [RENDER_FORMAT]='H')
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
CHECK CONSTRAINT [CK_TB_SCH_REPORT_RENDER_FORMAT]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	ADD
	CONSTRAINT [DF_TB_SCH_REPORT_SCH_REPORT_ID]
	DEFAULT (newid()) FOR [SCH_REPORT_ID]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	ADD
	CONSTRAINT [DF_TB_SCH_REPORT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_REPORT_TB_SCH_TASK]
	FOREIGN KEY ([SCH_REPORT_ID]) REFERENCES [dbo].[TB_SCH_TASK] ([TASK_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_REPORT]
	CHECK CONSTRAINT [FK_TB_SCH_REPORT_TB_SCH_TASK]

GO
ALTER TABLE [dbo].[TB_SCH_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_REPORT_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_REPORT]
	CHECK CONSTRAINT [FK_TB_SCH_REPORT_TB_REP_REPORT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_REPORT_REPORT_ID]
	ON [dbo].[TB_SCH_REPORT] ([REPORT_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a derived table of TB_SCH_TASK containing the derived information for a report schedule (R).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier. This is a foreign key to TB_SCH_TASK referencing TASK_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'SCH_REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_REP_REPORT indicating the report to be executed for the task.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the delivery type of the executed report. Possible values are; F: File share delivery, E: Email delivery.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'DELIVERY_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the rendering engine to be used for the report execution. Possible values are; R: Reporting services render engine, F: FYI rendering engine,', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'RENDER_ENGINE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the render format for the report. Possible values are; C: csv, E: xlsx, P: pdf, H: htm.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'RENDER_FORMAT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic information of the delivery of the scheduled report. For example, information about file share or information about email delivery.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'DELIVERY_XML'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_REPORT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_REPORT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_REPORT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_REPORT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_REPORT]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT] SET (LOCK_ESCALATION = TABLE)
GO
