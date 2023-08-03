SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_SERVICE_INTERVAL] (
		[SUMMARIZED_URN]                  [int] NOT NULL,
		[DATE_URN]                        [int] NOT NULL,
		[TIME_URN]                        [smallint] NOT NULL,
		[DATE_UTC_URN]                    [int] NOT NULL,
		[TIME_UTC_URN]                    [smallint] NOT NULL,
		[SERVICE_URN]                     [int] NOT NULL,
		[CALLS_OUT]                       [int] NULL,
		[CALLS_TERMINATED_OTHER]          [int] NULL,
		[CALLS_OFFERED]                   [int] NULL,
		[PERIPH_SERVICE_LEVEL_OFFER]      [int] NULL,
		[CALLS_INCOMING]                  [int] NULL,
		[TRANSFER_IN_CALLS]               [int] NULL,
		[CALLS_HANDLED]                   [int] NULL,
		[TRANSFER_OUT_CALLS]              [int] NULL,
		[CALLS_ROUTED]                    [int] NULL,
		[CALLS_ABAND_Q]                   [int] NULL,
		[PERIPH_SERVICE_LEVEL]            [real] NULL,
		[PERIPH_SERVICE_LEVEL_CALLS]      [int] NULL,
		[SERVICE_LEVEL]                   [real] NULL,
		[SERVICE_LEVEL_CALLS]             [int] NULL,
		[SERVICE_LEVEL_ABAND]             [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED]     [int] NULL,
		[AVG_DELAY_Q_TIME]                [int] NULL,
		[DELAY_Q_TIME]                    [int] NULL,
		[CALLS_Q]                         [int] NULL,
		[AVG_DELAY_Q_ABAND_TIME]          [int] NULL,
		[DELAY_Q_ABAND_TIME]              [int] NULL,
		[AVG_SPEED_ANSWER_TIME]           [int] NULL,
		[ANSWER_WAIT_TIME]                [int] NULL,
		[AVG_TALK_TIME]                   [int] NULL,
		[TALK_TIME]                       [int] NULL,
		[AVG_HANDLE_TIME]                 [int] NULL,
		[HANDLE_TIME]                     [int] NULL,
		[SHORT_CALLS]                     [int] NULL,
		[CALLS_ANSWERED]                  [int] NULL,
		[LONGEST_CALL_ABAND_TIME]         [int] NULL,
		[LONGEST_CALL_DELAY_Q_TIME]       [int] NULL,
		[SHORT_CALLS_TIME]                [int] NULL,
		[FORCED_CLOSED_CALLS]             [int] NULL,
		[OVERFLOW_IN]                     [int] NULL,
		[OVERFLOW_OUT]                    [int] NULL,
		[AUTO_OUT_CALLS]                  [int] NULL,
		[AUTO_OUT_CALLS_TIME]             [int] NULL,
		[AUTO_OUT_CALLS_TALK_TIME]        [int] NULL,
		[AUTO_OUT_CALLS_ON_HOLD]          [int] NULL,
		[AUTO_OUT_CALLS_ON_HOLD_TIME]     [int] NULL,
		[PREVIEW_CALLS]                   [int] NULL,
		[PREVIEW_CALLS_TIME]              [int] NULL,
		[PREVIEW_CALLS_TALK_TIME]         [int] NULL,
		[PREVIEW_CALLS_ON_HOLD]           [int] NULL,
		[PREVIEW_CALLS_ON_HOLD_TIME]      [int] NULL,
		[RESERVE_CALLS]                   [int] NULL,
		[RESERVE_CALLS_TIME]              [int] NULL,
		[RESERVE_CALLS_TALK_TIME]         [int] NULL,
		[RESERVE_CALLS_ON_HOLD]           [int] NULL,
		[RESERVE_CALLS_ON_HOLD_TIME]      [int] NULL,
		[HOLD_TIME]                       [int] NULL,
		[BLIND_TRANSFERS_OUT]             [int] NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[RECOVERY_KEY]                    [float] NULL,
		[DB_DATETIME]                     [datetime] NULL,
		[REDIRECT_NO_ANS_CALLS]           [int] NULL,
		[DATE_TIME]                       [datetime] NOT NULL,
		[NUM_MISSING_TASKS]               [int] NULL,
		[SERVICE_LEVEL_TYPE]              [int] NULL,
		[REPORTING_HALF_HOUR]             [int] NULL,
		[REPORTING_INTERVAL]              [int] NULL,
		[TIME_ZONE]                       [int] NULL,
		[CLUSTER_RESOURCE_URN]            [int] NOT NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_SERVICE_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_SERVICE_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'INDEX', N'IX_SUM_SERVICE_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_SERVICE_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_SERVICE_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'INDEX', N'IX_SUM_SERVICE_INTERVAL_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_SERVICE_INTERVAL_SERVICE_URN]
	ON [dbo].[TB_SUM_SERVICE_INTERVAL] ([SERVICE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'INDEX', N'IX_SUM_SERVICE_INTERVAL_SERVICE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics of all the services. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_SERVICE_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_SERVICE_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Service_Half_Hour or t_Service_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SERVICE corresponding to an item of type IT_SERVICE. This corresponds to the service associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SERVICE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of outbound calls placed by the agents for the service during the reporting interval. The data in this column maps to CallsOutToHalf or CallsOut column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were handled but terminated without proper reason during the reporting interval. The data in this column maps to CallsTerminatedOtherToHalf or CallsTerminatedOther column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_TERMINATED_OTHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming calls plus internal calls offered for the service during the reporting interval. The data in this column maps to CallsOfferedToHalf or CallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls offered to the service that were taken into consideration for peripheral service level calculation during the reporting interval. The data in this column maps to PeriphServiceLevelOfferToHalf or PeriphServiceLevelOffer column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PERIPH_SERVICE_LEVEL_OFFER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming calls for the service during the reporting interval. The data in this column maps to CallsIncomingToHalf or CallsIncoming column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_INCOMING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were transfered into the service during the reporting interval. The data in this column maps to TransferInCallsToHalf column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TRANSFER_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were handled during the reporting interval. The data in this column maps to CallsHandledToHalf or CallsHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were transfered out of the service during the reporting interval. The data in this column maps to TransferOutCallsToHalf or TransferOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TRANSFER_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were routed to the service during the reporting interval. The data in this column maps to CallsRoutedToHalf or CallsRouted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were abandoned whilst in queue during the reporting interval. The data in this column maps to CallsAbandQToHalf or CallsAbandQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_ABAND_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the peripheral service level during the reporting interval. The data in this column maps to PeriphServiceLevelToHalf or PeriphServiceLevel column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PERIPH_SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were answered within the peripheral service level during the reporting interval. The data in this column maps to PeriphServiceLevelCallsToHalf or PeriphServiceLevelCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PERIPH_SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the system service level during the reporting interval. The data in this column maps to ServiceLevelToHalf or ServiceLevel column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered within the system service level threshold during the reporting interval. The data in this column maps to ServiceLevelCallsToHalf or ServiceLevelCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of call for the service that were abandoned within the service level during the reporting interval. The data in this column maps to ServiceLevelAbandToHalf or ServiceLevelAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ABAND'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that had service level events during the reporting interval. The data in this column maps to ServiceLevelCallsOfferedToHalf or ServiceLevelCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay in queue, in seconds, for all calls for the service during the reporting interval. The data in this column maps to AvgDelayQToHalf or AvgDelayQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AVG_DELAY_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total wait time, in seconds, for all calls to the service whilst in queue during the reporting interval. The data in this column maps to DelayQTimeToHalf or DelayQTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DELAY_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were in queue during the reporting interval. The data in this column maps to CallsQToHalf or CallsQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay time, in seconds, for all calls for the service that were abandoned in queue during the reporting interval. The data in this column maps to AvgDelayQAbandToHalf or AvgDelayQAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AVG_DELAY_Q_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total wait time, in seconds, for all calls to the service that were abandoned whilst waiting in queue during the reporting interval. The data in this column maps to DelayQAbandTimeToHalf or DelayQAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DELAY_Q_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average answer wait time, in seconds, for all calls for the service before being answered during the reporting interval. The data in this column maps to AvgSpeedAnswerToHalf or AvgSpeedAnswer column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AVG_SPEED_ANSWER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total answer wait time, in seconds, for all calls that were answered for the service during the reporting interval. The data in this column maps to AnswerWaitTimeToHalf or AnswerWaitTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'ANSWER_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the average talk time, in seconds, for all calls for this service that were answered during the reporting interval. The data in this column maps to AvgTalkTimeToHalf or AvgTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AVG_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all calls for the service during the reporting interval. This include the time when agents were in active or paused state. The data in this column maps to TalkTimeToHalf or TalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average handle time, in seconds, for all calls that were handled for the service during the reporting interval. The data in this column maps to AvgHandleTimeToHalf or AvgHandleTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AVG_HANDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all calls to the service that were handled during the reporting interval. The data in this column maps to HandleTimeToHalf or HandleTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'HANDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were too short to be treated as abandoned during the reporting interval. The data in this column maps to ShortCallsToHalf or ShortCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were answered during the reporting interval. The data in this column maps to CallsAnsweredToHalf or CallsAnswered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time in queue, in seconds, for a call to the service that was abandoned whilst in queue during the reporting interval. The data in this column maps to LongestCallAbandTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'LONGEST_CALL_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time in queue, in seconds, for a call to the service that was answered during the reporting interval.The data in this column maps to LongestCallDelayQTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'LONGEST_CALL_DELAY_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls for the service that were too short to be treated as abandoned during the reporting interval. The data in this column maps to ShortCallsTimeToHalf or ShortCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SHORT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were determined to be closed due to interruption in data during the reporting interval. The data in this column maps to ForcedClosedCallsToHalf or ForcedClosedCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'FORCED_CLOSED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were overflowed into the service during the reporting interval. The data in this column maps to OverflowInToHalf column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'OVERFLOW_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were re-targeted out of the service during the reporting interval. The data in this column maps to OverflowOutToHalf or OverflowOut column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'OVERFLOW_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of predictive calls for the service during the reporting interval. The data in this column maps to AutoOutCallsToHalf or AutoOutCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the predictive calls handled for the service during the reporting interval. The data in this column maps to AutoOutCallsTimeToHalf or AutoOutCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all the predictive calls for the service during the reporting interval. The data in this column maps to AutoOutCallsTalkTimeToHalf or AutoOutCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of predictive calls for the service that were put on hold atleast once during the reporting interval. The data in this column maps to AutoOutCallsOnHoldToHalf or AutoOutCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all the predictive calls for this service that were put on hold during the reporting interval. The data in this column maps to AutoOutCallsOnHoldTimeToHalf or AutoOutCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'AUTO_OUT_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is total outbound preview calls made from this service during the reporting interval. The data in this column maps to PreviewCallsToHalf or PreviewCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PREVIEW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all outbound preview calls to the service during the reporting interval. The data in this column maps to PreviewCallsTimeToHalf or PreviewCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all outbound preview calls to the service during the reporting interval. The data in this column maps to PreviewCallsTalkTimeToHalf or PreviewCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of preview calls to the service that were put on hold atleast once during the reporting interval. The data in this column maps to PreviewCallsOnHoldToHalf or PreviewCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all preview calls to the service that were put on hold during the reporting interval. The data in this column maps to PreviewCallsOnHoldTimeToHalf or PreviewCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PREVIEW_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of reservation calls made by the service during the reporting interval. The data in this column maps to ReserveCallsToHalf or ReserveCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'RESERVE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all reservation calls that were handled by the service during the reporting interval. The data in this column maps to ReserveCallsTimeToHalf or ReserveCallsTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'RESERVE_CALLS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time, in seconds, for all reservation calls that were handled by the service during the reporting interval. The data in this column maps to ReserveCallsTalkTimeToHalf or ReserveCallsTalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'RESERVE_CALLS_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of reservation calls to the service that were placed on hold atleast once during the reporting interval. The data in this column maps to ReserveCallsOnHoldToHalf or ReserveCallsOnHold column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'RESERVE_CALLS_ON_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all reservation calls to the service that were placed on hold during the reporting interval. The data in this column maps to ReserveCallsOnHoldTimeToHalf or ReserveCallsOnHoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'RESERVE_CALLS_ON_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, for all calls to the service that were put on hold during the reporting interval. The data in this column maps to HoldTimeToHalf or HoldTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were blind transfered by agents in the service during the reporting interval. The data in this column maps to BlindTransfersOutToHalf or BlindTransfersOut column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'BLIND_TRANSFERS_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were redirected on failure to answer at the agent''s terminal during the reporting interval. The data in this column maps to RedirectNoAnsCallsToHalf or RedirectNoAnsCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'REDIRECT_NO_ANS_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the NumMissingTasks column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'NUM_MISSING_TASKS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level type used to calculate the service level for the reporting interval. This maps to the ServiceLevelType column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SERVICE_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_SERVICE_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SERVICE_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_SERVICE_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
