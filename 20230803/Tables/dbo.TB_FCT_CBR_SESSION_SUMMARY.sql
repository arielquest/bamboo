SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CBR_SESSION_SUMMARY] (
		[PARTITION_URN]                            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                     [bigint] NOT NULL,
		[PARTITION_ID]                             [int] NOT NULL,
		[START_DATE_TIME_UTC]                      [datetime] NOT NULL,
		[END_DATE_TIME_UTC]                        [datetime] NOT NULL,
		[START_DATE_UTC_URN]                       [int] NOT NULL,
		[START_TIME_UTC_URN]                       [smallint] NOT NULL,
		[END_DATE_UTC_URN]                         [int] NOT NULL,
		[END_TIME_UTC_URN]                         [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]                     [int] NOT NULL,
		[SESSION_ID]                               [numeric](19, 0) NOT NULL,
		[TENANT_URN]                               [int] NOT NULL,
		[CBR_RELEASE_URN]                          [int] NOT NULL,
		[KB_ARTICLE_URN]                           [int] NOT NULL,
		[CUSTOMER_URN]                             [int] NOT NULL,
		[AGENT_URN]                                [int] NOT NULL,
		[PERSON_URN]                               [int] NOT NULL,
		[AGENT_TEAM_URN]                           [int] NOT NULL,
		[LANGUAGE_URN]                             [int] NOT NULL,
		[SESSION_CNTR]                             [int] NOT NULL,
		[SESSION_CANCELLED_CNTR]                   [int] NOT NULL,
		[SESSION_ACCEPTED_CNTR]                    [int] NOT NULL,
		[SESSION_REJECTED_CNTR]                    [int] NOT NULL,
		[SESSION_QUESTIONS_ANSWERED_CNTR]          [int] NOT NULL,
		[SESSION_QUESTIONS_ANSWERED_RULE_CNTR]     [int] NOT NULL,
		[SESSION_DURATION]                         [int] NOT NULL,
		[ARTICLE_ACCEPTED_CNTR]                    [int] NOT NULL,
		[ARTICLE_REJECTED_CNTR]                    [int] NOT NULL,
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
		[MANAGER_AGENT_URN]                        [int] NOT NULL,
		[KB_PORTAL_URN]                            [int] NOT NULL,
		[KB_SESSION_TYPE_URN]                      [smallint] NOT NULL,
		[KB_START_ARTICLE_URN]                     [int] NOT NULL,
		[BOOKMARK_RESUMED_CNTR]                    [int] NOT NULL,
		[NEW_GH_SESSION_CNTR]                      [int] NOT NULL,
		[BOOKMARK_SAVED_CNTR]                      [int] NOT NULL,
		[BOOKMARK_TIME]                            [int] NOT NULL,
		[CLUSTER_ACTIVATED_CNTR]                   [int] NOT NULL,
		[CLUSTER_DEACTIVATED_CNTR]                 [int] NOT NULL,
		[ARTICLE_ANSWER_CNTR]                      [int] NOT NULL,
		[BOOKMARK_RECAP_CNTR]                      [int] NOT NULL,
		[CONTROL_ACTION_ANSWER_CNTR]               [int] NOT NULL,
		[DATA_LINK_ANSWER_CNTR]                    [int] NOT NULL,
		[USER_FIRST_ANSWER_CNTR]                   [int] NOT NULL,
		[USER_REANSWER_CNTR]                       [int] NOT NULL,
		[UNANSWERED_CNTR]                          [int] NOT NULL,
		[SOLUTION_PRESENTED_CNTR]                  [int] NOT NULL,
		[SOLUTION_VIEW_CNTR]                       [int] NOT NULL,
		[KB_START_FOLDER_URN]                      [int] NOT NULL,
		[KB_START_OWNER_URN]                       [int] NOT NULL,
		CONSTRAINT [PK_FCT_CBR_SESSION_SUMMARY]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CBR_SESSION_SUMMARY_AGENT_URN]
	ON [dbo].[TB_FCT_CBR_SESSION_SUMMARY] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'INDEX', N'IX_FCT_CBR_SESSION_SUMMARY_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CBR_SESSION_SUMMARY_PERSON_URN]
	ON [dbo].[TB_FCT_CBR_SESSION_SUMMARY] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'INDEX', N'IX_FCT_CBR_SESSION_SUMMARY_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CBR_SESSION_SUMMARY_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CBR_SESSION_SUMMARY] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'INDEX', N'IX_FCT_CBR_SESSION_SUMMARY_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics relating to the performance of guided help sessions. The metrics are calculated based on guided helps sessions and session statistics in the eGActiveDB.CBR_SESSION, eGActiveDB.CBR_SESSION_ENTRY and eGActiveDB.CBR_SESSION_STATISTICS  table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC indicating the start of the guided help session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC indicating the end of the guided help session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'END_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'END_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'END_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the guided help session identifier on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the guided help case base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CBR_RELEASE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CBR_RELEASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN indicating the article that was accepted or rejected as a solution for the guided help session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This will be a foreign key to TB_DIM_CUSTOMER.ITEM_URN indicating the authenticated customer for the knowledge base portal who initiated the guided help session. This will be set only for authenticated customer sessions. Default is -1 indicating no customer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN indicating the authenticated knowledge agent for the guided help session. This will be set only for portal sessions accessed by knowledge agents. Default is -1 indicating no agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN indicating the Person for the Agent. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN indicating the Agent Team for the Agent where it is a physical member. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TE_ADM_CULTURE.CULTURE_URN indicating the language of the guided help session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating a unique guided help session. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating a cancelled guided help session. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_CANCELLED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating an accepted guided help session. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_ACCEPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating a rejected guided help session. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating total number of questions answered during the guided help session. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_QUESTIONS_ANSWERED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating total number of questions answered by rules during the guided help session. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_QUESTIONS_ANSWERED_RULE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration of the guided help session in seconds. This is session specific and will not be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SESSION_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating total number of times an article was accepted during the guided help session. This is article specific and will only be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ACCEPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating total number of times an article was rejected during the guided help session. This is article specific and will only be set for rows where KB_ARTICLE_URN is set to a value greater than zero.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_PORTAL.ITEM_URN and refers to the KB Portal that was used to access guided help.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of user who used guided help - an agent, a self service customer or a virtual assistant.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'KB_SESSION_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the guided help session article from which guided help was initiated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'KB_START_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of Guided Help dialogs which began during the interval by resuming a previously bookmarked dialog.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'BOOKMARK_RESUMED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of new Guided Help dialogs (i.e. not resumed bookmarks) which began during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'NEW_GH_SESSION_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of Guided Help dialogs which began during the interval, which ended by being bookmarked.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'BOOKMARK_SAVED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration of Guided Help dialog which began during the interval and ended by being bookmarked.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'BOOKMARK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a cluster was activated during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CLUSTER_ACTIVATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a cluster was deactivated during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CLUSTER_DEACTIVATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was answered by a Guided Help Session article during the interval. These are articles which, when accessed, will begin the Guided Help dialog and can automatically answer selected questions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'ARTICLE_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question and answer were recapped when resuming a bookmarked dialog in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'BOOKMARK_RECAP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was answered by a control action during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'CONTROL_ACTION_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was answered by a data link during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'DATA_LINK_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that an unanswered question was answered by the user during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'USER_FIRST_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was reanswered by the user during a Guided Help dialog that began in the interval, changing the answer that had been given before.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'USER_REANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was unanswered by the user during a Guided Help dialog that began in the interval, removing an answer that had been given before rather than changing it.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'UNANSWERED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a solution article was presented during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SOLUTION_PRESENTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a solution article was viewed by a user during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_SUMMARY', 'COLUMN', N'SOLUTION_VIEW_CNTR'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CBR_SESSION_SUMMARY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CBR_SESSION_SUMMARY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CBR_SESSION_SUMMARY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CBR_SESSION_SUMMARY] SET (LOCK_ESCALATION = TABLE)
GO
