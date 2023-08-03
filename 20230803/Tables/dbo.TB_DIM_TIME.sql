SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_TIME] (
		[TIME_URN]                [smallint] NOT NULL,
		[FIVE_MINUTE_URN]         [smallint] NOT NULL,
		[HOUR]                    [tinyint] NULL,
		[MINUTE]                  [tinyint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[SHIFT]                   [tinyint] NOT NULL,
		[EVENING]                 [bit] NOT NULL,
		[TIME_VALUE]              [smalldatetime] NULL,
		[TIME_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[TIME_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_TIME]
		PRIMARY KEY
		CLUSTERED
		([TIME_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_TIME]
	ADD
	CONSTRAINT [DF_TB_DIM_TIME_SHIFT]
	DEFAULT ((0)) FOR [SHIFT]
GO
ALTER TABLE [dbo].[TB_DIM_TIME]
	ADD
	CONSTRAINT [DF_TB_DIM_TIME_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_TIME]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_TIME_TB_DIM_TIME_5M]
	FOREIGN KEY ([FIVE_MINUTE_URN]) REFERENCES [dbo].[TB_DIM_TIME_5M] ([FIVE_MINUTE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_TIME]
	CHECK CONSTRAINT [FK_TB_DIM_TIME_TB_DIM_TIME_5M]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_TIME_FIVE_MINUTE_URN]
	ON [dbo].[TB_DIM_TIME] ([FIVE_MINUTE_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_TIME_TIME_VALUE]
	ON [dbo].[TB_DIM_TIME] ([TIME_VALUE])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_TIME_TIME_URN]
	ON [dbo].[TB_DIM_TIME] ([TIME_URN])
	INCLUDE ([FIVE_MINUTE_URN], [HOUR], [MINUTE], [NAME], [INTERNAL_NAME], [SHIFT], [EVENING], [TIME_VALUE], [TIME_FORMULA], [TIME_OPTIONS])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the time values that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time. The supported time values are between 00:00:00 and 23:59:00 and are accurate within the minute only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This value is the number of minutes past midnight.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME_5M corresponding to the 5 minute interval, which the current time falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'FIVE_MINUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the hour number past midnight, which the current time falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minute number past midnight for the current time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'MINUTE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'SHIFT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the time falls into the evening bracket. Value 1 indicates evening. Evening brackets are between 18:00:00 to 07:59:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'EVENING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time representing the time value. The date part is not used and is always 1900-01-01.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'TIME_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'TIME_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'TIME_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_TIME', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_TIME]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_TIME]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_TIME]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_TIME]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_TIME] SET (LOCK_ESCALATION = TABLE)
GO
