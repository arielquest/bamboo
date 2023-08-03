SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] (
		[ENTRY_ID]                [varchar](95) COLLATE Latin1_General_CI_AS NOT NULL,
		[TRIGGER_NAME]            [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[TRIGGER_GROUP]           [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[IS_VOLATILE]             [varchar](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[INSTANCE_NAME]           [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[FIRED_TIME]              [bigint] NOT NULL,
		[PRIORITY]                [int] NOT NULL,
		[STATE]                   [varchar](16) COLLATE Latin1_General_CI_AS NOT NULL,
		[JOB_NAME]                [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[JOB_GROUP]               [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[IS_STATEFUL]             [varchar](1) COLLATE Latin1_General_CI_AS NULL,
		[REQUESTS_RECOVERY]       [varchar](1) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_QRTZ_FIRED_TRIGGERS]
		PRIMARY KEY
		CLUSTERED
		([ENTRY_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS]
	ADD
	CONSTRAINT [DF_TB_SCH_QRTZ_FIRED_TRIGGERS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_QRTZ_FIRED_TRIGGERS_TRIGGER_NAME]
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] ([TRIGGER_NAME])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_QRTZ_FIRED_TRIGGERS_TRIGGER_GROUP]
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] ([TRIGGER_GROUP])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_QRTZ_FIRED_TRIGGERS_TRIGGER_NAME_TRIGGER_GROUP]
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] ([TRIGGER_NAME], [TRIGGER_GROUP])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_QRTZ_FIRED_TRIGGERS_INSTANCE_NAME]
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] ([INSTANCE_NAME])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_QRTZ_FIRED_TRIGGERS_JOB_NAME]
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] ([JOB_NAME])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_QRTZ_FIRED_TRIGGERS_JOB_GROUP]
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] ([JOB_GROUP])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is part of the third party open source scheduling engine implemented within or plugged into the VIM application. The scheduling engine is used to execute scheduled reports and performance management forms and other scheduled jobs. The data within the table is managed completely from within the third party open source scheduling engine. Hence under no circumstance should the data in these table be modified manually.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_QRTZ_FIRED_TRIGGERS', NULL, NULL
GO
GRANT DELETE
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_FIRED_TRIGGERS] SET (LOCK_ESCALATION = TABLE)
GO
