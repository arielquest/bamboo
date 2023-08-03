SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] (
		[KNOWLEDGE_ARTICLE_READ_CONFIRMATION_URN]     [bigint] IDENTITY(1, 2) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_URN]                        [int] NOT NULL,
		[KB_COMPLIANCE_POLICY_URN]                    [int] NOT NULL,
		[TENANT_URN]                                  [int] NOT NULL,
		[AGENT_URN]                                   [int] NOT NULL,
		[KB_ARTICLE_URN]                              [int] NOT NULL,
		[KB_FOLDER_URN]                               [int] NOT NULL,
		[MANAGER_AGENT_URN]                           [int] NOT NULL,
		[SNAPSHOT_DATE]                               [datetime] NOT NULL,
		[START_DATE_TIME]                             [datetime] NOT NULL,
		[DUE_DATE_TIME]                               [datetime] NOT NULL,
		[SIGNED_DATE_TIME]                            [datetime] NULL,
		[COMPLIANCE_STATUS]                           [varchar](20) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLA_STATUS]                                  [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[SIGNED_IN_SLA]                               [int] NOT NULL,
		[SIGNED_PAST_SLA]                             [int] NOT NULL,
		[UNSIGNED_IN_SLA]                             [int] NOT NULL,
		[UNSIGNED_PAST_SLA]                           [int] NOT NULL,
		[msrepl_tran_version]                         [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
		PRIMARY KEY
		CLUSTERED
		([CLUSTER_RESOURCE_URN], [KNOWLEDGE_ARTICLE_READ_CONFIRMATION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
ALTER TABLE [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	ADD
	CONSTRAINT [DF_TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains information about the compliance for article read.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KNOWLEDGE_ARTICLE_READ_CONFIRMATION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the eGain department.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb article in TB_DIM_KB_ARTICLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb folder in TB_DIM_KB_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time by which the agent is due to have read the article. This is determined by the SLA of the compliance policy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'DUE_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time that the agent signed that they have read the article. This will be blank if the agent has not yet signed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'SIGNED_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the agent has signed that they have read the article, or if they have not yet signed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'COMPLIANCE_STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If the agent has signed, this indicates whether they did so within SLA (before the due time) or past SLA (after the due time). If the agent has not signed, this indicates whether they are still within SLA at the time of running the report (due time in the future) or if they are already past SLA (due time has passed).', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'SLA_STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Counts 1 if the agent has signed that they read the article within SLA (before the due time). Totals count the number of agents who have signed within SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'SIGNED_IN_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Counts 1 if the agent has signed that they read the article but exceeded the SLA (after the due time). Totals count the number of agents who have signed but exceeded SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'SIGNED_PAST_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Counts 1 if the agent has not yet signed but still has time to do so before the SLA (due time in the future at the time of running the report). Totals count the number of agents who have not yet signed but are still within SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'UNSIGNED_IN_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Counts 1 if the agent has not yet signed and has already exceeded the SLA (due time in the future at the time of running the report). Totals therefore count the number of agents who have not yet signed and have exceeded SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'UNSIGNED_PAST_SLA'
GO
GRANT DELETE
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portalrs_role]
GO
GRANT INSERT
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_RT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] SET (LOCK_ESCALATION = TABLE)
GO
