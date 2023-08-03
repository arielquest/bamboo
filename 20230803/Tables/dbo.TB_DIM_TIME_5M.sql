SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_TIME_5M] (
		[FIVE_MINUTE_URN]         [smallint] NOT NULL,
		[QUARTER_HOUR_URN]        [smallint] NOT NULL,
		[HOUR]                    [tinyint] NULL,
		[MINUTE]                  [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PERIOD_START]            [datetime] NOT NULL,
		[PERIOD_END]              [datetime] NOT NULL,
		[TIME_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[TIME_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_TIME_5M]
		PRIMARY KEY
		CLUSTERED
		([FIVE_MINUTE_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_5M]
	ADD
	CONSTRAINT [DF_TB_DIM_TIME_5M_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_5M]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_TIME_5M_TB_DIM_TIME_QH]
	FOREIGN KEY ([QUARTER_HOUR_URN]) REFERENCES [dbo].[TB_DIM_TIME_QH] ([QUARTER_HOUR_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_TIME_5M]
	CHECK CONSTRAINT [FK_TB_DIM_TIME_5M_TB_DIM_TIME_QH]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_TIME_5M_QUARTER_HOUR_URN]
	ON [dbo].[TB_DIM_TIME_5M] ([QUARTER_HOUR_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all five minute intervals for all the time values that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time. The supported five minute intervals are between 00:00:00 and 23:59:00 with an accuracy up to minute only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is ideally a value corresponding to the minutes past midnight.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'FIVE_MINUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME_QH corresponding to the quarter hour, which the current five minute interval falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'QUARTER_HOUR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the hour past midnight, which the current five minute interval falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value is the actual minutes past midnight.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'MINUTE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start time for the five minute interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'PERIOD_START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end time for the five minute interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'PERIOD_END'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'TIME_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'TIME_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_5M', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_TIME_5M]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_TIME_5M]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_TIME_5M]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_TIME_5M]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_5M] SET (LOCK_ESCALATION = TABLE)
GO
