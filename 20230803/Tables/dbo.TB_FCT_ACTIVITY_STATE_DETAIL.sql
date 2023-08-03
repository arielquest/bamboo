SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL] (
		[PARTITION_URN]                     [int] NOT NULL,
		[PARTITION_GLOBAL_URN]              [bigint] NOT NULL,
		[PARTITION_ID]                      [int] NOT NULL,
		[DATE_TIME_UTC]                     [datetime] NOT NULL,
		[DATE_UTC_URN]                      [int] NOT NULL,
		[TIME_UTC_URN]                      [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]              [int] NOT NULL,
		[SKEY]                              [numeric](19, 0) NOT NULL,
		[ACTIVITY_ID]                       [numeric](19, 0) NOT NULL,
		[CASE_ID]                           [numeric](19, 0) NOT NULL,
		[TENANT_URN]                        [int] NOT NULL,
		[ENTRY_POINT_URN]                   [int] NOT NULL,
		[ALIAS_URN]                         [int] NOT NULL,
		[CUSTOMER_URN]                      [int] NOT NULL,
		[AGENT_URN]                         [int] NOT NULL,
		[PERSON_URN]                        [int] NOT NULL,
		[QUEUE_URN]                         [int] NOT NULL,
		[AGENT_TEAM_URN]                    [int] NOT NULL,
		[SKILLGROUP_URN]                    [int] NOT NULL,
		[ACTIVITY_URN]                      [int] NOT NULL,
		[CASE_URN]                          [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]            [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]        [int] NOT NULL,
		[ACTIVITY_ORIGIN]                   [int] NOT NULL,
		[SCL_ADAPTER_URN]                   [int] NOT NULL,
		[SCL_SEARCH_URN]                    [int] NOT NULL,
		[SCL_ADAPTER_TYPE_CODE_URN]         [int] NOT NULL,
		[SCL_ADAPTER_TYPE_SUB_CODE_URN]     [int] NOT NULL,
		[CHAT_WORK_STATE_TIME]              [int] NOT NULL,
		[CHAT_WRAP_STATE_TIME]              [int] NOT NULL,
		[EMAIL_WORK_STATE_TIME]             [int] NOT NULL,
		[SOCIAL_WORK_STATE_TIME]            [int] NOT NULL,
		[TASKS_WORK_STATE_TIME]             [int] NOT NULL,
		[VCHAT_WORK_STATE_TIME]             [int] NOT NULL,
		[VCHAT_WRAP_STATE_TIME]             [int] NOT NULL,
		[CALLTRACK_WORK_STATE_TIME]         [int] NOT NULL,
		[CALLTRACK_HOLD_STATE_TIME]         [int] NOT NULL,
		[CALLTRACK_WRAP_STATE_TIME]         [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_0]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_1]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_2]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_3]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_4]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_5]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_6]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_7]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_8]                [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_9]                [int] NOT NULL,
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
		CONSTRAINT [PK_FCT_ACTIVITY_STATE_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_STATE_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'INDEX', N'IX_FCT_ACTIVITY_STATE_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_STATE_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'INDEX', N'IX_FCT_ACTIVITY_STATE_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_STATE_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'INDEX', N'IX_FCT_ACTIVITY_STATE_DETAIL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_STATE_DETAIL_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL] ([SKILLGROUP_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'INDEX', N'IX_FCT_ACTIVITY_STATE_DETAIL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain chat activities. It is equivalent to EGDM_INT_FCT_CHATACTIVITY_DET in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ENTRY_POINT.ITEM_URN and refers to the entry point of this chat activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ENTRY_POINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ALIAS.ITEM_URN and refers to the email Alias of this email activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALIAS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SKILLGROUP.ITEM_URN and refers to the Skill Group relating to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to an Activity Type in the Activity Type Code Group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of chat activity e.g. Video or Text.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat originated from an offer (proactive chat) or if it was a reactive chat. 0 = Proactive, 1 = Reactive.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'ACTIVITY_ORIGIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Adapter information, as TB_DIM_SCL_ADAPTER.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SCL_ADAPTER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Search information, as TB_DIM_SCL_SEARCH.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SCL_SEARCH_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Adapter Type Code information, as TB_DIM_CODE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SCL_ADAPTER_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Adapter Type Sub Code information, as TB_DIM_SUB_CODE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SCL_ADAPTER_TYPE_SUB_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CHAT_WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CHAT_WRAP_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'EMAIL_WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'SOCIAL_WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'TASKS_WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'VCHAT_WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'VCHAT_WRAP_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CALLTRACK_WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CALLTRACK_HOLD_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CALLTRACK_WRAP_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_STATE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_ACTIVITY_STATE_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
