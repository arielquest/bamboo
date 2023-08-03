SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS] (
		[TRIGGER_NAME]            [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[TRIGGER_GROUP]           [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[CRON_EXPRESSION]         [varchar](120) COLLATE Latin1_General_CI_AS NOT NULL,
		[TIME_ZONE_ID]            [varchar](80) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_QRTZ_CRON_TRIGGERS]
		PRIMARY KEY
		CLUSTERED
		([TRIGGER_NAME], [TRIGGER_GROUP])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	ADD
	CONSTRAINT [DF_TB_SCH_QRTZ_CRON_TRIGGERS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_QRTZ_CRON_TRIGGERS_TB_SCH_QRTZ_TRIGGERS]
	FOREIGN KEY ([TRIGGER_NAME], [TRIGGER_GROUP]) REFERENCES [dbo].[TB_SCH_QRTZ_TRIGGERS] ([TRIGGER_NAME], [TRIGGER_GROUP])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	CHECK CONSTRAINT [FK_TB_SCH_QRTZ_CRON_TRIGGERS_TB_SCH_QRTZ_TRIGGERS]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is part of the third party open source scheduling engine implemented within or plugged into the VIM application. The scheduling engine is used to execute scheduled reports and performance management forms and other scheduled jobs. The data within the table is managed completely from within the third party open source scheduling engine. Hence under no circumstance should the data in these table be modified manually.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_QRTZ_CRON_TRIGGERS', NULL, NULL
GO
GRANT DELETE
	ON [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_CRON_TRIGGERS] SET (LOCK_ESCALATION = TABLE)
GO
