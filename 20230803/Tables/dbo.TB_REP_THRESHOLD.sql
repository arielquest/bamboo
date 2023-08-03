SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_THRESHOLD] (
		[THRESHOLD_ID]            [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[ATTRIBUTE_ID]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DATA_TYPE]               [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[META_TYPE]               [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[THRESHOLD_TYPE]          [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[RELATION]                [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[LOW_VALUE]               [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_VALUE]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[LOW_STYLE]               [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_STYLE]              [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[LOW_VALUE_1]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_VALUE_1]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[RELATION_1]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STYLE_BOLD_1]            [bit] NULL,
		[STYLE_UNDERLINE_1]       [bit] NULL,
		[STYLE_ITALIC_1]          [bit] NULL,
		[STYLE_FORE_COLOR_1]      [int] NULL,
		[STYLE_BACK_COLOR_1]      [int] NULL,
		[LOW_VALUE_2]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_VALUE_2]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[RELATION_2]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STYLE_BOLD_2]            [bit] NULL,
		[STYLE_UNDERLINE_2]       [bit] NULL,
		[STYLE_ITALIC_2]          [bit] NULL,
		[STYLE_FORE_COLOR_2]      [int] NULL,
		[STYLE_BACK_COLOR_2]      [int] NULL,
		[LOW_VALUE_3]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_VALUE_3]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[RELATION_3]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STYLE_BOLD_3]            [bit] NULL,
		[STYLE_UNDERLINE_3]       [bit] NULL,
		[STYLE_ITALIC_3]          [bit] NULL,
		[STYLE_FORE_COLOR_3]      [int] NULL,
		[STYLE_BACK_COLOR_3]      [int] NULL,
		[LOW_VALUE_4]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_VALUE_4]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[RELATION_4]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STYLE_BOLD_4]            [bit] NULL,
		[STYLE_UNDERLINE_4]       [bit] NULL,
		[STYLE_ITALIC_4]          [bit] NULL,
		[STYLE_FORE_COLOR_4]      [int] NULL,
		[STYLE_BACK_COLOR_4]      [int] NULL,
		[LOW_VALUE_5]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HIGH_VALUE_5]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[RELATION_5]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STYLE_BOLD_5]            [bit] NULL,
		[STYLE_UNDERLINE_5]       [bit] NULL,
		[STYLE_ITALIC_5]          [bit] NULL,
		[STYLE_FORE_COLOR_5]      [int] NULL,
		[STYLE_BACK_COLOR_5]      [int] NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_THRESHOLD_REPORT_ID_ATTRIBUTE_ID]
		UNIQUE
		NONCLUSTERED
		([REPORT_ID], [ATTRIBUTE_ID])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_THRESHOLD]
		PRIMARY KEY
		CLUSTERED
		([THRESHOLD_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_1]
	CHECK
	([RELATION_1]='I' OR [RELATION_1]='N' OR [RELATION_1]='B' OR [RELATION_1]='D' OR [RELATION_1]='E' OR [RELATION_1]='H' OR [RELATION_1]='M' OR [RELATION_1]='G' OR [RELATION_1]='L')
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
CHECK CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_1]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_2]
	CHECK
	([RELATION_2]='I' OR [RELATION_2]='N' OR [RELATION_2]='B' OR [RELATION_2]='D' OR [RELATION_2]='E' OR [RELATION_2]='H' OR [RELATION_2]='M' OR [RELATION_2]='G' OR [RELATION_2]='L')
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
CHECK CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_2]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_3]
	CHECK
	([RELATION_3]='I' OR [RELATION_3]='N' OR [RELATION_3]='B' OR [RELATION_3]='D' OR [RELATION_3]='E' OR [RELATION_3]='H' OR [RELATION_3]='M' OR [RELATION_3]='G' OR [RELATION_3]='L')
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
CHECK CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_3]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_4]
	CHECK
	([RELATION_4]='I' OR [RELATION_4]='N' OR [RELATION_4]='B' OR [RELATION_4]='D' OR [RELATION_4]='E' OR [RELATION_4]='H' OR [RELATION_4]='M' OR [RELATION_4]='G' OR [RELATION_4]='L')
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
CHECK CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_4]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_5]
	CHECK
	([RELATION_5]='I' OR [RELATION_5]='N' OR [RELATION_5]='B' OR [RELATION_5]='D' OR [RELATION_5]='E' OR [RELATION_5]='H' OR [RELATION_5]='M' OR [RELATION_5]='G' OR [RELATION_5]='L')
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
CHECK CONSTRAINT [CK_TB_REP_THRESHOLD_RELATION_5]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_THRESHOLD_ID]
	DEFAULT (newid()) FOR [THRESHOLD_ID]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	ADD
	CONSTRAINT [DF_TB_REP_THRESHOLD_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_THRESHOLD_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_THRESHOLD]
	CHECK CONSTRAINT [FK_TB_REP_THRESHOLD_TB_REP_REPORT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_THRESHOLD_REPORT_ID]
	ON [dbo].[TB_REP_THRESHOLD] ([REPORT_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the threshold information for all the reports for which thresholds are defined. This holds the calculation rules and the data display details for the defined thresholds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'THRESHOLD_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id corresponding to the report in TB_REP_REPORT for which the current threshold is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id corresponding to the attribute defined in the semantic model which this threshold acts upon.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'ATTRIBUTE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the data type of the data on which the threshold is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'DATA_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the meta type of the data on which the threshold is defined which defines how the data is formatted and displayed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'META_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string indicating the threshold type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'THRESHOLD_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the record is set for archive or not. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the threshold is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the threshold is enabled or not. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the threshold is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the threshold is system owned or not. Value 1 indicates system owned threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RHS value corresponding to the first threshold relation. In case of BETWEEN relation this is the low value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'LOW_VALUE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the high value in case of a BETWEEN relation for the first threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'HIGH_VALUE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor indicating the threshold relation for the data for the first threshold. This can have values like L: Less than, G: Greater than, M: Less than or equal, H: Greater than or equal, E: Equal, D: Not equal, B: Between, N: Not between, I: In.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'RELATION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the first threshold should be bold or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BOLD_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the first threshold should the underlined or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_UNDERLINE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the first threshold should be italic or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_ITALIC_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the fore colour for the values matching the first threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_FORE_COLOR_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the back colour for the values matching the first threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BACK_COLOR_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RHS value corresponding to the second threshold relation. In case of BETWEEN relation this is the low value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'LOW_VALUE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the high value in case of a BETWEEN relation for the second threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'HIGH_VALUE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor indicating the threshold relation for the data for the second threshold. This can have values like L: Less than, G: Greater than, M: Less than or equal, H: Greater than or equal, E: Equal, D: Not equal, B: Between, N: Not between, I: In.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'RELATION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the first threshold should be bold or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BOLD_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the second threshold should the underlined or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_UNDERLINE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the second threshold should be italic or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_ITALIC_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the fore colour for the values matching the second threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_FORE_COLOR_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the back colour for the values matching the second threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BACK_COLOR_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RHS value corresponding to the third threshold relation. In case of BETWEEN relation this is the low value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'LOW_VALUE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the high value in case of a BETWEEN relation for the thrid threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'HIGH_VALUE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor indicating the threshold relation for the data for the third threshold. This can have values like L: Less than, G: Greater than, M: Less than or equal, H: Greater than or equal, E: Equal, D: Not equal, B: Between, N: Not between, I: In.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'RELATION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the third threshold should be bold or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BOLD_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the third threshold should the underlined or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_UNDERLINE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the third threshold should be italic or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_ITALIC_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the fore colour for the values matching the third threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_FORE_COLOR_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the back colour for the values matching the third threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BACK_COLOR_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RHS value corresponding to the fourth threshold relation. In case of BETWEEN relation this is the low value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'LOW_VALUE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the high value in case of a BETWEEN relation for the fourth threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'HIGH_VALUE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor indicating the threshold relation for the data for the fourth threshold. This can have values like L: Less than, G: Greater than, M: Less than or equal, H: Greater than or equal, E: Equal, D: Not equal, B: Between, N: Not between, I: In.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'RELATION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the fourth threshold should be bold or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BOLD_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the fourth threshold should the underlined or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_UNDERLINE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the fourth threshold should be italic or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_ITALIC_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the fore colour for the values matching the fourth threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_FORE_COLOR_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the back colour for the values matching the fourth threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BACK_COLOR_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RHS value corresponding to the fifth threshold relation. In case of BETWEEN relation this is the low value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'LOW_VALUE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the high value in case of a BETWEEN relation for the fifth threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'HIGH_VALUE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor indicating the threshold relation for the data for the fifth threshold. This can have values like L: Less than, G: Greater than, M: Less than or equal, H: Greater than or equal, E: Equal, D: Not equal, B: Between, N: Not between, I: In.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'RELATION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the fifth threshold should be bold or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BOLD_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the fifth threshold should the underlined or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_UNDERLINE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the values matching the fifth threshold should be italic or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_ITALIC_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the fore colour for the values matching the fifth threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_FORE_COLOR_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is the value of the back colour for the values matching the fifth threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'STYLE_BACK_COLOR_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_THRESHOLD', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_THRESHOLD]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_THRESHOLD]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_THRESHOLD]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_THRESHOLD]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_THRESHOLD]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_REP_THRESHOLD] SET (LOCK_ESCALATION = TABLE)
GO
