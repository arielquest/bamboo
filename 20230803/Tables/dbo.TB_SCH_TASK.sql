SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_TASK] (
		[TASK_ID]                 [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[TYPE]                    [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](150) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATED_BY_USER_ID]      [uniqueidentifier] NULL,
		[CREATION_DATE_TIME]      [smalldatetime] NULL,
		[MODIFIED_BY_USER_ID]     [uniqueidentifier] NULL,
		[MODIFIED_DATE_TIME]      [smalldatetime] NULL,
		[ENABLED]                 [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ASSIGNED_TO_USER_ID]     [uniqueidentifier] NULL,
		[FAILURE_COUNT]           [int] NOT NULL,
		[CALENDAR_ID]             [uniqueidentifier] NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_TASK]
		PRIMARY KEY
		CLUSTERED
		([TASK_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_SCH_TASK_TYPE]
	CHECK
	NOT FOR REPLICATION
	([TYPE]='R' OR [TYPE]='P')
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
CHECK CONSTRAINT [CK_TB_SCH_TASK_TYPE]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	ADD
	CONSTRAINT [DF_TB_SCH_TASK_TASK_ID]
	DEFAULT (newid()) FOR [TASK_ID]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	ADD
	CONSTRAINT [DF_TB_SCH_TASK_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	ADD
	CONSTRAINT [DF_TB_SCH_TASK_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	ADD
	CONSTRAINT [DF_TB_SCH_FAILURE_COUNT]
	DEFAULT ((0)) FOR [FAILURE_COUNT]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	ADD
	CONSTRAINT [DF_TB_SCH_TASK_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	ADD
	CONSTRAINT [DF_TB_SCH_TASK_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_USER_CREATED_BY_USER_ID]
	FOREIGN KEY ([CREATED_BY_USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_USER_CREATED_BY_USER_ID]

GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_USER_MODIFIED_BY_USER_ID]
	FOREIGN KEY ([MODIFIED_BY_USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_USER_MODIFIED_BY_USER_ID]

GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_USER_ASSIGNED_TO_USER_ID]
	FOREIGN KEY ([ASSIGNED_TO_USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_TB_SEC_USER_ASSIGNED_TO_USER_ID]

GO
ALTER TABLE [dbo].[TB_SCH_TASK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_TASK_TB_ADM_CALENDAR_CALENDAR_ID]
	FOREIGN KEY ([CALENDAR_ID]) REFERENCES [dbo].[TB_ADM_CALENDAR] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_TASK]
	CHECK CONSTRAINT [FK_TB_SCH_TASK_TB_ADM_CALENDAR_CALENDAR_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_TASK]
	ON [dbo].[TB_SCH_TASK] ([FOLDER_ID], [TASK_ID])
	INCLUDE ([NAME], [CREATED_BY_USER_ID], [ENABLED], [DELETED])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_TASK_CREATED_BY_USER_ID]
	ON [dbo].[TB_SCH_TASK] ([CREATED_BY_USER_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_TASK_MODIFIED_BY_USER_ID]
	ON [dbo].[TB_SCH_TASK] ([MODIFIED_BY_USER_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores information about any generic scheduled tasks in the system. These tasks for example can be a report execution schedule or a form schedule etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'TASK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the type of schedule. Possible values are; F: Form, R: Report, A: Alert', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_FOLDER indicating the folder when the schedule is placed under.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name given to the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who created the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'CREATED_BY_USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the schedule was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'CREATION_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who last modified the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'MODIFIED_BY_USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the schedule was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'MODIFIED_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the schedule is enabled or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the schedule is deleted or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The context in which the schedule report will be executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'ASSIGNED_TO_USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of times Schedule failed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'FAILURE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_TASK', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_TASK]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_TASK]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_TASK]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_TASK]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_TASK] SET (LOCK_ESCALATION = TABLE)
GO
