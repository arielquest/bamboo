SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_IN_CALL_VOLUME_HH] (
		[SUMMARIZED_URN]          [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[DATE_TIME]               [datetime] NOT NULL,
		[DATE_URN]                [int] NOT NULL,
		[TIME_URN]                [int] NOT NULL,
		[DATE_UTC_URN]            [int] NOT NULL,
		[TIME_UTC_URN]            [int] NOT NULL,
		[CDR_SESSION_URN]         [int] NOT NULL,
		[DIALED_NUMBER_URN]       [int] NOT NULL,
		[CLI_NNG_URN]             [int] NOT NULL,
		[RATING_PERIOD_URN]       [int] NOT NULL,
		[PRESENTED_TOT]           [int] NOT NULL,
		[EFFECTIVE_TOT]           [int] NOT NULL,
		[INEFFECTIVE_TOT]         [int] NOT NULL,
		[NETWORK_FAILURE_TOT]     [int] NOT NULL,
		[BUSY_TOT]                [int] NOT NULL,
		[NETWORK_BUSY_TOT]        [int] NOT NULL,
		[SUBSCRIBER_BUSY_TOT]     [int] NOT NULL,
		[NO_ANSWER_TOT]           [int] NOT NULL,
		[UNKNOWN_TOT]             [int] NOT NULL,
		[TALK_TIME_TOT]           [int] NOT NULL,
		[TIME_TO_ANSWER_TOT]      [int] NOT NULL,
		[NA_RING_TIME_TOT]        [int] NOT NULL,
		[TTA_TOT_0_5]             [int] NOT NULL,
		[TTA_TOT_6_10]            [int] NOT NULL,
		[TTA_TOT_11_15]           [int] NOT NULL,
		[TTA_TOT_16_20]           [int] NOT NULL,
		[TTA_TOT_21_25]           [int] NOT NULL,
		[TTA_TOT_26_30]           [int] NOT NULL,
		[TTA_TOT_31_45]           [int] NOT NULL,
		[TTA_TOT_46_60]           [int] NOT NULL,
		[TTA_TOT_61_120]          [int] NOT NULL,
		[TTA_TOT_120]             [int] NOT NULL,
		[PARTITION_ID]            [int] NOT NULL
) ON [SUMINGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_HH_DATE_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_HH] ([DATE_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_HH_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_HH_DIALED_NUMBER_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_HH] ([DIALED_NUMBER_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_HH_DIALED_NUMBER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_HH_TIME_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_HH] ([TIME_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_HH_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is created at install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_IN_CALL_LEG_VOLUME_HH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_IN_CALL_LEG_VOLUME_HH view. Since the partitioned tables are generated at runtime have the same schema, no separate documentation is required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the DATE_URN from TB_DIM_DATE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the TIME_URN from TB_DIM_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the DATE_URN from TB_DIM_DATE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the TIME_URN from TB_DIM_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an ID associated with import session. Each CDR file generates a new session. This field maps to the SESSION_URN from TB_IMP_CDR_SESSION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'CDR_SESSION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_DIALED_NUMBER. This is the Dialed Number associated with a particular call - derived from the Dialed Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NNG', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This us the URN as in TB_DIM_RATING_PERIOD of type IT_RATING_PERIOD. This is the rating period associated with the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_RATING_PERIOD', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of calls presented to the destination number, from the CLI area code in the half hour.  It is the sum of EFFECTIVE_TOT, NETWORK_FAILURE_TOT, BUSY_TOT & NA_TOT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'PRESENTED_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of effective calls to the destination number, from the CLI area code in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'EFFECTIVE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of ineffective calls to the destination number, from the CLI area code in the half hour.  It is the sum of NETWORK_FAILURE_TOT, BUSY_TOT & NA_TOT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'INEFFECTIVE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of network failure calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'NETWORK_FAILURE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of busy calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'BUSY_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were busy in the network during the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'NETWORK_BUSY_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'SUBSCRIBER_BUSY_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of unanswered calls during the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'NO_ANSWER_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where the result was unknown during the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'UNKNOWN_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total talk time for this leg of the call, calculated from the difference between end times and start times for the set of legs available when the leg was processed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TALK_TIME_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds when the call was answered for the first time. All legs subsequent to the current leg will have a value of zero for this column. This is the total call time to answer for this leg of the call, calculated from the difference between circuit seize times and start times for the set of legs available when the leg was processed (only for answered calls)', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TIME_TO_ANSWER_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'is the total call time to answer for this leg of the call, calculated from the difference between circuit seize time and start time for this leg of the call (only for unanswered calls, completion code not CMP)', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'NA_RING_TIME_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 0 and 5 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_0_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 6 and 10 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_6_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 11 and 15 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_11_15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 16 and 20 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_16_20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 21 and 25 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_21_25'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 26 and 30 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_26_30'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 31 and 45 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_31_45'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 46 and 60 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_46_60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer between 61 and 120 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_61_120'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is derived by counting answered calls in incoming CDRs with the time to answer above 120 seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'TTA_TOT_120'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_HH', 'COLUMN', N'PARTITION_ID'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_IN_CALL_VOLUME_HH] SET (LOCK_ESCALATION = TABLE)
GO
