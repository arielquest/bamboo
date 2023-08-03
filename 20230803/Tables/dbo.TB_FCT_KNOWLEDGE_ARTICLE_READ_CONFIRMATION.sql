SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] (
		[PARTITION_URN]              [int] NOT NULL,
		[PARTITION_ID]               [int] NOT NULL,
		[PARTITION_GLOBAL_URN]       [bigint] NOT NULL,
		[DATE_TIME_UTC]              [datetime] NOT NULL,
		[DATE_UTC_URN]               [int] NOT NULL,
		[TIME_UTC_URN]               [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]       [int] NOT NULL,
		[SKEY]                       [numeric](19, 0) NOT NULL,
		[SESSION_ID]                 [bigint] NULL,
		[TENANT_URN]                 [int] NOT NULL,
		[CUSTOMER_URN]               [int] NOT NULL,
		[AGENT_URN]                  [int] NOT NULL,
		[PERSON_URN]                 [int] NOT NULL,
		[AGENT_TEAM_URN]             [int] NOT NULL,
		[LANGUAGE_URN]               [int] NOT NULL,
		[KB_FOLDER_URN]              [int] NOT NULL,
		[KB_ARTICLE_URN]             [int] NOT NULL,
		[KB_ACCESS_TYPE]             [smallint] NOT NULL,
		[READ_CONFIRMATION_CNTR]     [int] NOT NULL,
		[MANAGER_AGENT_URN]          [int] NOT NULL,
		[KB_ARTICLE_TYPE_URN]        [int] NOT NULL,
		[ARTICLE_TYPE_URN]           [smallint] NOT NULL,
		CONSTRAINT [PK_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_AGENT_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'INDEX', N'IX_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_PERSON_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'INDEX', N'IX_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'INDEX', N'IX_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table will hold the article read information details for KB Articles.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging. This maps to field PKEY in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field SESSION_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A foreign key to the language of this culture in TE_ADM_CULTURE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb folder in TB_DIM_KB_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb article in TB_DIM_KB_ARTICLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The access type for the record based on view VW_DIM_KB_ACCESS_TYPE_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_ACCESS_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to TB_DIM_KB_ARTICLE_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'KB_ARTICLE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to VW_DIM_KB_ARTICLE_TYPE_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION', 'COLUMN', N'ARTICLE_TYPE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_KNOWLEDGE_ARTICLE_READ_CONFIRMATION] SET (LOCK_ESCALATION = TABLE)
GO
