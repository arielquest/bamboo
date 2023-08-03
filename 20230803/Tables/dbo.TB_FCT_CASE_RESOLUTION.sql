SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CASE_RESOLUTION] (
		[PARTITION_URN]                                [int] NOT NULL,
		[PARTITION_ID]                                 [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                         [bigint] NOT NULL,
		[FIRST_DATE_TIME_UTC]                          [datetime] NOT NULL,
		[FINAL_DATE_TIME_UTC]                          [datetime] NOT NULL,
		[FINAL_DATE_UTC_URN]                           [int] NOT NULL,
		[FINAL_TIME_UTC_URN]                           [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]                         [int] NOT NULL,
		[FIRST_TENANT_URN]                             [int] NOT NULL,
		[FINAL_TENANT_URN]                             [int] NOT NULL,
		[FIRST_ACTIVITY_TYPE_CODE_URN]                 [int] NOT NULL,
		[FINAL_ACTIVITY_TYPE_CODE_URN]                 [int] NOT NULL,
		[CASE_URN]                                     [int] NOT NULL,
		[CUSTOMER_URN]                                 [int] NOT NULL,
		[FIRST_AGENT_URN]                              [int] NOT NULL,
		[FINAL_AGENT_URN]                              [int] NOT NULL,
		[FIRST_MANAGER_AGENT_URN]                      [int] NOT NULL,
		[FINAL_MANAGER_AGENT_URN]                      [int] NOT NULL,
		[FIRST_AGENT_TEAM_URN]                         [int] NOT NULL,
		[FINAL_AGENT_TEAM_URN]                         [int] NOT NULL,
		[FIRST_PERSON_URN]                             [int] NOT NULL,
		[FINAL_PERSON_URN]                             [int] NOT NULL,
		[FIRST_QUEUE_URN]                              [int] NOT NULL,
		[FINAL_QUEUE_URN]                              [int] NOT NULL,
		[FIRST_CLASSIFICATION_CATEGORY_URN]            [int] NOT NULL,
		[FINAL_CLASSIFICATION_CATEGORY_URN]            [int] NOT NULL,
		[FIRST_RESOLUTION_CODE_CATEGORY_URN]           [int] NOT NULL,
		[FINAL_RESOLUTION_CODE_CATEGORY_URN]           [int] NOT NULL,
		[FIRST_CLOSE_CASE_CNTR]                        [int] NOT NULL,
		[FIRST_CLOSE_CASE_REOPEN_CNTR]                 [int] NOT NULL,
		[REPEAT_CLOSE_CASE_CNTR]                       [int] NOT NULL,
		[REPEAT_CLOSE_CASE_REOPEN_CNTR]                [int] NOT NULL,
		[CASE_REWORK_TIME]                             [bigint] NOT NULL,
		[CASE_FCR_CNTR]                                [int] NOT NULL,
		[CASE_NON_FCR_CNTR]                            [int] NOT NULL,
		[CASE_REOPEN_SEQUENCE_NUMBER]                  [int] NOT NULL,
		[CASE_ACTIVITY_SEQUENCE_NUMBER]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_0]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_1]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_2]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_3]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_4]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_5]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_6]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_7]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_8]                           [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_9]                           [int] NOT NULL,
		[CUSTOM_MEASURE_0]                             [int] NOT NULL,
		[CUSTOM_MEASURE_1]                             [int] NOT NULL,
		[CUSTOM_MEASURE_2]                             [int] NOT NULL,
		[CUSTOM_MEASURE_3]                             [int] NOT NULL,
		[CUSTOM_MEASURE_4]                             [int] NOT NULL,
		[CUSTOM_MEASURE_5]                             [int] NOT NULL,
		[CUSTOM_MEASURE_6]                             [int] NOT NULL,
		[CUSTOM_MEASURE_7]                             [int] NOT NULL,
		[CUSTOM_MEASURE_8]                             [int] NOT NULL,
		[CUSTOM_MEASURE_9]                             [int] NOT NULL,
		[DB_DATETIME_UTC]                              [datetime] NOT NULL,
		[FIRST_VIEWED_KB_FOLDER_URN]                   [int] NOT NULL,
		[FINAL_VIEWED_KB_FOLDER_URN]                   [int] NOT NULL,
		[FIRST_VIEWED_KB_PORTAL_URN]                   [int] NOT NULL,
		[FINAL_VIEWED_KB_PORTAL_URN]                   [int] NOT NULL,
		[FIRST_VIEWED_KB_TOPIC_URN]                    [int] NOT NULL,
		[FINAL_VIEWED_KB_TOPIC_URN]                    [int] NOT NULL,
		[FIRST_VIEWED_KB_ARTICLE_URN]                  [int] NOT NULL,
		[FINAL_VIEWED_KB_ARTICLE_URN]                  [int] NOT NULL,
		[FIRST_USED_KB_FOLDER_URN]                     [int] NOT NULL,
		[FINAL_USED_KB_FOLDER_URN]                     [int] NOT NULL,
		[FIRST_USED_KB_ARTICLE_URN]                    [int] NOT NULL,
		[FINAL_USED_KB_ARTICLE_URN]                    [int] NOT NULL,
		[FIRST_KNOWLEDGE_USED_BOOLEAN_VALUE_URN]       [bit] NOT NULL,
		[FINAL_KNOWLEDGE_USED_BOOLEAN_VALUE_URN]       [bit] NOT NULL,
		[FIRST_KNOWLEDGE_VIEWED_BOOLEAN_VALUE_URN]     [bit] NOT NULL,
		[FINAL_KNOWLEDGE_VIEWED_BOOLEAN_VALUE_URN]     [bit] NOT NULL
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FIRST_AGENT_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FIRST_AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FIRST_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FINAL_AGENT_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FINAL_AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FINAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FIRST_MANAGER_AGENT_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FIRST_MANAGER_AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FIRST_MANAGER_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FINAL_MANAGER_AGENT_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FINAL_MANAGER_AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FINAL_MANAGER_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FIRST_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FIRST_AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FIRST_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FINAL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FINAL_AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FINAL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FIRST_PERSON_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FIRST_PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FIRST_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_RESOLUTION_FINAL_PERSON_URN]
	ON [dbo].[TB_FCT_CASE_RESOLUTION] ([FINAL_PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'INDEX', N'IX_FCT_CASE_RESOLUTION_FINAL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical detail statistics of case resolution data. This schema contains data to analyze case closure, reopens and first contact resolution rates.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the first close case event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the close case event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent who closed this case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to the type of the activity (e.g. Chat or Email) associated with this first closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to the type of the activity (e.g. Chat or Email) associated with this closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CASE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CUSTOMER.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOMER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who closed the first case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who closed this case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Manager Agent who closed this case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent of the first closed case where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent of this closed case where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent of the first closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent of this closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the queue of the first closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the queue of this case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CATEGORY.ITEM_URN and refers to the classification category of the first closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_CLASSIFICATION_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CATEGORY', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_CLASSIFICATION_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CATEGORY.ITEM_URN and refers to the classification category of this case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_CLASSIFICATION_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CATEGORY', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_CLASSIFICATION_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CATEGORY.ITEM_URN and refers to the resolution category of the first closed case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_RESOLUTION_CODE_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CATEGORY', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_RESOLUTION_CODE_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CATEGORY.ITEM_URN and refers to the resolution category of this case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_RESOLUTION_CODE_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CATEGORY', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_RESOLUTION_CODE_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determines whether this is a closed case with no previous closures or reopens. Number of inbound activities in case is not considered. Cases reopened more than 90 days after last being closed will be recounted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_CLOSE_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determines if the case was closed but subequently reopened once. Cases reopened more than 90 days after last being closed will not be counted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_CLOSE_CASE_REOPEN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determines whether this is a closed case with previous closures or reopens. Number of inbound activities in case is not considered. Cases reopened more than 90 days after last being closed will be recounted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'REPEAT_CLOSE_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determines if the case was closed but subsequently reopened more than once. Cases reopened more than 90 days after last being closed will not be counted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'REPEAT_CLOSE_CASE_REOPEN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration in seconds between this close case and the first time it was closed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_REWORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determines if this case contains no more than one inbound activity at the time of closure. If a case that was closed has been reopened within 90 days of last being closed, it will no longer be counted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_FCR_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determines if this case contains more than one inbound activity at the time of closure. If a case that was closed has been reopened within 90 days of last being closed, it will no longer be counted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_NON_FCR_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times this case has been closed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_REOPEN_SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of completed inbound activities for thie case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CASE_ACTIVITY_SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date/time stamp when the record was written into the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'DB_DATETIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_FOLDER.ITEM_URN and refers to the folder of the last article viewed by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_FOLDER.ITEM_URN and refers to the folder of the last article viewed by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_PORTAL.ITEM_URN and refers to the portal of the last article viewed by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_PORTAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_PORTAL.ITEM_URN and refers to the portal of the last article viewed by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_PORTAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_PORTAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_TOPIC.ITEM_URN and refers to the topic of the last article viewed by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_TOPIC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_TOPIC', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_TOPIC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_TOPIC.ITEM_URN and refers to the topic of the last article viewed by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_TOPIC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_TOPIC', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_TOPIC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the last article viewed by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_VIEWED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the last article viewed by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_VIEWED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_FOLDER.ITEM_URN and refers to the folder of the last article used by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_USED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_USED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_FOLDER.ITEM_URN and refers to the folder of the last article used by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_USED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_USED_KB_FOLDER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the last article used by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_USED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_USED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_KB_ARTICLE.ITEM_URN and refers to the last article used by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_USED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_KB_ARTICLE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_USED_KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to VW_DIM_BOOLEAN_VALUE_CUBE.BOOLEAN_VALUE_URN and knowledge was used by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_KNOWLEDGE_USED_BOOLEAN_VALUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to VW_DIM_BOOLEAN_VALUE_CUBE.BOOLEAN_VALUE_URN and knowledge was used by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_KNOWLEDGE_USED_BOOLEAN_VALUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to VW_DIM_BOOLEAN_VALUE_CUBE.BOOLEAN_VALUE_URN and knowledge was viewed by the Agent who first closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FIRST_KNOWLEDGE_VIEWED_BOOLEAN_VALUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to VW_DIM_BOOLEAN_VALUE_CUBE.BOOLEAN_VALUE_URN and knowledge was viewed by the Agent who closed the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_RESOLUTION', 'COLUMN', N'FINAL_KNOWLEDGE_VIEWED_BOOLEAN_VALUE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CASE_RESOLUTION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CASE_RESOLUTION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CASE_RESOLUTION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CASE_RESOLUTION] SET (LOCK_ESCALATION = TABLE)
GO
