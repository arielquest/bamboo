SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_PROVISIONING_BATCH] (
		[ID]                       [uniqueidentifier] NOT NULL,
		[TOTAL_REQUESTS]           [smallint] NOT NULL,
		[PENDING_REQUESTS]         [smallint] NOT NULL,
		[IN_PROGRESS_REQUESTS]     [smallint] NOT NULL,
		[COMPLETED_REQUESTS]       [smallint] NOT NULL,
		[FAILED_REQUESTS]          [smallint] NOT NULL,
		[SUCCESSFUL_REQUESTS]      [smallint] NOT NULL,
		[SKIPPED_REQUESTS]         [smallint] NOT NULL,
		[COMPLETION_DATE]          [datetime] NULL,
		[STATUS]                   [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATED_BY_ID]            [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]           [uniqueidentifier] NOT NULL,
		[CREATION_DATE]            [datetime] NOT NULL,
		[MODIFIED_DATE]            [datetime] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_PROVISIONING_BATCH]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_ADM_PROVISIONING_BATCH_STATUS]
	CHECK
	NOT FOR REPLICATION
	([STATUS]='P' OR [STATUS]='I' OR [STATUS]='C')
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
CHECK CONSTRAINT [CK_TB_ADM_PROVISIONING_BATCH_STATUS]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_BATCH_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_BATCH_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_BATCH_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_BATCH_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_PROVISIONING_BATCH_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	CHECK CONSTRAINT [FK_TB_ADM_PROVISIONING_BATCH_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_PROVISIONING_BATCH_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH]
	CHECK CONSTRAINT [FK_TB_ADM_PROVISIONING_BATCH_TB_SEC_USER_MODIFIED_BY_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to store provisioning batches.  A Provisioning Batch represents a set of change requests to the provisioning server. This batch may be created via the execution of a job or may be created via RM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count of requests in this batch.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'TOTAL_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count of requests that have yet to be actioned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'PENDING_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count of requests that are currently being processed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'IN_PROGRESS_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count of requests that have completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'COMPLETED_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count of requests that have failed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'FAILED_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count of requests that were successful.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'SUCCESSFUL_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Current status of the batch.  In Progress (I), Pending (P), Complete (C)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_BATCH', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_PROVISIONING_BATCH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_PROVISIONING_BATCH]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PROVISIONING_BATCH]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_PROVISIONING_BATCH]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_BATCH] SET (LOCK_ESCALATION = TABLE)
GO
