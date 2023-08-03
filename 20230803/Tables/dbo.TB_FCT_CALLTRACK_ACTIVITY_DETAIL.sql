SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[DATE_TIME_UTC]                  [datetime] NOT NULL,
		[DATE_UTC_URN]                   [int] NOT NULL,
		[TIME_UTC_URN]                   [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[CASE_URN]                       [int] NOT NULL,
		[CASE_ID]                        [numeric](19, 0) NOT NULL,
		[ACTIVITY_URN]                   [int] NOT NULL,
		[ACTIVITY_ID]                    [numeric](19, 0) NOT NULL,
		[CUSTOMER_URN]                   [int] NOT NULL,
		[AGENT_URN]                      [int] NOT NULL,
		[MANAGER_AGENT_URN]              [int] NOT NULL,
		[AGENT_TEAM_URN]                 [int] NOT NULL,
		[PERSON_URN]                     [int] NOT NULL,
		[QUEUE_URN]                      [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]     [int] NOT NULL,
		[NEW_CALLS_IN_CNTR]              [int] NOT NULL,
		[EXISTING_CALLS_IN_CNTR]         [int] NOT NULL,
		[NEW_CALLS_OUT_CNTR]             [int] NOT NULL,
		[EXISTING_CALLS_OUT_CNTR]        [int] NOT NULL,
		[ASSIGNED_TO_SYSTEM_CNTR]        [int] NOT NULL,
		[TRANSCRIPT_SENT_CNTR]           [int] NOT NULL,
		[LINKED_TO_CUSTOMER_CNTR]        [int] NOT NULL,
		[COMPLETED_CNTR]                 [int] NOT NULL,
		[HANDLE_TIME]                    [int] NOT NULL,
		[WORK_STATE_TIME]                [int] NOT NULL,
		[ACTIVITY_DURATION]              [int] NOT NULL,
		[COMPLETED_MET_SLA_CNTR]         [int] NOT NULL,
		[COMPLETED_NOT_MET_SLA_CNTR]     [int] NOT NULL,
		[COMPLETED_NO_SLA_CNTR]          [int] NOT NULL,
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
		[DB_DATETIME_UTC]                [datetime] NOT NULL,
		[ACTIVITY_DURATION_BIZCAL]       [int] NOT NULL
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALLTRACK_ACTIVITY_DETAIL_PARTITION_GLOBAL_URN]
	ON [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] ([PARTITION_GLOBAL_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CALLTRACK_ACTIVITY_DETAIL_PARTITION_GLOBAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALLTRACK_ACTIVITY_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CALLTRACK_ACTIVITY_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALLTRACK_ACTIVITY_DETAIL_MANAGER_AGENT_URN]
	ON [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] ([MANAGER_AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CALLTRACK_ACTIVITY_DETAIL_MANAGER_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALLTRACK_ACTIVITY_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CALLTRACK_ACTIVITY_DETAIL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALLTRACK_ACTIVITY_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] ([PERSON_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'INDEX', N'IX_FCT_CALLTRACK_ACTIVITY_DETAIL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical detail statistics of CallTrack data. This schema contains data to analyze the handling of CallTrack activities in the Advisor Desktop and workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CASE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field CASE_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ACTIVITY', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field ACTIVITY_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CUSTOMER.ITEM_URN. Will be unknown for anonymous calls or events that occurred before the customer was linked to the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOMER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of chat activity e.g. Video or Text.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities created during the interval to log an inbound call, and which began a new case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'NEW_CALLS_IN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities created during the interval to log an inbound call, and which continued an existing case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'EXISTING_CALLS_IN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities created during the interval to log an outbound call, and which began a new case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'NEW_CALLS_OUT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities created during the interval to log an outbound call, and which continued an existing case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'EXISTING_CALLS_OUT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a CallTrack activity was assigned to the system during the interval. These activities were processed by the general workflow. CallTrack activities are assigned to the system automatically when an agent tries to complete them and there is an applicable workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_TO_SYSTEM_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of emails sent by an agent during the interval to confirm a call. If subsequent emails are sent for the same CallTrack activity (using the ''Send'' rather than the ''Send & Complete'' button), then each email is counted during the interval in which it is sent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'TRANSCRIPT_SENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities linked to a customer during the interval. This counts when the call began as anonymous and the agent subequently clicked on the Link Customer button. It does not count when the customer was known from the start of the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'LINKED_TO_CUSTOMER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities completed during the interval. An activity is typically completed by an agent but may be completed by the workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For CallTrack activities handled (i.e. completed, assigned to system or manually transferred out from the agent) during the interval, the total time that the agent spent working on those activities. An agent is considered to be working on an activity while it is in focus in their inbox, whether or not they are physically typing or clicking. This may include time the agent spent working on the activity during previous intervals.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'HANDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total amount of time that an agent spent working on CallTrack activities during the interval. An agent is considered to be working on an activity while it is in focus in their inbox, whether or not they are physically typing or clicking.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'WORK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For all CallTrack activities completed during the interval, the total time that elapsed between each activity being created and being completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities completed during the interval, which were completed before their due date & time was reached. An activity is typically completed by an agent but may be completed by the workflow. Due date & time may be assigned by an agent or by the workflow. Activities without a due date & time are not counted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_MET_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities completed during the interval, which were completed after their due date & time had been reached. An activity is typically completed by an agent but may be completed by the workflow. Due date & time may be assigned by an agent or by the workflow. Activities without a due date & time are not counted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_NOT_MET_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CallTrack activities completed during the interval, which had no due date & time. An activity is typically completed by an agent but may be completed by the workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_NO_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Date and Time in UTC that this record was written to the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'DB_DATETIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For all CallTrack activities completed during the interval, the total time that elapsed between each activity being created and being completed as per the business calendar.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALLTRACK_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_DURATION_BIZCAL'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_FCT_CALLTRACK_ACTIVITY_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
