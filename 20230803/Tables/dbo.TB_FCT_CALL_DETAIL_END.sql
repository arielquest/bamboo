SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CALL_DETAIL_END] (
		[CALL_DETAIL_END_URN]                     [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[STARTDATE_URN]                           [int] NOT NULL,
		[STARTTIME_URN]                           [smallint] NOT NULL,
		[STARTDATE_UTC_URN]                       [int] NOT NULL,
		[STARTTIME_UTC_URN]                       [smallint] NOT NULL,
		[START_DATE_TIME]                         [datetime] NOT NULL,
		[START_UTC_TIMEZONE]                      [int] NOT NULL,
		[CALL_DETAIL_LEG_URN]                     [int] NOT NULL,
		[SEQUENCE_NUMBER]                         [int] NULL,
		[NETWORK_TIME_TIMEBAND_URN]               [int] NULL,
		[DURATION_TIMEBAND_URN]                   [int] NULL,
		[RING_TIME_TIMEBAND_URN]                  [int] NULL,
		[DELAY_TIME_TIMEBAND_URN]                 [int] NULL,
		[ABANDON_TIME_TIMEBAND_URN]               [int] NULL,
		[HOLD_TIME_TIMEBAND_URN]                  [int] NULL,
		[TALK_TIME_TIMEBAND_URN]                  [int] NULL,
		[WORK_TIME_TIMEBAND_URN]                  [int] NULL,
		[LOCAL_Q_TIME_TIMEBAND_URN]               [int] NULL,
		[CONFERENCE_TIME_TIMEBAND_URN]            [int] NULL,
		[SEGMENT_TIME_TIMEBAND_URN]               [int] NULL,
		[CALL_DETAIL_URN]                         [bigint] NULL,
		[AGENT_TEAM_URN]                          [int] NOT NULL,
		[PERIPHERAL_URN]                          [int] NOT NULL,
		[AGENT_URN]                               [int] NOT NULL,
		[ORIGINATING_AGENT_URN]                   [int] NOT NULL,
		[SKILLGROUP_URN]                          [int] NOT NULL,
		[SERVICE_URN]                             [int] NOT NULL,
		[ROUTE_URN]                               [int] NOT NULL,
		[CALL_TYPE_URN]                           [int] NOT NULL,
		[TRUNK_GROUP_URN]                         [int] NOT NULL,
		[CLI_NNG_URN]                             [int] NOT NULL,
		[CLI_URN]                                 [int] NOT NULL,
		[CALL_DISPOSITION_URN]                    [int] NULL,
		[TASK_DISPOSITION_URN]                    [int] NULL,
		[VALUE_URN]                               [int] NOT NULL,
		[SATISFACTION_URN]                        [int] NOT NULL,
		[RATING_PERIOD_URN]                       [int] NOT NULL,
		[PERIPHERAL_CALL_TYPE_URN]                [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                      [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                      [int] NOT NULL,
		[DEVICE_NUMBER]                           [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[AGENT_PERIPHERAL_NUMBER]                 [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[PERIPHERAL_CALL_TYPE]                    [smallint] NULL,
		[BAD_CALL]                                [char](1) COLLATE Latin1_General_CI_AS NULL,
		[CALL_PRIORITY]                           [smallint] NULL,
		[NEW_TRANSACTION]                         [char](1) COLLATE Latin1_General_CI_AS NULL,
		[SERVICE_LEVEL_MET]                       [char](1) COLLATE Latin1_General_CI_AS NULL,
		[PERIPHERAL_TRUNK_NUMBER]                 [int] NULL,
		[OUTBOUND_DIGITS]                         [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CLI_STRING]                              [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[DIALED_NUMBER_TEXT]                      [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[WRAPUP_DATA]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[NETWORK_TIME]                            [int] NULL,
		[DURATION]                                [int] NULL,
		[RING_TIME]                               [int] NULL,
		[DELAY_TIME]                              [int] NULL,
		[ABANDON_TIME]                            [int] NULL,
		[HOLD_TIME]                               [int] NULL,
		[TALK_TIME]                               [int] NULL,
		[WORK_TIME]                               [int] NULL,
		[BILL_RATE]                               [int] NULL,
		[LOCAL_Q_TIME]                            [int] NULL,
		[CONFERENCE_TIME]                         [int] NULL,
		[SEGMENT_TIME]                            [int] NULL,
		[COST]                                    [smallmoney] NULL,
		[CUSTOM_MEASURE_0]                        [int] NULL,
		[CUSTOM_MEASURE_1]                        [int] NULL,
		[CUSTOM_MEASURE_2]                        [int] NULL,
		[CUSTOM_MEASURE_3]                        [int] NULL,
		[CUSTOM_MEASURE_4]                        [int] NULL,
		[CUSTOM_MEASURE_5]                        [int] NULL,
		[CUSTOM_MEASURE_6]                        [int] NULL,
		[CUSTOM_MEASURE_7]                        [int] NULL,
		[CUSTOM_MEASURE_8]                        [int] NULL,
		[CUSTOM_MEASURE_9]                        [int] NULL,
		[PARTITION_ID]                            [int] NOT NULL,
		[RECOVERY_KEY]                            [float] NULL,
		[PERSON_URN]                              [int] NULL,
		[DB_DATETIME]                             [datetime] NULL,
		[MEDIA_ROUTING_DOMAIN_URN]                [int] NULL,
		[ORIGINATING_AGENT_PERIPHERAL_NUMBER]     [nvarchar](32) COLLATE Latin1_General_CI_AS NULL,
		[CV1]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV2]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV3]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV4]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV5]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV6]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV7]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV8]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV9]                                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV10]                                    [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CED]                                     [varchar](30) COLLATE Latin1_General_CI_AS NULL,
		[CALL_KEY1]                               [int] NULL,
		[CALL_KEY2]                               [int] NULL,
		[PERIPHERAL_CALL_KEY]                     [int] NULL,
		[USER_TO_USER]                            [varchar](131) COLLATE Latin1_General_CI_AS NULL,
		[ICR_CALL_KEY]                            [int] NULL,
		[ICR_CALL_KEY_PARENT]                     [int] NULL,
		[ICR_CALL_KEY_CHILD]                      [int] NULL,
		[CALL_DISPOSITION_FLAG_CODE_URN]          [int] NULL,
		[APPLICATION_TASK_DISPOSITION]            [int] NULL,
		[APPLICATION_DATA]                        [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[NET_Q_TIME]                              [int] NULL,
		[SUPERVISOR_AGENT_URN]                    [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]                    [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                    [bigint] NOT NULL,
		[PRECISION_QUEUE_URN]                     [int] NOT NULL,
		[WRAP_CODE_1_URN]                         [int] NULL,
		[WRAP_CODE_2_URN]                         [int] NULL,
		[WRAP_CODE_3_URN]                         [int] NULL,
		[WRAP_CODE_4_URN]                         [int] NULL,
		[WRAP_CODE_5_URN]                         [int] NULL,
		[CALL_GUID]                               [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[CALL_REFERENCE_ID]                       [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[CALL_TYPE_REPORTING_DATE_TIME]           [datetime] NULL,
		[ENTERPRISE_QUEUE_DURATION]               [int] NULL,
		[LOCATION_PARAM_NAME]                     [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[LOCATION_PARAM_PK_ID]                    [varchar](128) COLLATE Latin1_General_CI_AS NULL,
		[NETWORK_SKILLGROUP_QUEUE_DURATION]       [int] NULL,
		[ORIGINATED]                              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[PSTN_TRUNK_GROUP_CHANNEL_NUMBER]         [int] NULL,
		[PSTN_TRUNK_GROUP_ID]                     [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[ROUTED_AGENT_URN]                        [int] NULL,
		[ROUTED_SERVICE_URN]                      [int] NULL,
		[ROUTED_SKILL_GROUP_URN]                  [int] NULL,
		[START_DATE_TIME_UTC]                     [datetime] NULL,
		[PROTOCOL_ID]                             [int] NULL,
		[ATTRIBUTES]                              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_0]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_0]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_1]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_1]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_2]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_2]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_3]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_3]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_4]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_4]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_5]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_5]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_6]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_6]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_7]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_7]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_8]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_8]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_ATTRIBUTE_URN_9]               [int] NULL,
		[PRECISION_ATTRIBUTE_VALUE_9]             [varchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PRECISION_QUEUE_STEP_ORDER]              [int] NULL
) ON [FCTICMGROUP]
GO
ALTER TABLE [dbo].[TB_FCT_CALL_DETAIL_END]
	ADD
	CONSTRAINT [DF_TB_FCT_CALL_DETAIL_END_PRECISION_QUEUE_URN]
	DEFAULT ((-1)) FOR [PRECISION_QUEUE_URN]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_AGENT_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_START_DATE_TIME]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([START_DATE_TIME])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_START_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_STARTDATE_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([STARTDATE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_STARTDATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_MULTIPLE]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([RECOVERY_KEY], [CALL_DETAIL_END_URN], [STARTDATE_URN], [STARTTIME_URN], [STARTDATE_UTC_URN], [STARTTIME_UTC_URN], [START_DATE_TIME], [START_UTC_TIMEZONE], [CALL_DETAIL_LEG_URN], [SEQUENCE_NUMBER], [NETWORK_TIME_TIMEBAND_URN], [DURATION_TIMEBAND_URN], [RING_TIME_TIMEBAND_URN], [DELAY_TIME_TIMEBAND_URN], [ABANDON_TIME_TIMEBAND_URN], [HOLD_TIME_TIMEBAND_URN])
	INCLUDE ([TALK_TIME_TIMEBAND_URN], [WORK_TIME_TIMEBAND_URN], [LOCAL_Q_TIME_TIMEBAND_URN], [CONFERENCE_TIME_TIMEBAND_URN], [SEGMENT_TIME_TIMEBAND_URN], [CALL_DETAIL_URN], [AGENT_TEAM_URN], [PERIPHERAL_URN], [AGENT_URN], [ORIGINATING_AGENT_URN], [SKILLGROUP_URN], [SERVICE_URN], [ROUTE_URN], [CALL_TYPE_URN], [TRUNK_GROUP_URN], [CLI_NNG_URN], [CLI_URN], [CALL_DISPOSITION_URN], [TASK_DISPOSITION_URN], [VALUE_URN], [SATISFACTION_URN], [RATING_PERIOD_URN], [PERIPHERAL_CALL_TYPE_URN], [CUSTOM_DIMENSION_0], [CUSTOM_DIMENSION_1], [CUSTOM_DIMENSION_2], [CUSTOM_DIMENSION_3], [CUSTOM_DIMENSION_4], [CUSTOM_DIMENSION_5], [CUSTOM_DIMENSION_6], [CUSTOM_DIMENSION_7], [CUSTOM_DIMENSION_8], [CUSTOM_DIMENSION_9], [DEVICE_NUMBER], [AGENT_PERIPHERAL_NUMBER], [PERIPHERAL_CALL_TYPE], [BAD_CALL], [CALL_PRIORITY], [NEW_TRANSACTION], [SERVICE_LEVEL_MET], [PERIPHERAL_TRUNK_NUMBER], [OUTBOUND_DIGITS], [CLI_STRING], [DIALED_NUMBER_TEXT], [WRAPUP_DATA], [NETWORK_TIME], [DURATION], [RING_TIME], [DELAY_TIME], [ABANDON_TIME], [HOLD_TIME], [TALK_TIME], [WORK_TIME], [BILL_RATE], [LOCAL_Q_TIME], [CONFERENCE_TIME], [SEGMENT_TIME], [COST], [CUSTOM_MEASURE_0], [CUSTOM_MEASURE_1], [CUSTOM_MEASURE_2], [CUSTOM_MEASURE_3], [CUSTOM_MEASURE_4], [CUSTOM_MEASURE_5], [CUSTOM_MEASURE_6], [CUSTOM_MEASURE_7], [CUSTOM_MEASURE_8], [CUSTOM_MEASURE_9], [PARTITION_ID], [PERSON_URN], [DB_DATETIME], [MEDIA_ROUTING_DOMAIN_URN], [ORIGINATING_AGENT_PERIPHERAL_NUMBER], [CV1], [CV2], [CV3], [CV4], [CV5], [CV6], [CV7], [CV8], [CV9], [CV10], [CED], [CALL_KEY1], [CALL_KEY2], [PERIPHERAL_CALL_KEY], [USER_TO_USER], [ICR_CALL_KEY], [ICR_CALL_KEY_PARENT], [ICR_CALL_KEY_CHILD], [CALL_DISPOSITION_FLAG_CODE_URN], [APPLICATION_TASK_DISPOSITION], [APPLICATION_DATA], [NET_Q_TIME], [SUPERVISOR_AGENT_URN], [CLUSTER_RESOURCE_URN], [PARTITION_GLOBAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_MULTIPLE'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_RECOVERY_KEY]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([RECOVERY_KEY])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_RECOVERY_KEY'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_CLUSTER_RESOURCE_URN_RECOVERY_KEY]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([CLUSTER_RESOURCE_URN], [RECOVERY_KEY])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_CLUSTER_RESOURCE_URN_RECOVERY_KEY'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_PARTITION_GLOBAL_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([PARTITION_GLOBAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_PARTITION_GLOBAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([AGENT_TEAM_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_PERIPHERAL_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([PERIPHERAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([SKILLGROUP_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_SERVICE_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([SERVICE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_SERVICE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_CALL_TYPE_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([CALL_TYPE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_CALL_TYPE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_PERIPHERAL_CALL_TYPE_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([PERIPHERAL_CALL_TYPE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_PERIPHERAL_CALL_TYPE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_END_PERSON_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_END] ([PERSON_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'INDEX', N'IX_FCT_CALL_DETAIL_END_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the for historical statistics of how calls were handled. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_CALL_DETAIL_END_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_CALL_DETAIL_END view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables are imported from t_Termination_Call_Detail(TCD) table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DETAIL_END_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when the call left a peripheral gateway. In case of Cisco ICM/IPCC this is calculated based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the date when the call left a peripheral gateway. In case of Cisco ICM/IPCC this is calculated based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the call left a peripheral gateway. In case of Cisco ICM/IPCC this is calculated based on the DateTime and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of the UTC date when the call left a peripheral gateway. In case of Cisco ICM/IPCC this is calculated based on the DateTime and TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the call left a peripheral gateway. In Cisco ICM/IPCC this column maps to DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC corresponding to the record. In case of Cisco ICM/IPCC this maps to the TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'START_UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DETAIL_LEG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column RouterCallKeySequenceNumber.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the NetworkTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'NETWORK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'NETWORK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the Duration column in Cisco ICM/IPCC. This corresponds to the duration of the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the RingTime column in Cisco ICM/IPCC. This corresponds to the duration for which the call was ringing at the aget''s terminal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'RING_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'RING_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the DelayTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DELAY_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DELAY_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the TimeToAband column in Cisco ICM/IPCC. This corresponds to the time range after which the call was abandoned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ABANDON_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ABANDON_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the HoldTime column in Cisco ICM/IPCC. This corresponds to the total duration range when the call was put on hold at the agent''s terminal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'HOLD_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'HOLD_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the TalkTime column in Cisco ICM/IPCC. This corresponds to the total duration range when the call was in talking state.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TALK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TALK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the WorkTime column in Cisco ICM/IPCC. This corresponds to the duration range for the total after call time associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WORK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WORK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the LocalQTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'LOCAL_Q_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'LOCAL_Q_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the ConferenceTime column in Cisco ICM/IPCC. This corresponds to the  duration range for the total conference time associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CONFERENCE_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CONFERENCE_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the CallSegmentTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SEGMENT_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SEGMENT_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the URN as in VW_PARTITIONED_FCT_CALL_DETAIL corresponding the RouterCallKey and RouterCallKeyDay pair in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DETAIL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT_TEAM corresponding to an item of type IT_AGENT_TEAM. This corresponds to the first agent team, which the agent belonged to at the time when the record was written into the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT for an item of type IT_AGENT. This corresponds to the agent who handled the call. In Cisco ICM/IPCC this is looked up or generated based on the AgentSkillTargetID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT for an item of type IT_AGENT. This corresponds to the agent who initiated the call. In Cisco ICM/IPCC this is looked up or generated based on the SourceAgentSkillTargetID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ORIGINATING_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ORIGINATING_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP. This corresponds to the skillgroup that handled the call. In Cisco ICM/IPCC this is looked up or generated based on the SkillGroupSkillTargetID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SERVICE for an item of type IT_SERVICE. This corresponds to the service that handled the call. In Cisco ICM/IPCC this is looked up or generated based on the ServiceSkillTargetID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SERVICE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SERVICE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SERVICE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_ROUTE for an item of type IT_ROUTE. This corresponds to the route where the call was sent. In Cisco ICM/IPCC this is looked up or generated based on the RouteID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ROUTE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ROUTE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ROUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CALL_TYPE for an item of type IT_CALL_TYPE. This corresponds to the call type associated with the call. In Cisco ICM/IPCC this is looked up or generated based on the CallTypeID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TRUNK_GROUP for an item of type IT_TRUNK_GROUP. This corresponds to the trunk group associated with the call. In Cisco ICM/IPCC this is looked up or generated based on the TrunkGroupID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TRUNK_GROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TRUNK_GROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TRUNK_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_NNG corresponding to the National number group associated with the ANI of the call. This is calculated based on ANI column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NNG', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CLI of type IT_CLI. This is calculated or generated based on the ANI string associated with the call in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CLI_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CLI', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_CALL_DISPOSITION. This is the final call disposition for the call. This is looked up based on CallDisposition column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DISPOSITION_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DISPOSITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TASK_DISPOSITION_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TASK_DISPOSITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'VALUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'VALUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SATISFACTION_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SATISFACTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_RATING_PERIOD of type IT_RATING_PERIOD. This is calculated based on the DateTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_RATING_PERIOD', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_PERIPHERAL of type IT_PERIPHERAL_CALL_TYPE. This corresponds to the type of call reported by the peripheral. In Cisco ICM/IPCC this is calculated based on the column PeripheralCallType.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the instrument number or the extension number of the device that handled the call. In Cisco ICM/IPCC this maps to InstrumentPortNumber column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DEVICE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the peripheral number of the agent who initiated the call. In Cisco ICM/IPCC this maps to AgentPeripheralNumber column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'AGENT_PERIPHERAL_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the type of call reported by the peripheral. In Cisco ICM/IPCC this is maps to PeripheralCallType column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_CALL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating whether the call was taged as a bad call. In Cisco ICM/IPCC this maps to BadCallTag column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'BAD_CALL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the Priority column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_PRIORITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates whether the call has been re-classified. This maps to the NewTransacion column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'NEW_TRANSACTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating whether the call was answered within the service level limit. In Cisco ICM/IPCC this maps to AnsweredWithinServiceLevel column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SERVICE_LEVEL_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the Trunk column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_TRUNK_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the digits dialed for an outbound call initiated. In Cisco ICM/IPCC this maps to DigitsDialed column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'OUTBOUND_DIGITS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ANI column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CLI_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the DNIS column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DIALED_NUMBER_TEXT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the WrapupData column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WRAPUP_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this maps to NetworkTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'NETWORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total duration of the call in seconds. In Cisco ICM/IPCC this maps to Duration column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when the call was ringing at the agent''s terminal. In Cisco ICM/IPCC this maps to RingTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total delay time, in seconds, associated with the call. In Cisco ICM/IPCC this maps to DelayTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DELAY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, after which the call was abandoned. In Cisco ICM/IPCC this maps to TimeToAband column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ABANDON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when the call was put on hold. In Cisco ICM/IPCC this maps to HoldTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when the call was in talking state. In Cisco ICM/IPCC this maps to TalkTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, for the after call work time associated with the call. In Cisco ICM/IPCC this maps to WorkTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this maps to BillRate column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'BILL_RATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this maps to LocalQTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'LOCAL_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, when the call was in confernce. In Cisco ICM/IPCC this maps to ConferenceTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CONFERENCE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the system took to segment the call. In Cisco ICM/IPCC this maps to CallSegmentTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SEGMENT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'COST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERSON corresponding to an item of type IT_PERSON. This corresponds to the person associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in Cisco ICM/IPCC', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_MEDIA_ROUTING_DOMAIN of type IT_MEDIA_ROUTING_DOMAIN corresponding to the media routing domain associated with the record. This is looked up or generated based on MRDomainID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Peripheral number of agent that initiated the call. In Cisco ICM/IPCC this maps to SourceAgentPeripheralNumber column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ORIGINATING_AGENT_PERIPHERAL_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable1 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable2 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable3 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable4 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable5 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable6 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable7 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable8 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable9 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable10 in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CV10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the caller entered digits associated with the call. In Cisco ICM/IPCC this column corresponds to the column CED in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column RouterCallKeyDay in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column RouterCallKey in the table t_Termination_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the PeripheralCallKey column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PERIPHERAL_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the UserToUser column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'USER_TO_USER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ICRCallKey column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ICR_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ICRCallKeyParent column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ICR_CALL_KEY_PARENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ICRCallKeyChild column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ICR_CALL_KEY_CHILD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the CallDispositionFlag column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DISPOSITION_FLAG_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_DISPOSITION_FLAG_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ApplicationTaskDisposition column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'APPLICATION_TASK_DISPOSITION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ApplicationData column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'APPLICATION_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the NetQTime column in the t_Termination_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'NET_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the supervisor agent of the team where the agent in the record is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PRECISION_QUEUE corresponding to an item of type IT_PRECISION_QUEUE. This corresponds to the precision queue associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the wrap-up associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WRAP_CODE_1_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the wrap-up associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WRAP_CODE_2_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the wrap-up associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WRAP_CODE_3_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the wrap-up associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WRAP_CODE_4_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the wrap-up associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'WRAP_CODE_5_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Globally unique call identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_GUID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value uniquely identify the instance of a call in a Unified CM cluster', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_REFERENCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value indicates interval date time that Router used TCD record to calculate Call Type related historical data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'CALL_TYPE_REPORTING_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the amount of time spent by the call in the queue, on the parent Unified CCE system in CVP/another network queuing platform. The EnterpriseQueueTime does not factor into the AnswerWaitTime or Service Level computations on the child system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ENTERPRISE_QUEUE_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Location name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'LOCATION_PARAM_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Globally unique location identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'LOCATION_PARAM_PK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Represents the time the call is queued for the skill group indentified by the RoutedSkillGroupSkillTargetID field in the network VRU. It is the time when the call is queued to the specific skill group until the call is routed by the routed. The router resets the time when the call is requeried.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'NETWORK_SKILLGROUP_QUEUE_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates which Unified CCE component initiates the call. ''D'' - originated from Dialer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ORIGINATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Trunk Group Channel Number on which the call arrived on the IOS Gateway', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PSTN_TRUNK_GROUP_CHANNEL_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Trunk Group ID on which the call arrived on the IOS Gateway', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PSTN_TRUNK_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the urn on the ICM of the agent that the call was routed to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ROUTED_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the urn on the ICM of the service that the call was routed to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ROUTED_SERVICE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the urn on the ICM of the skill group that the call was routed to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ROUTED_SKILL_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date/time in UTC that the call was first seen at the Peripheral Gateway (PG), e.g. ingress call arrival, agent initiated call, new call resulting from a call transfer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Internal reference ID used to identify the component class (PBX/VRU/ACD) The possible values are: NULL for all TCDs prior 8.x, 0 = LEGACY_TDM, 1 = JTAPI, 2 = GED125_CVP, 3 = GED125_IPIVR, 4 = GED125_OTHER, 5 = GED188_ACMI_CCX, 6 = GED188_ACMI_CCE, 7 = GED188_ACMI_EXPERT_ADVISOR, 8 = GED188_ACMI_ERS, 9 = ARI, 10 = MEDIA_ROUTING, 11 = Other.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PROTOCOL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML formatted string containing agent attributes 1 through 10 and corresponding values. It is possible that the XML document may overflow the NVARCHAR 255 definition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'ATTRIBUTES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A1></A1>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V1></V1>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A2></A2>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V2></V2>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A3></A3>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V3></V3>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A4></A4>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V4></V4>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A5></A5>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V5></V5>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A6></A6>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V6></V6>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A7></A7>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V7></V7>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A8></A8>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V8></V8>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A9></A9>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V9></V9>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <A10></A10>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Extracted from the Attributes XML string, representing the value of <V10></V10>.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_ATTRIBUTE_VALUE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Integer that defines the order of rows for a Precision Queue Step.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_END', 'COLUMN', N'PRECISION_QUEUE_STEP_ORDER'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALL_DETAIL_END]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CALL_DETAIL_END]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALL_DETAIL_END]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CALL_DETAIL_END] SET (LOCK_ESCALATION = TABLE)
GO
