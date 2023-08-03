SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL] (
		[PARTITION_URN]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[DATE_TIME_UTC]                      [datetime] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[SKEY]                               [numeric](19, 0) NOT NULL,
		[ACTIVITY_ID]                        [numeric](19, 0) NOT NULL,
		[ACTIVITY_STATE]                     [smallint] NOT NULL,
		[CASE_ID]                            [numeric](19, 0) NOT NULL,
		[CASE_STATE]                         [smallint] NOT NULL,
		[CASE_SEVERITY]                      [int] NOT NULL,
		[TENANT_URN]                         [int] NOT NULL,
		[ALIAS_URN]                          [int] NOT NULL,
		[CUSTOMER_URN]                       [int] NOT NULL,
		[AGENT_URN]                          [int] NOT NULL,
		[PERSON_URN]                         [int] NOT NULL,
		[QUEUE_URN]                          [int] NOT NULL,
		[AGENT_TEAM_URN]                     [int] NOT NULL,
		[SKILLGROUP_URN]                     [int] NOT NULL,
		[IS_ESCALATED]                       [bit] NOT NULL,
		[UNDELIVERABLE_MAIL]                 [bit] NOT NULL,
		[NEW_CASE_CNTR]                      [int] NOT NULL,
		[EXISTING_CASE_CNTR]                 [int] NOT NULL,
		[NEWCASE_UNDELIVERABL_CNTR]          [int] NOT NULL,
		[EXISTINGCASE_UNDELIVERABL_CNTR]     [int] NOT NULL,
		[ASSIGNED_TO_QUEUE_CNTR]             [int] NOT NULL,
		[COMPOSE_CNTR]                       [int] NOT NULL,
		[COMPOSE_SENT_CNTR]                  [int] NOT NULL,
		[AUTO_ACK_CNTR]                      [int] NOT NULL,
		[AUTO_REPLY_CNTR]                    [int] NOT NULL,
		[MANUAL_REPLY_CNTR]                  [int] NOT NULL,
		[ASSIGNED_TO_USER_CNTR]              [int] NOT NULL,
		[COMPLETED_CNTR]                     [int] NOT NULL,
		[UNDISPATCHABL_MANUALREPLY_CNTR]     [int] NOT NULL,
		[FIRST_MANUAL_REPLY_CNTR]            [int] NOT NULL,
		[FIRST_MANUAL_REPLY_METSLA_CNTR]     [int] NOT NULL,
		[COMPLETED_METSLA_CNTR]              [int] NOT NULL,
		[FIRST_MANUAL_REPLY_TIME]            [int] NOT NULL,
		[WORK_TIME]                          [int] NOT NULL,
		[TURNAROUND_TIME]                    [int] NOT NULL,
		[ACTIVITY_DURATION]                  [int] NOT NULL,
		[FIRST_MAN_REPLY_NOTMETSLA_CNTR]     [int] NOT NULL,
		[COMPLETED_NOTMETSLA_CNTR]           [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                 [int] NOT NULL,
		[CUSTOM_MEASURE_0]                   [int] NULL,
		[CUSTOM_MEASURE_1]                   [int] NULL,
		[CUSTOM_MEASURE_2]                   [int] NULL,
		[CUSTOM_MEASURE_3]                   [int] NULL,
		[CUSTOM_MEASURE_4]                   [int] NULL,
		[CUSTOM_MEASURE_5]                   [int] NULL,
		[CUSTOM_MEASURE_6]                   [int] NULL,
		[CUSTOM_MEASURE_7]                   [int] NULL,
		[CUSTOM_MEASURE_8]                   [int] NULL,
		[CUSTOM_MEASURE_9]                   [int] NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]         [int] NOT NULL,
		[AUTHORIZED_CUSTOMER_REP_CNTR]       [int] NOT NULL,
		[NOTIFICATION_GENERATION_CNTR]       [int] NOT NULL,
		[ACTIVITY_URN]                       [int] NOT NULL,
		[CASE_URN]                           [int] NOT NULL,
		[TURNAROUND_CNTR]                    [int] NOT NULL,
		[HANDLED_CNTR]                       [int] NOT NULL,
		[HANDLED_TIME]                       [int] NOT NULL,
		[MANUAL_REPLY_TIME]                  [int] NOT NULL,
		[WORK_STATE_TIME]                    [int] NOT NULL,
		[MANAGER_AGENT_URN]                  [int] NOT NULL,
		[ACCEPTED_CNTR]                      [int] NOT NULL,
		[REJECTED_CNTR]                      [int] NOT NULL,
		[RESUBMITTED_CNTR]                   [int] NOT NULL,
		[REWORK_TIME]                        [int] NOT NULL,
		[SUP_ACCEPTED_CNTR]                  [int] NOT NULL,
		[SUP_REJECTED_CNTR]                  [int] NOT NULL,
		[FIRST_MANUAL_REPLY_TIME_BIZCAL]     [int] NOT NULL,
		[TURNAROUND_TIME_BIZCAL]             [int] NOT NULL,
		[MANUAL_REPLY_TIME_BIZCAL]           [int] NOT NULL,
		[ACTIVITY_DURATION_BIZCAL]           [int] NOT NULL,
		[TURNAROUND_TIME_MET]                [int] NOT NULL,
		[TURNAROUND_TIME_NOT_MET]            [int] NOT NULL,
		[TURNAROUND_TIME_MET_BIZCAL]         [int] NOT NULL,
		[TURNAROUND_TIME_NOT_MET_BIZCAL]     [int] NOT NULL,
		[FORWARD_CNTR]                       [int] NOT NULL,
		[REDIRECT_CNTR]                      [int] NOT NULL,
		[UNDISPATCHABLE_FORWARD_CNTR]        [int] NOT NULL,
		[UNDISPATCHABLE_REDIRECT_CNTR]       [int] NOT NULL,
		[SECURE_REPLY_CNTR]                  [int] NOT NULL,
		[MESSAGE_TYPE_URN]                   [int] NOT NULL,
		CONSTRAINT [PK_FCT_EMAIL_ACTIVITY_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EMAIL_ACTIVITY_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_EMAIL_ACTIVITY_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EMAIL_ACTIVITY_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_EMAIL_ACTIVITY_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EMAIL_ACTIVITY_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_EMAIL_ACTIVITY_DETAIL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EMAIL_ACTIVITY_DETAIL_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL] ([SKILLGROUP_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_EMAIL_ACTIVITY_DETAIL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain email activities. It is equivalent to EGDM_INT_FCT_EMAILACTIVITY_DET in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the activity when this routing activity was performed. 1 = Open, 2 = Completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the case when this event occured. 1 = Open, 2 = Completed, 4 = Reopened.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CASE_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An integer value that identifies the severity of this case when this routing activity was performed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CASE_SEVERITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ALIAS.ITEM_URN and refers to the email Alias of this email activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALIAS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SKILLGROUP.ITEM_URN and refers to the Skill Group relating to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is an escalated email activity from the self-service portal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'IS_ESCALATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is an activity created because of an undeliverable email.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'UNDELIVERABLE_MAIL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is a new email activity for a new case or no case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'NEW_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is a new email activity for an existing case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'EXISTING_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this a new undeliverable email activity that gets assigned to a new case or no case. Note: An undeliverable mail is the one that gets sent out by the dispatcher but is bounced back by the exchange server since it could not be delivered for various reasons.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'NEWCASE_UNDELIVERABL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is a new undeliverable email activity that gets assigned to an existing case. Note: An undeliverable mail is the one that gets sent out by the dispatcher but is bounced back by the exchange server since it could not be delivered for various reasons.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'EXISTINGCASE_UNDELIVERABL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times this activity is assigned to the queue. This count increases when: 1) The workflow assigns the new incoming activities to a queue. 2) A user manually transfers an activity to a queue. 3) An alarm workflow transfers an activity to a queue. 4) The transfer workflow of a department assigns the activity to a queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_TO_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is a composed activity, which is an email activity composed by an agent from the Agent Console. The activity can belong to a new case, an existing case, or can have no case associated with it.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'COMPOSE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times emails were sent out for the composed activity. This number increases every time the user clicks the Send or Send and Complete button for the composed email activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'COMPOSE_SENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times auto-acknowledgments were sent for this activity by the workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AUTO_ACK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times auto-replies were sent for this activity by the workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AUTO_REPLY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times manual replies were sent for this activity by the agent. This also column counts each email in the group reply individually. Note: Forwarded or redirected email activities are not counted here.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'MANUAL_REPLY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times this activity was assigned to users. This count increases when: 1) The routing engine assigns the new incoming activities to a user depending on the rules defined. 2) A user manually pulls an activity. 3) A user manually transfers an activity to another user. 4) An alarm workflow transfers an activity to a user. The transfer workflow of a department assigns the activity to a user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is a completed activity. An activity can be completed by an agent from the Agent Console or by workflows.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of manual replies sent by agents that the dispatcher was unable to send out. Note: Forwarded or redirected email activities are not counted here.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'UNDISPATCHABL_MANUALREPLY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first manual reply for the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'FIRST_MANUAL_REPLY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the first manual reply for the activity meets the SLA configured for emails. This is determined by comparing the due date set for the activity (in the workflow or manually) and the date and time when the first manual reply is sent out.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'FIRST_MANUAL_REPLY_METSLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this activity was completed within the SLA configured for emails. This is determined by comparing the due date set for the activity (in the workflow or manually) and the date and time when the activity is completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_METSLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time taken by the agent to send the first manual reply. This time is calculated in seconds. First manual reply time = Time when first manual reply is sent out by dispatcher � Time when activity is created', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'FIRST_MANUAL_REPLY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time spent working on an activity, in seconds. This is not the time for which an activity stays in the agent�s inbox, but the time for which the agent works on an activity. For example an activity stays in the agent�s inbox for 15 minutes and the time for which the agent has clicked on the activity is five minutes, the work time for the activity is five minutes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not in use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total duration of the activity from creation to completion. This duration is calculated in seconds. Activity Duration = Activity Completion Time � Activity Creation Time', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the first manual reply for the activity does not meet the SLA configured for emails. This is determined by comparing the due date set for the activity (in the workflow or manually) and the date and time when the first manual reply is sent out.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'FIRST_MAN_REPLY_NOTMETSLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N' Identifies if this activity was not completed within the SLA configured for emails. This is determined by comparing the due date set for the activity (in the workflow or manually) and the date and time when the activity is completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_NOTMETSLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of email e.g. Secure, Webform, General, Unknown etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'AUTHORIZED_CUSTOMER_REP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'NOTIFICATION_GENERATION_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An activity is considered to have been turned around when a first manual reply is sent or the email is completed or manually transferred out from the agent (whichever happens first after it is assigned to the agent).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails activities completed or manually transferred out from the agent during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'HANDLED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cumulative work time per activity, between the timestamp of being assigned to an agent and the timestamp of being completed or manually transferred out from that agent, in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'HANDLED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time that elapsed between each email being retrieved and the manual reply being sent, in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'MANUAL_REPLY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time spent working on an activity pegged to interval where it occurred, in seconds. This is not the time for which an activity stays in the agent�s inbox, but the time for which the agent works on an activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails sent by an agent, which were accepted by a supervisor during the interval. This is attributed to the agent who sent the email originally, not the supervisor.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'ACCEPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails sent by an agent, which were rejected by a supervisor during the interval. This is attributed to the agent who sent the email originally, not the supervisor.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails resubmitted by an agent during the interval. These are emails that the agent had originally sent which were rejected by a supervisor and re-assigned back to the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'RESUBMITTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Handle time for rejected email activities, pegged to interval of email being resubmitted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'REWORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails accepted by a supervisor during the interval. This is attributed to the supervisor, not the agent who sent the email originally.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'SUP_ACCEPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails rejected by a supervisor during the interval. This is attributed to the supervisor, not the agent who sent the email originally.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'SUP_REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails turned around within the target turnaround time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails turned around outside of the target turnaround time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_NOT_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails turned around within the target turnaround time, calculated according to the business calendar.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_MET_BIZCAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails turned around outside of the target turnaround time, calculated according to the business calendar.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_NOT_MET_BIZCAL'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_EMAIL_ACTIVITY_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
