SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_TIME_QH] (
		[QUARTER_HOUR_URN]        [smallint] NOT NULL,
		[HALF_HOUR_URN]           [smallint] NOT NULL,
		[HOUR]                    [tinyint] NULL,
		[MINUTE]                  [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PERIOD_START]            [datetime] NOT NULL,
		[PERIOD_END]              [datetime] NOT NULL,
		[TIME_VALUE]              [smalldatetime] NULL,
		[TIME_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[TIME_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_TIME_QH]
		PRIMARY KEY
		CLUSTERED
		([QUARTER_HOUR_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_QH]
	ADD
	CONSTRAINT [DF_TB_DIM_TIME_QH_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_QH]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_TIME_QH_TB_DIM_TIME_HH]
	FOREIGN KEY ([HALF_HOUR_URN]) REFERENCES [dbo].[TB_DIM_TIME_HH] ([HALF_HOUR_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_TIME_QH]
	CHECK CONSTRAINT [FK_TB_DIM_TIME_QH_TB_DIM_TIME_HH]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_TIME_QH_HALF_HOUR_URN]
	ON [dbo].[TB_DIM_TIME_QH] ([HALF_HOUR_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all quarter hour intervals for all the time values that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time. The supported quarter hour intervals are between 00:00:00 and 23:59:00 with an accuracy up to minute only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is ideally the number of minutes past midnight corresponding to the start time for the quarter hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'QUARTER_HOUR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME_HH corresponding to the half hour interval, which the quarter hour falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'HALF_HOUR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the hour past midnight corresponding to the start time of the quarter hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minute value for the quarter hour. This can take the values 0, 15, 30, and 45 depending on the minute of the start time for the quarter hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'MINUTE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the quarter hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the quarter hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start time for the quarter hour interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'PERIOD_START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end time for the quarter hour interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'PERIOD_END'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'TIME_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'TIME_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'TIME_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_QH', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_TIME_QH]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_TIME_QH]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_TIME_QH]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_TIME_QH]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_QH] SET (LOCK_ESCALATION = TABLE)
GO
