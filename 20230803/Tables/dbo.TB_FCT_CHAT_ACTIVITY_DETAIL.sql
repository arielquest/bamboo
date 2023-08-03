SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] (
		[PARTITION_URN]                           [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                    [bigint] NOT NULL,
		[PARTITION_ID]                            [int] NOT NULL,
		[DATE_TIME_UTC]                           [datetime] NOT NULL,
		[DATE_UTC_URN]                            [int] NOT NULL,
		[TIME_UTC_URN]                            [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]                    [int] NOT NULL,
		[SKEY]                                    [numeric](19, 0) NOT NULL,
		[ACTIVITY_ID]                             [numeric](19, 0) NOT NULL,
		[ACTIVITY_STATE]                          [smallint] NOT NULL,
		[CASE_ID]                                 [numeric](19, 0) NOT NULL,
		[CASE_STATE]                              [smallint] NOT NULL,
		[CASE_SEVERITY]                           [int] NOT NULL,
		[TENANT_URN]                              [int] NOT NULL,
		[ENTRY_POINT_URN]                         [int] NOT NULL,
		[CUSTOMER_URN]                            [int] NOT NULL,
		[AGENT_URN]                               [int] NOT NULL,
		[PERSON_URN]                              [int] NOT NULL,
		[QUEUE_URN]                               [int] NOT NULL,
		[AGENT_TEAM_URN]                          [int] NOT NULL,
		[SKILLGROUP_URN]                          [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]              [int] NOT NULL,
		[ACTIVITY_ORIGIN]                         [int] NOT NULL,
		[NEW_CASE_CNTR]                           [int] NOT NULL,
		[EXISTING_CASE_CNTR]                      [int] NOT NULL,
		[PULLED_BY_USER_CNTR]                     [int] NOT NULL,
		[ASSIGNED_TO_USER_CNTR]                   [int] NOT NULL,
		[UNASSIGNED_FROM_USER_CNTR]               [int] NOT NULL,
		[SERVICED_CNTR]                           [int] NOT NULL,
		[ABANDONED_CNTR]                          [int] NOT NULL,
		[COMPLETED_CNTR]                          [int] NOT NULL,
		[WAIT_SERVICED_TIME]                      [int] NOT NULL,
		[WAIT_ABANDONED_TIME]                     [int] NOT NULL,
		[CHAT_DURATION]                           [int] NOT NULL,
		[WORK_TIME]                               [int] NOT NULL,
		[WRAP_TIME]                               [int] NOT NULL,
		[FOLLOWUP_EMAIL_CNTR]                     [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                      [int] NOT NULL,
		[CUSTOM_MEASURE_0]                        [int] NULL,
		[CUSTOM_MEASURE_1]                        [int] NULL,
		[CUSTOM_MEASURE_2]                        [int] NULL,
		[CUSTOM_MEASURE_3]                        [int] NULL,
		[CUSTOM_MEASURE_4]                        [int] NULL,
		[CUSTOM_MEASURE_5]                        [int] NULL,
		[CUSTOM_MEASURE_6]                        [int] NULL,
		[CUSTOM_MEASURE_7]                        [int] NULL,
		[CUSTOM_MEASURE_8]                        [int] NULL,
		[CUSTOM_MEASURE_9]                        [int] NULL,
		[ACTIVITY_URN]                            [int] NOT NULL,
		[CASE_URN]                                [int] NOT NULL,
		[ASSIGNED_DURATION]                       [int] NOT NULL,
		[FIRST_SERVICED_CNTR]                     [int] NOT NULL,
		[AGENT_DURATION]                          [int] NOT NULL,
		[HANDLED]                                 [int] NOT NULL,
		[INCOMING_QUEUE]                          [int] NOT NULL,
		[INCOMING_WAIT_SERVICED_TIME]             [int] NOT NULL,
		[WORK_STATE_TIME]                         [int] NOT NULL,
		[WRAP_STATE_TIME]                         [int] NOT NULL,
		[MANAGER_AGENT_URN]                       [int] NOT NULL,
		[CHAT_REFERRER_NAME_URN]                  [int] NOT NULL,
		[CHAT_REFERRER_URL_URN]                   [int] NOT NULL,
		[CONFERENCE_IN_CNTR]                      [int] NOT NULL,
		[AUTO_COMPLETED_CNTR]                     [int] NOT NULL,
		[COMPLETED_BY_AGENT_CNTR]                 [int] NOT NULL,
		[COMPLETED_BY_ERROR_CNTR]                 [int] NOT NULL,
		[COMPLETED_BY_OTHER_USER_CNTR]            [int] NOT NULL,
		[ABANDONED_MET_SLA]                       [int] NOT NULL,
		[ABANDONED_NOT_MET_SLA]                   [int] NOT NULL,
		[SERVICED_MET_SLA]                        [int] NOT NULL,
		[SERVICED_NOT_MET_SLA]                    [int] NOT NULL,
		[INCOMING_SERVICED_MET_SLA]               [int] NOT NULL,
		[INCOMING_SERVICED_NOT_MET_SLA]           [int] NOT NULL,
		[ABANDONED_AGENT_CNTR]                    [int] NOT NULL,
		[ABANDONED_QUEUE_CNTR]                    [int] NOT NULL,
		[INCOMING_ABANDONED_CNTR]                 [int] NOT NULL,
		[INCOMING_ABANDONED_AGENT_CNTR]           [int] NOT NULL,
		[INCOMING_ABANDONED_QUEUE_CNTR]           [int] NOT NULL,
		[INCOMING_WAIT_ABANDONED_TIME]            [int] NOT NULL,
		[VA_SELF_SERVED_CNTR]                     [int] NOT NULL,
		[INCOMING_ABANDONED_SLA_MET_CNTR]         [int] NOT NULL,
		[INCOMING_ABANDONED_SLA_NOT_MET_CNTR]     [int] NOT NULL,
		CONSTRAINT [PK_FCT_CHAT_ACTIVITY_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_ACTIVITY_DETAIL_PARTITION_GLOBAL_URN]
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] ([PARTITION_GLOBAL_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CHAT_ACTIVITY_DETAIL_PARTITION_GLOBAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_ACTIVITY_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CHAT_ACTIVITY_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_ACTIVITY_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] ([PERSON_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CHAT_ACTIVITY_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_ACTIVITY_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CHAT_ACTIVITY_DETAIL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_ACTIVITY_DETAIL_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] ([SKILLGROUP_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CHAT_ACTIVITY_DETAIL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain chat activities. It is equivalent to EGDM_INT_FCT_CHATACTIVITY_DET in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the activity when this routing activity was performed. 1 = Open, 2 = Completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the case when this event occured. 1 = Open, 2 = Completed, 4 = Reopened.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CASE_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An integer value that identifies the severity of this case when this routing activity was performed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CASE_SEVERITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ENTRY_POINT.ITEM_URN and refers to the entry point of this chat activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ENTRY_POINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SKILLGROUP.ITEM_URN and refers to the Skill Group relating to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of chat activity e.g. Video or Text.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat originated from an offer (proactive chat) or if it was a reactive chat. 0 = Proactive, 1 = Reactive.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_ORIGIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this is a new chat activity for a new case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'NEW_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not in use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'EXISTING_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was pulled by an agent from a queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'PULLED_BY_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was assigned to the user by the agent assignment service or by another user through transfer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was pushed back from the agent’s Chat Inbox because the agent did not attend to it in the time configured in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'UNASSIGNED_FROM_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was serviced by an agent at least once. A chat is considered as serviced when the activity status is changed to Assigned - In Progress at least once. This occurs when the agent selects the activity in the Chat Inbox the first time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'SERVICED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was abandoned by the customer before an agent joins the chat session. A chat is considered as abandoned if the customer leaves the chat session before the activity status changes to Assigned - In Progress the first time. This occurs when no agent joins the chat session and the customer leaves the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ABANDONED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat activity is completed. This includes the activities created by the system or by the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The wait time before the chat is serviced by an agent. Wait Serviced Time = Time when agent clicks on a chat – Time when the chat is started', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'WAIT_SERVICED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The wait time before the customer abandoned the chat. Wait Abandoned Time = Time customer abandoned the chat – Time when the chat is started', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'WAIT_ABANDONED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total duration of a chat. Chat Duration = Activity completion time – Activity creation time', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CHAT_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time the agent spent actively servicing a chat. This is not the time for which the chat stays in the agents inbox, but the time for which the agent works on the activity. For example, assume that the agent is servicing two chats at a time, and both the activities stay in the agent’s inbox for 10 minutes and the time for which the agent has serviced each of the chat is five minutes. The work time for each activity is five minutes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The time the agent spent working on the activity after the customer has exited the chat. This is the time for which the agent’s focus is on a chat activity after the customer exits the chat and before the agent completes the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'WRAP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat transcript was emailed to the customer. Transcripts can be emailed for both serviced chats and abandoned chats.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'FOLLOWUP_EMAIL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration the chat has been assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was serviced by an agent for the first time, this will be once per Activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'FIRST_SERVICED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For all chats handled (i.e. completed or transferred out) during the interval, the total time that elapsed between each chat being assigned to the agent and being handled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats completed or manually transferred out from the agent during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming chats received by the queue during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_QUEUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For all incoming chats serviced during the interval, the total time which elapsed from each chat being initiated to the agent sending their first message.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_WAIT_SERVICED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time that an agent spent working on chats during the interval with the customer present.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time that an agent spent working on chats during the interval after the customer had left.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'WRAP_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_NAME.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CHAT_REFERRER_NAME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_URL.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CHAT_REFERRER_URL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times an agent joined a conference during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'CONFERENCE_IN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats that were auto-completed during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'AUTO_COMPLETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats that were completed by the assigned agent during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_BY_AGENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats that were completed during the interval as a result of the customer being disconnected due to a server error.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_BY_ERROR_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats that were completed during the interval by a user other than the assigned agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_BY_OTHER_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats abandoned during the interval and within the SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ABANDONED_MET_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats abandoned during the interval and after the SLA had been exceeded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ABANDONED_NOT_MET_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats serviced during the interval and within the SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'SERVICED_MET_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats serviced during the interval and after the SLA had been exceeded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'SERVICED_NOT_MET_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming chats serviced during the interval and within the SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_SERVICED_MET_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming chats serviced during the interval and after the SLA had been exceeded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_SERVICED_NOT_MET_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats abandoned during the interval while assigned to an agent but before the agent clicked on the activity to begin work on it.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ABANDONED_AGENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats abandoned during the interval while not assigned to an agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'ABANDONED_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming chats abandoned during the interval. The customer left while waiting for an agent to service the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_ABANDONED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming chats abandoned during the interval where the customer left while an agent was assigned but had not serviced the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_ABANDONED_AGENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming chats abandoned during the interval where the customer left while no agent was assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_ABANDONED_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For all incoming chats abandoned during the interval, the total time which elapsed from each chat being assigned to the queue until the customer left.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_WAIT_ABANDONED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of Virtual Assistant interactions that were completed during the interval without requiring a transfer to a live agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'VA_SELF_SERVED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats abandoned during the interval where the wait time in the current queue was within service level. Includes incoming and transferred chats.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_ABANDONED_SLA_MET_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of chats abandoned during the interval where the wait time in the current queue had exceeded service level. Includes incoming and transferred chats.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_ACTIVITY_DETAIL', 'COLUMN', N'INCOMING_ABANDONED_SLA_NOT_MET_CNTR'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CHAT_ACTIVITY_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
