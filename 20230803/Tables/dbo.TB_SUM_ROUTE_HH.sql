SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_ROUTE_HH] (
		[SUMMARIZED_URN]                     [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[DATE_URN]                           [int] NOT NULL,
		[TIME_URN]                           [smallint] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[ROUTE_URN]                          [int] NOT NULL,
		[CALLS_OFFERED_TH]                   [int] NULL,
		[CALLS_INCOMING_TH]                  [int] NULL,
		[CALLS_HANDLED_TH]                   [int] NULL,
		[CALLS_ROUTED_TH]                    [int] NULL,
		[CALLS_ABANDQ_TH]                    [int] NULL,
		[SERVICE_LEVEL_TH]                   [real] NULL,
		[SERVICE_LEVEL_CALLS_TH]             [int] NULL,
		[SERVICE_LEVEL_ABAND_TH]             [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED_TH]     [int] NULL,
		[AVG_DELAY_Q_TH]                     [int] NULL,
		[DELAY_Q_TTH]                        [int] NULL,
		[CALLS_Q_TH]                         [int] NULL,
		[AVG_DELAY_QA_BAND_TH]               [int] NULL,
		[DELAY_QA_BAND_TTH]                  [int] NULL,
		[AVG_SPEED_ANSWER_TH]                [int] NULL,
		[ANSWER_WAIT_TTH]                    [int] NULL,
		[AVG_TALK_TTH]                       [int] NULL,
		[TALK_TTH]                           [int] NULL,
		[AVG_HANDLE_TTH]                     [int] NULL,
		[HANDLE_TTH]                         [int] NULL,
		[CALLS_ANSWER_ED_TH]                 [int] NULL,
		[LONGEST_CALL_ABAND_TIME]            [int] NULL,
		[LONGEST_CALL_DELAY_Q_TIME]          [int] NULL,
		[SHORT_CALLS_TH]                     [int] NULL,
		[SHORT_CALLS_TTH]                    [int] NULL,
		[FORCED_CLOSED_CALLS_TH]             [int] NULL,
		[OVERFLOW_IN_TH]                     [int] NULL,
		[OVERFLOW_OUT_TH]                    [int] NULL,
		[HOLD_TTH]                           [int] NULL,
		[BLIND_TRANSFERS_OUT_TH]             [int] NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[RECOVERY_KEY]                       [float] NULL,
		[DB_DATETIME]                        [datetime] NULL,
		[REDIRECT_NO_ANS_CALLS_TH]           [int] NULL,
		[DATE_TIME]                          [datetime] NOT NULL,
		[SERVICE_LEVEL_TYPE]                 [int] NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_ROUTE_HH_DATE_TIME]
	ON [dbo].[TB_SUM_ROUTE_HH] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'INDEX', N'IX_SUM_ROUTE_HH_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_ROUTE_HH_DATE_URN]
	ON [dbo].[TB_SUM_ROUTE_HH] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'INDEX', N'IX_SUM_ROUTE_HH_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_ROUTE_HH_ROUTE_URN]
	ON [dbo].[TB_SUM_ROUTE_HH] ([ROUTE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'INDEX', N'IX_SUM_ROUTE_HH_ROUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical half hour summary statistics for all the routes in the application. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_ROUTE_HH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_ROUTE_HH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Route_Half_Hour table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_ROUTE corresponding to an item of type IT_ROUTE. This corresponds to the route associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'ROUTE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ROUTE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'ROUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming calls plus the internal calls that where offered on this route during the half hour interval. The data in this column maps to CallsOfferedToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_OFFERED_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming calls offered on this route during the half hour interval. The data in this column maps to CallsIncomingToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_INCOMING_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were handled by answering resources like agents, IVRs or voice mails during the half hour interval. The data in this column maps to CallsHandledToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_HANDLED_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were sent to this route during the half hour interval. The data in this column maps to CallsRoutedToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_ROUTED_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of call on this route that were abandoned in queue during the half hour interval. The data in this column maps to CallsAbandQToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_ABANDQ_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the cumulative service level for the route during the half hour itnerval. The data in this column maps to ServiceLevelToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SERVICE_LEVEL_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were answered within the service level threshold during the half hour interval. The data in this column maps to ServiceLevelCallsToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SERVICE_LEVEL_CALLS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were abandoned within the service level threshold during the half hour interval. The data in this column maps to ServiceLevelAbandToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SERVICE_LEVEL_ABAND_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that had service level event during the half hour interval. The data in this column maps to ServiceLevelCallsOfferedToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay time, in seconds, for all calls queued for the route during the half hour interval. The data in this column maps to AvgDelayQToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'AVG_DELAY_Q_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total delay time, in seconds, for all calls in queue on this route during the half hour interval. The data in this column maps to DelayQTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DELAY_Q_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route in queue during the half hour interval. The data in this column maps to CallsQToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_Q_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average delay time, in seconds, for all calls on this route that were abandoned whilst in queue during the half hour. The data in this column maps to AvgDelayQAbandToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'AVG_DELAY_QA_BAND_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls on this route which were abandoned whilst in queue during the half hour interval. The data in this column maps to DelayQAbandTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DELAY_QA_BAND_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average answere wait time, in seconds, for all the calls on this route during the half hour interval. The data in this column maps to AvgSpeedAnswerToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'AVG_SPEED_ANSWER_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total answer wait time, in seconds, for all the calls on this route during the half hour interval. The data in this column maps to AnswerWaitTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'ANSWER_WAIT_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average talk time, in seconds, for all the calls on this route during the half hour interval. The data in this column maps to AvgTalkTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'AVG_TALK_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls on this route whilst talking and whilst on hold during the half hour inteval. The data in this column maps to TalkTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'TALK_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average handle time, in seconds, for all calls on this route that were counted as handled during the half hour inteval. The data in this column maps to AvgHandleTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'AVG_HANDLE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time, in seconds, for all the calls on this route that were counted as handled during the half hour interval. The data in this column maps to HandleTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'HANDLE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were answered by agents, IVRs or voice mail during the half hour interval. The data in this column maps to CallsAnsweredToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CALLS_ANSWER_ED_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time, in seconds, a call on this route was in queue before being abandoned during the half hour interval. The data in this column maps to LongestCallAbandTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'LONGEST_CALL_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest time, in seconds, a call on this route was in queue before being answered during the half hour interval. The data in this column maps to LongestCallDelayQTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'LONGEST_CALL_DELAY_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were too short to be considered as abandoned during the half hour interval. The data in this column maps to ShortCallsToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SHORT_CALLS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for all calls on this route that were short. The data in this column maps to ShortCallsTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SHORT_CALLS_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were determined to be closed because of an interruption during the half hour interval. The data in this column maps to ForcedClosedCallsToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'FORCED_CLOSED_CALLS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that the peripheral overflowed into this route during the half hour interval. The data in this column maps to OverflowInToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'OVERFLOW_IN_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that the peripheral overflowed out of this route during the half hour interval. The data in this column maps to OverflowOutToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'OVERFLOW_OUT_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total hold time, in seconds, across all calls on this route during the half hour interval. The data in this column maps to HoldTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'HOLD_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were blind transfered out for this route during the half hour interval. The data in this column maps to BlindTransfersOutToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'BLIND_TRANSFERS_OUT_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls on this route that were redirected on no answer during the half hour interval. The data in this column maps to RedirectNoAnsCallsToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'REDIRECT_NO_ANS_CALLS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ServiceLevelType column in the t_Route_Half_Hour table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTE_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_ROUTE_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_ROUTE_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_ROUTE_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_ROUTE_HH] SET (LOCK_ESCALATION = TABLE)
GO
