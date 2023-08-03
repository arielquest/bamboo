SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IN_CDR] (
		[SUMMARIZED_URN]                  [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[DIALED_NUMBER_URN]               [int] NOT NULL,
		[TLI_URN]                         [int] NOT NULL,
		[CLI]                             [nvarchar](20) COLLATE Latin1_General_CI_AS NOT NULL,
		[CLI_SHORT]                       [nvarchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[CIRCUIT_SEIZE_DATE_TIME]         [datetime] NOT NULL,
		[CIRCUIT_SEIZE_UTC_DATE_TIME]     [datetime] NOT NULL,
		[ADDRESS_DATE_TIME]               [datetime] NULL,
		[ADDRESS_UTC_DATE_TIME]           [datetime] NULL,
		[ANSWER_DATE_TIME]                [datetime] NULL,
		[ANSWER_UTC_DATE_TIME]            [datetime] NULL,
		[CLEAR_DATE_TIME]                 [datetime] NULL,
		[CLEAR_UTC_DATE_TIME]             [datetime] NULL,
		[TERMINATION_CODE]                [nvarchar](3) COLLATE Latin1_General_CI_AS NOT NULL,
		[DURATION]                        [int] NOT NULL,
		[RECORD_TYPE_CODE]                [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[RECORD_LINK_NUMBER]              [bigint] NOT NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[CUSTOM_DIMENSION_0]              [int] NOT NULL,
		[CUSTOM_DIMENSION_1]              [int] NOT NULL,
		[CUSTOM_DIMENSION_2]              [int] NOT NULL,
		[CUSTOM_DIMENSION_3]              [int] NOT NULL,
		[CUSTOM_DIMENSION_4]              [int] NOT NULL,
		[CUSTOM_DIMENSION_5]              [int] NOT NULL,
		[CUSTOM_DIMENSION_6]              [int] NOT NULL,
		[CUSTOM_DIMENSION_7]              [int] NOT NULL,
		[CUSTOM_DIMENSION_8]              [int] NOT NULL,
		[CUSTOM_DIMENSION_9]              [int] NOT NULL,
		[CUSTOM_MEASURE_0]                [int] NULL,
		[CUSTOM_MEASURE_1]                [int] NULL,
		[CUSTOM_MEASURE_2]                [int] NULL,
		[CUSTOM_MEASURE_3]                [int] NULL,
		[CUSTOM_MEASURE_4]                [int] NULL,
		[CUSTOM_MEASURE_5]                [int] NULL,
		[CUSTOM_MEASURE_6]                [int] NULL,
		[CUSTOM_MEASURE_7]                [int] NULL,
		[CUSTOM_MEASURE_8]                [int] NULL,
		[CUSTOM_MEASURE_9]                [int] NULL
) ON [FCTINGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IN_CDR_CIRCUIT_SEIZE_DATE_TIME]
	ON [dbo].[TB_FCT_IN_CDR] ([CIRCUIT_SEIZE_DATE_TIME])
	ON [FCTINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'INDEX', N'IX_FCT_IN_CDR_CIRCUIT_SEIZE_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IN_CDR_DIALED_NUMBER_URN]
	ON [dbo].[TB_FCT_IN_CDR] ([DIALED_NUMBER_URN])
	ON [FCTINIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'INDEX', N'IX_FCT_IN_CDR_DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the storing the raw IN CDR data. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IN_CDR_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IN_CDR view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_DIALED_NUMBER. This is the dialed number associated with a particular call leg - derived from the Dialed Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TLI for an item of type IT_TLI. This is the Termination Line Identifier (Destination Number) associated with a particular call leg - derived from the Destination Number field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'TLI_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TLI', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'TLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Calling Line Identifier associated with a particular call leg - derived from the Calling Line Identifier field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CLI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the first seven digits of the Calling Line Identifier associated with a particular call leg - derived from the Calling Line Identifier field in the IN CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CLI_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CIRCUIT_SEIZE_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to Circuit Seize Date Time field in the IN CDR. Circuit Seize represents the date and time at which the Calling Party seizes a circuit on the network.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CIRCUIT_SEIZE_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Address Date Time field in the IN CDR. Address represents the date and time at which the Called Party Destination has accepted the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'ADDRESS_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is calculated based on Address Date Time field in the IN CDR and the timezone information. This represents the UTC date and time at which the Called Party Destination has accepted the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'ADDRESS_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Answer Date Time field in the IN CDR. Answer represents the date and time at which the Called Party Destination has answered the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'ANSWER_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is calcuated based on the Answer Date Time field in the IN CDR and the timezone information. Answer represents the date and time at which the Called Party Destination has answered the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'ANSWER_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Derived from the Clear Date Time field in the IN CDR. This represents the date and time at which the leg is cleared either after an answer or ringing, after which the call may be re-routed.  This field will be null if the call is not complete.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CLEAR_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is calcuated based on the Clear Date Time field in the IN CDR and the timezone information. This represents the UTC date and time at which the leg is cleared either after an answer or ringing, after which the call may be re-routed.  This field will be null if the call is not complete.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CLEAR_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Populated from the Termination Code field in the IN CDR.  This represents the outcome of the call leg. Valid values: CMP (Complete); INF (Incomplete - Network Failure); INB (Incomplete - Network Busy); ISB (Incomplete - Subscriber Busy); RNG (Incomplete - Ring, No Answer); 999 (Unknown).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'TERMINATION_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Populated from the Duration field in the IN CDR. This represents the duration of the leg (in seconds).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Populated from the Duration field in the IN CDR. This represents the type of record. Valid values: C (Initial Contact Centre Service (CCS) call leg); S (Subsequent Contact Centre Service (CCS) call leg); 0 (Normal Call); 1 (Initial Long Call leg); 2(Middle Long Call leg); 3 (Final Long Call leg).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'RECORD_TYPE_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Populated from the Record Link Number field in the IN CDR.  It is a unique identifier for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'RECORD_LINK_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IN_CDR', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IN_CDR]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IN_CDR]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IN_CDR]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IN_CDR] SET (LOCK_ESCALATION = TABLE)
GO
