SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_SCHEDULE] (
		[SCHEDULE_ID]              [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[RESOURCE_TYPE_ID]         [uniqueidentifier] NOT NULL,
		[IMPORT_TYPE]              [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[IMPORT_START_TIME]        [datetime] NOT NULL,
		[IMPORT_END_TIME]          [datetime] NOT NULL,
		[LAST_IMPORT_RUN_TIME]     [datetime] NOT NULL,
		[IMPORT_PERIOD]            [datetime] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_SCHEDULE_IMPORT_TYPE]
		UNIQUE
		NONCLUSTERED
		([RESOURCE_TYPE_ID], [IMPORT_TYPE])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_IMP_IMPORT_SCHEDULE]
		PRIMARY KEY
		CLUSTERED
		([SCHEDULE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	ADD
	CONSTRAINT [DF_TB_IMP_SCHEDULE_SCHEDULE_ID]
	DEFAULT (newid()) FOR [SCHEDULE_ID]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	ADD
	CONSTRAINT [DF_TB_IMP_SCHEDULE_IMPORT_START_TIME]
	DEFAULT ('1900-01-01 00:00:00') FOR [IMPORT_START_TIME]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	ADD
	CONSTRAINT [DF_TB_IMP_SCHEDULE_IMPORT_END_TIME]
	DEFAULT ('1900-01-01 23:59:59') FOR [IMPORT_END_TIME]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	ADD
	CONSTRAINT [DF_TB_IMP_SCHEDULE_LAST_IMPORT_RUN_TIME]
	DEFAULT ('1900-01-01 00:00:00') FOR [LAST_IMPORT_RUN_TIME]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	ADD
	CONSTRAINT [DF_TB_IMP_SCHEDULE_IMPORT_PERIOD]
	DEFAULT ('1900-01-01 00:15:00') FOR [IMPORT_PERIOD]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	ADD
	CONSTRAINT [DF_TB_IMP_SCHEDULE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_SCHEDULE_TE_ADM_RESOURCE_TYPE]
	FOREIGN KEY ([RESOURCE_TYPE_ID]) REFERENCES [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] ([CLUSTER_RESOURCE_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_SCHEDULE]
	CHECK CONSTRAINT [FK_TB_IMP_SCHEDULE_TE_ADM_RESOURCE_TYPE]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about any schedules for specific import types from any specific source types. For example a schedule for importing IP Endpoints from Callmanagers.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'SCHEDULE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from TE_ADM_CLUSTER_RESOURCE_TYPE corresponding to the source type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of import to be scheduled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'IMPORT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp with date 01-01-1900. The date is not used. The time corresponds to the time when the import starts for the current import type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'IMPORT_START_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp with date 01-01-1900. The date is not used. The time corresponds to the time when the import ends for the current import type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'IMPORT_END_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp when the current import was last run.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'LAST_IMPORT_RUN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp with date 01-01-1900. The date is not used. The time corresponds to the time interval for each cycle of import between IMPORT_START_TIME and IMPORT_END_TIME. For example if IMPORT_START_TIME = 00:00:00, IMPORT_END_TIME = 05:00:00 and IMPORT_PERIOD = 00:45:00, it means that the import runs every 45 minutes between midnight and 5 a.m.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'IMPORT_PERIOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_SCHEDULE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_SCHEDULE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_SCHEDULE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_SCHEDULE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_SCHEDULE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_SCHEDULE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_IMP_SCHEDULE] SET (LOCK_ESCALATION = TABLE)
GO
