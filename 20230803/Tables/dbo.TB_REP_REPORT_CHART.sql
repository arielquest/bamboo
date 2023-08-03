SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_REPORT_CHART] (
		[REPORT_CHART_ID]         [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[REPORT_CHART_JSON]       [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_REPORT_CHART]
		PRIMARY KEY
		CLUSTERED
		([REPORT_CHART_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_CHART_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_CHART_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_CHART_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_CHART_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_CHART_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_CHART_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_CHART_TB_REP_REPORT]

GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_CHART_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_CHART_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_CHART_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_CHART]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_CHART_TB_SEC_USER_MODIFIED_BY_ID]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_REP_REPORT_CHART_REPORT_ID_NAME]
	ON [dbo].[TB_REP_REPORT_CHART] ([REPORT_ID], [NAME])
	WHERE (([DELETED]=(0)))
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_CHART_CREATED_BY_ID]
	ON [dbo].[TB_REP_REPORT_CHART] ([CREATED_BY_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_CHART_MODIFIED_BY_ID]
	ON [dbo].[TB_REP_REPORT_CHART] ([MODIFIED_BY_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_CHART_REPORT_ID]
	ON [dbo].[TB_REP_REPORT_CHART] ([REPORT_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores information pertaining to visualisation persistence.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'REPORT_CHART_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_REP_REPORT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the report chart.  When combined with REPORT_ID, this is unique.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The JSON definition of the report chart.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'REPORT_CHART_JSON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_CHART', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_REPORT_CHART]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_REPORT_CHART]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT_CHART]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_REPORT_CHART]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT_CHART]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_CHART] SET (LOCK_ESCALATION = TABLE)
GO
