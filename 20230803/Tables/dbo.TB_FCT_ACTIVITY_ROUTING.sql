SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_ACTIVITY_ROUTING] (
		[PARTITION_URN]                     [int] NOT NULL,
		[PARTITION_GLOBAL_URN]              [bigint] NOT NULL,
		[PARTITION_ID]                      [int] NOT NULL,
		[DATE_TIME_UTC]                     [datetime] NOT NULL,
		[DATE_UTC_URN]                      [int] NOT NULL,
		[TIME_UTC_URN]                      [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]              [int] NOT NULL,
		[SKEY]                              [numeric](19, 0) NOT NULL,
		[ACTIVITY_ID]                       [numeric](19, 0) NOT NULL,
		[ACTIVITY_STATE]                    [smallint] NOT NULL,
		[IS_ESCALATED]                      [bit] NOT NULL,
		[UNDELIVERABLE_MAIL]                [bit] NOT NULL,
		[CASE_ID]                           [numeric](19, 0) NOT NULL,
		[CASE_STATE]                        [smallint] NOT NULL,
		[CASE_SEVERITY]                     [int] NOT NULL,
		[TENANT_URN]                        [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]            [int] NOT NULL,
		[CUSTOMER_URN]                      [int] NOT NULL,
		[AGENT_URN]                         [int] NOT NULL,
		[PERSON_URN]                        [int] NOT NULL,
		[AGENT_TEAM_URN]                    [int] NOT NULL,
		[ACTOR_AGENT_URN]                   [int] NOT NULL,
		[ACTOR_PERSON_URN]                  [int] NOT NULL,
		[ACTOR_AGENT_TEAM_URN]              [int] NOT NULL,
		[QUEUE_URN]                         [int] NOT NULL,
		[SKILLGROUP_URN]                    [int] NOT NULL,
		[OBJECT_OPERATION]                  [int] NOT NULL,
		[NEW_IN_QUEUE_CASE_CNTR]            [int] NOT NULL,
		[EXISTING_IN_QUEUE_CASE_CNTR]       [int] NOT NULL,
		[PUSHED_TO_USER_CNTR]               [int] NOT NULL,
		[PULLED_BY_USER_CNTR]               [int] NOT NULL,
		[PUSHEDBACK_TO_QUEUE_CNTR]          [int] NOT NULL,
		[WORKFLOW_XFER_FROM_USER_CNTR]      [int] NOT NULL,
		[WORKFLOW_XFER_FROM_QUEUE_CNTR]     [int] NOT NULL,
		[WORKFLOW_XFER_FROM_DEPT_CNTR]      [int] NOT NULL,
		[MANUAL_XFER_FROM_USER_CNTR]        [int] NOT NULL,
		[MANUAL_XFER_FROM_QUEUE_CNTR]       [int] NOT NULL,
		[MANUAL_XFER_FROM_DEPT_CNTR]        [int] NOT NULL,
		[WORKFLOW_XFER_TO_USER_CNTR]        [int] NOT NULL,
		[WORKFLOW_XFER_TO_QUEUE_CNTR]       [int] NOT NULL,
		[WORKFLOW_XFER_TO_DEPT_CNTR]        [int] NOT NULL,
		[MANUAL_XFER_TO_USER_CNTR]          [int] NOT NULL,
		[MANUAL_XFER_TO_QUEUE_CNTR]         [int] NOT NULL,
		[MANUAL_XFER_TO_DEPT_CNTR]          [int] NOT NULL,
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
		[ACTIVITY_URN]                      [int] NOT NULL,
		[CASE_URN]                          [int] NOT NULL,
		[REASON_CODE_URN]                   [int] NOT NULL,
		[ENTRY_POINT_URN]                   [int] NOT NULL,
		[ALIAS_URN]                         [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]        [int] NOT NULL,
		[PULLED_FROM_USER_CNTR]             [int] NOT NULL,
		[MANAGER_AGENT_URN]                 [int] NOT NULL,
		[MANUAL_XFER_BACK_CNTR]             [int] NOT NULL,
		[WORKFLOW_XFER_BACK_CNTR]           [int] NOT NULL,
		[CHAT_REFERRER_NAME_URN]            [int] NOT NULL,
		[CHAT_REFERRER_URL_URN]             [int] NOT NULL,
		CONSTRAINT [PK_FCT_ACTIVITY_ROUTING]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_AGENT_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_PERSON_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_ACTOR_AGENT_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([ACTOR_AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_ACTOR_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_ACTOR_PERSON_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([ACTOR_PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_ACTOR_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_ACTOR_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([ACTOR_AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_ACTOR_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_ROUTING_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING] ([SKILLGROUP_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'INDEX', N'IX_FCT_ACTIVITY_ROUTING_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to activity routing in the eGain application. It is equivalent to EGDM_INT_FCT_ACTIVITY_ROUTING in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the activity when this routing activity was performed. 1 = Open, 2 = Completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTIVITY_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is an escalated email activity from the self-service portal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'IS_ESCALATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is an activity created because of an undeliverable email.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'UNDELIVERABLE_MAIL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the case when this routing activity was performed. 1 = Open, 2 = Completed, 4 = Reopened.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CASE_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An integer value that identifies the severity of this case when this routing activity was performed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CASE_SEVERITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to an Activity Type in the Activity Type Code Group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent that triggered the transfer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Actor Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTOR_PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTOR_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTOR_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTOR_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SKILLGROUP.ITEM_URN and refers to the Skill Group relating to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The object operation value from the source event table which corresponds to this activity routing event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'OBJECT_OPERATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of new activities with new cases, or no cases, coming into the queue. This does not include new activities for existing cases.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'NEW_IN_QUEUE_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of new activities for existing cases coming into the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'EXISTING_IN_QUEUE_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities assigned or pushed to a user by the routing engine.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PUSHED_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities pulled or picked by a user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PULLED_BY_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities pushed back to the queue as a result of activities meeting the autopushback criteria.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PUSHEDBACK_TO_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The number of activities transferred from a user automatically by the workflow engine to a queue or another user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_FROM_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred from a queue automatically by the workflow engine to another queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_FROM_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred from a department automatically by the workflow engine to a queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_FROM_DEPT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred from a user manually to a queue or another user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_FROM_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred from a queue manually to another queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_FROM_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred from a department manually to a queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_FROM_DEPT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred to a user automatically from a queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred to a queue automatically from a queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_TO_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred to a department automatically from a queue or user', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_TO_DEPT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred to a user manually from a queue or another user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The number of activities transferred to a queue manually from another queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_TO_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities transferred to a department manually from a queue or user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_TO_DEPT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_REASON_CODE indicating the reason why the activity was transferred.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_REASON_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ENTRY_POINT.ITEM_URN and refers to the entry point of this chat activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ENTRY_POINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ALIAS.ITEM_URN and refers to the email Alias of this email activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALIAS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that an activity was manually pulled or picked away from an agent by another user during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'PULLED_FROM_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times during the interval that activities were manually transferred from an agent back to the activitys originating queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'MANUAL_XFER_BACK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times during the interval that activities were automatically transferred by the workflow from an agent back to the activitys originating queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'WORKFLOW_XFER_BACK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_NAME.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CHAT_REFERRER_NAME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_URL.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_ROUTING', 'COLUMN', N'CHAT_REFERRER_URL_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_ROUTING]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_ACTIVITY_ROUTING] SET (LOCK_ESCALATION = TABLE)
GO
