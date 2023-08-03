SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY] (
		[PARTITION_URN]                            [int] NOT NULL,
		[PARTITION_ID]                             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                     [bigint] NOT NULL,
		[START_DATE_TIME_UTC]                      [datetime] NOT NULL,
		[END_DATE_TIME_UTC]                        [datetime] NOT NULL,
		[START_DATE_UTC_URN]                       [int] NOT NULL,
		[START_TIME_UTC_URN]                       [smallint] NOT NULL,
		[END_DATE_UTC_URN]                         [int] NOT NULL,
		[END_TIME_UTC_URN]                         [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]                     [int] NOT NULL,
		[SESSION_ID]                               [numeric](19, 0) NOT NULL,
		[LAST_SESSION_ENTRY_ID]                    [numeric](19, 0) NOT NULL,
		[TENANT_URN]                               [int] NOT NULL,
		[KB_PORTAL_URN]                            [int] NOT NULL,
		[CUSTOMER_URN]                             [int] NOT NULL,
		[AGENT_URN]                                [int] NOT NULL,
		[PERSON_URN]                               [int] NOT NULL,
		[AGENT_TEAM_URN]                           [int] NOT NULL,
		[LANGUAGE_URN]                             [int] NOT NULL,
		[KB_ACCESS_TYPE]                           [smallint] NOT NULL,
		[SESSION_OUTCOME]                          [int] NOT NULL,
		[SESSION_ABANDONED]                        [bit] NOT NULL,
		[SESSION_DURATION]                         [int] NOT NULL,
		[ESCALATION_ATTEMPTED_CNTR]                [int] NOT NULL,
		[ESCALATED_CNTR]                           [int] NOT NULL,
		[ESCALATION_AVERTED_CNTR]                  [int] NOT NULL,
		[SEARCH_SUCCESSFUL_CNTR]                   [int] NOT NULL,
		[SEARCH_UNSUCCESSFUL_CNTR]                 [int] NOT NULL,
		[SEARCH_RESULTS_ARTICLE_COUNT]             [int] NOT NULL,
		[GUIDED_HELP_CNTR]                         [int] NOT NULL,
		[GUIDED_HELP_SOLUTION_ACCEPT_CNTR]         [int] NOT NULL,
		[GUIDED_HELP_SOLUTION_REJECT_CNTR]         [int] NOT NULL,
		[GUIDED_HELP_QUESTION_CNTR]                [int] NOT NULL,
		[ARTICLE_USEFUL_CNTR]                      [int] NOT NULL,
		[ARTICLE_NOT_USEFUL_CNTR]                  [int] NOT NULL,
		[ARTICLE_RATED_CNTR]                       [int] NOT NULL,
		[ARTICLE_RATING_CNTR]                      [int] NOT NULL,
		[ARTICLE_ACCESS_CNTR]                      [int] NOT NULL,
		[ARTICLE_ACCESS_OTHER_CNTR]                [int] NOT NULL,
		[ARTICLE_ACCESS_DIRECT_CNTR]               [int] NOT NULL,
		[ARTICLE_ACCESS_SEARCH_CNTR]               [int] NOT NULL,
		[ARTICLE_ACCESS_GUIDED_HELP_CNTR]          [int] NOT NULL,
		[ARTICLE_ACCESS_TOPIC_CNTR]                [int] NOT NULL,
		[ARTICLE_ACCESS_TOPIC_TREE_CNTR]           [int] NOT NULL,
		[ARTICLE_ACCESS_POPULAR_ARTICLE_CNTR]      [int] NOT NULL,
		[ARTICLE_ACCESS_LIST_CNTR]                 [int] NOT NULL,
		[ARTICLE_ACCESS_SUGGESTED_CNTR]            [int] NOT NULL,
		[ARTICLE_ACCESS_CALL_TRACK_CNTR]           [int] NOT NULL,
		[ARTICLE_ACCESS_RELATED_ARTICLES_CNTR]     [int] NOT NULL,
		[ARTICLE_ACCESS_WIDGETS_CNTR]              [int] NOT NULL,
		[ARTICLE_ACCESS_MULTISEARCH_CNTR]          [int] NOT NULL,
		[ARTICLE_ACCESS_ANNOUNCEMENT_CNTR]         [int] NOT NULL,
		[ARTICLE_ACCESS_BOOKMARKS_CNTR]            [int] NOT NULL,
		[ARTICLE_ACCESS_OFFERS_CNTR]               [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                       [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                       [int] NOT NULL,
		[CUSTOM_MEASURE_0]                         [int] NULL,
		[CUSTOM_MEASURE_1]                         [int] NULL,
		[CUSTOM_MEASURE_2]                         [int] NULL,
		[CUSTOM_MEASURE_3]                         [int] NULL,
		[CUSTOM_MEASURE_4]                         [int] NULL,
		[CUSTOM_MEASURE_5]                         [int] NULL,
		[CUSTOM_MEASURE_6]                         [int] NULL,
		[CUSTOM_MEASURE_7]                         [int] NULL,
		[CUSTOM_MEASURE_8]                         [int] NULL,
		[CUSTOM_MEASURE_9]                         [int] NULL,
		[ARTICLE_ACCESS_GUIDED_HELP_INFO_CNTR]     [int] NOT NULL,
		[MANAGER_AGENT_URN]                        [int] NOT NULL,
		[SESSION_ACTIVE]                           [int] NOT NULL,
		[SESSION_ACTIVE_DURATION]                  [int] NOT NULL,
		[BOT_SESSION]                              [int] NOT NULL,
		[SESSION_SUBSCRIPTION_ACCESS]              [int] NOT NULL,
		[ARTICLE_ACCESS_SUBSCRIPTION_CNTR]         [int] NOT NULL,
		[KB_ACCESS_SUB_TYPE]                       [int] NOT NULL,
		CONSTRAINT [PK_FCT_KNOWLEDGE_SS_SESSION_SUMMARY]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_AGENT_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_PERSON_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'INDEX', N'IX_FCT_KNOWLEDGE_SS_SESSION_SUMMARY_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics relating to the performance of knowledge base portal sessions. The metrics are calculated based on session entries in the eGActiveDB.EGSS_SESSION_ENTRY table. There will be a single row for each knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC indicating the start of the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC indicating the end of the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'END_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'END_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'END_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the knowledge base portal session identifier on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the last session entry ID (EGSS_SESSION_ENTRY) seen for the knowledge base portal session on the source equipment. This is for internal use only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'LAST_SESSION_ENTRY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the knowledge base portal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_PORTAL.ITEM_URN indicating the Knowledge Base Portal for the session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_PORTAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN indicating the authenticated customer for the knowledge base portal session. This will be set only for authenticated customer sessions. Default is -1 indicating no customer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN indicating the authenticated knowledge agent for the portal session. This will be set only for portal sessions accessed by knowledge agents. Default is -1 indicating no agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN indicating the Person for the Agent. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN indicating the Agent Team for the Agent where it is a physical member. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TE_ADM_CULTURE.CULTURE_URN indicating the language of the knowledge base portal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a numeric value indicating the access type for the knowledge base session. Possible values are 1:Agent,2:Customer', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'KB_ACCESS_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a numeric value indicating the outcome for the knowledge base session. Possible values are 1:Manual Logout,2:Timeout,3:Force Shutdown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_OUTCOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a boolean flag indicating whether the session was abandoned or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_ABANDONED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration of the knowledge base portal session in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times escalations were attempted during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ESCALATION_ATTEMPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the knowledge base portal session was escalated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ESCALATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times attempted escalations were averted during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ESCALATION_AVERTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times during the knowledge base portal session search attempts resulted in atleast one article being returned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SEARCH_SUCCESSFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times during the knowledge base portal session search attempts resulted in no articles being returned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SEARCH_UNSUCCESSFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of articles retuned across all search attempts during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SEARCH_RESULTS_ARTICLE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times guided help was used during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'GUIDED_HELP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times guided help solution was accepted during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'GUIDED_HELP_SOLUTION_ACCEPT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times guided help solution was rejected during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'GUIDED_HELP_SOLUTION_REJECT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of questions presented across all guided help sessions initiated during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'GUIDED_HELP_QUESTION_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times guided help solution was accepted during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_USEFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times guided help solution was rejected during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_NOT_USEFUL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were rated during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_RATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total article rating for articles that were rated during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_RATING_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed by other access methods during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_OTHER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed directly during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_DIRECT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed from the list of articles returned from searches during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_SEARCH_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed as a result of guided help sessions during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_GUIDED_HELP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through topic list during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_TOPIC_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through topic tree during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_TOPIC_TREE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through popular articles (FAQ) section during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_POPULAR_ARTICLE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through flat list of articles presented during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_LIST_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through the suggested articles list presented during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_SUGGESTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through a call track activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_CALL_TRACK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through related articles section during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_RELATED_ARTICLES_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through widgets during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_WIDGETS_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through multisearch during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_MULTISEARCH_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through announcement list during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_ANNOUNCEMENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through bookmarks during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_BOOKMARKS_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were accessed through offers during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_OFFERS_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times articles were viewed as Guided Help additional information during the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_GUIDED_HELP_INFO_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total number of sessions that ended during the interval where user interaction with the knowledge base occurred.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_ACTIVE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total duration of sessions that ended during the interval where user interaction with the knowledge base occurred.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_ACTIVE_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identify Bot Session', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'BOT_SESSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Session level metric which will determine whether the Self Service Session had any article views via the subscription access methods.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'SESSION_SUBSCRIPTION_ACCESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Article access counter incremented each time subscription access entries (214, 215) are seen for a session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCESS_SUBSCRIPTION_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a numeric value indicating the access type for the knowledge base session. Possible values are 1:Agent,2:Customer', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY', 'COLUMN', N'KB_ACCESS_SUB_TYPE'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_KNOWLEDGE_SS_SESSION_SUMMARY] SET (LOCK_ESCALATION = TABLE)
GO
