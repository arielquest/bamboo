SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] (
		[WORKFLOW_DETAIL_URN]                [bigint] IDENTITY(1, 2) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[KB_ARTICLE_URN]                     [int] NOT NULL,
		[KB_FOLDER_URN]                      [int] NOT NULL,
		[TENANT_URN]                         [int] NOT NULL,
		[KB_ARTICLE_OWNER_URN]               [int] NOT NULL,
		[KB_ARTICLE_TYPE_URN]                [int] NOT NULL,
		[ARTICLE_TYPE_URN]                   [smallint] NOT NULL,
		[KB_PORTAL_URN]                      [int] NOT NULL,
		[WORKFLOW_URN]                       [int] NOT NULL,
		[CHECKED_OUT_BY_AGENT_URN]           [int] NOT NULL,
		[SENDER_AGENT_URN]                   [int] NOT NULL,
		[CURRENT_STAGE_URN]                  [int] NOT NULL,
		[PREVIOUS_STAGE_URN]                 [int] NOT NULL,
		[KB_ARTICLE_LAST_PUBLISHED_DATE]     [datetime] NULL,
		[KB_ARTICLE_EXPIRATION_DATE]         [datetime] NULL,
		[CURRENT_STAGE_START_DATE_TIME]      [datetime] NOT NULL,
		[PREVIOUS_STAGE_START_DATE_TIME]     [datetime] NULL,
		[SNAPSHOT_DATE]                      [datetime] NOT NULL,
		[SUMMARIZATION_DATE]                 [datetime] NOT NULL,
		[msrepl_tran_version]                [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([CLUSTER_RESOURCE_URN], [WORKFLOW_DETAIL_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
ALTER TABLE [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	ADD
	CONSTRAINT [DF_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_SUMMARIZATION_DATE]
	DEFAULT (getutcdate()) FOR [SUMMARIZATION_DATE]
GO
ALTER TABLE [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	ADD
	CONSTRAINT [DF_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_KB_ARTICLE_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([KB_ARTICLE_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_KB_FOLDER_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([KB_FOLDER_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_TENANT_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([TENANT_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_KB_PORTAL_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([KB_PORTAL_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_WORKFLOW_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([WORKFLOW_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_CHECKED_OUT_BY_AGENT_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([CHECKED_OUT_BY_AGENT_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_SENDER_AGENT_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([SENDER_AGENT_URN])
	ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_KNOWLEDGE_WORKFLOW_DETAIL_KB_ARTICLE_OWNER_URN]
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] ([KB_ARTICLE_OWNER_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains fact of type real-time periodic snapshot of workflow-processing of KB Articles', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'WORKFLOW_DETAIL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the eGain KB Article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_FOLDER.ITEM_URN and refers to the KB Folder the eGain KB Article is located in.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the eGain Department the KB Article is created in.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent the KB Article is owned by.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_ARTICLE_OWNER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE_TYPE.ITEM_URN and refers to the type of the KB Article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_ARTICLE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to VW_DIM_ARTICLE_TYPE_CUBE.ITEM_URN and refers to the type of the KB Article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'ARTICLE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_PORTAL.ITEM_URN and refers to the KB Portal this KB Article is published on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_KB_ARTICLE_WORKFLOW corresponding to the KB Workflow through which the KB Article is being processed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'WORKFLOW_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who has currently checked out the corresponding KB Article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'CHECKED_OUT_BY_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is responsible for bringing the KB Article in current workflow stage.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'SENDER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE_REVIEW_STAGE.ITEM_URN and refers to the workflow stage the KB Article is currently in.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'CURRENT_STAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE_REVIEW_STAGE.ITEM_URN and refers to the workflow stage the KB Article was in prior to the current stage, if this is the first stage, then -1.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'PREVIOUS_STAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the timestamp of most recent attempt of publishing the KB Article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_ARTICLE_LAST_PUBLISHED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the timestamp of expiry of the KB Article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'KB_ARTICLE_EXPIRATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the timestamp since when the KB Article is in the current workflow stage.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'CURRENT_STAGE_START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the timestamp when the KB Article was added to the previous stage.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'PREVIOUS_STAGE_START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the DateTimeStamp in UTC of the last event processed in the most recent summarization cycle ran against the cluster resource. All the durations are calculated based on this date considered as end-date.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'SNAPSHOT_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the DateTimeStamp in UTC when the fact data is summarized.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'SUMMARIZATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_WORKFLOW_DETAIL', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_RT_KNOWLEDGE_WORKFLOW_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
