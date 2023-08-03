SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CBR_SESSION_DETAIL] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[DATE_TIME_UTC]                  [datetime] NOT NULL,
		[DATE_UTC_URN]                   [int] NOT NULL,
		[TIME_UTC_URN]                   [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[SESSION_ID]                     [numeric](19, 0) NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[CBR_RELEASE_URN]                [int] NOT NULL,
		[KB_ARTICLE_URN]                 [int] NOT NULL,
		[CUSTOMER_URN]                   [int] NOT NULL,
		[AGENT_URN]                      [int] NOT NULL,
		[PERSON_URN]                     [int] NOT NULL,
		[AGENT_TEAM_URN]                 [int] NOT NULL,
		[LANGUAGE_URN]                   [int] NOT NULL,
		[KB_PORTAL_URN]                  [int] NOT NULL,
		[KB_SESSION_TYPE_URN]            [smallint] NOT NULL,
		[KB_START_ARTICLE_URN]           [int] NOT NULL,
		[GHE_CLUSTER_GROUP_URN]          [int] NOT NULL,
		[GHE_QUESTION_URN]               [int] NOT NULL,
		[GHE_ANSWER_URN]                 [int] NOT NULL,
		[MANAGER_AGENT_URN]              [int] NOT NULL,
		[CLUSTER_ACTIVATED_CNTR]         [int] NOT NULL,
		[CLUSTER_DEACTIVATED_CNTR]       [int] NOT NULL,
		[ARTICLE_ANSWER_CNTR]            [int] NOT NULL,
		[BOOKMARK_RECAP_CNTR]            [int] NOT NULL,
		[CONTROL_ACTION_ANSWER_CNTR]     [int] NOT NULL,
		[DATA_LINK_ANSWER_CNTR]          [int] NOT NULL,
		[USER_FIRST_ANSWER_CNTR]         [int] NOT NULL,
		[USER_REANSWER_CNTR]             [int] NOT NULL,
		[UNANSWERED_CNTR]                [int] NOT NULL,
		[SOLUTION_PRESENTED_CNTR]        [int] NOT NULL,
		[SOLUTION_VIEW_CNTR]             [int] NOT NULL,
		[SOLUTION_ACCEPTED_CNTR]         [int] NOT NULL,
		[SOLUTION_REJECTED_CNTR]         [int] NOT NULL,
		[CUSTOM_DIMENSION_0]             [int] NOT NULL,
		[CUSTOM_DIMENSION_1]             [int] NOT NULL,
		[CUSTOM_DIMENSION_2]             [int] NOT NULL,
		[CUSTOM_DIMENSION_3]             [int] NOT NULL,
		[CUSTOM_DIMENSION_4]             [int] NOT NULL,
		[CUSTOM_DIMENSION_5]             [int] NOT NULL,
		[CUSTOM_DIMENSION_6]             [int] NOT NULL,
		[CUSTOM_DIMENSION_7]             [int] NOT NULL,
		[CUSTOM_DIMENSION_8]             [int] NOT NULL,
		[CUSTOM_DIMENSION_9]             [int] NOT NULL,
		[CUSTOM_MEASURE_0]               [int] NOT NULL,
		[CUSTOM_MEASURE_1]               [int] NOT NULL,
		[CUSTOM_MEASURE_2]               [int] NOT NULL,
		[CUSTOM_MEASURE_3]               [int] NOT NULL,
		[CUSTOM_MEASURE_4]               [int] NOT NULL,
		[CUSTOM_MEASURE_5]               [int] NOT NULL,
		[CUSTOM_MEASURE_6]               [int] NOT NULL,
		[CUSTOM_MEASURE_7]               [int] NOT NULL,
		[CUSTOM_MEASURE_8]               [int] NOT NULL,
		[CUSTOM_MEASURE_9]               [int] NOT NULL,
		[ANSWER_TYPE_URN]                [int] NOT NULL,
		[GHE_CLUSTER_URN]                [int] NOT NULL,
		[KB_ARTICLE_TYPE_URN]            [int] NOT NULL,
		[ARTICLE_TYPE_URN]               [smallint] NOT NULL,
		[KB_START_FOLDER_URN]            [int] NOT NULL,
		[KB_START_OWNER_URN]             [int] NOT NULL,
		[KB_SOLUTION_FOLDER_URN]         [int] NOT NULL,
		[KB_SOLUTION_OWNER_URN]          [int] NOT NULL,
		CONSTRAINT [PK_FCT_CBR_SESSION_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CBR_SESSION_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_CBR_SESSION_DETAIL] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'INDEX', N'IX_FCT_CBR_SESSION_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CBR_SESSION_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_CBR_SESSION_DETAIL] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'INDEX', N'IX_FCT_CBR_SESSION_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CBR_SESSION_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CBR_SESSION_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'INDEX', N'IX_FCT_CBR_SESSION_DETAIL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain Guided Help Session Detail-level reporting.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC corresponding to the current event occurred in a GH Session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the guided help session identifier on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the guided help case base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CBR_RELEASE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CBR_RELEASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN indicating the article that was accepted or rejected as a solution for the guided help session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This will be a foreign key to TB_DIM_CUSTOMER.ITEM_URN indicating the authenticated customer for the knowledge base portal who initiated the guided help session. This will be set only for authenticated customer sessions. Default is -1 indicating no customer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN indicating the authenticated knowledge agent for the guided help session. This will be set only for portal sessions accessed by knowledge agents. Default is -1 indicating no agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN indicating the Person for the Agent. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN indicating the Agent Team for the Agent where it is a physical member. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TE_ADM_CULTURE.CULTURE_URN indicating the language of the guided help session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_PORTAL.ITEM_URN and refers to the KB Portal that was used to access guided help.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of user who used guided help - an agent, a self service customer or a virtual assistant.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'KB_SESSION_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the guided help session article from which guided help was initiated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'KB_START_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a cluster in the Case Base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'GHE_CLUSTER_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a question in the Case Base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'GHE_QUESTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the answer that was selected for a list or enumerated question.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'GHE_ANSWER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a cluster was activated during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CLUSTER_ACTIVATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a cluster was deactivated during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CLUSTER_DEACTIVATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was answered by a Guided Help Session article during the interval. These are articles which, when accessed, will begin the Guided Help dialog and can automatically answer selected questions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'ARTICLE_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question and answer were recapped when resuming a bookmarked dialog in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'BOOKMARK_RECAP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was answered by a control action during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CONTROL_ACTION_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was answered by a data link during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'DATA_LINK_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that an unanswered question was answered by the user during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'USER_FIRST_ANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was reanswered by the user during a Guided Help dialog that began in the interval, changing the answer that had been given before.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'USER_REANSWER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a question was unanswered by the user during a Guided Help dialog that began in the interval, removing an answer that had been given before rather than changing it.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'UNANSWERED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a solution article was presented during a Guided Help dialog that began in the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'SOLUTION_PRESENTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a solution article was viewed by a user during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'SOLUTION_VIEW_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating the GH solution was accepted by user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'SOLUTION_ACCEPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a counter indicating the GH solution was rejected by user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'SOLUTION_REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to TB_DIM_KB_ARTICLE_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'KB_ARTICLE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to VW_DIM_KB_ARTICLE_TYPE_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CBR_SESSION_DETAIL', 'COLUMN', N'ARTICLE_TYPE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CBR_SESSION_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CBR_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CBR_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CBR_SESSION_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
