SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_SKILLGROUP_INTERVAL] (
		[SUMMARIZED_URN]                     [int] NOT NULL,
		[DATE_URN]                           [int] NOT NULL,
		[TIME_URN]                           [smallint] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[SKILLGROUP_URN]                     [int] NOT NULL,
		[CALLBACK_MESSAGES]                  [int] NULL,
		[CALLBACK_MESSAGES_TIME]             [int] NULL,
		[AVG_HANDLED_CALLS_TALK_TIME]        [int] NULL,
		[HOLD_TIME]                          [int] NULL,
		[HANDLED_CALLS_TALK_TIME]            [int] NULL,
		[INTERNAL_CALLS]                     [int] NULL,
		[INTERNAL_CALLS_TIME]                [int] NULL,
		[CALLS_HANDLED]                      [int] NULL,
		[SUPERV_ASSIST_CALLS]                [int] NULL,
		[AVG_HANDLED_CALLS_TIME]             [int] NULL,
		[SUPERV_ASSIST_CALLS_TIME]           [int] NULL,
		[HANDLED_CALLS_TIME]                 [int] NULL,
		[PERCENT_UTILIZATION]                [real] NULL,
		[AGENT_OUT_CALLS_TIME]               [int] NULL,
		[TALK_IN_TIME]                       [int] NULL,
		[LOGGED_ON_TIME]                     [int] NULL,
		[AGENT_OUT_CALLS]                    [int] NULL,
		[TALK_OUT_TIME]                      [int] NULL,
		[TALK_OTHER_TIME]                    [int] NULL,
		[AVAIL_TIME]                         [int] NULL,
		[NOT_READY_TIME]                     [int] NULL,
		[TRANSFER_IN_CALLS]                  [int] NULL,
		[TALK_TIME]                          [int] NULL,
		[TRANSFER_IN_CALLS_TIME]             [int] NULL,
		[WORK_READY_TIME]                    [int] NULL,
		[TRANSFER_OUT_CALLS]                 [int] NULL,
		[WORK_NOT_READY_TIME]                [int] NULL,
		[BUSY_OTHER_TIME]                    [int] NULL,
		[CALLS_ANSWERED]                     [int] NULL,
		[RESERVED_STATE_TIME]                [int] NULL,
		[ANSWER_WAIT_TIME]                   [int] NULL,
		[ABANDON_RING_CALLS]                 [int] NULL,
		[ABANDON_RING_TIME]                  [int] NULL,
		[ABANDON_HOLD_CALLS]                 [int] NULL,
		[AGENT_OUT_CALLS_TALK_TIME]          [int] NULL,
		[AGENT_OUT_CALLS_ON_HOLD]            [int] NULL,
		[AGENT_OUT_CALLS_ON_HOLD_TIME]       [int] NULL,
		[AGENT_TERMINATED_CALLS]             [int] NULL,
		[CONSULTATIVE_CALLS]                 [int] NULL,
		[CONSULTATIVE_CALLS_TIME]            [int] NULL,
		[CONFERENCED_IN_CALLS]               [int] NULL,
		[CONFERENCED_IN_CALLS_TIME]          [int] NULL,
		[CONFERENCED_OUT_CALLS]              [int] NULL,
		[CONFERENCED_OUT_CALLS_TIME]         [int] NULL,
		[INCOMING_CALLS_ON_HOLD_TIME]        [int] NULL,
		[INCOMING_CALLS_ON_HOLD]             [int] NULL,
		[INTERNAL_CALLS_ON_HOLD_TIME]        [int] NULL,
		[INTERNAL_CALLS_ON_HOLD]             [int] NULL,
		[INTERNAL_CALLS_RCVD_TIME]           [int] NULL,
		[INTERNAL_CALLS_RCVD]                [int] NULL,
		[REDIRECT_NO_ANS_CALLS]              [int] NULL,
		[REDIRECT_NO_ANS_CALLS_TIME]         [int] NULL,
		[SHORT_CALLS]                        [int] NULL,
		[ROUTER_CALLS_ABAND_Q]               [int] NULL,
		[ROUTER_QUEUE_CALLS]                 [int] NULL,
		[AUTO_OUT_CALLS]                     [int] NULL,
		[AUTO_OUT_CALLS_TIME]                [int] NULL,
		[AUTO_OUT_CALLS_TALK_TIME]           [int] NULL,
		[AUTO_OUT_CALLS_ON_HOLD]             [int] NULL,
		[AUTO_OUT_CALLS_ON_HOLD_TIME]        [int] NULL,
		[PREVIEW_CALLS]                      [int] NULL,
		[PREVIEW_CALLS_TIME]                 [int] NULL,
		[PREVIEW_CALLS_TALK_TIME]            [int] NULL,
		[PREVIEW_CALLS_ON_HOLD]              [int] NULL,
		[PREVIEW_CALLS_ON_HOLD_TIME]         [int] NULL,
		[RESERVE_CALLS]                      [int] NULL,
		[RESERVE_CALLS_TIME]                 [int] NULL,
		[RESERVE_CALLS_TALK_TIME]            [int] NULL,
		[RESERVE_CALLS_ON_HOLD]              [int] NULL,
		[RESERVE_CALLS_ON_HOLD_TIME]         [int] NULL,
		[TALK_AUTO_OUT_TIME]                 [int] NULL,
		[TALK_PREVIEW_TIME]                  [int] NULL,
		[TALK_RESERVE_TIME]                  [int] NULL,
		[BARGE_IN_CALLS]                     [int] NULL,
		[INTERCEPT_CALLS]                    [int] NULL,
		[MONITOR_CALLS]                      [int] NULL,
		[WHISPER_CALLS]                      [int] NULL,
		[EMERGENCY_ASSISTS]                  [int] NULL,
		[CALLS_OFFERED]                      [int] NULL,
		[CALLS_QUEUED]                       [int] NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[RECOVERY_KEY]                       [float] NULL,
		[DB_DATETIME]                        [datetime] NULL,
		[ABANDON_HOLD_CALLS_OUT]             [int] NULL,
		[NET_CONSULTATIVE_CALLS]             [int] NULL,
		[NET_CONSULTATIVE_CALLS_TIME]        [int] NULL,
		[NET_CONFERENCED_OUT_CALLS]          [int] NULL,
		[NET_CONFERENCED_OUT_CALLS_TIME]     [int] NULL,
		[NET_TRANSFER_OUT_CALLS]             [int] NULL,
		[ROUTER_CALLS_OFFERED]               [int] NULL,
		[ROUTER_CALLS_ABANDON_TO_AGENT]      [int] NULL,
		[ROUTER_CALLS_DEQUEUED]              [int] NULL,
		[ROUTER_ERROR]                       [int] NULL,
		[SERVICE_LEVEL]                      [float] NULL,
		[SERVICE_LEVEL_CALLS]                [int] NULL,
		[SERVICE_LEVEL_CALLS_ABANDON]        [int] NULL,
		[SERVICE_LEVEL_CALLS_DEQUEUED]       [int] NULL,
		[SERVICE_LEVEL_ERROR]                [int] NULL,
		[SERVICE_LEVEL_RONA]                 [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED]        [int] NULL,
		[DATE_TIME]                          [datetime] NOT NULL,
		[BUCKET_INTERVAL_URN]                [int] NULL,
		[CAMPAIGN_URN]                       [int] NULL,
		[CONSULT_OUT_CALLS]                  [int] NULL,
		[CONSULT_OUT_CALLS_TIME]             [int] NULL,
		[INTERRUPTED_TIME]                   [int] NULL,
		[ROUTER_DELAY_Q_ABAND_TIME]          [int] NULL,
		[ROUTER_MAX_CALLS_QUEUED]            [int] NULL,
		[ROUTER_MAX_CALL_WAIT_TIME]          [int] NULL,
		[ROUTER_CALLS_ABAND_DEQUEUED]        [int] NULL,
		[ROUTER_ABAND_INTERVAL_1]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_2]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_3]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_4]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_5]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_6]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_7]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_8]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_9]            [int] NULL,
		[ROUTER_ABAND_INTERVAL_10]           [int] NULL,
		[ROUTER_ANS_INTERVAL_1]              [int] NULL,
		[ROUTER_ANS_INTERVAL_2]              [int] NULL,
		[ROUTER_ANS_INTERVAL_3]              [int] NULL,
		[ROUTER_ANS_INTERVAL_4]              [int] NULL,
		[ROUTER_ANS_INTERVAL_5]              [int] NULL,
		[ROUTER_ANS_INTERVAL_6]              [int] NULL,
		[ROUTER_ANS_INTERVAL_7]              [int] NULL,
		[ROUTER_ANS_INTERVAL_8]              [int] NULL,
		[ROUTER_ANS_INTERVAL_9]              [int] NULL,
		[ROUTER_ANS_INTERVAL_10]             [int] NULL,
		[REPORTING_HALF_HOUR]                [int] NULL,
		[REPORTING_INTERVAL]                 [int] NULL,
		[TIME_ZONE]                          [int] NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[PRECISION_QUEUE_URN]                [int] NOT NULL,
		[MEDIA_CLASS_URN]                    [int] NOT NULL,
		[MEDIA_ROUTING_DOMAIN_URN]           [int] NOT NULL
) ON [SUMICMGROUP]
GO
ALTER TABLE [dbo].[TB_SUM_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_SKILLGROUP_INTERVAL_PRECISION_QUEUE_URN]
	DEFAULT ((-1)) FOR [PRECISION_QUEUE_URN]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_SKILLGROUP_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_SKILLGROUP_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_SKILLGROUP_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_SKILLGROUP_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_SKILLGROUP_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_SKILLGROUP_INTERVAL_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_SKILLGROUP_INTERVAL_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_SKILLGROUP_INTERVAL] ([SKILLGROUP_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_SKILLGROUP_INTERVAL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics of all the skillgroups. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_SKILLGROUP_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_SKILLGROUP_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Skill_Group_Half_Hour or t_Skill_Group_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of callback messages processed by the skillgroup during the reporting interval. The data in this column maps to CallbackMessagesToHalf or CallbackMessages column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLBACK_MESSAGES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the skillgroup spent processing all the callback messages during the reporting interval. The data in this column maps to CallbackMessagesTimeToHalf or CallbackMessagesTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLBACK_MESSAGES_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average talk time, in seconds, for all the inbound calls associated with the skillgroup that were handled during the reporting interval. The data in this column maps to AvgHandledCallsTalkTimeToHalf or AvgHandledCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AVG_HANDLED_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, where all calls to agents associated with the skillgroup were on hold during the reporting interval. The data in this column maps to HoldTimeToHalf or HoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, whn all agents associated with the skillgroup spent talking during the reporting interval. The data in this column maps to HandledCallsTalkTimeToHalf or HandledCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'HANDLED_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of internal calls initiated by the agents associated with the skillgroup during the reporting interval. The data in this column maps to InternalCallsToHalf or InternalCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that were spent on internal calls initiated by the agents associated with the skillgroup during the reporting interval. The data in this column maps to InternalCallsTimeToHalf or InternalCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of inbound calls that were answered and wrap-up completed by agents associated with the skillgroup during the reporting interval. The data in this column maps to CallsHandledToHalf or CallsHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup where the associated agents recieved supervisor assistance during the reporting interval. The data in this column maps to SupervAssistCallsToHalf or SupervAssistCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SUPERV_ASSIST_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average handle time, in seconds, for all the inbound calls associated with the skillgroup that were handled during the reporting interval. The data in this column maps to AvgHandledCallsTimeToHalf or AvgHandledCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AVG_HANDLED_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agents associated with the skillgroup spent on supervisor assisted calls during the reporting interval. The data in this column maps to SupervAssistCallsTimeToHalf or SupervAssistCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SUPERV_ASSIST_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent on calls that were handled during the reporting interval. The data in this column maps to HandledCallsTimeToHalf or HandledCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'HANDLED_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the percentage of Ready time that agents associated with this skillgroup spent talking or doing call work during the reporting interval. The data in this column maps to PercentUtilizationToHalf or PercentUtilization column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PERCENT_UTILIZATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the outbound calls that were handled by the skillgroup during the reporting interval. The data in this column maps to AgentOutCallsTimeToHalf or AgentOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on inbound calls during the reporting interval. The data in this column maps to TalkInTimeToHalf or TalkInTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when all the agents associated with the skillgroup were logged in during the reporting interval. The data in this column maps to LoggedOnTimeToHalf or LoggedOnTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'LOGGED_ON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound calls made by agents associated with the skillgroup during the reporting interval. The data in this column maps to AgentOutCallsToHalf or AgentOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on external outbound calls or consultive transfer calls during the reporting interval. The data in this column maps to TalkOutTimeToHalf or TalkOutTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on calls excluding inbound or outbound calls. These calls are for example agent-to-agent transfers or supervisor calls. The data in this column maps to TalkOtherTimeToHalf or TalkOtherTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup were in available state during the reporting interval. The data in this column maps to AvailTimeToHalf or AvailTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup were in not ready state during the reporting interval. The data in this column maps to NotReadyTimeToHalf or NotReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'NOT_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were transfered into the skillgroup during the reporting interval. The data in this column maps to TransferInCallsToHalf or TransferInCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFER_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on calls during the reporting interval. The data in this column maps to TalkTimeToHalf or TalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent handling transferd in calls during the reporting interval. The data in this column maps to TransferInCallsTimeToHalf or TransferInCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFER_IN_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup were in work ready state during the reporting interval. The data in this column maps to WorkReadyTimeToHalf or WorkReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'WORK_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls transfered out of the skillgroup during the reporting interval. The data in this column maps to TransferOutCallsToHalf or TransferOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFER_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup were in work not ready state during the reporting interval. The data in this column maps to WorkNotReadyTimeToHalf or WorkNotReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'WORK_NOT_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent in busy other state during the reporting interval. The data in this column maps to BusyOtherTimeToHalf or BusyOtherTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'BUSY_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered by the agents associated with the skillgroup during the reporting interval. The data in this column maps to CallsAnsweredToHalf or CallsAnswered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent in reserved state during the reporting interval. The data in this column maps to ReservedStateTimeToHalf or ReservedStateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVED_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for the answer wait times for all agents associated with the skillgroup for all the calls answered during the reporting interval. The data in this column maps to AnswerWaitTimeToHalf or AnswerWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were abandoned whilst ringing at the associated agent''s position during the reporting interval. The data in this column maps to AbandonRingCallsToHalf or AbandonRingCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls that were abandoned whilst ringing at the agent''s position during the reporting interval. The data in this column maps to AbandonRingTimeToHalf or AbandonRingTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were abandoned whilst on hold at the associated agent''s position during the reporting interval. The data in this column maps to AbandonHoldCallsToHalf or AbandonHoldCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_HOLD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all outbound calls handled by the agents associated skillgroup during the reporting interval. The data in this column maps to AgentOutCallsTalkTimeToHalf or AgentOutCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were put on hold by the agents associated with the skillgroup during the reporting interval. The data in this column maps to AgentOutCallsOnHoldToHalf or AgentOutCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all the calls that were put on hold by the agents associated with the skillgroup during the reporting interval. The data in this column maps to AgentOutCallsOnHoldTimeToHalf or AgentOutCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The data in this column maps to AgentTerminatedCallsToHalf or AgentTerminatedCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_TERMINATED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of consultative calls that were made by the agents associated with the skillgroup during the reporting interval. The data in this column maps to ConsultativeCallsToHalf or ConsultativeCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULTATIVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent handling consultative calls during the reporting interval. The data in this column maps to ConsultativeCallsTimeToHalf or ConsultativeCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULTATIVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that the agents associated with the skillgroup conferenced into during the reporting interval. The data in this column maps to ConferencedInCallsToHalf or ConferencedInCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent on incoming conference calls during the reporting interval. The data in this column maps to ConferencedInCallsTimeToHalf or ConferencedInCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_IN_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of conference calls that were initiated by the agents associated with the skillgroup during the reporting interval. The data in this column maps to ConferencedOutCallsToHalf or ConferencedOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent on the conference calls that were initiated by them during the reporting interval. The data in this column maps to ConferencedOutCallsTimeToHalf or ConferencedOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, that the agents associated with the skillgroup placed inbound calls on hold during the reporting interval. The data in this column maps to IncomingCallsOnHoldTimeToHalf or IncomingCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INCOMING_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of inbound calls that the agents associated with the skillgroup placed on hold at least once during the reporting interval. The data in this column maps to IncomingCallsOnHoldToHalf or IncomingCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INCOMING_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, that the agents associated with the skillgroup placed internal calls on hold during the reporting interval. The data in this column maps to InternalCallsOnHoldTimeToHalf or InternalCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of internal calls that the agents associated with the skillgroup placed on hold at least once during the reporting interval. The data in this column maps to InternalCallsOnHoldToHalf or InternalCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent on internal calls that they recieved during the reporting interval. The data in this column maps to InternalCallsRcvdTimeToHalf or InternalCallsRcvdTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_RCVD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming internal calls recieved by the agents associated with the skillgroup during the reporting interval. The data in this column maps to InternalCallsRcvdToHalf or InternalCallsRcvd column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_RCVD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls on the skillgroup that were redirected on no answer at the associated agent''s position during the reporting interval. The data in this column maps to RedirectNoAnsCallsToHalf or RedirectNoAnsCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'REDIRECT_NO_ANS_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total ring time, in seconds, for all calls to the skillgroup that were redirected on failure to answer at the associated agent''s position during the reporting interval. The data in this column maps to RedirectNoAnsCallsTimeToHalf or RedirectNoAnsCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'REDIRECT_NO_ANS_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of short calls to the skillgroup during the reporting interval. The data in this column maps to ShortCallsToHalf or ShortCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were queued to the skillgroup by the router and were abandoned whilst in the queue during the reporting interval. The data in this column maps to RouterCallsAbandQToHalf or RouterCallsAbandQcolumn in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were queued to the skillgroup by the router during the reporting interval. The data in this column maps to RouterQueueCallsToHalf or RouterQueueCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of predictive calls made by the agents associated with the skillgroup during the reporting interval. The data in this column maps to AutoOutCallsToHalf or AutoOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent on handling predictive calls during the reporting interval. The data in this column maps to AutoOutCallsTimeToHalf or AutoOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the predictive calls handled by the agents associated with the skillgroup during the reporting interval. The data in this column maps to AutoOutCallsTalkTimeToHalf or AutoOutCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of predictive calls handled by the agents associated with the skillgroup that were put on hold at least once during the reporting interval. The data in this column maps to AutoOutCallsOnHoldToHalf or AutoOutCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all predictive calls handled by the agents associated with the skillgroup that were put on hold during the reporting interval. The data in this column maps to AutoOutCallsOnHoldTimeToHalf or AutoOutCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound preview calls made by the agents associated with the skillgroup during the reporting interval. The data in this column maps to PreviewCallsToHalf or PreviewCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the outbound preview calls made by the agents associated with the skillgroup during the reporting interval. The data in this column maps to PreviewCallsTimeToHalf or PreviewCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the outbound preview calls made by the agents associated with the skillgroup during the reporting interval. The data in this column maps to PreviewCallsTalkTimeToHalf or PreviewCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound preview calls made by the agents associated with the skillgroup that were put on hold at least once during the reporting interval. The data in this column maps to PreviewCallsOnHoldToHalf or PreviewCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all outbound preview calls made by the agents associated with the skillgroup that were put on hold during the reporting interval. The data in this column maps to PreviewCallsOnHoldTimeToHalf or PreviewCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of reservation calls made by the agents associated with the skillgroup during the reporting interval. The data in this column maps to ReserveCallsToHalf or ReserveCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the reservation calls handled by the agents associated with the skillgroup during the reporting interval. The data in this column maps to ReserveCallsTimeToHalf or ReserveCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the reservation calls handled by the agents associated with the skillgroup during the reporting interval. The data in this column maps to ReserveCallsTalkTimeToHalf or ReserveCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of reservation calls on the skillgroup that were put on hold atleast once during the reporting interval. The data in this column maps to ReserveCallsOnHoldToHalf or ReserveCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, the reservation calls on this skillgroup that were placed on hold during the reporting interval. The data in this column maps to ReserveCallsOnHoldTimeToHalf or ReserveCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on predictive calls during the reporting interval. The data in this column maps to TalkAutoOutTimeToHalf or TalkAutoOutTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_AUTO_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on outbound preview calls during the reporting interval. The data in this column maps to TalkPreviewTimeToHalf or TalkPreviewTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_PREVIEW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent talking on reservation calls during the reporting interval. The data in this column maps to TalkReserveTimeToHalf or TalkReserveTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_RESERVE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were barged into either by a supervisor or another agent during the reporting interval. The data in this column maps to BargeInCallsToHalf or BargeInCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'BARGE_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls associated with the skillgroup that were intercepted by a suprevisor or an agent during the agent during the reporting interval. The data in this column maps to InterceptCallsToHalf or InterceptCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERCEPT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were monitored either by a supervisor or another agent during the reporting interval. The data in this column maps to MonitorCallsToHalf or MonitorCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'MONITOR_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were coached either by a supervisor or another agent during the reporting interval. The data in this column maps to WhisperCallsToHalf column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'WHISPER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of emergency assist requests either by supervisors or agents during the reporting interval. The data in this column maps to EmergencyAssistsToHalf or EmergencyAssists column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'EMERGENCY_ASSISTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of call recieved on the skillgroup during the reporting interval. The data in this column maps to CallsOfferedToHalf or CallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls queued to the skillgroup during the reporting interval. The data in this column maps to CallsQueuedToHalf or CallsQueued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_QUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound calls on the skillgroup that were put on hold atleast once during the reporting interval. The data in this column maps to AbandonHoldCallsOutToHalf or AbandonHoldCallsOut column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_HOLD_CALLS_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of network consultative calls made by the agents associated with the skillgroup during the reporting interval with at least one call on hold. The data in this column maps to NetConsultativeCallsToHalf column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONSULTATIVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all network consultative calls handled by the agents associated with the skillgroup during the reporting interval. The data in this column maps to NetConsultativeCallsTimeToHalf or NetConsultativeCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONSULTATIVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of network conference calls that were initiated by the agents associated with the skillgroup during the reporting interval. The data in this column maps to NetConferencedOutCallsToHalf or NetConferencedOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONFERENCED_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents associated with the skillgroup spent on network conference calls initiated by them during the reporting interval. The data in this column maps to NetConfOutCallsTimeToHalf or NetConfOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONFERENCED_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were network transfered out of the skillgroup during the reporting interval. The data in this column maps to NetTransferOutCallsToHalf or NetTransferOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_TRANSFER_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls routed or queued to the skillgroup during the reporting interval. The data in this column maps to RouterCallsOfferedToHalf or RouterCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that have been routed to the agents but abandoned before being answered by the agents. The data in this column maps to RouterCallsAbandToAgentToHalf or RouterCallsAbandToAgent column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABANDON_TO_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were de-queued to be routed to another skillgroup during the reporting interval. The data in this column maps to RouterCallsDequeuedToHalf or RouterCallsDequeued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were routed to the skillgroup but ended up in an error condition during the reporting interval. The data in this column maps to RouterErrorToHalf or RouterError column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level for the skillgroup during the reporting interval. The data in this column maps to ServiceLevelToHalf or ServiceLevel column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were answered within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelCallsToHalf or ServiceLevelCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on the skillgroup that were abandoned within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelCallsAbandToHalf or ServiceLevelCallsAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_ABANDON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of queued calls on the skillgroup that were de-queued within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelCallsDequeueToHalf or ServiceLevelCallsDequeue column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that ended up in an error state withing the service level threshold during the reporting interval. The data in this column maps to ServiceLevelErrorToHalf or ServiceLevelError column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were redirected on no answer within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelRONAToHalf or ServiceLevelRONA column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of service level calls offered on a skillgroup during the reporting interval. This include cals that were answered, abandoned, redirected on no answer within the service level plus the calls that were incomplete after passing the service level threshold. The data in this column maps to ServiceLevelCallsOfferedToHalf or ServiceLevelCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_BUCKET_INTERVAL corresponding to an item of type IT_BUCKET_INTERVAL. This corresponds to the bucket interval associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_BUCKET_INTERVAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_CAMPAIGN corresponding to an item of type IT_CAMPAIGN. This corresponds to the campaign associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CAMPAIGN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of external consult calls the agents in the skillgroup completed during the reporting interval. This maps to ConsultOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULT_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents in the skillgroup spent on external consult calls during the reporting interval. This maps to ConsultOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULT_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to InterruptedTimeToHalf or InterruptedTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERRUPTED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that all calls with the skillgroup spent waiting in the queue and were abandoned before being routed to agents. This maps to RouterDelayQAbandTime in the source table', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_DELAY_Q_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum number of calls that were queued for the skillgroup during the reporting interval. This maps to RouterMaxCallsQueued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_MAX_CALLS_QUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time, in seconds, a call had to wait before being answered, abandoned or otherwise ended during the reporting interval. This maps to RouterMaxCallWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_MAX_CALL_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned and de-queued from the skillgroup during the reporting interval. This maps to RouterCallsAbandDequeued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval5 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval6 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval7 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval8 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval9 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAbandInterval10 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ABAND_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval5 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval6 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval7 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval8 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval9 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to RouterAnsInterval10 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_ANS_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PRECISION_QUEUE corresponding to an item of type IT_PRECISION_QUEUE. This corresponds to the precision queue associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_CLASS. This corresponds to the media class associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_CLASS', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN. This corresponds to the media routing domain associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SKILLGROUP_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_SKILLGROUP_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
