SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] (
		[SUMMARIZED_URN]          [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[CDR_SESSION_URN]         [int] NOT NULL,
		[TLI_URN]                 [int] NOT NULL,
		[TLI_NNG_URN]             [int] NOT NULL,
		[DIALED_NUMBER_URN]       [int] NOT NULL,
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
		[CALL_LEG_TOT]            [int] NOT NULL,
		[PARTITION_ID]            [int] NOT NULL
) ON [SUMINGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_DATE_URN]
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] ([DATE_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'INDEX', N'IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_DIALED_NUMBER_URN]
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] ([DIALED_NUMBER_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'INDEX', N'IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_DIALED_NUMBER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_TIME_URN]
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] ([TIME_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'INDEX', N'IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_TIME_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_TLI_NNG_URN]
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] ([TLI_NNG_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'INDEX', N'IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_TLI_NNG_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_TLI_URN]
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] ([TLI_URN])
	ON [SUMINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'INDEX', N'IX_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_TLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is created at install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an ID associated with import session.  Each CDR file generates a new session. This field maps to the SESSION_URN from TB_IMP_CDR_SESSION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'CDR_SESSION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_TLI. This is the Termination Line Identifier (Destination Number) associated with a particular call - derived from the Destination Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TLI_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TLI', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_NNG. This is the Termination Line Identifier (Destination Number) area code associated with a call - derived from the Destination Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NNG', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_DIALED_NUMBER. This is the Dialed Number associated with a particular call - derived from the Dialed Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the DATE_URN from TB_DIM_DATE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the TIME_URN from TB_DIM_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the DATE_URN from TB_DIM_DATE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network. This maps to the TIME_URN from TB_DIM_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of calls presented to the dialed number and destination number in the half hour.  It is the sum of EFFECTIVE_TOT, NETWORK_FAILURE_TOT, BUSY_TOT & NA_TOT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'PRESENTED_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of effective calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'EFFECTIVE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of ineffective calls to the dialed number and destination number in the half hour.  It is the sum of NETWORK_FAILURE_TOT, BUSY_TOT & NA_TOT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'INEFFECTIVE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of network failure calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'NETWORK_FAILURE_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of busy calls to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'BUSY_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of calls not answered to the dialed number and destination number in the half hour.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'NA_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of Call Legs, derived by taking the maximum of the number of call legs current in each minute of the day.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'CALL_LEG_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI', 'COLUMN', N'PARTITION_ID'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI] SET (LOCK_ESCALATION = TABLE)
GO
