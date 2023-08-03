SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CALL_DETAIL_LEG] (
		[CALL_DETAIL_LEG_URN]             [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[STARTDATE_URN]                   [int] NOT NULL,
		[STARTTIME_URN]                   [smallint] NOT NULL,
		[STARTDATE_UTC_URN]               [int] NOT NULL,
		[STARTTIME_UTC_URN]               [smallint] NOT NULL,
		[START_DATE_TIME]                 [datetime] NOT NULL,
		[START_UTC_TIMEZONE]              [int] NOT NULL,
		[CALL_DETAIL_URN]                 [bigint] NULL,
		[SEQUENCE_NUMBER]                 [int] NULL,
		[DURATION_TIMEBAND_URN]           [int] NULL,
		[SEGMENT_TIME_TIMEBAND_URN]       [int] NULL,
		[NETWORK_Q_TIME_TIMEBAND_URN]     [int] NULL,
		[IVR_TALK_TIME_TIMEBAND_URN]      [int] NULL,
		[DIALED_NUMBER_URN]               [int] NOT NULL,
		[SCRIPT_URN]                      [int] NOT NULL,
		[CALL_OUTCOME_URN]                [int] NOT NULL,
		[ROUTE_URN]                       [int] NOT NULL,
		[LABEL_URN]                       [int] NOT NULL,
		[FINAL_LABEL_URN]                 [int] NOT NULL,
		[CALL_TYPE_URN]                   [int] NOT NULL,
		[CLI_NNG_URN]                     [int] NOT NULL,
		[CLI_URN]                         [int] NOT NULL,
		[VALUE_URN]                       [int] NOT NULL,
		[SATISFACTION_URN]                [int] NOT NULL,
		[RATING_PERIOD_URN]               [int] NOT NULL,
		[CHARGEBAND_URN]                  [int] NOT NULL,
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
		[FINAL_SCRIPT_NODE]               [int] NULL,
		[SOURCE_ERROR_CODE]               [int] NULL,
		[DURATION]                        [int] NULL,
		[SEGMENT_TIME]                    [int] NULL,
		[NETWORK_Q_TIME]                  [int] NULL,
		[SCRIPT_COUNT]                    [int] NULL,
		[IVR_TALK_TIME]                   [float] NULL,
		[COST]                            [smallmoney] NULL,
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
		[CLI_STRING]                      [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[RECOVERY_KEY]                    [float] NULL,
		[DB_DATETIME]                     [datetime] NULL,
		[MEDIA_ROUTING_DOMAIN_URN]        [int] NULL,
		[REQUEST_TYPE_URN]                [int] NULL,
		[ORIGINATOR_TYPE_URN]             [int] NULL,
		[TARGET_TYPE_URN]                 [int] NULL,
		[MESSAGE_ORIGIN_URN]              [int] NULL,
		[ROUTING_CLIENT_URN]              [int] NULL,
		[ROUTER_Q_TIME]                   [int] NULL,
		[ORIGINATOR]                      [varchar](8) COLLATE Latin1_General_CI_AS NULL,
		[CV1]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV2]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV3]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV4]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV5]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV6]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV7]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV8]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV9]                             [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV10]                            [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CED]                             [varchar](30) COLLATE Latin1_General_CI_AS NULL,
		[CALL_KEY1]                       [int] NULL,
		[CALL_KEY2]                       [int] NULL,
		[USER_TO_USER]                    [varchar](131) COLLATE Latin1_General_CI_AS NULL,
		[PRIORITY]                        [smallint] NULL,
		[ROUTING_CLIENT_CALL_KEY]         [int] NULL,
		[CDPD]                            [varchar](30) COLLATE Latin1_General_CI_AS NULL,
		[TARGET_LABEL]                    [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[DIALED_NUMBER_STRING]            [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[BEGAN_ROUTING_DATE_TIME]         [datetime] NULL,
		[BEGAN_CALL_TYPE_DATE_TIME]       [datetime] NULL,
		[REQUERY_RESULT]                  [int] NULL,
		[VRU_PROGRESS]                    [int] NULL,
		[LABEL]                           [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[CLUSTER_RESOURCE_URN]            [int] NOT NULL,
		[APPLICATION_GATEWAY_ID]          [int] NOT NULL,
		[CONTACT_SHARE_ERROR_CODE]        [int] NULL,
		[CONTACT_SHARE_GROUP_ID]          [int] NOT NULL,
		[CONTACT_SHARE_QUEUE_ID]          [int] NOT NULL,
		[CONTACT_SHARE_RESULT]            [float] NULL,
		[CONTACT_SHARE_RULE_ID]           [int] NOT NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_LEG_STARTDATE_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG] ([STARTDATE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'INDEX', N'IX_FCT_CALL_DETAIL_LEG_STARTDATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_LEG_DIALED_NUMBER_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG] ([DIALED_NUMBER_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'INDEX', N'IX_FCT_CALL_DETAIL_LEG_DIALED_NUMBER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_LEG_CALL_TYPE_URN]
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG] ([CALL_TYPE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'INDEX', N'IX_FCT_CALL_DETAIL_LEG_CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the for historical statistics of routing request associated with calls. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_CALL_DETAIL_LEG_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_CALL_DETAIL_LEG view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables are imported from t_Route_Call_Detail(RCD) table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_DETAIL_LEG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when the call was routed. In case of Cisco ICM/IPCC this is calculated based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the date when the call was routed. In case of Cisco ICM/IPCC this is calculated based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the call was routed. In case of Cisco ICM/IPCC this is calculated based on the DateTime and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of the UTC date when the call was routed. In case of Cisco ICM/IPCC this is calculated based on the DateTime and TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the call was routed. In Cisco ICM/IPCC this column maps to DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC corresponding to the record. In case of Cisco ICM/IPCC this maps to the TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'START_UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the URN as in VW_PARTITIONED_FCT_CALL_DETAIL corresponding the RouterCallKey and RouterCallKeyDay pair in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_DETAIL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column RouterCallKeySequenceNumber.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the duration of the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the CallSegmentTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SEGMENT_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SEGMENT_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for the NetQTime column in Cisco ICM/IPCC. This corresponds to the duration range for the total time the call spent in the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'NETWORK_Q_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'NETWORK_Q_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is the URN as in TB_DIM_TIMEBAND for an item of type IT_TIMEBAND corresponding to the timeband for duration when the call was on the IVR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'IVR_TALK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'IVR_TALK_TIME_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER of type IT_DIALED_NUMBER. This corresponds to the dialed number associated with the call. This is looked up or generated based on DialedNumberID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SCRIPT of type IT_SCRIPT. This corresponds to the script used to route the call. This is looked up or generated based on ScriptID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_OUTCOME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_OUTCOME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_ROUTE of type IT_ROUTE. This corresponds to the route where the call was sent. This is looked up or generated based on RouteID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ROUTE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ROUTE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ROUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_LABEL of type IT_LABEL. This corresponds to the label that was passed to the routing client. This is looked up or generated based on LableID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'LABEL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_LABEL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'LABEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_LABEL of type IT_LABEL. This corresponds to the target label associated with the call. This is looked up or generated based on TargetLabelID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'FINAL_LABEL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_LABEL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'FINAL_LABEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CALL_TYPE of type IT_CALL_TYPE. This corresponds to the call type associated with the call.. This is looked up or generated based on CallTypeID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_NNG corresponding to the National number group associated with the ANI of the call. This is calculated based on ANI column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NNG', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CLI_NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CLI of type IT_CLI. This is calculated or generated based on the ANI string associated with the call in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CLI_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CLI', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CLI_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'VALUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'VALUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SATISFACTION_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SATISFACTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_RATING_PERIOD of type IT_RATING_PERIOD. This is calculated based on the DateTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_RATING_PERIOD', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CHARGEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CHARGEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CHARGEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the FinalObjectID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'FINAL_SCRIPT_NODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the RouterErrorCode column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SOURCE_ERROR_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the system took to segment the call. In Cisco ICM/IPCC this maps to CallSegmentTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SEGMENT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the call spent in the network queue. In Cisco ICM/IPCC this maps to NetQTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'NETWORK_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of script nodes the call encountered. In Cisco ICM/IPCC this maps to the VruScripts column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'SCRIPT_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'IVR_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'COST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the Caller line identification string associated with the call. In Cisco ICM/IPCC this maps to ANI column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CLI_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in Cisco ICM/IPCC', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_MEDIA_ROUTING_DOMAIN of type IT_MEDIA_ROUTING_DOMAIN corresponding to the media routing domain associated with the record. This is looked up or generated based on MRDomainID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_REQUEST_TYPE corresponding to the request type associated with the call. This is looked up based on RequestType column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'REQUEST_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_ORIGINATOR_TYPE corresponding to the originator type associated with the call. This is looked up based on OriginatorType column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ORIGINATOR_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ORIGINATOR_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_TARGET_TYPE corresponding to the execution result of the script associated with the call. This is looked up based on TargetType column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'TARGET_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'TARGET_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_MESSAGE_ORIGIN corresponding to the originator of the request. This is looked up based on MsgOrigin column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'MESSAGE_ORIGIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'MESSAGE_ORIGIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_ROUTING_CLIENT of type IT_ROUTING_CLIENT corresponding to the routing client associated with the record. This is looked up or generated based on RoutingClientID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ROUTING_CLIENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ROUTING_CLIENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ROUTING_CLIENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, that the call was held in the CallRouter queue. In Cisco ICM/IPCC this maps to RouterQueueTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ROUTER_Q_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the origin of the route request. In Cisco ICM/IPCC this maps to Originator column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ORIGINATOR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable1 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable2 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable3 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable4 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable5 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable6 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable7 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable8 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable9 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column Variable10 in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CV10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the called entered digits associated with the call. In Cisco ICM/IPCC this column corresponds to the column CED in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column RouterCallKeyDay in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Cisco ICM/IPCC this column corresponds to the column RouterCallKey in the table t_Route_Call_Detail table corresponding to the call record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the UserToUser column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'USER_TO_USER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the Priority column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'PRIORITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the RoutingClientCallKey column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'ROUTING_CLIENT_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the CDPD column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CDPD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the TargetLabel column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'TARGET_LABEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the DialedNumberString column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'DIALED_NUMBER_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the BeganRoutingDateTime column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'BEGAN_ROUTING_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the BeganCallTypeDateTime column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'BEGAN_CALL_TYPE_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the RequeryResult column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'REQUERY_RESULT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the VruProgress column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'VRU_PROGRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the Label column in the t_Route_Call_Detail table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'LABEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'APPLICATION_GATEWAY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CONTACT_SHARE_ERROR_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CONTACT_SHARE_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CONTACT_SHARE_QUEUE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CONTACT_SHARE_RESULT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG', 'COLUMN', N'CONTACT_SHARE_RULE_ID'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CALL_DETAIL_LEG] SET (LOCK_ESCALATION = TABLE)
GO
