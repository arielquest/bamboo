SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL] (
		[PARTITION_URN]                    [int] NOT NULL,
		[PARTITION_ID]                     [int] NOT NULL,
		[PARTITION_GLOBAL_URN]             [bigint] NOT NULL,
		[DATE_TIME_UTC]                    [datetime] NOT NULL,
		[DATE_UTC_URN]                     [int] NOT NULL,
		[TIME_UTC_URN]                     [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]             [int] NOT NULL,
		[SKEY]                             [numeric](19, 0) NOT NULL,
		[SESSION_ID]                       [bigint] NULL,
		[TENANT_URN]                       [int] NOT NULL,
		[CUSTOMER_URN]                     [int] NOT NULL,
		[AGENT_URN]                        [int] NOT NULL,
		[PERSON_URN]                       [int] NOT NULL,
		[AGENT_TEAM_URN]                   [int] NOT NULL,
		[LANGUAGE_URN]                     [int] NOT NULL,
		[KB_FOLDER_URN]                    [int] NOT NULL,
		[KB_PORTAL_URN]                    [int] NOT NULL,
		[KB_TOPIC_URN]                     [int] NOT NULL,
		[KB_ARTICLE_URN]                   [int] NOT NULL,
		[KB_SEARCH_STRING_URN]             [int] NOT NULL,
		[KB_ACCESS_TYPE]                   [smallint] NOT NULL,
		[KB_ARTICLE_ACCESS_METHOD]         [smallint] NOT NULL,
		[ARTICLE_ACCESS_CNTR]              [int] NOT NULL,
		[ARTICLE_ACCESS_ACTIVITY_CNTR]     [int] NOT NULL,
		[SESSION_DURATION]                 [bigint] NOT NULL,
		[SUCCESSFUL_SESSION_CNTR]          [int] NOT NULL,
		[ESCALATIONS_ATTEMPTED_CNTR]       [int] NOT NULL,
		[ESCALATED_CNTR]                   [int] NOT NULL,
		[ESCALATIONS_AVERTED_CNTR]         [int] NOT NULL,
		[SEARCH_SUCCESSFUL_CNTR]           [int] NOT NULL,
		[SEARCH_UNSUCCESSFUL_CNTR]         [int] NOT NULL,
		[SEARCH_RESULT_ARTICLE_COUNT]      [int] NOT NULL,
		[ARTICLE_USEFUL_CNTR]              [int] NOT NULL,
		[ARTICLE_NOT_USEFUL_CNTR]          [int] NOT NULL,
		[ARTICLE_RATED_CNTR]               [int] NOT NULL,
		[ARTICLE_RATING]                   [int] NOT NULL,
		[CUSTOM_DIMENSION_0]               [int] NOT NULL,
		[CUSTOM_DIMENSION_1]               [int] NOT NULL,
		[CUSTOM_DIMENSION_2]               [int] NOT NULL,
		[CUSTOM_DIMENSION_3]               [int] NOT NULL,
		[CUSTOM_DIMENSION_4]               [int] NOT NULL,
		[CUSTOM_DIMENSION_5]               [int] NOT NULL,
		[CUSTOM_DIMENSION_6]               [int] NOT NULL,
		[CUSTOM_DIMENSION_7]               [int] NOT NULL,
		[CUSTOM_DIMENSION_8]               [int] NOT NULL,
		[CUSTOM_DIMENSION_9]               [int] NOT NULL,
		[CUSTOM_MEASURE_0]                 [int] NULL,
		[CUSTOM_MEASURE_1]                 [int] NULL,
		[CUSTOM_MEASURE_2]                 [int] NULL,
		[CUSTOM_MEASURE_3]                 [int] NULL,
		[CUSTOM_MEASURE_4]                 [int] NULL,
		[CUSTOM_MEASURE_5]                 [int] NULL,
		[CUSTOM_MEASURE_6]                 [int] NULL,
		[CUSTOM_MEASURE_7]                 [int] NULL,
		[CUSTOM_MEASURE_8]                 [int] NULL,
		[CUSTOM_MEASURE_9]                 [int] NULL,
		[MANAGER_AGENT_URN]                [int] NOT NULL,
		[SESSION_ENTRY_TIME]               [datetime] NOT NULL,
		[KB_ARTICLE_TYPE_URN]              [int] NOT NULL,
		[ARTICLE_TYPE_URN]                 [smallint] NOT NULL,
		[KB_OWNER_URN]                     [int] NOT NULL,
		CONSTRAINT [PK_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_PARTITION_GLOBAL_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL] ([PARTITION_GLOBAL_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_PARTITION_GLOBAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL] ([PERSON_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_DETAIL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table will hold the detailed fact data for KB usage from KA-SS Portals.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging. This maps to field PKEY in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field SESSION_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A foreign key to the language of this culture in TE_ADM_CULTURE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb folder in TB_DIM_KB_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the portal in TB_DIM_KB_PORTAL.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_PORTAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the topic in TB_DIM_KB_TOPIC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_TOPIC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_TOPIC', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_TOPIC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb article in TB_DIM_KB_ARTICLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the search string in TB_DIM_KB_SEARCH_STRING.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_SEARCH_STRING_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The access type for the record based on view VW_DIM_KB_ACCESS_TYPE_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_ACCESS_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The access method for the record based on view VW_DIM_KB_ARTICLE_ACCESS_METHOD_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_ACCESS_METHOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article access activity occured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_ACTIVITY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The session duration in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SESSION_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of Sessions which had no escalations.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SUCCESSFUL_SESSION_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the user attempts to begin an escalation (by clicking Contact us, Chat with an agent, Call me, etc.) during a session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ESCALATIONS_ATTEMPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times escalation is completed�typically when the user continues the escalation even after the escalation avoidance options are presented.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ESCALATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times escalation is averted�typically when the user sees the escalation avoidance options, and does not continue with the escalation.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ESCALATIONS_AVERTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates the number of times the search action resulted in 1 or more articles.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SEARCH_SUCCESSFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates the number of times the search action resulted in 0 results.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SEARCH_UNSUCCESSFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of articles in search result.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'SEARCH_RESULT_ARTICLE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total number of times a guided help solution is rated as �useful� for a particular session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ARTICLE_USEFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total number of times a guided help solution is rated as �not useful� for a particular session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ARTICLE_NOT_USEFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is rated during a session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ARTICLE_RATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The sum of the rating values applied to the article during a session.Rating values are between 0 and 10.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ARTICLE_RATING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to TB_DIM_KB_ARTICLE_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to VW_DIM_KB_ARTICLE_TYPE_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL', 'COLUMN', N'ARTICLE_TYPE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
