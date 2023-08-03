SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS] (
		[TRIGGER_NAME]            [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[TRIGGER_GROUP]           [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[TRIGGER_LISTENER]        [varchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_QRTZ_TRIGGER_LISTENERS]
		PRIMARY KEY
		CLUSTERED
		([TRIGGER_NAME], [TRIGGER_GROUP], [TRIGGER_LISTENER])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	ADD
	CONSTRAINT [DF_TB_SCH_QRTZ_TRIGGER_LISTENERS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_QRTZ_TRIGGER_LISTENERS_TB_SCH_QRTZ_TRIGGERS]
	FOREIGN KEY ([TRIGGER_NAME], [TRIGGER_GROUP]) REFERENCES [dbo].[TB_SCH_QRTZ_TRIGGERS] ([TRIGGER_NAME], [TRIGGER_GROUP])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	CHECK CONSTRAINT [FK_TB_SCH_QRTZ_TRIGGER_LISTENERS_TB_SCH_QRTZ_TRIGGERS]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is part of the third party open source scheduling engine implemented within or plugged into the VIM application. The scheduling engine is used to execute scheduled reports and performance management forms and other scheduled jobs. The data within the table is managed completely from within the third party open source scheduling engine. Hence under no circumstance should the data in these table be modified manually.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_QRTZ_TRIGGER_LISTENERS', NULL, NULL
GO
GRANT DELETE
	ON [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_QRTZ_TRIGGER_LISTENERS] SET (LOCK_ESCALATION = TABLE)
GO
