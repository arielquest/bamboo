SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_TASK_HISTORY] (
		[TASK_HISTORY_ID]         [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[TASK_ID]                 [uniqueidentifier] NOT NULL,
		[SESSION_ID]              [uniqueidentifier] NOT NULL,
		[FIRETIME]                [datetime] NULL,
		[SCHEDULER]               [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[TRIGGER]                 [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[PREVIOUS_FIRE_TIME]      [datetime] NULL,
		[NEXT_FIRE_TIME]          [datetime] NULL,
		[REFIRE_COUNT]            [int] NOT NULL,
		[MESSAGE]                 [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[RESULT]                  [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[RECOVERING]              [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_TASK_HISTORY]
		PRIMARY KEY
		CLUSTERED
		([TASK_HISTORY_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	ADD
	CONSTRAINT [DF_SCH_TASK_HISTORY_TASK_HISTORY_ID]
	DEFAULT (newid()) FOR [TASK_HISTORY_ID]
GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	ADD
	CONSTRAINT [DF_SCH_TASK_HISTORY_REFIRE_COUNT]
	DEFAULT ((0)) FOR [REFIRE_COUNT]
GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	ADD
	CONSTRAINT [DF_SCH_TASK_HISTORY_RECOVERING]
	DEFAULT ((0)) FOR [RECOVERING]
GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	ADD
	CONSTRAINT [DF_SCH_TASK_HISTORY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_HISTORY_TB_ADM_SESSION]
	FOREIGN KEY ([SESSION_ID]) REFERENCES [dbo].[TB_ADM_SESSION] ([SESSION_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_HISTORY_TB_ADM_SESSION]

GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_HISTORY_TB_SCH_TASK]
	FOREIGN KEY ([TASK_ID]) REFERENCES [dbo].[TB_SCH_TASK] ([TASK_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_HISTORY_TB_SCH_TASK]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_TASK_HISTORY_SESSION_ID]
	ON [dbo].[TB_SCH_TASK_HISTORY] ([SESSION_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_TASK_HISTORY_TASK_ID]
	ON [dbo].[TB_SCH_TASK_HISTORY] ([TASK_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores historical information about the executions of the generic scheduled tasks.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'TASK_HISTORY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SCH_TASK indicating the scheduled task.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'TASK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_ADM_SESSION indicating the session under which the scheduled task was executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the scheduled task was last executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'FIRETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the machine from which the task was executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'SCHEDULER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the TRIGGER_NAME in TB_SCH_QRTZ_TRIGGER indicating the schedule trigger that executed the task.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'TRIGGER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating the execution time prior to the last execution time for the task.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'PREVIOUS_FIRE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the task will be executed next.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'NEXT_FIRE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a count of the number of times the task has been executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'REFIRE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a message returned from the scheduling engine when the task was last executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'MESSAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the result of the last execution of the task. This flag is returned by the scheduling engine when the task is executed. Possible Values are : S: Success, F: Failure.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'RESULT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a bit flag indicating whether the scheduled tasks is recovering from a previous failed execution.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'RECOVERING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK_HISTORY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_TASK_HISTORY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_TASK_HISTORY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_TASK_HISTORY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_TASK_HISTORY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_TASK_HISTORY] SET (LOCK_ESCALATION = TABLE)
GO
