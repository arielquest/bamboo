SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] (
		[SUMMARIZED_URN]                     [int] NOT NULL,
		[DATE_URN]                           [int] NOT NULL,
		[TIME_URN]                           [smallint] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[AGENT_URN]                          [int] NOT NULL,
		[SKILLGROUP_URN]                     [int] NOT NULL,
		[AGENT_TEAM_URN]                     [int] NOT NULL,
		[PERIPHERAL_URN]                     [int] NOT NULL,
		[ABANDON_RING_CALLS]                 [int] NULL,
		[ABANDON_RING_TIME]                  [int] NULL,
		[ABANDON_HOLD_CALLS]                 [int] NULL,
		[AGENT_OUT_CALLS_TIME]               [int] NULL,
		[AGENT_OUT_CALLS_TALK_TIME]          [int] NULL,
		[AGENT_OUT_CALLS]                    [int] NULL,
		[AGENT_OUT_CALLS_ON_HOLD]            [int] NULL,
		[AGENT_OUT_CALLS_ON_HOLD_TIME]       [int] NULL,
		[AGENT_TERMINATED_CALLS]             [int] NULL,
		[ANSWER_WAIT_TIME]                   [int] NULL,
		[AVAIL_TIME]                         [int] NULL,
		[BUSY_OTHER_TIME]                    [int] NULL,
		[CALLBACK_MESSAGES_TIME]             [int] NULL,
		[CALLBACK_MESSAGES]                  [int] NULL,
		[CALLS_ANSWERED]                     [int] NULL,
		[CALLS_HANDLED]                      [int] NULL,
		[CONSULTATIVE_CALLS]                 [int] NULL,
		[CONSULTATIVE_CALLS_TIME]            [int] NULL,
		[CONFERENCED_IN_CALLS]               [int] NULL,
		[CONFERENCED_IN_CALLS_TIME]          [int] NULL,
		[CONFERENCED_OUT_CALLS]              [int] NULL,
		[CONFERENCED_OUT_CALLS_TIME]         [int] NULL,
		[HANDLED_CALLS_TALK_TIME]            [int] NULL,
		[HANDLED_CALLS_TIME]                 [int] NULL,
		[HOLD_TIME]                          [int] NULL,
		[INCOMING_CALLS_ON_HOLD_TIME]        [int] NULL,
		[INCOMING_CALLS_ON_HOLD]             [int] NULL,
		[INTERNAL_CALLS_ON_HOLD_TIME]        [int] NULL,
		[INTERNAL_CALLS_ON_HOLD]             [int] NULL,
		[INTERNAL_CALLS_RCVD_TIME]           [int] NULL,
		[INTERNAL_CALLS_RCVD]                [int] NULL,
		[INTERNAL_CALLS_TIME]                [int] NULL,
		[INTERNAL_CALLS]                     [int] NULL,
		[LOGGED_ON_TIME]                     [int] NULL,
		[NOT_READY_TIME]                     [int] NULL,
		[REDIRECT_NO_ANS_CALLS]              [int] NULL,
		[REDIRECT_NO_ANS_CALLS_TIME]         [int] NULL,
		[RESERVED_STATE_TIME]                [int] NULL,
		[SHORT_CALLS]                        [int] NULL,
		[SUPERV_ASSIST_CALLS_TIME]           [int] NULL,
		[SUPERV_ASSIST_CALLS]                [int] NULL,
		[TALK_IN_TIME]                       [int] NULL,
		[TALK_OTHER_TIME]                    [int] NULL,
		[TALK_OUT_TIME]                      [int] NULL,
		[TRANSFERRED_IN_CALLS_TIME]          [int] NULL,
		[TRANSFERRED_IN_CALLS]               [int] NULL,
		[TRANSFERRED_OUT_CALLS]              [int] NULL,
		[WORK_NOT_READY_TIME]                [int] NULL,
		[WORK_READY_TIME]                    [int] NULL,
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
		[PARTITION_ID]                       [int] NOT NULL,
		[RECOVERY_KEY]                       [float] NULL,
		[PERSON_URN]                         [int] NULL,
		[DB_DATETIME]                        [datetime] NULL,
		[ABANDON_HOLD_OUT_CALLS]             [int] NULL,
		[NET_CONFERENCED_OUT_CALLS_TIME]     [int] NULL,
		[NET_CONFERENCED_OUT_CALLS]          [int] NULL,
		[NET_CONSULTATIVE_CALLS_TIME]        [int] NULL,
		[NET_CONSULTATIVE_CALLS]             [int] NULL,
		[NET_TRANSFERED_OUT_CALLS]           [int] NULL,
		[DATE_TIME]                          [datetime] NOT NULL,
		[CONSULT_OUT_CALLS]                  [int] NULL,
		[CONSULT_OUT_CALLS_TIME]             [int] NULL,
		[INTERRUPTED_TIME]                   [int] NULL,
		[REPORTING_HALF_HOUR]                [int] NULL,
		[REPORTING_INTERVAL]                 [int] NULL,
		[TIME_ZONE]                          [int] NULL,
		[SUPERVISOR_AGENT_URN]               [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[PRECISION_QUEUE_URN]                [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_1]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_2]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_3]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_4]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_5]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_6]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_7]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_8]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_9]          [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_10]         [int] NOT NULL,
		[MEDIA_CLASS_URN]                    [int] NOT NULL,
		[MEDIA_ROUTING_DOMAIN_URN]           [int] NOT NULL
) ON [SUMICMGROUP]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_2]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_2]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_3]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_3]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_4]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_4]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_5]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_5]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_6]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_6]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_7]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_7]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_8]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_8]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_9]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_9]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_10]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_10]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_QUEUE_URN]
	DEFAULT ((-1)) FOR [PRECISION_QUEUE_URN]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_AGENT_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_1]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_1]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_AGENT_URN]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([AGENT_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([SKILLGROUP_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_AGENT_TEAM_URN]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([AGENT_TEAM_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_PERIPHERAL_URN]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([PERIPHERAL_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_SKILLGROUP_INTERVAL_PERSON_URN]
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] ([PERSON_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_AGENT_SKILLGROUP_INTERVAL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics of an agent''s activities on specific skillgroups. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_AGENT_SKILLGROUP_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_AGENT_SKILLGROUP_HH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Agent_Slill_Group_Half_Hour table or t_Agent_Skill_Group_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the agent associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT_TEAM corresponding to an item of type IT_AGENT_TEAM. This corresponds to the first agent team, which the agent belonged to at the time when the record was written into the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned whilst ringing at the agent''s position in the reporting interval. The data in this column maps to AbandonRingCallsToHalf or AbandonRingCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when the calls were ringing at the agent''s position for all the calls that were abandoned whilst in that state in the reporting interval. The data in this column maps to AbandonRingTimeToHalf or AbandonRingTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned whilst they were held at the agent''s position in the reporting interval. The data in this column maps to AbandonHoldCallsToHalf or AbandonHoldCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_HOLD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the outbound calls handled by the agent in association with the skillgroup in the reporting interval. This includes the work time, talk time and hold time for all the outbound calls. The data in this column maps to AgentOutCallsTimeToHalf or AgentOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the outbound calls handled by the agent in association with the skillgroup in the reporting interval. The data in this column maps to AgentOutCallsTalkTimeToHalf or AgentOutCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound calls made by the agent in association with the skillgroup in the reporting interval. The data in this column maps to AgentOutCallsToHalf or AgentOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound calls made by the agent in association with the skillgroup in the reporting interval that were put on hold at least once in the life of the call. The data in this column maps to AgentOutCallsOnHoldToHalf or AgentOutCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all the outbound calls made by the agent in association with the skillgroup that were put on hold in the reporting interval. The data in this column maps to AgentOutCallsOnHoldTimeToHalf or AgentOutCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_OUT_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The data in this column maps to AgentTerminatedCallsToHalf or AgentTerminatedCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_TERMINATED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total answer wait time, in seconds, for all calls that were answered by the agent in association with the skillgroup in the half hout interval. The data in this column maps to AnswerWaitTimeToHalf or AnswerWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent spent in the available state in association with the skillgroup in the reporting interval. The data in this column maps to AvailTimeToHalf or AvailTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent spent in busy other state in association with the skillgroup in the reporting interval. The data in this column maps to BusyOtherTimeToHalf or BusyOtherTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'BUSY_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent spent processing callback messages during the reporting interval. The data in this column maps to CallbackMessagesTimeToHalf or CallbackMessagesTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLBACK_MESSAGES_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total callback messages processed by the agent in the reporting interval. The data in this column maps to CallbackMessagesToHalf or CallbackMessages column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLBACK_MESSAGES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of call that were answered by the agent in association with the skillgroup in the reporting interval. The data in this column maps to CallsAnsweredToHalf or CallsAnswered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of inbound calls that were answered and completed with wrap-up by the agent in association with the skillgroup in the reporting interval. The data in this column maps to CallsHandledToHalf or CallsHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of consultative calls made by the agent in association with the skillgroup in the reporting interval. The data in this column maps to ConsultativeCallsToHalf or ConsultativeCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULTATIVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all the consultative calls made by the agent in association with the skillgroup in the reporting interval. The data in this column maps to ConsultativeCallsTimeToHalf ConsultativeCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULTATIVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that the agent was conferenced into during the reporting interval. The data in this column maps to ConferencedInCallsToHalf or ConferencedInCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent was involved in incoming conference calls during the half hout interval. The data in this column maps to ConferencedInCallsTimeToHalf or ConferencedInCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_IN_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of conference calls that were initiated by the agent during the reporting interval. The data in this column maps to ConferencedOutCallsToHalf or ConferencedOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent was involved in outbound conference calls during the half hour iterval. The data in this column maps to ConferencedOutCallsTimeToHalf or ConferencedOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCED_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, which includes the time spent from the call being answered by the agent to the time the agent completed after call work time for the call. The data in this column maps to HandledCallsTalkTimeToHalf or HandledCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'HANDLED_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent spent on calls that were handled during the reporting interval. The data in this column maps to HandledCallsTimeToHalf or HandledCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'HANDLED_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when all the calls to were agent were on hold in association with the skillgroup during the reporting interval. The data in this column maps to HoldTimeToHalf or HoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when all the inbound calls to the agent associated with the skillgroup were put on hold during the reporting interval. The data in this column maps to IncomingCallsOnHoldTimeToHalf or IncomingCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INCOMING_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of inbound calls to the agent in association with the skillgroup that were put on hold at least once during the reporting interval. The data in this column maps to IncomingCallsOnHoldToHalf or IncomingCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INCOMING_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, spent on hold for all the internal calls by the agent on the associated skillgroup. The data in this column maps to InternalCallsOnHoldTimeToHalf or InternalCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of internal calls by the agent in association with the skillgroup that were put on hold at least once during the reporting interval. The data in this column maps to InternalCallsOnHoldToHalf or InternalCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent spent on inbound internal calls in association with the skillgroup during the reporting interval. The data in this column maps to InternalCallsRcvdTimeToHalf or InternalCallsRcvdTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_RCVD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of inbound internal calls that were recieved by the agent in association with the skillgroup during the reporting interval. The data in this column maps to InternalCallsRcvdToHalf or InternalCallsRcvd column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_RCVD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent spent on all the internal calls in association with the skillgroup during the reporting interval. The data in this column maps to InternalCallsTimeToHalf or InternalCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of internal calls associated with the agent on the skillgroup during the reporting interval. The data in this column maps to InternalCallsToHalf or InternalCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERNAL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent was logged on in association with the skillgroup during the reporting interval. The data in this column maps to LoggedOnTimeToHalf or LoggedOnTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'LOGGED_ON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent spent in NOT READY state in association with the skillgroup during the reporting interval. The data in this column maps to NotReadyTimeToHalf or NotReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'NOT_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the skillgroup associated with the agent that rang at the agent''s terminal and were redirected on failing to answer. The data in this column maps to RedirectNoAnsCallsToHalf or RedirectNoAnsCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'REDIRECT_NO_ANS_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is total time, in seconds, during the reporting interval that calls were ringing at the agent''s position in association with the skillgroup before being redirected on failing to answer. The data in this column maps to RedirectNoAnsCallsTimeToHalf or RedirectNoAnsCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'REDIRECT_NO_ANS_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent spent in reserved state in association with the skillgroup during the reporting interval. The data in this column maps to ReservedStateTimeToHalf or ReservedStateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVED_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls answered by the agent in association with the skillgroup, during the reporting interval, where the duration of the calls were less than the short calls threshold. The data in this column maps to ShortCallsToHalf or ShortCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, an agent in association with the skillgroup spent on suprevisor assisted calls during the reporting interval. The data in this column maps to SupervAssistCallsTimeToHalf or SupervAssistCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SUPERV_ASSIST_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered by the agent in association with the skillgroup and recieved supervisor assistance. The data in this column maps to SupervAssistCallsToHalf or SupervAssistCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SUPERV_ASSIST_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent talking on all inbound calls excluding internal calls during the reporting interval. The data in this column maps to TalkInTimeToHalf or TalkInTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent talking on all other calls excluding inbound and outbound calls during the reporting interval. The data in this column maps to TalkOtherTimeToHalf or TalkOtherTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent talking on external outbound or consultative transfer calls during the reporting interval. The data in this column maps to TalkOutTimeToHalf or TalkOutTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent handling transfered in calls to the skillgroup during the reporting interval. The data in this column maps to TransferredInCallsTimeToHalf or TransferredInCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFERRED_IN_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were transfered in to the agent associated with the skillgroup during the reporting interval. The data in this column maps to TransferredInCallsToHalf or TransferredInCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFERRED_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were transfered out by the agent in association with the skillgroup during the reporting interval. The data in this column maps to TransferredOutCallsToHalf or TransferredOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFERRED_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent associated with the skillgroup spent in work not ready state during the reporting interval. The data in this column maps to WorkNotReadyTimeToHalf or WorkNotReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'WORK_NOT_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the agent associated with the skillgroup spent in work ready state during the reporting interval. The data in this column maps to WorkReadyTimeToHalf or WorkReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'WORK_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of predictive calls made by the agent in association with the skillgroup during the reporting interval. The data in this column maps to AutoOutCallsToHalf or AutoOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the predictive calls made by the agent in association to the skillgroup during the reporting interval. This includes work time, talk time and hold time. The data in this column maps to AutoOutCallsTimeToHalf or AutoOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the predictive calls made by the agent in association to the skillgroup during the reporting interval. The data in this column maps to AutoOutCallsTalkTimeToHalf or AutoOutCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of predicitve calls made by the agent in association to the skillgroup that were put on hold at least once during the reporting interval. The data in this column maps to AutoOutCallsOnHoldToHalf or AutoOutCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds that all the predictive calls made by the agent in association to the skillgroup that were put on hold during the reporting interval. The data in this column maps to AutoOutCallsOnHoldTimeToHalf or AutoOutCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound preview calls made by the agent in association with the skillgroup during the half hour inteval. The data in this column maps to PreviewCallsToHalf or PreviewCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the outbound preview calls handled by the agent in association with the skillgroup during the reporting interval. The data in this column maps to PreviewCallsTimeToHalf column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the outbound preview calls handled by the agent in association with the skillgroup during the reporting interval. The data in this column maps to PreviewCallsTalkTimeToHalf or PreviewCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound preview calls handled by the agent that were put on hold at least once during the reporting interval. The data in this column maps to PreviewCallsOnHoldToHalf or PreviewCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds for all the preview calls handled by the agent in association to the skillgroup that were put on hold during the reporting interval. The data in this column maps to PreviewCallsOnHoldTimeToHalf or PreviewCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agent reservation calls made by the agent in association with the skillgroup during the reporting interval. The data in this column maps to ReserveCallsToHalf or ReserveCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the reservation calls handled by the agent in association with the skillgroup during the reporting interval. The data in this column maps to ReserveCallsTimeToHalf or ReserveCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the reservation calls handled by the agent in association with the skillgroup during the reporting interval. The data in this column maps to ReserveCallsTalkTimeToHalf or ReserveCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of reservation calls handled by the agent that were put on hold at least once during the reporting interval. The data in this column maps to ReserveCallsOnHoldToHalf or ReserveCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds for all the reservation calls handled by the agent in association to the skillgroup that were put on hold during the reporting interval. The data in this column maps to ReserveCallsOnHoldTimeToHalf or ReserveCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVE_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent talking on all external outbound or consultative transfer calls during the reporting interval. The data in this column maps to TalkAutoOutTimeToHalf or TalkAutoOutTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_AUTO_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent talking on all preview calls during the reporting interval. The data in this column maps to TalkPreviewTimeToHalf or TalkPreviewTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_PREVIEW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent talking on all agent reservation calls during the reporting interval. The data in this column maps to TalkReserveTimeToHalf or TalkReserveTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_RESERVE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls associated with the agent in association to the skillgroup that were barged into by a supervisor or by agent during the reporting interval. The data in this column maps to BargeInCallsToHalf or BargeInCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'BARGE_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were intercepted by a suprevisour or the agent in association with the skillgroup during the reporting interval. The data in this column maps to InterceptCallsToHalf or InterceptCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERCEPT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were monitored either by a supervisor or by the agent in association with the skillgroup during the reporting interval. The data in this column maps to MonitorCallsToHalf or MonitorCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'MONITOR_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were coached either by a supervior or the agent in association with the skillgroup during the reporting interval. The data in this column maps to WhisperCallsToHalf or WhisperCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'WHISPER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of emergency requests made by the agent in association with the skillgroup during the reporting interval. The data in this column maps to EmergencyAssistsToHalf or EmergencyAssists column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'EMERGENCY_ASSISTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERSON corresponding to an item of type IT_PERSON. This corresponds to the person associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned whilst on hold during the reporting interval. The data in this column maps to AbandonHoldOutCallsToHalf or AbandonHoldOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'ABANDON_HOLD_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent on network conference calls initiated by the agent during the reporting interval. The data in this column maps to NetConfOutCallsTimeToHalf or NetConfOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONFERENCED_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of network conference calls that were initiated by the agent in association with the skillgroup during the reporting interval. The data in this column maps to NetConferencedOutCallsToHalf or NetConferencedOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONFERENCED_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agent associated with the skillgroup spent on handling network consultative call with at least on call on hold during the reporting interval. The data in this column maps to NetConsultativeCallsTimeToHalf or NetConsultativeCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONSULTATIVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of network consultative calls handled by the agent associated with the skillgroup with at least one call on hold during the reporting interval. The data in this column maps to NetConsultativeCallsToHalf or NetConsultativeCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_CONSULTATIVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of network transfered out calls by the agent associated with the skillgroup during the reporting interval. The data in this column maps to NetTransferredOutCallsToHalf or NetTransferredOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'NET_TRANSFERED_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agent initiated consult calls. This maps to the ConsultOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULT_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all agent initiated consult calls. This maps to the ConsultOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CONSULT_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the InterruptedTimeToHalf or InterruptedTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERRUPTED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the supervisor agent of the team where the agent in the record is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PRECISION_QUEUE corresponding to an item of type IT_PRECISION_QUEUE. This corresponds to the precision queue associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AttributeID10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_CLASS. This corresponds to the media class associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_CLASS', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN. This corresponds to the media routing domain associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_SKILLGROUP_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
