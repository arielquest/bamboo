SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_AGENT_STATE_CHANGE] (
		[AGENT_STATE_CHANGE_URN]              [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[STARTDATE_URN]                       [int] NOT NULL,
		[STARTTIME_URN]                       [smallint] NOT NULL,
		[STARTDATE_UTC_URN]                   [int] NOT NULL,
		[STARTTIME_UTC_URN]                   [smallint] NOT NULL,
		[START_DATE_TIME]                     [datetime] NOT NULL,
		[START_UTC_TIMEZONE]                  [int] NOT NULL,
		[AGENT_URN]                           [int] NOT NULL,
		[EVENT]                               [int] NOT NULL,
		[REASON]                              [int] NULL,
		[STATE]                               [int] NULL,
		[DIRECTION]                           [int] NULL,
		[PARTITION_ID]                        [int] NOT NULL,
		[RECOVERY_KEY]                        [float] NULL,
		[PERSON_URN]                          [int] NULL,
		[MEDIA_ROUTING_DOMAIN_URN]            [int] NULL,
		[SKILLGROUP_URN]                      [int] NULL,
		[ICR_CALL_KEY]                        [int] NULL,
		[PERIPHERAL_CALL_KEY]                 [int] NULL,
		[ROUTER_CALL_KEY_DAY]                 [int] NULL,
		[ROUTER_CALL_KEY]                     [int] NULL,
		[ROUTER_CALL_KEY_SEQUENCE_NUMBER]     [int] NULL,
		[EVENT_CODE_URN]                      [int] NULL,
		[CLUSTER_RESOURCE_URN]                [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                  [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                  [int] NOT NULL,
		[CUSTOM_MEASURE_0]                    [int] NULL,
		[CUSTOM_MEASURE_1]                    [int] NULL,
		[CUSTOM_MEASURE_2]                    [int] NULL,
		[CUSTOM_MEASURE_3]                    [int] NULL,
		[CUSTOM_MEASURE_4]                    [int] NULL,
		[CUSTOM_MEASURE_5]                    [int] NULL,
		[CUSTOM_MEASURE_6]                    [int] NULL,
		[CUSTOM_MEASURE_7]                    [int] NULL,
		[CUSTOM_MEASURE_8]                    [int] NULL,
		[CUSTOM_MEASURE_9]                    [int] NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_STATE_CHANGE_AGENT_URN]
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE] ([AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'INDEX', N'IX_FCT_AGENT_STATE_CHANGE_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_STATE_CHANGE_STARTDATE_URN]
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE] ([STARTDATE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'INDEX', N'IX_FCT_AGENT_STATE_CHANGE_STARTDATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_STATE_CHANGE_PERSON_URN]
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE] ([PERSON_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'INDEX', N'IX_FCT_AGENT_STATE_CHANGE_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_STATE_CHANGE_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE] ([SKILLGROUP_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'INDEX', N'IX_FCT_AGENT_STATE_CHANGE_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics for agent states. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_AGENT_STATE_CHANGE_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_AGENT_STATE_CHANGE view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Agent_State_Trace table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'AGENT_STATE_CHANGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when the state change occured. In case of Cisco ICM/IPCC this is calculated based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the date when the state change occured. In case of Cisco ICM/IPCC this is calculated based on the DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the state change occured. In case of Cisco ICM/IPCC this is calculated based on the DateTime and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of the UTC date when the state change occured. In case of Cisco ICM/IPCC this is calculated based on the DateTime and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the state change occurred. In Cisco ICM/IPCC this column maps to DateTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC corresponding to the record. In case of Cisco ICM/IPCC this maps to the TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'START_UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT of type IT_AGENT corresponding to the agent associated with the record. This is looked up or generated based on SkillTargetID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a code indicating the event that occured. In case of Cisco ICM/IPCC this maps to the EventName column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'EVENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a code indicating the reason for the state change. In case of Cisco ICM/IPCC this maps to the ReasonCode column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a code indicating the state of the agent after the state change. In case of Cisco ICM/IPCC this maps to the AgentState column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In case of Cisco ICM/IPCC this maps to the Direction column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'DIRECTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERSON corresponding to an item of type IT_PERSON. This corresponds to the person associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_MEDIA_ROUTING_DOMAIN of type IT_MEDIA_ROUTING_DOMAIN corresponding to the media routing domain associated with the record. This is looked up or generated based on MRDomainID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the SkillGroupSkillTargetID column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the ICRCallKey column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'ICR_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the PeripheralCallKey column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'PERIPHERAL_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the RouterCallKeyDay column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'ROUTER_CALL_KEY_DAY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the RouterCallKey column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'ROUTER_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the RouterCallKeySequenceNumber column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'ROUTER_CALL_KEY_SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the EventName column in the t_Agent_State_Trace table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'EVENT_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'EVENT_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_STATE_CHANGE', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_STATE_CHANGE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_AGENT_STATE_CHANGE] SET (LOCK_ESCALATION = TABLE)
GO
