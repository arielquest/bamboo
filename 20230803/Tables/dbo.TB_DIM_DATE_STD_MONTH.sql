SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_DATE_STD_MONTH] (
		[MONTH_ID]                [char](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[QUARTER_ID]              [char](6) COLLATE Latin1_General_CI_AS NOT NULL,
		[YEAR]                    [smallint] NULL,
		[MONTH]                   [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PERIOD_START]            [smalldatetime] NULL,
		[PERIOD_END]              [smalldatetime] NULL,
		[DATE_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[DATE_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_DATE_STD_MONTH]
		PRIMARY KEY
		CLUSTERED
		([MONTH_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_DATE_STD_MONTH]
	ADD
	CONSTRAINT [DF_TB_DIM_DATE_STD_MONTH_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_DATE_STD_MONTH]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_DATE_STD_MONTH_TB_DIM_DATE_STD_QUARTER]
	FOREIGN KEY ([QUARTER_ID]) REFERENCES [dbo].[TB_DIM_DATE_STD_QUARTER] ([QUARTER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_DATE_STD_MONTH]
	CHECK CONSTRAINT [FK_TB_DIM_DATE_STD_MONTH_TB_DIM_DATE_STD_QUARTER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_DATE_STD_MONTH_QUARTER_ID]
	ON [dbo].[TB_DIM_DATE_STD_MONTH] ([QUARTER_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the months accross all the years that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is the id specified for the month.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'MONTH_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the quarter for the year as in TB_DIM_DATE_STD_QUARTER to which the current month of the year belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'QUARTER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the year corresponding to the month.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'YEAR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the month number for the month.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'MONTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the month.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the month.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start date for the month. Note that the time part is not used. It is always 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'PERIOD_START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end date for the month. Note that the time part is not used. It is always 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'PERIOD_END'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'DATE_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'DATE_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_MONTH', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_DATE_STD_MONTH]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_DATE_STD_MONTH]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_DATE_STD_MONTH]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_DATE_STD_MONTH]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_DATE_STD_MONTH] SET (LOCK_ESCALATION = TABLE)
GO
