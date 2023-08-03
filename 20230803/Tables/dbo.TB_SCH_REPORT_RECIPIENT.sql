SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SCH_REPORT_RECIPIENT] (
		[REPORT_RECIPIENT_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[SCH_REPORT_ID]           [uniqueidentifier] NOT NULL,
		[RECIPIENT_XML]           [xml] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_REPORT_RECIPIENT]
		PRIMARY KEY
		CLUSTERED
		([REPORT_RECIPIENT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_RECIPIENT]
	ADD
	CONSTRAINT [DF_TB_SCH_REPORT_RECIPIENT_REPORT_RECIPIENT_ID]
	DEFAULT (newid()) FOR [REPORT_RECIPIENT_ID]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_RECIPIENT]
	ADD
	CONSTRAINT [DF_TB_SCH_REPORT_RECIPIENT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_RECIPIENT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_REPORT_RECIPIENT_TB_SCH_REPORT]
	FOREIGN KEY ([SCH_REPORT_ID]) REFERENCES [dbo].[TB_SCH_REPORT] ([SCH_REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_REPORT_RECIPIENT]
	CHECK CONSTRAINT [FK_TB_SCH_REPORT_RECIPIENT_TB_SCH_REPORT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_REPORT_RECIPIENT_SCH_REPORT_ID]
	ON [dbo].[TB_SCH_REPORT_RECIPIENT] ([SCH_REPORT_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables stores information about the recipients of a scheduled report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_RECIPIENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_RECIPIENT', 'COLUMN', N'REPORT_RECIPIENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SCH_REPORT indicating the scheduled report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_RECIPIENT', 'COLUMN', N'SCH_REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic xml blob containing extra recipient information if any.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_RECIPIENT', 'COLUMN', N'RECIPIENT_XML'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_REPORT_RECIPIENT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_REPORT_RECIPIENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_REPORT_RECIPIENT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_REPORT_RECIPIENT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_REPORT_RECIPIENT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_REPORT_RECIPIENT]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_SCH_REPORT_RECIPIENT] SET (LOCK_ESCALATION = TABLE)
GO
