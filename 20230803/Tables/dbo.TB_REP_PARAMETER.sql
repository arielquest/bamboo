SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_PARAMETER] (
		[PARAMETER_ID]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_ID]                  [uniqueidentifier] NOT NULL,
		[DEPENDENT_PARAMETER_ID]     [uniqueidentifier] NULL,
		[PROMPT]                     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[NAME]                       [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DATA_TYPE]                  [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARAMETER_TYPE]             [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[ITEM_TYPE_ID]               [uniqueidentifier] NULL,
		[DEFAULT_VALUE]              [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[ALLOW_BLANK]                [bit] NOT NULL,
		[PARAMETER_ORDER]            [tinyint] NOT NULL,
		[ARCHIVED]                   [bit] NOT NULL,
		[ENABLED]                    [bit] NOT NULL,
		[HIDDEN]                     [bit] NOT NULL,
		[SYSTEM]                     [bit] NOT NULL,
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_REPORT_PARAMETER_REPORT_ID_NAME]
		UNIQUE
		NONCLUSTERED
		([REPORT_ID], [NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_REPORT_PARAMETER]
		PRIMARY KEY
		CLUSTERED
		([PARAMETER_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [CK_TB_REP_REPORT_PARAMETER_DEPENDENT_PARAMETER_ID_PARAMETER_ID]
	CHECK
	([PARAMETER_ID]<>[DEPENDENT_PARAMETER_ID] OR [DEPENDENT_PARAMETER_ID] IS NULL)
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
CHECK CONSTRAINT [CK_TB_REP_REPORT_PARAMETER_DEPENDENT_PARAMETER_ID_PARAMETER_ID]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_PARAMETER_ID]
	DEFAULT (newid()) FOR [PARAMETER_ID]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_ALLOW_BLANK]
	DEFAULT ((1)) FOR [ALLOW_BLANK]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_PARAMETER_ORDER]
	DEFAULT ((0)) FOR [PARAMETER_ORDER]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_TB_REP_REPORT]

GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_TE_DIM_ITEM_TYPE]

GO
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_TB_REP_REPORT_PARAMETER_DEPENDENT_PARAMETER_ID]
	FOREIGN KEY ([DEPENDENT_PARAMETER_ID]) REFERENCES [dbo].[TB_REP_PARAMETER] ([PARAMETER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_TB_REP_REPORT_PARAMETER_DEPENDENT_PARAMETER_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_PARAMETER_DEPENDENT_PARAMETER_ID]
	ON [dbo].[TB_REP_PARAMETER] ([DEPENDENT_PARAMETER_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_PARAMETER_ITEM_TYPE_ID]
	ON [dbo].[TB_REP_PARAMETER] ([ITEM_TYPE_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all parameters associated with the reports.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id in TB_REP_REPORT corrspoding to the report to which the the parameter is associated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the PARAMETER_ID in TB_REP_PARAMETER corrspoding to the parameter that this parameter is dependant on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'DEPENDENT_PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an identifier for caption that is displayed besides the parameter set selection combobox or textbox on the parameter selection section of the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'PROMPT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the paramter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual datatype for the paramter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'DATA_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of parameter as they appear on the report. For example List, DateTime, Date, Time, Boolean etc. It can be used for example a List of integers (DATA_TYPE)', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'PARAMETER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_TYPE of the item type associated with the paramter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the default value for the paramter if specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'DEFAULT_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the parameter can be blank or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'ALLOW_BLANK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an integer value indicating the order in which the parameter appears when the report is run.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'PARAMETER_ORDER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is owned by the system or not. Value of 1 indicates system owned parameter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_PARAMETER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_PARAMETER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_PARAMETER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_PARAMETER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER] SET (LOCK_ESCALATION = TABLE)
GO
