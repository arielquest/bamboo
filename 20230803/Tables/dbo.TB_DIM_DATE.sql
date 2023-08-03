SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_DATE] (
		[DATE_URN]                [int] NOT NULL,
		[STD_WEEK_ID]             [char](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[STD_MONTH_ID]            [char](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[FISCAL_YEAR_URN]         [int] NULL,
		[FISCAL_QUARTER_URN]      [int] NULL,
		[FISCAL_MONTH_URN]        [int] NULL,
		[FISCAL_WEEK_URN]         [int] NULL,
		[YEAR]                    [smallint] NULL,
		[MONTH]                   [tinyint] NULL,
		[DAY]                     [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[HOLIDAY]                 [bit] NOT NULL,
		[DATE_VALUE]              [smalldatetime] NULL,
		[DATE_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[DATE_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_DATE]
		PRIMARY KEY
		CLUSTERED
		([DATE_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	ADD
	CONSTRAINT [DF_TB_DIM_DATE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	ADD
	CONSTRAINT [DF_TB_DIM_DATE_HOLIDAY]
	DEFAULT ((0)) FOR [HOLIDAY]
GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_DATE_STD_MONTH]
	FOREIGN KEY ([STD_MONTH_ID]) REFERENCES [dbo].[TB_DIM_DATE_STD_MONTH] ([MONTH_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_DATE_STD_MONTH]

GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_DATE_STD_WEEK]
	FOREIGN KEY ([STD_WEEK_ID]) REFERENCES [dbo].[TB_DIM_DATE_STD_WEEK] ([WEEK_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_DATE_STD_WEEK]

GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_YEAR]
	FOREIGN KEY ([FISCAL_YEAR_URN]) REFERENCES [dbo].[TB_DIM_FISCAL_YEAR] ([FISCAL_YEAR_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_YEAR]

GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_QUARTER]
	FOREIGN KEY ([FISCAL_QUARTER_URN]) REFERENCES [dbo].[TB_DIM_FISCAL_QUARTER] ([FISCAL_QUARTER_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_QUARTER]

GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_MONTH]
	FOREIGN KEY ([FISCAL_MONTH_URN]) REFERENCES [dbo].[TB_DIM_FISCAL_MONTH] ([FISCAL_MONTH_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_MONTH]

GO
ALTER TABLE [dbo].[TB_DIM_DATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_WEEK]
	FOREIGN KEY ([FISCAL_WEEK_URN]) REFERENCES [dbo].[TB_DIM_FISCAL_WEEK] ([FISCAL_WEEK_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_TB_DIM_FISCAL_WEEK]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_STD_MONTH_ID]
	ON [dbo].[TB_DIM_DATE] ([STD_MONTH_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_STD_WEEK_ID]
	ON [dbo].[TB_DIM_DATE] ([STD_WEEK_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_FISCAL_YEAR_URN]
	ON [dbo].[TB_DIM_DATE] ([FISCAL_YEAR_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_FISCAL_QUARTER_URN]
	ON [dbo].[TB_DIM_DATE] ([FISCAL_QUARTER_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_FISCAL_MONTH_URN]
	ON [dbo].[TB_DIM_DATE] ([FISCAL_MONTH_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_FISCAL_WEEK_URN]
	ON [dbo].[TB_DIM_DATE] ([FISCAL_WEEK_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_DATE_VALUE]
	ON [dbo].[TB_DIM_DATE] ([DATE_VALUE])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_DATE_URN]
	ON [dbo].[TB_DIM_DATE] ([DATE_URN])
	INCLUDE ([STD_WEEK_ID], [STD_MONTH_ID], [FISCAL_YEAR_URN], [FISCAL_QUARTER_URN], [FISCAL_MONTH_URN], [FISCAL_WEEK_URN], [YEAR], [MONTH], [DAY], [NAME], [INTERNAL_NAME], [HOLIDAY], [DATE_VALUE], [DATE_FORMULA], [DATE_OPTIONS])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the dates that are supported by the applicaiton. This is a static table. This table is populated at install time. The values in this table should not be modified at any time, unless specified otherwise.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is calculated based on the number of days from 1900-01-01 untill the current date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is id from TB_DIM_DATE_STD_WEEK that corresponds to the week of the year to which the date belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'STD_WEEK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is id from TB_DIM_DATE_STD_MONTH that corresponds to the month of the year to which the date belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'STD_MONTH_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is URN from TB_DIM_FISCAL_YEAR that corresponds to the fiscal year to which the date belongs. This is populated as a custom set up for customers if required. This column is not populated during standard installation of the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'FISCAL_YEAR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is URN from TB_DIM_FISCAL_YEAR that corresponds to the fiscal year to which the date belongs. This is populated as a custom set up for customers if required. This column is not populated during standard installation of the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'FISCAL_QUARTER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is URN from TB_DIM_FISCAL_MONTH that corresponds to the fiscal month to which the date belongs. This is populated as a custom set up for customers if required. This column is not populated during standard installation of the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'FISCAL_MONTH_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is URN from TB_DIM_FISCAL_WEEK that corresponds to the fiscal week to which the date belongs. This is populated as a custom set up for customers if required. This column is not populated during standard installation of the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'FISCAL_WEEK_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the year corresponding to the date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'YEAR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the month number corresponding to the date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'MONTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the day of the month for the date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'DAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is display string for the date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the date is a holiday or not. Value 1 indicates holiday.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'HOLIDAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time represent the date. Note that the time part for the dates is always 00:00:00.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'DATE_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'DATE_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'DATE_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_DATE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_DATE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_DATE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_DATE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_DATE] SET (LOCK_ESCALATION = TABLE)
GO
