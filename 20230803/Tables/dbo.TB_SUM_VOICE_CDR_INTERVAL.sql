SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_VOICE_CDR_INTERVAL] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[START_DATE_TIME_UTC]            [datetime] NOT NULL,
		[START_DATE_UTC_URN]             [int] NOT NULL,
		[START_TIME_UTC_URN]             [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[CUSTOMER_URN]                   [int] NOT NULL,
		[DIALED_NUMBER_URN]              [int] NOT NULL,
		[SCRIPT_URN]                     [int] NOT NULL,
		[QUEUE_URN]                      [int] NOT NULL,
		[SERVICE_LEVEL_TYPE]             [int] NULL,
		[SL_THRESHOLD]                   [int] NOT NULL,
		[SOURCE_QUEUE_URN]               [int] NOT NULL,
		[ACTIVITY_QUEUE_URN]             [int] NOT NULL,
		[AGENT_URN]                      [int] NOT NULL,
		[SOURCE_AGENT_URN]               [int] NOT NULL,
		[PERSON_URN]                     [int] NOT NULL,
		[SOURCE_PERSON_URN]              [int] NOT NULL,
		[AGENT_TEAM_URN]                 [int] NOT NULL,
		[SOURCE_AGENT_TEAM_URN]          [int] NOT NULL,
		[ROUTING_PROFILE_URN]            [int] NOT NULL,
		[SOURCE_ROUTING_PROFILE_URN]     [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]     [int] NOT NULL,
		[CAMPAIGN_URN]                   [int] NOT NULL,
		[IVR_SCRIPT_URN]                 [int] NOT NULL,
		[IVR_EXIT_POINT_URN]             [int] NOT NULL,
		[CALL_ORIGIN_URN]                [int] NOT NULL,
		[NEW_CASES]                      [int] NOT NULL,
		[EXISTING_CASES]                 [int] NOT NULL,
		[CONTACTS]                       [int] NOT NULL,
		[OFFERED_IVR]                    [int] NOT NULL,
		[TERMINATED_IVR]                 [int] NOT NULL,
		[COMPLETED_IVR]                  [int] NOT NULL,
		[ABANDONED_IVR]                  [int] NOT NULL,
		[SUCCESSFUL_IVR]                 [int] NOT NULL,
		[OFFERED_QUEUE]                  [int] NOT NULL,
		[CALLBACK_ACCEPTED]              [int] NOT NULL,
		[OFFERED_CALLBACK]               [int] NOT NULL,
		[OFFERED_AGENT]                  [int] NOT NULL,
		[ABANDONED_QUEUE]                [int] NOT NULL,
		[ABANDONED_AGENT]                [int] NOT NULL,
		[RONA]                           [int] NOT NULL,
		[MISSED]                         [int] NOT NULL,
		[ANSWERED]                       [int] NOT NULL,
		[HANDLED]                        [int] NOT NULL,
		[HOLD]                           [int] NOT NULL,
		[ABANDONED_HOLD]                 [int] NOT NULL,
		[HOLD_COUNT]                     [int] NOT NULL,
		[SHORT_HANDLED]                  [int] NOT NULL,
		[AGENT_HUNG_UP]                  [int] NOT NULL,
		[SL_OFFERED]                     [int] NOT NULL,
		[SL_HANDLED]                     [int] NOT NULL,
		[SL_ABANDONED]                   [int] NOT NULL,
		[SL_HANDLED_INCL_RONA]           [int] NOT NULL,
		[SL_ABANDONED_INCL_RONA]         [int] NOT NULL,
		[SL_RONA]                        [int] NOT NULL,
		[SL_ERROR]                       [int] NOT NULL,
		[SHORT_ABANDONED]                [int] NOT NULL,
		[ERROR]                          [int] NOT NULL,
		[IVR_TIME]                       [int] NOT NULL,
		[QUEUE_TIME]                     [int] NOT NULL,
		[RING_TIME]                      [int] NOT NULL,
		[ANSWER_WAIT_TIME]               [int] NOT NULL,
		[ABANDON_TIME]                   [int] NOT NULL,
		[ANSWER_WAIT_TIME_INCL_RONA]     [int] NOT NULL,
		[ABANDON_TIME_INCL_RONA]         [int] NOT NULL,
		[TALK_TIME]                      [int] NOT NULL,
		[HOLD_TIME]                      [int] NOT NULL,
		[LONGEST_HOLD_TIME]              [int] NOT NULL,
		[WRAP_TIME]                      [int] NOT NULL,
		[CONSULT_TIME]                   [int] NOT NULL,
		[CONFERENCE_TIME]                [int] NOT NULL,
		[WORK_TIME]                      [int] NOT NULL,
		[COLD_XFER_OUT]                  [int] NOT NULL,
		[COLD_XFER_IN]                   [int] NOT NULL,
		[WARM_XFER_OUT]                  [int] NOT NULL,
		[WARM_XFER_IN]                   [int] NOT NULL,
		[CONSULT_OUT]                    [int] NOT NULL,
		[CALLS_CONSULT_OUT]              [int] NOT NULL,
		[CONSULT_IN]                     [int] NOT NULL,
		[CONFERENCE_OUT]                 [int] NOT NULL,
		[CALLS_CONFERENCE_OUT]           [int] NOT NULL,
		[CONFERENCE_IN]                  [int] NOT NULL,
		[TRANSFER_OUT_ALL]               [int] NOT NULL,
		[ANS_INTERVAL_1]                 [int] NOT NULL,
		[ANS_INTERVAL_2]                 [int] NOT NULL,
		[ANS_INTERVAL_3]                 [int] NOT NULL,
		[ANS_INTERVAL_4]                 [int] NOT NULL,
		[ANS_INTERVAL_5]                 [int] NOT NULL,
		[ANS_INTERVAL_6]                 [int] NOT NULL,
		[ANS_INTERVAL_7]                 [int] NOT NULL,
		[ANS_INTERVAL_8]                 [int] NOT NULL,
		[ANS_INTERVAL_9]                 [int] NOT NULL,
		[ANS_INTERVAL_10]                [int] NOT NULL,
		[ABN_INTERVAL_1]                 [int] NOT NULL,
		[ABN_INTERVAL_2]                 [int] NOT NULL,
		[ABN_INTERVAL_3]                 [int] NOT NULL,
		[ABN_INTERVAL_4]                 [int] NOT NULL,
		[ABN_INTERVAL_5]                 [int] NOT NULL,
		[ABN_INTERVAL_6]                 [int] NOT NULL,
		[ABN_INTERVAL_7]                 [int] NOT NULL,
		[ABN_INTERVAL_8]                 [int] NOT NULL,
		[ABN_INTERVAL_9]                 [int] NOT NULL,
		[ABN_INTERVAL_10]                [int] NOT NULL,
		[KNOWLEDGE_USED]                 [int] NOT NULL,
		[ARTICLES_USED]                  [int] NOT NULL,
		[COMPLETED]                      [int] NOT NULL,
		[COMPLETED_OUTSIDE_SLA]          [int] NOT NULL,
		[COMPLETED_WITHIN_SLA]           [int] NOT NULL,
		[ACTIVITY_DURATION]              [int] NOT NULL,
		[WORKFLOW_ASSIGNED]              [int] NOT NULL,
		[QUEUE_ASSIGNED]                 [int] NOT NULL,
		[USER_ASSIGNED]                  [int] NOT NULL,
		[CALL_LOGS_IN]                   [int] NOT NULL,
		[CALL_LOGS_OUT]                  [int] NOT NULL,
		[EXTERNAL_XFER_OUT]              [int] NOT NULL,
		[CONSULT_IN_TIME]                [int] NOT NULL,
		[ANSWERED_ABANDONED]             [int] NOT NULL,
		[OVERFLOW_IN]                    [int] NOT NULL,
		[OVERFLOW_OUT]                   [int] NOT NULL,
		[QUEUED]                         [int] NOT NULL,
		[CONSULT_IN_HANDLED]             [int] NOT NULL,
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
		[CUSTOM_MEASURE_0]               [int] NULL,
		[CUSTOM_MEASURE_1]               [int] NULL,
		[CUSTOM_MEASURE_2]               [int] NULL,
		[CUSTOM_MEASURE_3]               [int] NULL,
		[CUSTOM_MEASURE_4]               [int] NULL,
		[CUSTOM_MEASURE_5]               [int] NULL,
		[CUSTOM_MEASURE_6]               [int] NULL,
		[CUSTOM_MEASURE_7]               [int] NULL,
		[CUSTOM_MEASURE_8]               [int] NULL,
		[CUSTOM_MEASURE_9]               [int] NULL,
		CONSTRAINT [PK_SUM_VOICE_CDR_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [SUMAWSGROUP]
) ON [SUMAWSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_DIALED_NUMBER_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([DIALED_NUMBER_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_DIALED_NUMBER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_AGENT_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([AGENT_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_SOURCE_AGENT_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([SOURCE_AGENT_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_SOURCE_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_PERSON_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([PERSON_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_SOURCE_PERSON_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([SOURCE_PERSON_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_SOURCE_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_AGENT_TEAM_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([AGENT_TEAM_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_CDR_INTERVAL_SOURCE_AGENT_TEAM_URN]
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL] ([SOURCE_AGENT_TEAM_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'INDEX', N'IX_SUM_VOICE_CDR_INTERVAL_SOURCE_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics related to Voice CDR Interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the call was started in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The department to which the call log was assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The customer to which the call log was associated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The dialed number on which the call first arrived. (The ingress dialed number).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The initial script or contact flow for the call leg. (This may be useful for dimensioning IVR activity depending on voice platform configuration).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The queue the call leg arrived on. If the leg has no queue association (for example in the case of a direct agent transfer) then the queue for the previous leg persists.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level type used to calculate the service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A dimension representing the service level threshold for the call: the number of seconds within which the call must be answered to be counted within service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_THRESHOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For transfers, consults and conference, the queue for the preceding call leg. Applies only to the transfer/consult/conference leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The eGain base queue to which the Calltrack activity was assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ACTIVITY_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ACTIVITY_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The agent who received the current call leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For transfers, consults and conference, the agent who initiated the transfer/consult/conference. Applies only to the transfer/consult/conference leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent. For records only where PreviousContactID is populated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ROUTING_PROFILE.ITEM_URN. For AWS Connect, this is the name of the AWS Connect routing profile for the agent, the routing profile determines which queues the agent can take calls for.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ROUTING_PROFILE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ROUTING_PROFILE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ROUTING_PROFILE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ROUTING_PROFILE.ITEM_URN. This refers to transfers, consults and conference for the ROUTING_PROFILE for the preceding call leg. For AWS Connect, this is the name of the AWS Connect routing profile for the initiating agent, the routing profile determines which queues the agent can take calls for.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_ROUTING_PROFILE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ROUTING_PROFILE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SOURCE_ROUTING_PROFILE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of call log.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For calls which originated as outbound dialler calls, the campaign associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CAMPAIGN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The IVR application or call flow which processed the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The point in the IVR application where the customer exited.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'IVR_EXIT_POINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A string representing the path the caller navigated in IVR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CALL_ORIGIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call logs created during the interval which began a new case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'NEW_CASES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call logs created during the interval which continued an existing case. The agent can associate the call log to an existing case when creating the call log.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'EXISTING_CASES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls offered (applies to all CALL_ORIGIN/CALL_SOURCE types.).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONTACTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call legs offered to the IVR, pegged to the time the call entered IVR prompts.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'OFFERED_IVR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call legs which terminated whilst the caller was in IVR i.e. no queueing or agent activity occurred.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'TERMINATED_IVR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call legs offered to IVR, pegged to the time the call leg exited IVR. Counted whether or not queueing or agent activity occurred. Used as the denominator for an Average IVR Time calculation.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'COMPLETED_IVR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which terminated in IVR at an exit point which is classified as an abandon exit point. This depends on the customer setting the contact attribute eGainVRUSuccess.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABANDONED_IVR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which terminated in IVR at an exit point which is classified as an abandon exit point.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SUCCESSFUL_IVR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call legs offered to the queue, pegged to the time the call started queueing. This includes callbacks if rows where CALL_ORIGIN=2 are included.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'OFFERED_QUEUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the customer accepted the offer of a callback.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CALLBACK_ACCEPTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of callbacks initiated for the queue, pegged to the time the callback was placed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'OFFERED_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call legs offered to the agent, pegged to the time the call began ringing at the agent desktop.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'OFFERED_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Calls abandoned whilst the caller was in queue, pegged to the time the caller abandoned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABANDONED_QUEUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Calls which were abandoned whilst ringing at the agent desktop, pegged to the time the caller abandoned. This includes transfer, conference and consult in calls which were missed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABANDONED_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Calls which were pushed back to the queue because the agent did not accept the call within a pre-configured threshold. This includes transfer, conference and consult in calls which were missed. Pegged to the time the call was pushed back to the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which were offered to the agent but not answered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'MISSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Calls answered by the agent, pegged to the time the agent answered the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Calls answered by the agent, pegged to END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls placed on hold by the agent, pegged to END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Calls abandoned whilst the agent had the caller placed on hold, pegged to END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABANDONED_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times calls were placed on hold by the agent. This is incremented each time the agent places a call on hold. Pegged to END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'HOLD_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which were answered but then terminated within a short period of time defined by the short handled calls threshold. Pegged to END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SHORT_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent hung up on the customer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'AGENT_HUNG_UP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A count of CTR records where Queue attribute is not null, pegged to SL_DATE_TIME_UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls for the queue which were answered within the service level threshold, pegged to the time the call was answered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls for the queue which were abandoned within the service level threshold, pegged to the time the call was abandoned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_ABANDONED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls for the ingress dialed number which were answered within the service level threshold, pegged to the time the call was answered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_HANDLED_INCL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls for the ingress dialed number which were answered within the service level threshold, pegged to the time the call was abandoned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_ABANDONED_INCL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which rang at the agent desktop but were not answered within the ring time threshold, and which were redirected as a result within the service level threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which terminated as a result of an error condition within the service level threshold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SL_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which abandoned before the short abandoned calls threshold had expired. These can be excluded from service level calculations.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'SHORT_ABANDONED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls which terminated as a result of an error condition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time the call spent in IVR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'IVR_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time the call spent in queue. For AWS Connect this is the time from when the call started queueing until it was answered by an agent or the caller abandoned. Pegged to the time the call completed queueing.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'QUEUE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time the call spent ringing at the agent desktop before the agent accepted the call. Pegged to the time the call finished ringing. This is zero for AWS Connect.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time from the point the call started queueing up to the time the agent answered the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time from the point the call started queueing up to the time the caller abandoned the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABANDON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For the ingress dialed number, the time from the point the call first started queueing up to the time the caller anwered the call, pegged to the time the caller answered the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME_INCL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For the ingress dialed number, the time from the point the call first started queueing up to the time the caller abandoned the call, pegged to the time the caller abandoned the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABANDON_TIME_INCL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time the agent spent talking on the call. This includes time spent talking to the customer plus any time spent talking to a third party / other agents whilst the customer was on hold, for example during consult or warm transfer scenarios. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time the customer was placed on hold during the call. This includes the time the agent placed customers on hold by using the hold button, and also any time the customer was on hold whilst the agent was talking to a third party / other agents, for example during consult or warm transfer scenarios. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The longest duration for a single instance of hold time during the call. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'LONGEST_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time the agent spent in the wrapup state. This is the time between the voice connection for the agent being dropped and either a) the agent becoming available again or b) the agent going unavailable or offline. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'WRAP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time the agent spent talking to third parties / other agents with the customer on hold. This includes any time the customer was on hold prior to transfer or conference. Pegged to the time the agent completed wrapup for the call. This includes time waiting for the consulted agent to answer the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONSULT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time that the customer, the agent and at least one additional party were all connected on the same call. This excludes any time the customer was on hold. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONFERENCE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time spent working on the Calltrack activity. This is measured by eGain base as the amount of time the CallTrack activity had focus within the agent inbox, it is not derived from any voice platform metrics. Pegged to the time the Calltrack activity was completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of cold transfers performed by the agent. A cold transfer is a transfer where the agent transfers the call without speaking to the transfer recipient to hand off the call. This is counted whether or not the recipient agent answered. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'COLD_XFER_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of cold transfers received by the agent. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'COLD_XFER_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of warm transfers performed by the agent. A warm transfer is a transfer where the agent places the customer on hold to speak to the transfer recipient before finally transferring the call. For warm transfer to queue, this is counted whether or not the recipient agent answered. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'WARM_XFER_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of warm transfers received by the agent. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'WARM_XFER_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the agent put the customer on hold to talk to another agent, then returned to the customer. This excludes consults where the agent completed transfer or conference directly after the consult, to avoid double counting the consult activity when added to the warm transfer and conference metrics. An agent can place a consult multiple times within the same call leg. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONSULT_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where CONSULT_OUT was greater than zero. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CALLS_CONSULT_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number times the agent received a consult from another agent. This is only counted if the agent answers the call. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONSULT_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of conferences performed by the agent. This is the number of distinct occasions the agent, the customer and at least one additional party were connected on the same call. Conferences can be placed multiple times within the same call leg. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONFERENCE_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where CALLS_CONFERENCE_OUT was greater than zero. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CALLS_CONFERENCE_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of conferences received by the agent where the agent joined the conference. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONFERENCE_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'TRANSFER_OUT_ALL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANS_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls where the agent performed a consult, conference or transfer. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ABN_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Count 1 if the agent clicked on an article in a CallTrack activity. Facilitates metrics indicating the % of calls utilizing knowledge. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'KNOWLEDGE_USED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that an agent used an article in a CallTrack activity during the interval. Only populated in activity queue, agent or department reports. Pegged to the time the agent completed wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ARTICLES_USED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call logs completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'COMPLETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call logs completed during the interval, which had a due date & time but were not completed until after exceeding it. This is expressed as a percentage of the total number of call logs completed during the interval. Due date & time may be assigned by an agent or by the workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'COMPLETED_OUTSIDE_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of call logs completed during the interval, which had a due date & time and were completed before it was reached. This is expressed as a percentage of the total number of call logs completed during the interval. Due date & time may be assigned by an agent or by the workflow.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'COMPLETED_WITHIN_SLA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For all call logs completed during the interval, the total time that elapsed between each call log being created and being completed. Pegged to the time the call log was completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ACTIVITY_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a call log was assigned to a general workflow during the interval. This happens when the agent attempts to complete the call log and a general workflow is applicable to the call type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'WORKFLOW_ASSIGNED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a call log was assigned to a queue during the interval. This includes call logs routed by the general workflow and call logs which have been transferred from elsewhere. Pegged to the time the Calltrack log was assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'QUEUE_ASSIGNED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that a call log was assigned to an agent during the interval. This includes call logs routed by the general workflow, call logs which the agent has pulled or picked, and call logs which have been transferred from elsewhere.  Pegged to the time the Calltrack log was assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'USER_ASSIGNED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound Calltrack call logs created. Pegged to the time the Calltrack log was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CALL_LOGS_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound Calltrack call logs created. Pegged to the time the Calltrack log was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CALL_LOGS_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A count of CTR Records where NextContactID is not populated, but TransferCompletedTimestamp is not null', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'EXTERNAL_XFER_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time the agent spent talking on calls received as a conference/consult. This includes any time the customer was on hold prior to transfer or conference.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONSULT_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of abandoned calls plus the number of answered calls, pegged to talk start. This is a count of all calls queued plus any calls which an agent answered which were not assigned to a queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'ANSWERED_ABANDONED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'OVERFLOW_IN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'OVERFLOW_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'OVERFLOW_OUT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'OVERFLOW_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A count of CTR records counted as OFFERED_IVR which were queued.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'QUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A count of CTR records counted as agent hanldling calls received as a conference/consult.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CONSULT_IN_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based dimension custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A placeholder for fact-based measure custom attributes logged against the CallTrack activity in eGain base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_CDR_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_VOICE_CDR_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_VOICE_CDR_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
