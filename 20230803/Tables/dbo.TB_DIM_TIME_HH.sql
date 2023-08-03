SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_TIME_HH] (
		[HALF_HOUR_URN]           [smallint] NOT NULL,
		[HOUR_URN]                [smallint] NOT NULL,
		[HOUR]                    [tinyint] NULL,
		[MINUTE]                  [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PERIOD_START]            [datetime] NOT NULL,
		[PERIOD_END]              [datetime] NOT NULL,
		[TIME_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[TIME_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_TIME_HH]
		PRIMARY KEY
		CLUSTERED
		([HALF_HOUR_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_HH]
	ADD
	CONSTRAINT [DF_TB_DIM_TIME_HH_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_HH]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_TIME_HH_TB_DIM_TIME_H]
	FOREIGN KEY ([HOUR_URN]) REFERENCES [dbo].[TB_DIM_TIME_H] ([HOUR_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_TIME_HH]
	CHECK CONSTRAINT [FK_TB_DIM_TIME_HH_TB_DIM_TIME_H]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_TIME_HH_HOUR_URN]
	ON [dbo].[TB_DIM_TIME_HH] ([HOUR_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all half hour intervals for all the time values that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time. The supported half hour intervals are between 00:00:00 and 23:59:00 with an accuracy up to minute only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This value is ideally the number of minutes past midnight corresponding to the start time of the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'HALF_HOUR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME_H corresponding to the hour interval, which the current half hour interval falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'HOUR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual hour past midnight corresponding to the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minute value for the half hour interval. This can be either 0 or 30 based on the start time minute of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'MINUTE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start time for the half hour interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'PERIOD_START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end time for the half hour interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'PERIOD_END'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'TIME_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'TIME_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_HH', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_TIME_HH]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_TIME_HH]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_TIME_HH]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_TIME_HH]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_HH] SET (LOCK_ESCALATION = TABLE)
GO
