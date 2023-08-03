SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CALL_TYPE_INTERVAL] (
		[SUMMARIZED_URN]                   [int] NOT NULL,
		[DATE_URN]                         [int] NOT NULL,
		[TIME_URN]                         [smallint] NOT NULL,
		[DATE_UTC_URN]                     [int] NOT NULL,
		[TIME_UTC_URN]                     [smallint] NOT NULL,
		[CALL_TYPE_URN]                    [int] NOT NULL,
		[ROUTER_QUEUE_WAIT_TIME]           [int] NULL,
		[ROUTER_QUEUE_CALLS]               [int] NULL,
		[AVG_ROUTER_DELAY_Q]               [int] NULL,
		[ROUTER_CALLS_ABAND_Q]             [int] NULL,
		[ROUTER_QUEUE_CALL_TYPE_LIMIT]     [int] NULL,
		[ROUTER_QUEUE_GLOBAL_LIMIT]        [int] NULL,
		[CALLS_ROUTED]                     [int] NULL,
		[ERROR_COUNT]                      [int] NULL,
		[ICR_DEFAULT_ROUTED]               [int] NULL,
		[NETWORK_DEFAULT_ROUTED]           [int] NULL,
		[RETURN_BUSY]                      [int] NULL,
		[RETURN_RING]                      [int] NULL,
		[NETWORK_ANNOUNCEMENT]             [int] NULL,
		[ANSWER_WAIT_TIME]                 [int] NULL,
		[CALLS_HANDLED]                    [int] NULL,
		[CALLS_OFFERED]                    [int] NULL,
		[HANDLE_TIME]                      [int] NULL,
		[SERVICE_LEVEL_ABANDONED]          [int] NULL,
		[SERVICE_LEVEL_CALLS]              [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED]      [int] NULL,
		[SERVICE_LEVEL]                    [float] NULL,
		[TALK_TIME]                        [int] NULL,
		[OVERFLOW_OUT]                     [int] NULL,
		[HOLD_TIME]                        [int] NULL,
		[INCOMPLETE_CALLS]                 [int] NULL,
		[PARTITION_ID]                     [int] NOT NULL,
		[RECOVERY_KEY]                     [float] NULL,
		[DB_DATETIME]                      [datetime] NULL,
		[CALLS_ANSWERED]                   [int] NULL,
		[CALLS_ROUTED_NON_AGENT]           [int] NULL,
		[CALLS_RONA]                       [int] NULL,
		[RETURN_RELEASE]                   [int] NULL,
		[CALLS_Q_HANDLED]                  [int] NULL,
		[VRU_UNHANDLED_CALLS]              [int] NULL,
		[VRU_HANDLED_CALLS]                [int] NULL,
		[VRU_ASSISTED_CALLS]               [int] NULL,
		[VRU_OPT_OUT_UNHANDLED_CALLS]      [int] NULL,
		[VRU_SCRIPTED_XFERRED_CALLS]       [int] NULL,
		[VRU_FORCED_XFERRED_CALLS]         [int] NULL,
		[VRU_OTHER_CALLS]                  [int] NULL,
		[ABAND_INTERVAL_1]                 [int] NULL,
		[ABAND_INTERVAL_2]                 [int] NULL,
		[ABAND_INTERVAL_3]                 [int] NULL,
		[ABAND_INTERVAL_4]                 [int] NULL,
		[ABAND_INTERVAL_5]                 [int] NULL,
		[ABAND_INTERVAL_6]                 [int] NULL,
		[ABAND_INTERVAL_7]                 [int] NULL,
		[ABAND_INTERVAL_8]                 [int] NULL,
		[ABAND_INTERVAL_9]                 [int] NULL,
		[ABAND_INTERVAL_10]                [int] NULL,
		[ANS_INTERVAL_1]                   [int] NULL,
		[ANS_INTERVAL_2]                   [int] NULL,
		[ANS_INTERVAL_3]                   [int] NULL,
		[ANS_INTERVAL_4]                   [int] NULL,
		[ANS_INTERVAL_5]                   [int] NULL,
		[ANS_INTERVAL_6]                   [int] NULL,
		[ANS_INTERVAL_7]                   [int] NULL,
		[ANS_INTERVAL_8]                   [int] NULL,
		[ANS_INTERVAL_9]                   [int] NULL,
		[ANS_INTERVAL_10]                  [int] NULL,
		[AGENT_ERROR_COUNT]                [int] NULL,
		[CALL_DELAY_ABAND_TIME]            [int] NULL,
		[CALLS_REQUERIED]                  [int] NULL,
		[CT_DELAY_ABAND_TIME]              [int] NULL,
		[CT_VRU_TIME]                      [int] NULL,
		[DELAY_AGENT_ABAND_TIME]           [int] NULL,
		[ROUTER_CALLS_ABAND_TO_AGENT]      [int] NULL,
		[SERVICE_LEVEL_ERROR]              [int] NULL,
		[SERVICE_LEVEL_RONA]               [int] NULL,
		[TOTAL_CALLS_ABAND]                [int] NULL,
		[VRU_TIME]                         [int] NULL,
		[SHORT_CALLS]                      [int] NULL,
		[DELAY_QUEUE_ABANDON_TIME]         [int] NULL,
		[DATE_TIME]                        [datetime] NOT NULL,
		[SERVICE_LEVEL_TYPE]               [int] NULL,
		[BUCKET_INTERVAL_URN]              [int] NULL,
		[CALLS_ON_HOLD]                    [int] NULL,
		[MAX_HOLD_TIME]                    [int] NULL,
		[MAX_CALLS_QUEUED]                 [int] NULL,
		[MAX_CALL_WAIT_TIME]               [int] NULL,
		[RESERVATION_CALLS]                [int] NULL,
		[REPORTING_HALF_HOUR]              [int] NULL,
		[REPORTING_INTERVAL]               [int] NULL,
		[TIME_ZONE]                        [int] NULL,
		[CLUSTER_RESOURCE_URN]             [int] NOT NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_INTERVAL_CALL_TYPE_URN]
	ON [dbo].[TB_SUM_CALL_TYPE_INTERVAL] ([CALL_TYPE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_INTERVAL_CALL_TYPE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_CALL_TYPE_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CALL_TYPE_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_CALL_TYPE_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'INDEX', N'IX_SUM_CALL_TYPE_INTERVAL_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics for all the call types. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CALL_TYPE_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CALL_TYPE_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Call_Type_Half_Hour or t_Call_Type_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_CALL_TYPE corresponding to an item of type IT_CALL_TYPE. This corresponds to the call type associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the calls of this type spent in queue during the reporting interval. The data in this column maps to RouterQueueWaitTimeToHalf or RouterQueueWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were assigned from the queue to be routed during the reporting interval. The data in this column maps to RouterQueueCallsToHalf or RouterQueueCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay in queue(in seconds) for calls removed from the queue during the reporting interval. The data in this column maps to AvgRouterDelayQToHalf or AvgRouterDelayQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'AVG_ROUTER_DELAY_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to this call type that were abandoned in the queue. The data in this column maps to RouterCallsAbandQToHalf or RouterCallsAbandQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of queue requests that failed for calls because the limit for the call type was reached during the reporting interval. The data in this column maps to RouterQueueCallTypeLimitToHalf or RouterQueueCallTypeLimit column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_CALL_TYPE_LIMIT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of queue requests that failed for calls because the global system limit was reached during the reporting interval. The data in this column maps to RouterQueueGlobalLimitToHalf or RouterQueueGlobalLimit column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ROUTER_QUEUE_GLOBAL_LIMIT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were routed during the reporting interval. The data in this column maps to CallsRoutedToHalf or CallsRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to this type that resulted in an error condition during the reporting interval. The data in this column maps to ErrorCountToHalf or ErrorCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ERROR_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were routed to the default label during the reporting interval. The data in this column maps to ICRDefaultRoutedToHalf or ICRDefaultRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ICR_DEFAULT_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were routed to the default network termination node during the reporting interval. The data in this column maps to NetworkDefaultRoutedToHalf or NetworkDefaultRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'NETWORK_DEFAULT_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were routed to the busy target during the reporting interval. The data in this column maps to ReturnBusyToHalf or ReturnBusy column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'RETURN_BUSY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were routed to the ring target during the reporting interval. The data in this column maps to ReturnRingToHalf or ReturnRing column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'RETURN_RING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were routed with an announcement node during the reporting interval. The data in this column maps to NetworkAnnouncementToHalf or NetworkAnnouncement column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'NETWORK_ANNOUNCEMENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total answer wait time, in seconds, for all calls of this type that were handled during the reporting interval. The data in this column maps to AnswerWaitTimeHalf or AnswerWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were handled during the reporting interval. The data in this column maps to CallsHandledHalf or CallsHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is total number of calls of this call type that were offered during tha reporting interval. The data in this column maps to CallsOfferedHalf or CallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all the calls of this call type that were handled during the reporting interval. The data in this column maps to HandleTimeHalf or HandleTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'HANDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were abandoned within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelAbandHalf or ServiceLevelAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ABANDONED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were answered within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelCallsHalf or ServiceLevelCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that had service level events during the reporting interval. The data in this column maps to ServiceLevelCallsOfferedHalf or ServiceLevelCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level for all the calls of this call type during the reporting interval. The data in this column maps to ServiceLevelHalf or ServiceLevel column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the calls of this call type that were handled during the reporting interval. The data in this column maps to TalkTimeHalf or TalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that overflowed to another call type during the reporting interval. The data in this column maps to OverflowOutHalf or OverflowOut column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'OVERFLOW_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all the calls of this call type during the reporting interval. The data in this column maps to HoldTimeToHalf or HoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were imcomplete because they were routed to an agent but failed to arrive. The data in this column maps to IncompleteCallsHalf or IncompleteCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'INCOMPLETE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were answered by the agent during the reporting interval. The data in this column maps to CallsAnsweredToHalf or CallsAnswered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that executed a Label node or a Divert Label node in their routing script in the reporting interval interval or were routed to a standard ACD without using a translation route in the reporting interval interval. The data in this column maps to CallsRoutedNonAgentToHalf or CallsRoutedNonAgent column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_ROUTED_NON_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were redirected on no answer during the reporting interval. The data in this column maps to CallsRONAToHalf or CallsRONA column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that executed a return release not in their routing script during the reporting interval. The data in this column maps to ReturnReleaseToHalf or ReturnRelease column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'RETURN_RELEASE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were handled after being queued during the reporting interval. The data in this column maps to CallsQHandledToHalf or CallsQHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_Q_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were offered to the VRU but not handled during the reporting interval. The data in this column maps to VruUnhandledCallsToHalf or VruUnhandledCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_UNHANDLED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were offered to the VRU and were handled during the reporting interval. The data in this column maps to VruHandledCallsToHalf or VruHandledCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_HANDLED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were handled by the VRU and marked as routed to an agent during the reporting interval. The data in this column maps to VruAssistedCallsToHalf or VruAssistedCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_ASSISTED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were unhandled by the VRU and marked as routed to an agent during the reporting interval. The data in this column maps to VruOptOutUnhandledCallsToHalf or VruOptOutUnhandledCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_OPT_OUT_UNHANDLED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of VRU calls of this call type that were marked as routed to an agent by normal script procedure during the reporting interval. The data in this column maps to VruScriptedXferredCallsToHalf or VruScriptedXferredCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_SCRIPTED_XFERRED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of VRU calls of this call type that were marked as routed to an agent as a result of caller difficulty during the reporting interval. The data in this column maps to VruForcedXferredCallsToHalf or VruForcedXferredCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_FORCED_XFERRED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were marked with any VRUProgress value other than the ToHalf during the reporting interval. The data in this column maps to VruOtherCallsToHalf or VruOtherCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 1 during the half hour inteval. The data in this column maps to AbandInterval1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 2 during the half hour inteval. The data in this column maps to AbandInterval2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 3 during the half hour inteval. The data in this column maps to AbandInterval3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 4 during the half hour inteval. The data in this column maps to AbandInterval4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 5 during the half hour inteval. The data in this column maps to AbandInterval5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 6 during the half hour inteval. The data in this column maps to AbandInterval6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 7 during the half hour inteval. The data in this column maps to AbandInterval7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 8 during the half hour inteval. The data in this column maps to AbandInterval8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 9 during the half hour inteval. The data in this column maps to AbandInterval9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned in interval 10 during the half hour inteval. The data in this column maps to AbandInterval10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 1 during the half hour inteval. The data in this column maps to AnsInterval1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 2 during the half hour inteval. The data in this column maps to AnsInterval2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 3 during the half hour inteval. The data in this column maps to AnsInterval3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 4 during the half hour inteval. The data in this column maps to AnsInterval4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 5 during the half hour inteval. The data in this column maps to AnsInterval5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 6 during the half hour inteval. The data in this column maps to AnsInterval6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 7 during the half hour inteval. The data in this column maps to AnsInterval7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 8 during the half hour inteval. The data in this column maps to AnsInterval8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 9 during the half hour inteval. The data in this column maps to AnsInterval9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered in interval 10 during the half hour inteval. The data in this column maps to AnsInterval10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that had errors whilst at the agent desktop. The data in this column maps to AgentErrorCountToHalf or AgentErrorCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'AGENT_ERROR_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for calls of this type that were abandoned during the reporting interval. Note: This time is not reset if the call type changed. The data in this column maps to CallDelayAbandTimeToHalf or CallDelayAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALL_DELAY_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of router requeries for this call type during the reporting interval. The data in this column maps to CallsRequeriedToHalf or CallsRequeried column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_REQUERIED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for calls of this type that were abandoned during the reporting interval. Note: This time is reset if the call type changed. The data in this column maps to CTDelayAbandTimeToHalf or CTDelayAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CT_DELAY_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls of this call type that spent in the VRU in the current call type. The data in this column maps to CTVRUTimeToHalf or CTVRUTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CT_VRU_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls of this call type that were abandoned at the agent''s desktop before being abandoned. Note: This time is not reset of the call type changes. The data in this column maps to DelayAgentAbandTimeToHalf or DelayAgentAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DELAY_AGENT_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls of this call type that were abandoned at the agent''s desktop before being abandoned. The data in this column maps to RouterCallsAbandToAgentToHalf or RouterCallsAbandToAgent column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_TO_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that ended in an error state within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelErrorToHalf or ServiceLevelError column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were redirected on no answer during the reporting interval. The data in this column maps to ServiceLevelRONAToHalf or ServiceLevelRONA column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this type that were abandoned whilst in the VRU, abandoned whilst queued to a skillgroup and abandoned at the agent''s desktop. The data in this column maps to TotalCallsAbandToHalf or TotalCallsAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TOTAL_CALLS_ABAND'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that all calls of this call type spent in the VRU during the reporting interval. The data in this column maps to VRUTimeToHalf or VRUTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'VRU_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls of this call type that were too short to be considered as abandoned. The data in this column maps to ShortCallsHalf or ShortCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that all calls of this call type spent in the queue before being abandoned during the reporting interval. The data in this column maps to DelayQAbandTimeHalf or DelayQAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DELAY_QUEUE_ABANDON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level type used to calculate the service level. This maps to the ServiceLevelType column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_BUCKET_INTERVAL corresponding to an item of type IT_BUCKET_INTERVAL. This corresponds to the bucket interval associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_BUCKET_INTERVAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls put on hold during the reporting interval. This maps to the CallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximumn hold time, in seconds, for all calls in the reporting interval. This maps to the MaxHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'MAX_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time, in seconds, a call had to wait before it was dispositioned. This maps to the MaxCallWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'MAX_CALL_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the Dialer reserved an agent for an agent campaign during the reporting interval. This maps to the ReservationCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'RESERVATION_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CALL_TYPE_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CALL_TYPE_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CALL_TYPE_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CALL_TYPE_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CALL_TYPE_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
