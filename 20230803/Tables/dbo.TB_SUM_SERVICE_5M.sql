SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_SERVICE_5M] (
		[SUMMARIZED_URN]                        [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[SERVICE_URN]                           [int] NOT NULL,
		[DATE_URN]                              [int] NOT NULL,
		[TIME_URN]                              [smallint] NOT NULL,
		[DATE_UTC_URN]                          [int] NOT NULL,
		[TIME_UTC_URN]                          [smallint] NOT NULL,
		[CALLS_IN_PROGRESS]                     [int] NULL,
		[CALLS_OFFERED_TODAY]                   [int] NULL,
		[CALLS_INCOMING_TODAY]                  [int] NULL,
		[CALLS_HANDLED_TODAY]                   [int] NULL,
		[CALLS_ROUTED_TODAY]                    [int] NULL,
		[CALLS_ABAND_Q_TODAY]                   [int] NULL,
		[PERIPH_SERVICE_LEVEL_TODAY]            [real] NULL,
		[PERIPH_SERVICE_LEVEL_TO5]              [real] NULL,
		[SERVICE_LEVEL_TODAY]                   [real] NULL,
		[SERVICE_LEVEL_TO5]                     [real] NULL,
		[SERVICE_LEVEL_CALLS_TODAY]             [int] NULL,
		[SERVICE_LEVEL_CALLS_TO5]               [int] NULL,
		[SERVICE_LEVEL_ABAND_TODAY]             [int] NULL,
		[SERVICE_LEVEL_ABAND_TO5]               [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED_TODAY]     [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED_TO5]       [int] NULL,
		[SERVICE_LEVEL_CALLS_Q_HELD]            [int] NULL,
		[LONGEST_CALL_Q]                        [int] NULL,
		[AVG_DELAY_Q_ABAND_TO5]                 [int] NULL,
		[EXPECTED_DELAY]                        [real] NULL,
		[AVG_SPEED_ANSWER_TO5]                  [int] NULL,
		[CALLS_OFFERED_TO5]                     [int] NULL,
		[AVG_TALK_TIME_TO5]                     [int] NULL,
		[CALLS_HANDLED_TO5]                     [int] NULL,
		[AVG_HANDLE_TIME_TO5]                   [int] NULL,
		[AVG_DELAY_Q_NOW]                       [int] NULL,
		[CALLS_Q_NOW]                           [int] NULL,
		[AGENTS_TALKING]                        [int] NULL,
		[CALLS_LEFT_Q_TO5]                      [int] NULL,
		[OVERFLOW_IN_TO5]                       [int] NULL,
		[OVERFLOW_OUT_TO5]                      [int] NULL,
		[CALLS_ANSWERED_TODAY]                  [int] NULL,
		[CALLS_ANSWERED_TO5]                    [int] NULL,
		[LONGEST_AVAIL_AGENT]                   [int] NULL,
		[PARTITION_ID]                          [int] NOT NULL,
		[RECOVERY_KEY]                          [float] NULL,
		[DATE_TIME]                             [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]                  [int] NOT NULL
) ON [SUMICMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical five minute summary statistics of all the services. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_SERVICE_5M_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_SERVICE_5M view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Service_Five_Minute table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SERVICE for an item of type IT_SERVICE. This is the service associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of inbound or outbound calls to the service that were being handled during the five minute interval. In Cisco ICM/IPCC this maps to CallsInProgress column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_IN_PROGRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming calls plus internal calls offered to the service since midnight. In Cisco ICM/IPCC this maps to CallsOfferedToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_OFFERED_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming calls to the service since midnight. In Cisco ICM/IPCC this maps to CallsIncomingToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_INCOMING_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to this service that were handled since midnight. In Cisco ICM/IPCC this maps to CallsHandledToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_HANDLED_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were routed to this service since midnight. In Cisco ICM/IPCC this maps to CallsRoutedToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_ROUTED_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were abandoned whilst in queue since midnight. In Cisco ICM/IPCC this maps to CallsAbandQToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_ABAND_Q_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the peripheral service level for the service since midnight. In Cisco ICM/IPCC this maps to PeriphServiceLevelToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'PERIPH_SERVICE_LEVEL_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the peripheral service level for the service during the five minute interval. In Cisco ICM/IPCC this maps to PeriphServiceLevelTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'PERIPH_SERVICE_LEVEL_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the cumulative service level for the service since midnight. In Cisco ICM/IPCC this maps to ServiceLevelToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the cumulative service level for the service during the five minute interval. In Cisco ICM/IPCC this maps to ServiceLevelTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service since midnight that were held within the service level. In Cisco ICM/IPCC this maps to ServiceLevelCallsToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_CALLS_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were handled within the service level during the five minute interval. In Cisco ICM/IPCC this maps to ServiceLevelCallsTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_CALLS_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service since midnight that were abandoned within the service level threshold. In Cisco ICM/IPCC this maps to ServiceLevelAbandToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_ABAND_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were abandoned within the service level threshold during the five minute interval. In Cisco ICM/IPCC this maps to ServiceLevelAbandTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_ABAND_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service since midnight that were answered or abandoned within the service level threshold. In Cisco ICM/IPCC this maps to ServiceLevelCallsOfferedToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were answered or abandoned within the service level threshold during the five minute interval. In Cisco ICM/IPCC this maps to ServiceLevelCallsOfferedTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the service that were in the queue for a duration longer than the service level threshold during the five minute interval. In Cisco ICM/IPCC this maps to ServiceLevelCallsQHeld column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'SERVICE_LEVEL_CALLS_Q_HELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration, in seconds, that a call to the service spent in the queue for the longest period of time during the five minute interval. In Cisco ICM/IPCC this maps to LongestCallQ column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'LONGEST_CALL_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay time, in seconds, for calls to the service that were abandoned whilst in queue during the five minute interval. In Cisco ICM/IPCC this maps to AvgDelayQAbandTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'AVG_DELAY_Q_ABAND_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the predicted delay, in seconds, for a new call put in the service queue during the five minute interval. In Cisco ICM/IPCC this maps to ExpectedDelay column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'EXPECTED_DELAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average answer wait time, in seconds, for calls to this service during the five minute interval. In Cisco ICM/IPCC this maps to AvgSpeedAnswerTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'AVG_SPEED_ANSWER_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls offered to the service during the five minute interval. In Cisco ICM/IPCC this maps to CallsOfferedTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_OFFERED_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average talk time, in serconds, for all calls to this service during the five minute interval. In Cisco ICM/IPCC this maps to AvgTalkTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'AVG_TALK_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls handled by the service during the five minute interval. In Cisco ICM/IPCC this maps to CallsHandledTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_HANDLED_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average handle time, in seconds, for all calls to this service during the five minute interval. In Cisco ICM/IPCC this maps to AvgHandleTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'AVG_HANDLE_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay, in seconds, for calls in queue for the service at the end of the five minute interval. In Cisco ICM/IPCC this maps to AvgDelayQNow column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'AVG_DELAY_Q_NOW'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls in queue for the service at the end of the five minute interval. In Cisco ICM/IPCC this maps to CallsQNow column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_Q_NOW'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents in talking state for calls on the service at the end of the five minute interval. In Cisco ICM/IPCC this maps to AgentsTalking column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'AGENTS_TALKING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were removed from the queue during the five minute interval. In Cisco ICM/IPCC this maps to CallsLeftQTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_LEFT_Q_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were re-targeted to the service during the five minute interval. In Cisco ICM/IPCC this maps to OverflowInTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'OVERFLOW_IN_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were re-targeted out of the service during the five minute interval. In Cisco ICM/IPCC this maps to OverflowOutTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'OVERFLOW_OUT_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were answered by agents since midnight. In Cisco ICM/IPCC this maps to CallsAnsweredToday column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_ANSWERED_TODAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls for the service that were answered by agents during the five minute interval. In Cisco ICM/IPCC this maps to CallsAnsweredTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CALLS_ANSWERED_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration, in seconds, when an agent for the service was available for the longest period of time at the end of the five minute interval. In Cisco ICM/IPCC this maps to LongestAvailAgent column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'LONGEST_AVAIL_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SERVICE_5M', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SERVICE_5M]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_SERVICE_5M]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SERVICE_5M]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_SERVICE_5M] SET (LOCK_ESCALATION = TABLE)
GO
