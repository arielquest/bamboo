SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_TIME_H] (
		[HOUR_URN]                [smallint] NOT NULL,
		[HOUR]                    [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PERIOD_START]            [datetime] NOT NULL,
		[PERIOD_END]              [datetime] NOT NULL,
		[TIME_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[TIME_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_TIME_H]
		PRIMARY KEY
		CLUSTERED
		([HOUR_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_H]
	ADD
	CONSTRAINT [DF_TB_DIM_TIME_H_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all hour intervals for all the time values that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time. The supported hour intervals are between 00:00:00 and 23:59:00 with an accuracy up to minute only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. The value is ideally the number of minutes past midnight corresponding to the start time of the hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'HOUR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual hour number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start time for the hour interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'PERIOD_START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end time for the hour interval. Note that the date part is not used. It is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'PERIOD_END'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'TIME_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'TIME_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME_H', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_TIME_H]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_TIME_H]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_TIME_H]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_TIME_H]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_TIME_H] SET (LOCK_ESCALATION = TABLE)
GO
