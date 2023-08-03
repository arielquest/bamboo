SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IVR_LEG] (
		[PARTITION_URN]                   [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[PARTITION_GLOBAL_URN]            [bigint] NOT NULL,
		[DATE_TIME]                       [datetime] NOT NULL,
		[UTC_TIMEZONE]                    [int] NOT NULL,
		[DATE_URN]                        [int] NOT NULL,
		[TIME_URN]                        [smallint] NOT NULL,
		[DATE_UTC_URN]                    [int] NOT NULL,
		[TIME_UTC_URN]                    [smallint] NOT NULL,
		[CALL_DETAIL_URN]                 [bigint] NULL,
		[DIALED_NUMBER_URN]               [int] NOT NULL,
		[IVR_SCRIPT_URN]                  [int] NOT NULL,
		[CALL_OUTCOME_URN]                [int] NOT NULL,
		[INITIAL_IVR_SCRIPT_NODE_URN]     [int] NOT NULL,
		[FINAL_IVR_SCRIPT_NODE_URN]       [int] NOT NULL,
		[IVR_ROUTING_TARGET_URN]          [int] NOT NULL,
		[DEFLECTION_LEVEL_URN]            [int] NOT NULL,
		[TRANSFER_TARGET_URN]             [int] NOT NULL,
		[TRANSFER_STATUS_URN]             [int] NOT NULL,
		[SECURITY_STATUS_URN]             [int] NOT NULL,
		[TERMINATION_REASON_URN]          [int] NOT NULL,
		[DESTINATION_ANI_URN]             [int] NOT NULL,
		[ORGANIZATION_URN]                [int] NOT NULL,
		[LOCATION_URN]                    [int] NOT NULL,
		[DURATION_TIMEBAND_URN]           [int] NULL,
		[NETWORK_TIME_TIMEBAND_URN]       [int] NULL,
		[RING_TIME_TIMEBAND_URN]          [int] NULL,
		[HOLD_TIME_TIMEBAND_URN]          [int] NULL,
		[TALK_TIME_TIMEBAND_URN]          [int] NULL,
		[QUEUE_TIME_TIMEBAND_URN]         [int] NULL,
		[CALL_TYPE_URN]                   [int] NOT NULL,
		[PERIPHERAL_URN]                  [int] NOT NULL,
		[CALL_SOURCE_URN]                 [int] NOT NULL,
		[CALL_REASON_URN]                 [int] NOT NULL,
		[CLI_NNG_URN]                     [int] NOT NULL,
		[CLI_URN]                         [int] NOT NULL,
		[VALUE_URN]                       [int] NOT NULL,
		[SATISFACTION_URN]                [int] NOT NULL,
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
		[IVR_SCRIPT_NODE_COUNT]           [int] NULL,
		[DEFLECTION_COUNT]                [int] NULL,
		[DESTINATION_ANI]                 [nvarchar](32) COLLATE Latin1_General_CI_AS NULL,
		[DURATION]                        [int] NULL,
		[NETWORK_TIME]                    [int] NULL,
		[RING_TIME]                       [float] NULL,
		[HOLD_TIME]                       [float] NULL,
		[TALK_TIME]                       [float] NULL,
		[QUEUE_TIME]                      [float] NULL,
		[CALL_REC_LINK]                   [int] NULL,
		[SEQUENCE_NUMBER]                 [int] NOT NULL,
		[PORT]                            [int] NULL,
		[DIRECTION]                       [char](1) COLLATE Latin1_General_CI_AS NULL,
		[CLI]                             [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[VERSION]                         [char](2) COLLATE Latin1_General_CI_AS NULL,
		[GRAMMAR_REJECTS]                 [int] NULL,
		[INPUT_TIMEOUTS]                  [int] NULL,
		[REPEAT_REQUESTS]                 [int] NULL,
		[LOST_INFO]                       [char](1) COLLATE Latin1_General_CI_AS NULL,
		[COST]                            [money] NULL,
		[CUSTOM_MEASURE_0]                [int] NULL,
		[CUSTOM_MEASURE_1]                [int] NULL,
		[CUSTOM_MEASURE_2]                [int] NULL,
		[CUSTOM_MEASURE_3]                [int] NULL,
		[CUSTOM_MEASURE_4]                [int] NULL,
		[CUSTOM_MEASURE_5]                [int] NULL,
		[CUSTOM_MEASURE_6]                [int] NULL,
		[CUSTOM_MEASURE_7]                [int] NULL,
		[CUSTOM_MEASURE_8]                [int] NULL,
		[CUSTOM_MEASURE_9]                [int] NULL,
		[IVR_SOURCE_SESSION_ID]           [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[IVR_LEG_STAGE_URN]               [bigint] NULL,
		[CLUSTER_RESOURCE_ID]             [uniqueidentifier] NULL
) ON [FCTIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_LEG] ([DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'INDEX', N'IX_FCT_IVR_LEG_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_DATE_URN]
	ON [dbo].[TB_FCT_IVR_LEG] ([DATE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'INDEX', N'IX_FCT_IVR_LEG_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_DIALED_NUMBER_URN]
	ON [dbo].[TB_FCT_IVR_LEG] ([DIALED_NUMBER_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'INDEX', N'IX_FCT_IVR_LEG_DIALED_NUMBER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_CALL_TYPE_URN]
	ON [dbo].[TB_FCT_IVR_LEG] ([CALL_TYPE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'INDEX', N'IX_FCT_IVR_LEG_CALL_TYPE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_PERIPHERAL_URN]
	ON [dbo].[TB_FCT_IVR_LEG] ([PERIPHERAL_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'INDEX', N'IX_FCT_IVR_LEG_PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical IVR data. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_LEG_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_LEG view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identity column for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique number for the current partition table. This will be the same for all records in a single partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a values that is globally unique accross all partition tables. This is calculated based on the PARTITION_URN and PARTITION_ID columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC corresponding to the date time associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the wall clock date associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the wall clock time associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_DETAIL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER of type IT_DIALED_NUMBER. This corresponds to the dialed number associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT of type IT_IVR_SCRIPT. This corresponds to the ivr script associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_CALL_OUTCOME. This corresponds to the outcome associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_OUTCOME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_OUTCOME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE of type IT_IVR_SCRIPT_NODE. This corresponds to the initial ivr script node associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'INITIAL_IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'INITIAL_IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE of type IT_IVR_SCRIPT_NODE. This corresponds to the final ivr script node associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'FINAL_IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'FINAL_IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN for the routing target associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_ROUTING_TARGET_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_ROUTING_TARGET', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_ROUTING_TARGET_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN for the deflection level associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DEFLECTION_LEVEL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DEFLECTION_LEVEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN of the transfer target associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TRANSFER_TARGET_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN of the transfer status associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TRANSFER_STATUS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TRANSFER_STATUS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN of the security status associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'SECURITY_STATUS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN for the termination reason associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TERMINATION_REASON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TERMINATION_REASON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN of the destination ANU associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DESTINATION_ANI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'ORGANIZATION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'LOCATION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband corresponding to the duration of the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'NETWORK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'NETWORK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'RING_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'RING_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'HOLD_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'HOLD_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TALK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TALK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'QUEUE_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'QUEUE_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CALL_TYPE of type IT_CALL_TYPE. This corresponds to the call type associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_PERIPHERAL of type IT_PERIPHERAL. This corresponds to the peripheral associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CALL_SOURCE of type IT_CALL_SOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_SOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_CALL_REASON.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_REASON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_REASON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_NNG corresponding to the area code of the CLI associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NNG', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CLI of type IT_CLI. This corresponds to the CLI associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CLI_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CLI', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'VALUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'VALUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_SATISFACTION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'SATISFACTION_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'SATISFACTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the count of the total nodes hit for the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_SCRIPT_NODE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of deflection nodes hit for the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DEFLECTION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DESTINATION_ANI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'NETWORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'QUEUE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CALL_REC_LINK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'PORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'DIRECTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the CLI associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CLI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'GRAMMAR_REJECTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'INPUT_TIMEOUTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'REPEAT_REQUESTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'LOST_INFO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'COST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID corresponding to the IVR session in the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_SOURCE_SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the key that uniquely maps the IVR leg record to the source IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'IVR_LEG_STAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is ID as in TB_CLU_RESOURCE identifying the source equipment that the IVR leg record maps to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_LEG]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_LEG]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_LEG]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_LEG] SET (LOCK_ESCALATION = TABLE)
GO
