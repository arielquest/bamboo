SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_DIALER_DETAIL] (
		[PARTITION_URN]                              [int] NOT NULL,
		[PARTITION_ID]                               [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                       [bigint] NOT NULL,
		[DATE_UTC_URN]                               [int] NOT NULL,
		[TIME_UTC_URN]                               [smallint] NOT NULL,
		[UTC_DATE_TIME]                              [datetime] NOT NULL,
		[UTC_TIMEZONE]                               [int] NOT NULL,
		[AGENT_URN]                                  [int] NOT NULL,
		[CAMPAIGN_URN]                               [int] NOT NULL,
		[DIALER_URN]                                 [int] NOT NULL,
		[PERIPHERAL_URN]                             [int] NOT NULL,
		[QUERY_RULE_URN]                             [int] NOT NULL,
		[SKILLGROUP_URN]                             [int] NOT NULL,
		[AGENT_TEAM_URN]                             [int] NOT NULL,
		[PERSON_URN]                                 [int] NOT NULL,
		[CALL_RESULT_CODE_URN]                       [int] NOT NULL,
		[CALL_STATUS_ZONE_1_CODE_URN]                [int] NOT NULL,
		[CALL_STATUS_ZONE_2_CODE_URN]                [int] NOT NULL,
		[DIALING_MODE_CODE_URN]                      [int] NOT NULL,
		[PROTOCOL_ID_CODE_URN]                       [int] NOT NULL,
		[ACCOUNT_NUMBER]                             [varchar](128) COLLATE Latin1_General_CI_AS NULL,
		[ACTIVE_THRESHOLD]                           [int] NULL,
		[AGENT_PERIPHERAL_NUMBER]                    [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[CALLBACK_PHONE]                             [varchar](20) COLLATE Latin1_General_CI_AS NULL,
		[CALLBACK_DATE_TIME]                         [datetime] NULL,
		[CALL_DURATION]                              [int] NULL,
		[CALL_GUID]                                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CALL_RESULT]                                [int] NULL,
		[CALL_RESULT_DETAIL]                         [int] NULL,
		[CALL_STATUS_ZONE_1]                         [varchar](1) COLLATE Latin1_General_CI_AS NULL,
		[CALL_STATUS_ZONE_2]                         [varchar](1) COLLATE Latin1_General_CI_AS NULL,
		[CAMPAIGN_REPORTING_DATE_TIME]               [datetime] NULL,
		[DB_DATE_TIME]                               [datetime] NULL,
		[DIALING_LIST_ID]                            [int] NULL,
		[DIALING_MODE]                               [int] NULL,
		[FIRST_NAME]                                 [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[FUTURE_USE_INT_1]                           [int] NULL,
		[FUTURE_USE_INT_2]                           [int] NULL,
		[FUTURE_USE_INT_3]                           [int] NULL,
		[FUTURE_USE_INT_4]                           [int] NULL,
		[FUTURE_USE_INT_5]                           [int] NULL,
		[FUTURE_USE_INT_6]                           [int] NULL,
		[FUTURE_USE_INT_7]                           [int] NULL,
		[FUTURE_USE_INT_8]                           [int] NULL,
		[FUTURE_USE_VARCHAR_1]                       [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[FUTURE_USE_VARCHAR_2]                       [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[FUTURE_USE_VARCHAR_3]                       [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[FUTURE_USE_VARCHAR_4]                       [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[IMPORT_RULE_DATE_TIME]                      [datetime] NULL,
		[INTERNAL_USE_1]                             [int] NULL,
		[INTERNAL_USE_2]                             [int] NULL,
		[INTERNAL_USE_3]                             [int] NULL,
		[INTERNAL_USE_4]                             [int] NULL,
		[INTERNAL_USE_5]                             [int] NULL,
		[INTERNAL_USE_6]                             [int] NULL,
		[INTERNAL_USE_7]                             [int] NULL,
		[INTERNAL_USE_8]                             [int] NULL,
		[INTERNAL_USE_9]                             [int] NULL,
		[INTERNAL_USE_10]                            [int] NULL,
		[INTERNAL_USE_11]                            [int] NULL,
		[LAST_NAME]                                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[MAX_ACTIVE_GLITCH_TIME]                     [int] NULL,
		[MAX_POST_SPEECH_SILENCE_GLITCH_TIME]        [int] NULL,
		[MAX_ZCR_ST_DEV]                             [int] NULL,
		[NOISE_THRESHOLD]                            [int] NULL,
		[NUMBER_OF_ACTIVE_GLITCHES]                  [int] NULL,
		[NUMBER_OF_POST_SPEECH_SILENCE_GLITCHES]     [int] NULL,
		[PERIPHERAL_CALL_KEY]                        [int] NULL,
		[PHONE]                                      [varchar](20) COLLATE Latin1_General_CI_AS NULL,
		[PHONE_EXTENSION]                            [varchar](8) COLLATE Latin1_General_CI_AS NULL,
		[PHONE_ID]                                   [int] NULL,
		[PHONE_INDEX]                                [int] NULL,
		[PICKUP_TIME]                                [int] NULL,
		[PORT_NUMBER]                                [int] NULL,
		[PREVIEW_TIME]                               [int] NULL,
		[PROTOCOL_ID]                                [int] NULL,
		[RECOVERY_KEY]                               [float] NOT NULL,
		[RESERVATION_CALL_DURATION]                  [int] NULL,
		[ROUTER_CALL_KEY]                            [int] NULL,
		[ROUTER_CALL_KEY_DAY]                        [int] NULL,
		[SILENCE_PERIOD]                             [int] NULL,
		[TERM_TONE_DETECTION_TIME]                   [int] NULL,
		[VALID_SPEECH_TIME]                          [int] NULL,
		[WRAPUP_DATA]                                [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[ZONE_INDEX]                                 [tinyint] NULL,
		[CUSTOM0_URN]                                [int] NOT NULL,
		[CUSTOM1_URN]                                [int] NOT NULL,
		[CUSTOM2_URN]                                [int] NOT NULL,
		[CUSTOM3_URN]                                [int] NOT NULL,
		[CUSTOM4_URN]                                [int] NOT NULL,
		[CUSTOM5_URN]                                [int] NOT NULL,
		[CUSTOM6_URN]                                [int] NOT NULL,
		[CUSTOM7_URN]                                [int] NOT NULL,
		[CUSTOM8_URN]                                [int] NOT NULL,
		[CUSTOM9_URN]                                [int] NOT NULL,
		[CUSTOM_INT_MEASURE_0]                       [int] NOT NULL,
		[CUSTOM_INT_MEASURE_1]                       [int] NOT NULL,
		[CUSTOM_INT_MEASURE_2]                       [int] NOT NULL,
		[CUSTOM_INT_MEASURE_3]                       [int] NOT NULL,
		[CUSTOM_INT_MEASURE_4]                       [int] NOT NULL,
		[CUSTOM_BIGINT_MEASURE_0]                    [bigint] NOT NULL,
		[CUSTOM_BIGINT_MEASURE_1]                    [bigint] NOT NULL,
		[CUSTOM_BIGINT_MEASURE_2]                    [bigint] NOT NULL,
		[CUSTOM_FLOAT_MEASURE_0]                     [float] NOT NULL,
		[CUSTOM_FLOAT_MEASURE_1]                     [float] NOT NULL,
		[CUSTOM_FLOAT_MEASURE_2]                     [float] NOT NULL,
		[CUSTOM_VARCHAR_MEASURE_0]                   [varchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CUSTOM_VARCHAR_MEASURE_1]                   [varchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CUSTOM_VARCHAR_MEASURE_2]                   [varchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CLUSTER_RESOURCE_URN]                       [int] NOT NULL,
		[CUSTOMER_TIMEZONE]                          [int] NULL,
		[IDLE_TIME]                                  [int] NULL,
		[CUSTOM_DIMENSION_0]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                         [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                         [int] NOT NULL,
		[CUSTOM_MEASURE_0]                           [int] NULL,
		[CUSTOM_MEASURE_1]                           [int] NULL,
		[CUSTOM_MEASURE_2]                           [int] NULL,
		[CUSTOM_MEASURE_3]                           [int] NULL,
		[CUSTOM_MEASURE_4]                           [int] NULL,
		[CUSTOM_MEASURE_5]                           [int] NULL,
		[CUSTOM_MEASURE_6]                           [int] NULL,
		[CUSTOM_MEASURE_7]                           [int] NULL,
		[CUSTOM_MEASURE_8]                           [int] NULL,
		[CUSTOM_MEASURE_9]                           [int] NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([AGENT_TEAM_URN])
	INCLUDE ([UTC_DATE_TIME], [ACTIVE_THRESHOLD], [AGENT_PERIPHERAL_NUMBER], [CALLBACK_PHONE], [CALLBACK_DATE_TIME], [CALL_DURATION], [CALL_RESULT], [CALL_STATUS_ZONE_1], [CALL_STATUS_ZONE_2], [DB_DATE_TIME], [DIALING_MODE], [MAX_ACTIVE_GLITCH_TIME], [MAX_POST_SPEECH_SILENCE_GLITCH_TIME], [MAX_ZCR_ST_DEV], [NOISE_THRESHOLD], [NUMBER_OF_ACTIVE_GLITCHES], [NUMBER_OF_POST_SPEECH_SILENCE_GLITCHES], [PHONE], [PICKUP_TIME], [PREVIEW_TIME], [PROTOCOL_ID], [RECOVERY_KEY], [RESERVATION_CALL_DURATION], [ROUTER_CALL_KEY], [ROUTER_CALL_KEY_DAY], [SILENCE_PERIOD], [TERM_TONE_DETECTION_TIME], [VALID_SPEECH_TIME], [WRAPUP_DATA])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_CAMPAIGN_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([CAMPAIGN_URN])
	INCLUDE ([UTC_DATE_TIME], [AGENT_URN], [QUERY_RULE_URN], [SKILLGROUP_URN], [AGENT_TEAM_URN], [PERSON_URN], [ACTIVE_THRESHOLD], [AGENT_PERIPHERAL_NUMBER], [CALLBACK_PHONE], [CALLBACK_DATE_TIME], [CALL_DURATION], [CALL_RESULT], [CALL_STATUS_ZONE_1], [CALL_STATUS_ZONE_2], [DB_DATE_TIME], [DIALING_MODE], [FIRST_NAME], [LAST_NAME], [MAX_ACTIVE_GLITCH_TIME], [MAX_POST_SPEECH_SILENCE_GLITCH_TIME], [MAX_ZCR_ST_DEV], [NOISE_THRESHOLD], [NUMBER_OF_ACTIVE_GLITCHES], [NUMBER_OF_POST_SPEECH_SILENCE_GLITCHES], [PHONE], [PICKUP_TIME], [PREVIEW_TIME], [PROTOCOL_ID], [RECOVERY_KEY], [RESERVATION_CALL_DURATION], [ROUTER_CALL_KEY], [ROUTER_CALL_KEY_DAY], [SILENCE_PERIOD], [TERM_TONE_DETECTION_TIME], [VALID_SPEECH_TIME], [WRAPUP_DATA])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_CAMPAIGN_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_UTC_DATE_TIME]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([UTC_DATE_TIME])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_UTC_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_DIALER_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([DIALER_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_DIALER_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_PERIPHERAL_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([PERIPHERAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([PERSON_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_QUERY_RULE_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([QUERY_RULE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_QUERY_RULE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_DIALER_DETAIL_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_DIALER_DETAIL] ([SKILLGROUP_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'INDEX', N'IX_FCT_DIALER_DETAIL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics for all the Dialer in the application. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_DIALER_DETAIL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_DIALER_DETAIL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Dialer_Dialer table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the corresponding Mediator package based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the corresponding Mediator package based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC date and time at the start of the interval when the row was generated. This maps to the DateTime field in the DialerDetail table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC. This value is the value from the TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT corresponding to the Agent associated with this record. The Dialer_Detail.AgentPeripheralNumber is looked up within the Mediator package against the corresponding ICM/UCCE instance. If the lookup does not return any results this field is set to -1.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CAMPAIGN corresponding to the campaign associated with this record. This maps to the CampaignID field in the DialerDetail table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CAMPAIGN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALER corresponding to the Agent associated with this record. This maps to the DialerID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DIALER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DIALER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_PERIPHERAL corresponding to the Agent associated with this record. This maps to the PeripheralID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_QUERY_RULE corresponding to the query rule associated with the record. This maps to QueryRuleID field in the DialerDetail table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'QUERY_RULE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUERY_RULE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'QUERY_RULE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SKILLGROUP corresponding to the skillgroup associated with the record. This maps to SkillgroupSkillTargetID field in the DialerDetail table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT_TEAM corresponding to the agent team associated with the record. This is looked up based on the Agent and the datetime associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_PERSON corresponding to the person associated with the record. This is looked up based on the Agent and the datetime associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Telephony call result (busy no answer and so forth) or agent reservation attempt result (Agent Rejected Call Unable to reserve CallResult nd so forth', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_RESULT_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future Use. The Dialer_Detail.CallStatusZone1 is looked up during import against the corresponding ICM/UCCE instance. If the lookup does not return any results this field is set to -1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_STATUS_ZONE_1_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. The Dialer_Detail.CallStatusZone2 is looked up during against the corresponding ICM/UCCE instance. If the lookup does not return any results this field is set to -1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_STATUS_ZONE_2_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. The Dialer_Detail.DialingMode is looked up during import against the corresponding ICM/UCCE instance. If the lookup does not return any results this field is set to -1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DIALING_MODE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. The Dialer_Detail.ProtocolID is looked up during import against the corresponding ICM/UCCE instance. If the lookup does not return any results this field is set to -1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PROTOCOL_ID_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer account number. This maps to the AccountNumber field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'ACCOUNT_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The actually calculated active threshold during the period for computing the noise floor. This maps to the ActiveThreshold field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'ACTIVE_THRESHOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'PeripheralNumber / AgentID of the Agent that handled the call. This maps to the AgentPeripheralNumber field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'AGENT_PERIPHERAL_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The phone number at which the customer requested to be called back. This field remains populated with customer-requested CallbackPhone callback numbers for all personal callback calls or regular callback calls. This maps to the CallbackPhone  field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALLBACK_PHONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'PeripheralNumber / AgentID of the Agent that handled the call. This maps to the CallbackDateTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALLBACK_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Reserved for future use. This maps to the CallDuration field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An identifier assigned to the call by the SIP Dialer. This maps to the CallGUID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_GUID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Telephony call result (busy - no answer and so forth) or agent reservation attempt result (Agent Rejected Call Unable to reserve CallResult and so forth). This maps to the CallResult  field in the CallGUID table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_RESULT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Reserved for future use. This maps to the CallResultDetail field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_RESULT_DETAIL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Current status of the customer record for Zone1. This maps to the CallStatusZone1 field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_STATUS_ZONE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Current status of the customer record for Zone1. This maps to the CallStatusZone2 field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CALL_STATUS_ZONE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value indicates interval date time that Router used TCD record to calculate Call Type related historical data. This maps to the CampaignReportingDateTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CAMPAIGN_REPORTING_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The current date and time stamp when the records are written to the HDS database. The logger database has NULL for this column. This maps to the DbDateTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DB_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique identifier from the dialing list (DL_<CampaignID>_<QueryRuleID>) table in the outbound database. If the attempt is a Personal Callback then this unique identifier refers to the PersonalCallbackListID field in the Personal_Callback_List table in the outbound database. This maps to the DialingListID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DIALING_LIST_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Campaign mode the call was called. This maps to the DialingMode field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'DIALING_MODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'First name of the contact. This maps to the FirstName field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FIRST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt1 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt2 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt3 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt4 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt5 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt6 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt7 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseInt8 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_INT_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseVarChar1 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_VARCHAR_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseVarChar2 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_VARCHAR_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseVarChar3 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_VARCHAR_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to FutureUseVarChar4 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'FUTURE_USE_VARCHAR_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Unified ICM Central Controller date and time when the record was imported. This maps to the ImportRuleDateTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'IMPORT_RULE_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse1 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse2 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse3 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse4 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse5 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse6 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse7 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse8 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse9 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse10 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This maps to InternalUse11 field in the DialerDetail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'INTERNAL_USE_11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Last name of the contact. This maps to the LastName field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'LAST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum amount of time that signal is detected as active glitch (in mS). This maps to the MaxActiveGlitchTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'MAX_ACTIVE_GLITCH_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum amount of time that signal is detected as post speech silence glitch (in mS). This maps to the MaxActiveGlitchTimeMaximum field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'MAX_POST_SPEECH_SILENCE_GLITCH_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum ZCR standard deviation during the tone determination. This maps to the MaxZCRstdev field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'MAX_ZCR_ST_DEV'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The actually calculated noise threshold during the period for computing the noise floor. This maps to the NoiseThreshold field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'NOISE_THRESHOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total numbers of active glitches before a speech energy is detected or during the CPAMaxTermToneAnalysis period. This maps to the NumOfActiveGlitches field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'NUMBER_OF_ACTIVE_GLITCHES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total numbers of post speech silence glitches. This maps to the NumOfPostSpeechSilenceGlitches field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'NUMBER_OF_POST_SPEECH_SILENCE_GLITCHES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An identifier for the call that is provided by Unified CM and is unique to the Unified CM cluster. This maps to the PeripheralCallKey field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PERIPHERAL_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Phone number that was called. This maps to the Phone field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PHONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Phone extension that was imported. This maps to the PhoneExt field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PHONE_EXTENSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identifier of the phone that was dialed. This value can be any of phones 1 through 10. This field should be NULL for both Personal Callback calls and Regular Callback calls. This maps to the PhoneID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PHONE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identifier of the phone that was dialed. This value can be any of phones 1 through 10. This field should be NULL for both Personal Callback calls and Regular Callback calls. This maps to the PhoneID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PHONE_INDEX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time period the first active voice energy is detected after the customer answered the call (in millseconds). This maps to the PickupTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PICKUP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Reserved for future use. This maps to the PortNumber field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PORT_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time that the agent took to accept or skip or reject a customer call when the skill group is in preview mode and direct preview mode. This maps to the PreviewTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PREVIEW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Internal reference ID used to identify the component class (PBX/VRU/ACD). This maps to the ProtocolID field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'PROTOCOL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A unique ID assigned to each record and used internally by the Unified ICM/Unified CCE software to track the record. This maps to the RecoveryKey field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The call duration (in milliseconds) that agent was reserved. In preview mode this value includes the time of the last preview and the time the Dialer spends dialing performing CPA and transferring the customer call to the agent.. This maps to the ReservationCallDuration field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'RESERVATION_CALL_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A call key counter created and set by the system software. This value forms the unique portion of the 64-bit key for the call. The system software resets this counter at midnight. This maps to the RouterCallKey field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'ROUTER_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The day that the call was taken and the Dialer_Detail record was created. This field contains a value only for calls that were translation-routed or post-routed to or from an ACD. This maps to the RouterCallKeyDay field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'ROUTER_CALL_KEY_DAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Amount of time that the signal is silent after speech detection to declare a live speech (in mS). This maps to the SilencePeriod field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'SILENCE_PERIOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Amount of time that the answering machine terminating tone is detected after declaring answering machine detection (in mS). This maps to the TermToneDetectionTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'TERM_TONE_DETECTION_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Amount of time that energy is active for declaring speech energy. This maps to the ValidSpeechTime field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'VALID_SPEECH_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Wrap up data that was entered by the outbound agent. This maps to the WrapupData field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'WRAPUP_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The zone that was active at the time that the attempt was made.The value can be 0 or 1. This field should be NULL for both Personal Callback calls and Regular Callback calls. This maps to the ZoneIndex field in the DetailedDialer table', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'ZONE_INDEX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM0_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM1_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM2_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM3_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM4_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM5_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM6_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM7_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM8_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom dimension field which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM9_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type integer which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_INT_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type integer which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_INT_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type integer which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_INT_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type integer which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_INT_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type integer which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_INT_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type bigint which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_BIGINT_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type bigint which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_BIGINT_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type bigint which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_BIGINT_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type float which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_FLOAT_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type float which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_FLOAT_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type float which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_FLOAT_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type varchar (length 500) which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_VARCHAR_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type varchar (length 500) which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_VARCHAR_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a custom measure field of data type varchar (length 500) which is included for future expansion if required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_VARCHAR_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the offset in minutes that the customer is from UTC (formerly GMT). This maps to the CustomerTimeZone field in the DetailedDialer table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOMER_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'IDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_DIALER_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_DIALER_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_DIALER_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_DIALER_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_DIALER_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
