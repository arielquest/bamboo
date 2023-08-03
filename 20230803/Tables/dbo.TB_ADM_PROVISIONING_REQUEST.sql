SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[BATCH_ID]                [uniqueidentifier] NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NOT NULL,
		[RESOURCE_TYPE_ID]        [uniqueidentifier] NOT NULL,
		[RESOURCE_KEY_1]          [nvarchar](40) COLLATE Latin1_General_CI_AS NOT NULL,
		[RESOURCE_KEY_2]          [nvarchar](40) COLLATE Latin1_General_CI_AS NULL,
		[OPERATION]               [char](1) COLLATE Latin1_General_CI_AS NULL,
		[RECORD_NUMBER]           [smallint] NOT NULL,
		[TOTAL_RECORDS]           [smallint] NOT NULL,
		[COMPLETION_DATE]         [datetime] NULL,
		[RETRY_COUNT]             [tinyint] NULL,
		[STATUS]                  [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STATUS_MESSAGE]          [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_PROVISIONING_REQUEST]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_ADM_PROVISIONING_REQUEST_STATUS]
	CHECK
	NOT FOR REPLICATION
	([STATUS]='P' OR [STATUS]='I' OR [STATUS]='S' OR [STATUS]='F' OR [STATUS]='K')
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
CHECK CONSTRAINT [CK_TB_ADM_PROVISIONING_REQUEST_STATUS]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_REQUEST_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_REQUEST_RECORD_NUMBER]
	DEFAULT ((1)) FOR [RECORD_NUMBER]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_REQUEST_TOTAL_RECORDS]
	DEFAULT ((1)) FOR [TOTAL_RECORDS]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_REQUEST_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_REQUEST_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	ADD
	CONSTRAINT [DF_TB_ADM_PROVISIONING_REQUEST_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	CHECK CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	CHECK CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_SEC_USER_MODIFIED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_CLU_RESOURCE_CLUSTER_RESOURCE_ID]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	CHECK CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_CLU_RESOURCE_CLUSTER_RESOURCE_ID]

GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_ADM_PROVISIONING_BATCH_BATCH_ID]
	FOREIGN KEY ([BATCH_ID]) REFERENCES [dbo].[TB_ADM_PROVISIONING_BATCH] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST]
	CHECK CONSTRAINT [FK_TB_ADM_PROVISIONING_REQUEST_TB_ADM_PROVISIONING_BATCH_BATCH_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to store provisioning request.  A Provisioning Request defines a change that should be made to remote equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Optional foreign key to a Batch in TB_ADM_PROVISIONING_BATCH.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'BATCH_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The cluster resource on which this change should take place.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type id for the resource (e.g. Agent, Skill Group etc).', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The ID of the resource (for items) or the parent resource (for memberships)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'RESOURCE_KEY_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The ID of the resource (for items) or the parent resource (for memberships)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'RESOURCE_KEY_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Create (C), Delete (D), Update (U)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'OPERATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of times this request has been retried.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'RETRY_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Current status of the batch.  In Progress (I), Pending (P), Complete (K), Skipped (S), Failed (F)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Optional message related to the status. E.g failure message for Failure, Skip reason if skipped.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'STATUS_MESSAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROVISIONING_REQUEST', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_PROVISIONING_REQUEST]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_PROVISIONING_REQUEST]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PROVISIONING_REQUEST]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_PROVISIONING_REQUEST]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_PROVISIONING_REQUEST] SET (LOCK_ESCALATION = TABLE)
GO
