SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_QRTZ_CALENDARS] (
		[CALENDAR_NAME]           [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[CALENDAR]                [varbinary](max) NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_QRTZ_CALENDARS]
		PRIMARY KEY
		CLUSTERED
		([CALENDAR_NAME])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_CALENDARS]
	ADD
	CONSTRAINT [DF_TB_SCH_QRTZ_CALENDARS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is part of the third party open source scheduling engine implemented within or plugged into the VIM application. The scheduling engine is used to execute scheduled reports and performance management forms and other scheduled jobs. The data within the table is managed completely from within the third party open source scheduling engine. Hence under no circumstance should the data in these table be modified manually.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_QRTZ_CALENDARS', NULL, NULL
GO
GRANT DELETE
	ON [dbo].[TB_SCH_QRTZ_CALENDARS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_QRTZ_CALENDARS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_QRTZ_CALENDARS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_QRTZ_CALENDARS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_CALENDARS] SET (LOCK_ESCALATION = TABLE)
GO
