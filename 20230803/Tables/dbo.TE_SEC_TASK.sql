SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_SEC_TASK] (
		[TASK_ID]                 [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[GLOBAL_TASK]             [bit] NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[CODE]                    [bigint] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_SEC_TASK_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [SECINDEXGROUP],
		CONSTRAINT [PK_TE_SEC_TASK]
		PRIMARY KEY
		CLUSTERED
		([TASK_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_CODE]
	DEFAULT ((0)) FOR [CODE]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_ACTION_ID]
	DEFAULT (newid()) FOR [TASK_ID]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_GLOBAL_TASK]
	DEFAULT ((0)) FOR [GLOBAL_TASK]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_SEC_TASK]
	ADD
	CONSTRAINT [DF_TE_SEC_TASK_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
CREATE NONCLUSTERED INDEX [IX_TE_SEC_TASK_DELETED_ENABLED_CODE_INTERNAL_NAME_TASK_ID]
	ON [dbo].[TE_SEC_TASK] ([DELETED], [ENABLED])
	INCLUDE ([CODE], [INTERNAL_NAME], [TASK_ID])
	ON [SECINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the security tasks available in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'TASK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the task.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the task. This is unique.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the task.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the task is global or path based. Value of 1 indicates global task.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'GLOBAL_TASK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the task has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the task has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the task is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the task is hidden or not. Value of 1 indicates hidden. Only system administrators can change this.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the task is owned by system or not. Value of 1 indicates system owned task.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This holds the hex code for the task. This code defines various other tasks associated with the current task if any. This should never be changed.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_TASK', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_SEC_TASK]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_SEC_TASK]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_SEC_TASK]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_SEC_TASK]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_SEC_TASK] SET (LOCK_ESCALATION = TABLE)
GO
