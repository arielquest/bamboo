SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL] (
		[PARTITION_URN]                     [int] NOT NULL,
		[PARTITION_ID]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]              [bigint] NOT NULL,
		[DATE_TIME_UTC]                     [datetime] NOT NULL,
		[DATE_UTC_URN]                      [int] NOT NULL,
		[TIME_UTC_URN]                      [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]              [int] NOT NULL,
		[SKEY]                              [numeric](19, 0) NOT NULL,
		[CASE_ID]                           [numeric](19, 0) NULL,
		[ACTIVITY_ID]                       [numeric](19, 0) NULL,
		[TENANT_URN]                        [int] NOT NULL,
		[CUSTOMER_URN]                      [int] NOT NULL,
		[AGENT_URN]                         [int] NOT NULL,
		[PERSON_URN]                        [int] NOT NULL,
		[AGENT_TEAM_URN]                    [int] NOT NULL,
		[QUEUE_URN]                         [int] NOT NULL,
		[ALIAS_URN]                         [int] NOT NULL,
		[ENTRY_POINT_URN]                   [int] NOT NULL,
		[LANGUAGE_URN]                      [int] NOT NULL,
		[IS_USAGE_DATA]                     [bit] NOT NULL,
		[KB_FOLDER_URN]                     [int] NOT NULL,
		[KB_ARTICLE_URN]                    [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]            [int] NOT NULL,
		[ARTICLE_ACCESS_CNTR]               [int] NOT NULL,
		[ARTICLE_ACCESS_EMAIL_CNTR]         [int] NOT NULL,
		[ARTICLE_ACCESS_CHAT_CNTR]          [int] NOT NULL,
		[ARTICLE_ACCESS_TASK_CNTR]          [int] NOT NULL,
		[ARTICLE_ACCESS_PHONE_CNTR]         [int] NOT NULL,
		[ARTICLE_ACCESS_OTHER_CNTR]         [int] NOT NULL,
		[ARTICLE_ACCESS_RULES_CNTR]         [int] NOT NULL,
		[ARTICLE_ACCESS_KB_PORTAL_CNTR]     [int] NOT NULL,
		[SS_SESSION_ID]                     [numeric](19, 0) NULL,
		[ARTICLE_AUTO_SUGGESTED_CNTR]       [int] NOT NULL,
		[ARTICLE_ACCESS_QR_CNTR]            [int] NOT NULL,
		[ARTICLE_ACCESS_QL_CNTR]            [int] NOT NULL,
		[ARTICLE_SUGGESTED_CNTR]            [int] NOT NULL,
		[ARTICLE_APPROVED_CNTR]             [int] NOT NULL,
		[ARTICLE_REJECTED_CNTR]             [int] NOT NULL,
		[ARTICLE_FEEDBACK_CNTR]             [int] NOT NULL,
		[ARTICLE_CREATED_CNTR]              [int] NOT NULL,
		[ARTICLE_UPDATED_CNTR]              [int] NOT NULL,
		[ARTICLE_DELETED_CNTR]              [int] NOT NULL,
		[ARTICLE_CHECKED_OUT_CNTR]          [int] NOT NULL,
		[ARTICLE_CHECKED_IN_CNTR]           [int] NOT NULL,
		[ARTICLE_PUBLISHED_CNTR]            [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                [int] NOT NULL,
		[CUSTOM_MEASURE_0]                  [int] NULL,
		[CUSTOM_MEASURE_1]                  [int] NULL,
		[CUSTOM_MEASURE_2]                  [int] NULL,
		[CUSTOM_MEASURE_3]                  [int] NULL,
		[CUSTOM_MEASURE_4]                  [int] NULL,
		[CUSTOM_MEASURE_5]                  [int] NULL,
		[CUSTOM_MEASURE_6]                  [int] NULL,
		[CUSTOM_MEASURE_7]                  [int] NULL,
		[CUSTOM_MEASURE_8]                  [int] NULL,
		[CUSTOM_MEASURE_9]                  [int] NULL,
		[MANAGER_AGENT_URN]                 [int] NOT NULL,
		[KB_ARTICLE_TYPE_URN]               [int] NOT NULL,
		[ARTICLE_TYPE_URN]                  [smallint] NOT NULL,
		[KB_OWNER_URN]                      [int] NOT NULL,
		CONSTRAINT [PK_FCT_KNOWLEDGE_AC_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_AC_DETAIL_PARTITION_GLOBAL_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL] ([PARTITION_GLOBAL_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_AC_DETAIL_PARTITION_GLOBAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_AC_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_AC_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_AC_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL] ([PERSON_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_AC_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_KNOWLEDGE_AC_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'INDEX', N'IX_FCT_KNOWLEDGE_AC_DETAIL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table will hold fact data for KB usages from Agent Console. The data will be sourced from eGActiveDB.EVENT_HISTORY_KB. This table will hold information about the general usage of articles from within the Agent Console including article suggestions, approvals and rejections.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging. This maps to field PKEY in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ALIAS.ITEM_URN and refers to the Alias of this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALIAS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ENTRY_POINT.ITEM_URN and refers to the entry point of this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ENTRY_POINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A foreign key to the language of this culture in TE_ADM_CULTURE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Separates the usage metrics from authoring metrics.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'IS_USAGE_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb folder in TB_DIM_KB_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the kb article in TB_DIM_KB_ARTICLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to an Activity Type in the Activity Type Code Group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed within agent console via email.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_EMAIL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed within agent console via chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_CHAT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed within agent console via task.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_TASK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed within agent console via phone.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_PHONE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed within agent console by other access methods.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_OTHER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed within agent console via rules.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_RULES_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was accessed using self service portal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_KB_PORTAL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'if present,it represents the session id for self service portal when an article was accessed via solve button.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'SS_SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of time an article was marked as a suggested response for an activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_AUTO_SUGGESTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of time an article was used via quick response in activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_QR_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of time an article was used via quick links in activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_ACCESS_QL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was suggested.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_SUGGESTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was approved.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_APPROVED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article was rejected.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article received feedback.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_FEEDBACK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_CREATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is updated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_UPDATED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_DELETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is checked out.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_CHECKED_OUT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is checked in.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_CHECKED_IN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an article is published.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_PUBLISHED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to TB_DIM_KB_ARTICLE_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'KB_ARTICLE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the KB Article, foreign key to VW_DIM_KB_ARTICLE_TYPE_CUBE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_KNOWLEDGE_AC_DETAIL', 'COLUMN', N'ARTICLE_TYPE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_KNOWLEDGE_AC_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
