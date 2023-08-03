SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] (
		[SUMMARIZED_URN]          [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[CDR_SESSION_URN]         [int] NOT NULL,
		[DIALED_NUMBER_URN]       [int] NOT NULL,
		[TLI_URN]                 [int] NOT NULL,
		[TLI_NNG_URN]             [int] NOT NULL,
		[RATING_PERIOD_URN]       [int] NOT NULL,
		[DATE_URN]                [int] NOT NULL,
		[TIME_URN]                [int] NOT NULL,
		[DATE_UTC_URN]            [int] NOT NULL,
		[TIME_UTC_URN]            [int] NOT NULL,
		[DATE_TIME]               [datetime] NOT NULL,
		[PRESENTED_TOT]           [int] NOT NULL,
		[EFFECTIVE_TOT]           [int] NOT NULL,
		[INEFFECTIVE_TOT]         [int] NOT NULL,
		[NETWORK_FAILURE_TOT]     [int] NOT NULL,
		[BUSY_TOT]                [int] NOT NULL,
		[NA_TOT]                  [int] NOT NULL,
		[TTA_MAX]                 [int] NOT NULL,
		[TTA_MIN]                 [int] NOT NULL,
		[TTA_TOT]                 [int] NOT NULL,
		[TT_MAX]                  [bigint] NOT NULL,
		[TT_MIN]                  [bigint] NOT NULL,
		[TT_TOT]                  [bigint] NOT NULL,
		[NA_RINGTIME_MAX]         [int] NOT NULL,
		[NA_RINGTIME_MIN]         [int] NOT NULL,
		[NA_RINGTIME_TOT]         [int] NOT NULL,
		[PARTITION_ID]            [int] NOT NULL
) ON [SUMINGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_DATE_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] ([DATE_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_DIALED_NUMBER_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] ([DIALED_NUMBER_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_DIALED_NUMBER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_RATING_PERIOD_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] ([RATING_PERIOD_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_RATING_PERIOD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_TIME_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] ([TIME_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_TIME_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_TLI_NNG_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] ([TLI_NNG_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_TLI_NNG_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_TLI_URN]
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] ([TLI_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'INDEX', N'IX_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_TLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an ID associated with import session.  Each CDR file generates a new session. This field maps to the SESSION_URN from TB_IMP_CDR_SESSION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'CDR_SESSION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_DIALED_NUMBER. This is the Dialed Number associated with a particular call - derived from the Dialed Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_TLI. This is the Termination Line Identifier (Destination Number) associated with a particular call - derived from the Destination Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TLI_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TLI', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_NNG. This is the Termination Line Identifier (Destination Number) area code associated with a call - derived from the Destination Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NNG', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This us the URN as in TB_DIM_RATING_PERIOD of type IT_RATING_PERIOD. This is the rating period associated with the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_RATING_PERIOD', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the DATE_URN from TB_DIM_DATE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the TIME_URN from TB_DIM_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the DATE_URN from TB_DIM_DATE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the TIME_URN from TB_DIM_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of calls presented to the dialed number and destination number in the half hour.  It is the sum of EFFECTIVE_TOT, NETWORK_FAILURE_TOT, BUSY_TOT & NA_TOT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'PRESENTED_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of effective calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'EFFECTIVE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of ineffective calls to the dialed number and destination number in the half hour.  It is the sum of NETWORK_FAILURE_TOT, BUSY_TOT & NA_TOT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'INEFFECTIVE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of network failure calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'NETWORK_FAILURE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of busy calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'BUSY_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of calls not answered to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'NA_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum time to answer any particular call to the dialed number and destination number in the half hour.  Time to answer is calculated as the number of seconds between the ADDRESS time and the ANSWER time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TTA_MAX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Minimum time to answer any particular call to the dialed number and destination number in the half hour.  Time to answer is calculated as the number of seconds between the ADDRESS time and the ANSWER time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TTA_MIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total time to answer all calls to the dialed number and destination number in the half hour.  I.e. the sum of all ring times where the call is answered.  Time to answer is calculated as the number of seconds between the ADDRESS time and the ANSWER time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TTA_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum talk time of any particular call to the dialed number and destination number in the half hour.  Talk time is calculated as the number of seconds between the ANSWER time and the CLEAR time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TT_MAX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Minimum talk time of any paricular call to the dialed number and destination number in the half hour.  Talk time is calculated as the number of seconds between the ANSWER time and the CLEAR time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TT_MIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total talk time of all answered calls to the dialed number and destination number in the half hour.  I.e. the sum of all talk times.  Talk time is calculated as the number of seconds between the ANSWER time and the CLEAR time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'TT_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum ring time of any particular call to the dialed number and destination number in the half hour where the call was not answered.  No Answer Ring Time is calculated as the number of seconds between the ADDRESS time and the CLEAR time where the call was not answered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'NA_RINGTIME_MAX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Minimum ring time of any particular call to the dialed number and destination number in the half hour where the call was not answered.  No Answer Ring Time is calculated as the number of seconds between the ADDRESS time and the CLEAR time where the call was not answered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'NA_RINGTIME_MIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total ring time of all calls to the dialed number and destination number in the half hour where the call was not answered.  I.e. the sum of all ring times where calls were not answered. No Answer Ring Time is calculated as the number of seconds between the ADDRESS time and the CLEAR time where the call was not answered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'NA_RINGTIME_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG', 'COLUMN', N'PARTITION_ID'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_IN_CALL_VOLUME_BY_DNIS_TLI_TLINNG] SET (LOCK_ESCALATION = TABLE)
GO
