SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_SEC_OPERATION] (
		[OPERATION_ID]            [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[TASK_ID]                 [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[AUDIT]                   [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_SEC_OPERATION_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [SECINDEXGROUP],
		CONSTRAINT [PK_TE_SEC_OPERATION]
		PRIMARY KEY
		CLUSTERED
		([OPERATION_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_OPERATION_ID]
	DEFAULT (newid()) FOR [OPERATION_ID]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_AUDIT]
	DEFAULT ((1)) FOR [AUDIT]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	ADD
	CONSTRAINT [DF_TE_SEC_OPERATION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_SEC_OPERATION_TE_SEC_TASK]
	FOREIGN KEY ([TASK_ID]) REFERENCES [dbo].[TE_SEC_TASK] ([TASK_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_SEC_OPERATION]
	CHECK CONSTRAINT [FK_TE_SEC_OPERATION_TE_SEC_TASK]

GO
CREATE NONCLUSTERED INDEX [IX_TE_SEC_OPERATION_DELETED_ENABLED_NAME_TASK_ID]
	ON [dbo].[TE_SEC_OPERATION] ([DELETED], [ENABLED])
	INCLUDE ([NAME], [TASK_ID])
	ON [SECINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TE_SEC_OPERATION_TASK_ID]
	ON [dbo].[TE_SEC_OPERATION] ([TASK_ID])
	ON [SECGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the security operations that a user can perform in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'OPERATION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the task in TE_SEC_TASK, associated with the current operation.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'TASK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the operation.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the operation. This is unique.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the operation.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the operation has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the operation has been set for audit or not. Value of 1 indicates audited.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'AUDIT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the operation has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the operation is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the operation is hidden or not. Value of 1 indicates hidden. Only system administrators can change this.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the operation is owned by system or not. Value of 1 indicates system owned operation.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_SEC_OPERATION', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_SEC_OPERATION]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_SEC_OPERATION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_SEC_OPERATION]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_SEC_OPERATION]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_SEC_OPERATION] SET (LOCK_ESCALATION = TABLE)
GO
