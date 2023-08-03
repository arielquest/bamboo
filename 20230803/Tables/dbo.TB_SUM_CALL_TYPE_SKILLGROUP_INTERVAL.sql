SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] (
		[PARTITION_URN]                   [int] NOT NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[PARTITION_GLOBAL_URN]            [bigint] NOT NULL,
		[DATE_TIME]                       [datetime] NOT NULL,
		[TIME_ZONE]                       [int] NOT NULL,
		[DATE_URN]                        [int] NOT NULL,
		[TIME_URN]                        [smallint] NOT NULL,
		[DATE_UTC_URN]                    [int] NOT NULL,
		[TIME_UTC_URN]                    [smallint] NOT NULL,
		[BUCKET_INTERVAL_URN]             [int] NOT NULL,
		[CALL_TYPE_URN]                   [int] NOT NULL,
		[SKILLGROUP_URN]                  [int] NOT NULL,
		[PERIPHERAL_URN]                  [int] NOT NULL,
		[MEDIA_ROUTING_DOMAIN_URN]        [int] NOT NULL,
		[ANSWER_WAIT_TIME]                [int] NULL,
		[AVG_ROUTER_DELAY_Q]              [int] NULL,
		[CALL_DELAY_ABAND_TIME]           [int] NULL,
		[CALLS_ANSWERED]                  [int] NULL,
		[CALLS_HANDLED]                   [int] NULL,
		[CALLS_REPORT_AGAINST_OTHER]      [int] NULL,
		[CALLS_Q_HANDLED]                 [int] NULL,
		[CALLS_RONA]                      [int] NULL,
		[CALLS_REQUERIED]                 [int] NULL,
		[CALLS_ROUTED_NON_AGENT]          [int] NULL,
		[CALLS_HANDLED_NOT_ROUTED]        [int] NULL,
		[CALLS_ON_HOLD]                   [int] NULL,
		[DELAY_AGENT_ABAND_TIME]          [int] NULL,
		[DELAY_Q_ABAND_TIME]              [int] NULL,
		[HANDLED_TIME]                    [int] NULL,
		[TALK_TIME]                       [int] NULL,
		[HOLD_TIME]                       [int] NULL,
		[INCOMPLETE_CALLS]                [int] NULL,
		[CALLS_OFFERED_ROUTED]            [int] NULL,
		[CALLS_OFFERED_NOT_ROUTED]        [int] NULL,
		[ROUTER_CALLS_ABAND_Q]            [int] NULL,
		[ROUTER_CALLS_ABAND_TO_AGENT]     [int] NULL,
		[ROUTER_QUEUE_WAIT_TIME]          [int] NULL,
		[ROUTER_QUEUE_CALLS]              [int] NULL,
		[ROUTER_CALLS_DEQUEUED]           [int] NULL,
		[ROUTER_CALLS_ABAND_DEQUEUED]     [int] NULL,
		[SHORT_CALLS]                     [int] NULL,
		[AGENT_ERROR_COUNT]               [int] NULL,
		[ERROR_COUNT]                     [int] NULL,
		[SERVICE_LEVEL_ABAND]             [int] NULL,
		[SERVICE_LEVEL_CALLS]             [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED]     [int] NULL,
		[SERVICE_LEVEL]                   [int] NULL,
		[SERVICE_LEVEL_ERROR]             [int] NULL,
		[SERVICE_LEVEL_RONA]              [int] NULL,
		[SERVICE_LEVEL_TYPE]              [int] NULL,
		[SERVICE_LEVEL_CALLS_DEQUEUE]     [int] NULL,
		[MAX_HOLD_TIME]                   [int] NULL,
		[MAX_CALL_WAIT_TIME]              [int] NULL,
		[MAX_CALLS_QUEUED]                [int] NULL,
		[OVERFLOW_OUT]                    [int] NULL,
		[RESERVATION_CALLS]               [int] NULL,
		[ABAND_INTERVAL_1]                [int] NULL,
		[ABAND_INTERVAL_2]                [int] NULL,
		[ABAND_INTERVAL_3]                [int] NULL,
		[ABAND_INTERVAL_4]                [int] NULL,
		[ABAND_INTERVAL_5]                [int] NULL,
		[ABAND_INTERVAL_6]                [int] NULL,
		[ABAND_INTERVAL_7]                [int] NULL,
		[ABAND_INTERVAL_8]                [int] NULL,
		[ABAND_INTERVAL_9]                [int] NULL,
		[ABAND_INTERVAL_10]               [int] NULL,
		[ANS_INTERVAL_1]                  [int] NULL,
		[ANS_INTERVAL_2]                  [int] NULL,
		[ANS_INTERVAL_3]                  [int] NULL,
		[ANS_INTERVAL_4]                  [int] NULL,
		[ANS_INTERVAL_5]                  [int] NULL,
		[ANS_INTERVAL_6]                  [int] NULL,
		[ANS_INTERVAL_7]                  [int] NULL,
		[ANS_INTERVAL_8]                  [int] NULL,
		[ANS_INTERVAL_9]                  [int] NULL,
		[ANS_INTERVAL_10]                 [int] NULL,
		[REPORTING_HALF_HOUR]             [int] NULL,
		[REPORTING_INTERVAL]              [int] NULL,
		[RECOVERY_KEY]                    [float] NULL,
		[DB_DATETIME]                     [datetime] NULL,
		[CLUSTER_RESOURCE_URN]            [int] NOT NULL,
		[PRECISION_QUEUE_URN]             [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_1]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_2]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_3]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_4]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_5]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_6]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_7]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_8]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_9]       [int] NOT NULL,
		[PRECISION_ATTRIBUTE_URN_10]      [int] NOT NULL
) ON [SUMICMGROUP]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_QUEUE_URN]
	DEFAULT ((-1)) FOR [PRECISION_QUEUE_URN]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_1]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_1]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_2]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_2]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_3]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_3]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_4]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_4]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_5]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_5]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_6]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_6]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_7]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_7]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_8]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_8]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_9]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_9]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	ADD
	CONSTRAINT [DF_TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PRECISION_ATTRIBUTE_URN_10]
	DEFAULT ((-1)) FOR [PRECISION_ATTRIBUTE_URN_10]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_CALL_TYPE_URN]
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] ([CALL_TYPE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_CALL_TYPE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] ([SKILLGROUP_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PERIPHERAL_URN]
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] ([PERIPHERAL_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics for call type and skillgroup pairs. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CALL_TYPE_SKILLGROUP_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Call_Type_SG_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_BUCKET_INTERVAL corresponding to an item of type IT_BUCKET_INTERVAL. This corresponds to the bucket interval associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_BUCKET_INTERVAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_CALL_TYPE corresponding to an item of type IT_CALL_TYPE. This corresponds to the call type associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the skillgroup in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN corresponding to an item of type IT_MEDIA_ROUTING_DOMAIN. This corresponds to the media routing domain associated with the skillgroup in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total answer wait time, in seconds, for all calls that were answere for the call type and skillgroup pair in the reporting interval. This maps to AnswerWaitTime in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay in queue, in seconds, for all calls that were removed from the router queue during the reporting interval. This maps to AvgRouterDelayQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'AVG_ROUTER_DELAY_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is total time, in seconds, spent by all call for the call type and skillgroup pair before being abandoned in the reporting interval. This maps to CallDelayAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALL_DELAY_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls to the call type and skillgroup pair that were answered by agents in the reporting interval. This maps to CallsAnswered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls to the call type and skillgroup pair that were handled during the reporting interval. This maps to CallsHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were routed to the call type and skillgroup pair but were reported against another skillgroup during the reporting interval. This maps to CallsReportedAgainstOther column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_REPORT_AGAINST_OTHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls to the call type and skillgroup pair that were handled and were queued at any time during the reporting interval. This maps to CallsQHandled column in teh source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_Q_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that where redirected on no answer during the reporting interval. This maps to CallsRONA column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of router requery events for the call type and skillgroup pair during the reporting interval. This maps to CallsRequeried column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_REQUERIED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were routed without translation route in the reporting interval. This maps to CallsRoutedNonAgent column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_ROUTED_NON_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were handled by the skillgroup but the skillgroup was not the one that was originally routed to. This maps to CallsHandledNotRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_HANDLED_NOT_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were put on hold at least once during the reporting interval. This maps to CallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, spent by all calls that were abandoned at agent''s position before being answered in the reporting interval. This maps to DelayAgentAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DELAY_AGENT_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, spent by all calls that were abandoned while in the queue. This maps to DelayQAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DELAY_Q_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all calls during the reporting interval. This maps to HandledTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'HANDLED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all calls that were handled during the reporting interval. This maps to TalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all calls during the reporting interval. This maps to HoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were routed to an agent but failed to arrive during the reporting interval. This maps to IncompleteCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'INCOMPLETE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls associated with the skillgroup that were routed during the reporting interval. This maps to CallsOfferedRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_OFFERED_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were offered to the skillgroup but not routed by the router during the reporting interval. This maps to CallsOfferedNotRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_OFFERED_NOT_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned while in the queue during the reporting interval. This maps to RouterCallsAbandQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned at the agent''s position before being answered during the reporting interval. This maps to RouterCallsAbandToAgent column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_TO_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that call calls spent in the router queue during the reporting interval. This maps to RouterQueueWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of tasks of the call type associated with the skillgroup assigned from the queue to be routed in the reporting interval. This maps to RouterQueueCalls in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were removed from the queue during the reporting interval. This maps to RouterCallsDequeued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned and de-queued during the reporting interval. This maps to RouterCallsAbandDequeued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were too short to be considered abandoned during the reporting interval. This maps to ShortCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that encountered an error at the agent''s position during the reporting interval. This maps to AgentErrorCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'AGENT_ERROR_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that encountered an error during the reporting interval. This maps to ErrorCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ERROR_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ABAND'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that had service level events during the reporting interval. The data in this column maps to ServiceLevelCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level for the call type and skillgroup pair during the reporting interval. The data in this column maps to ServiceLevel column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that ended in an error state within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelError column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were redirected on no answer within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelRONA column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level type used to calculate the service level. This maps to the ServiceLevelType column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of queued calls that were de-queued within the service level threshold during the reporting interval. This maps to ServiceLevelCallsDequeue column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_DEQUEUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximumn hold time, in seconds, for all calls in the reporting interval. This maps to the MaxHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time, in seconds, a call had to wait before it was dispositioned. This maps to the MaxCallWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_CALL_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum number of calls in queue during the reporting interval. This maps to MaxCallsQueued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_CALLS_QUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were overflowed to another call type during the reporting interval. This maps to OverflowOut column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'OVERFLOW_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the Dialer reserved an agent for an agent campaign during the reporting interval. This maps to ReservationCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'RESERVATION_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PRECISION_QUEUE corresponding to an item of type IT_PRECISION_QUEUE. This corresponds to the precision queue associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL', 'COLUMN', N'PRECISION_QUEUE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_SKILLGROUP_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
