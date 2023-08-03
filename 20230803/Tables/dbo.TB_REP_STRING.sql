SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_STRING] (
		[STRING_ID]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_MODEL_ID]         [uniqueidentifier] NOT NULL,
		[LOOKUP_VALUE]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[CULTURE]                 [nvarchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_STRING]          [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_STRING_LOOKUP_VALUE_CULTURE]
		UNIQUE
		NONCLUSTERED
		([REPORT_MODEL_ID], [LOOKUP_VALUE], [CULTURE])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_REP_STRING]
		PRIMARY KEY
		CLUSTERED
		([STRING_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_STRING]
	ADD
	CONSTRAINT [DF_TB_REP_STRING_STRING_ID]
	DEFAULT (newid()) FOR [STRING_ID]
GO
ALTER TABLE [dbo].[TB_REP_STRING]
	ADD
	CONSTRAINT [DF_TB_REP_STRING_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_STRING]
	ADD
	CONSTRAINT [DF_TB_REP_STRING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_STRING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_STRING_TB_REP_REPORT_MODEL]
	FOREIGN KEY ([REPORT_MODEL_ID]) REFERENCES [dbo].[TB_REP_REPORT_MODEL] ([REPORT_MODEL_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_STRING]
	CHECK CONSTRAINT [FK_TB_REP_STRING_TB_REP_REPORT_MODEL]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds internationalised strings for various components of a report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'STRING_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the report model as in TB_REP_REPORT_MODEL corresponding to the current internationalised string.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'REPORT_MODEL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the lookup key for the internationalised string.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'LOOKUP_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is string indicating the culture of the internationalised string.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'CULTURE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual internationalised string corresponding to the report, category, culture and the lookup value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'DISPLAY_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is system owned or not. Value 1 indicates system owned record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_STRING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_STRING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_STRING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_STRING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_STRING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_STRING]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_REP_STRING] SET (LOCK_ESCALATION = TABLE)
GO
