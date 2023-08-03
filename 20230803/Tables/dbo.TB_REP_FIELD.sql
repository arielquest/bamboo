SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_FIELD] (
		[FIELD_ID]                [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[DATASET]                 [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[FIELD_NAME]              [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DATA_TYPE]               [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[THRESHOLD]               [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_FIELD]
		PRIMARY KEY
		CLUSTERED
		([FIELD_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_FIELD]
	ADD
	CONSTRAINT [DF_TB_REP_FIELD_FIELD_ID]
	DEFAULT (newid()) FOR [FIELD_ID]
GO
ALTER TABLE [dbo].[TB_REP_FIELD]
	ADD
	CONSTRAINT [DF_TB_REP_FIELD_THRESHOLD]
	DEFAULT ((0)) FOR [THRESHOLD]
GO
ALTER TABLE [dbo].[TB_REP_FIELD]
	ADD
	CONSTRAINT [DF_TB_REP_FIELD_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_FIELD]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_FIELD_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_FIELD]
	CHECK CONSTRAINT [FK_TB_REP_FIELD_TB_REP_REPORT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_FIELD_REPORT_ID]
	ON [dbo].[TB_REP_FIELD] ([REPORT_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is not used. This is deprecated and will be removed from future versions. Hence it is not documented.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_FIELD', NULL, NULL
GO
GRANT DELETE
	ON [dbo].[TB_REP_FIELD]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_FIELD]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_FIELD]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_FIELD]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_FIELD] SET (LOCK_ESCALATION = TABLE)
GO
