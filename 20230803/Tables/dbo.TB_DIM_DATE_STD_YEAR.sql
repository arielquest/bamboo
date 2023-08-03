SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_DATE_STD_YEAR] (
		[YEAR_ID]                 [char](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[YEAR]                    [smallint] NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PERIOD_START]            [smalldatetime] NULL,
		[PERIOD_END]              [smalldatetime] NULL,
		[DATE_FORMULA]            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[DATE_OPTIONS]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_DATE_STD_YEAR]
		PRIMARY KEY
		CLUSTERED
		([YEAR_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_DATE_STD_YEAR]
	ADD
	CONSTRAINT [DF_TB_DIM_DATE_STD_YEAR_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the years that are supported by the application. This is a static table. This table is populated at install time. The values in this table should not be modified at any time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is the id specified for the year.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'YEAR_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the year number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'YEAR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the year.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the year.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start date for the year. Note that the time part is not used. It is always 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'PERIOD_START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end date for the year. Note that the time part is not used. It is always 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'PERIOD_END'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'DATE_FORMULA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'DATE_OPTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_DATE_STD_YEAR', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_DATE_STD_YEAR]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_DATE_STD_YEAR]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_DATE_STD_YEAR]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_DATE_STD_YEAR]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_DATE_STD_YEAR] SET (LOCK_ESCALATION = TABLE)
GO
