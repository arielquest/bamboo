SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_AGENT_EVENT] (
		[AGENT_EVENT_URN]              [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[EVENT_DATE_URN]               [int] NOT NULL,
		[EVENT_TIME_URN]               [smallint] NOT NULL,
		[EVENT_DATE_UTC_URN]           [int] NOT NULL,
		[EVENT_TIME_UTC_URN]           [smallint] NOT NULL,
		[EVENT_DATE_TIME]              [datetime] NOT NULL,
		[LOGIN_DATE_URN]               [int] NOT NULL,
		[LOGIN_TIME_URN]               [smallint] NOT NULL,
		[LOGIN_DATE_UTC_URN]           [int] NOT NULL,
		[LOGIN_TIME_UTC_URN]           [smallint] NOT NULL,
		[LOGIN_DATE_TIME]              [datetime] NOT NULL,
		[UTC_TIMEZONE]                 [int] NOT NULL,
		[MEDIA_ROUTING_DOMAIN_URN]     [int] NOT NULL,
		[AGENT_URN]                    [int] NOT NULL,
		[AGENT_TEAM_URN]               [int] NOT NULL,
		[PERIPHERAL_URN]               [int] NOT NULL,
		[PERSON_URN]                   [int] NOT NULL,
		[REASON_CODE_URN]              [int] NOT NULL,
		[DURATION_TIMEBAND_URN]        [int] NOT NULL,
		[DURATION]                     [int] NOT NULL,
		[EVENT]                        [int] NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[RECOVERY_KEY]                 [float] NULL,
		[DB_DATETIME]                  [datetime] NULL,
		[SUPERVISOR_AGENT_URN]         [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]         [int] NOT NULL,
		[CUSTOM_DIMENSION_0]           [int] NOT NULL,
		[CUSTOM_DIMENSION_1]           [int] NOT NULL,
		[CUSTOM_DIMENSION_2]           [int] NOT NULL,
		[CUSTOM_DIMENSION_3]           [int] NOT NULL,
		[CUSTOM_DIMENSION_4]           [int] NOT NULL,
		[CUSTOM_DIMENSION_5]           [int] NOT NULL,
		[CUSTOM_DIMENSION_6]           [int] NOT NULL,
		[CUSTOM_DIMENSION_7]           [int] NOT NULL,
		[CUSTOM_DIMENSION_8]           [int] NOT NULL,
		[CUSTOM_DIMENSION_9]           [int] NOT NULL,
		[CUSTOM_MEASURE_0]             [int] NULL,
		[CUSTOM_MEASURE_1]             [int] NULL,
		[CUSTOM_MEASURE_2]             [int] NULL,
		[CUSTOM_MEASURE_3]             [int] NULL,
		[CUSTOM_MEASURE_4]             [int] NULL,
		[CUSTOM_MEASURE_5]             [int] NULL,
		[CUSTOM_MEASURE_6]             [int] NULL,
		[CUSTOM_MEASURE_7]             [int] NULL,
		[CUSTOM_MEASURE_8]             [int] NULL,
		[CUSTOM_MEASURE_9]             [int] NULL,
		[MEDIA_CLASS_URN]              [int] NOT NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_EVENT_AGENT_URN]
	ON [dbo].[TB_FCT_AGENT_EVENT] ([AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'INDEX', N'IX_FCT_AGENT_EVENT_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_EVENT_EVENT_DATE_URN]
	ON [dbo].[TB_FCT_AGENT_EVENT] ([EVENT_DATE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'INDEX', N'IX_FCT_AGENT_EVENT_EVENT_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_EVENT_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_AGENT_EVENT] ([AGENT_TEAM_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'INDEX', N'IX_FCT_AGENT_EVENT_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_EVENT_PERIPHERAL_URN]
	ON [dbo].[TB_FCT_AGENT_EVENT] ([PERIPHERAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'INDEX', N'IX_FCT_AGENT_EVENT_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_EVENT_PERSON_URN]
	ON [dbo].[TB_FCT_AGENT_EVENT] ([PERSON_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'INDEX', N'IX_FCT_AGENT_EVENT_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics for agent events. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_AGENT_EVENT_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_AGENT_EVENT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Agent_Event_Detail table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'AGENT_EVENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time and the TimeZone information corresponding to the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time and the TimeZone information corresponding to the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time associated with the record. The data in this column maps to DateTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when the agent logged in. This is calculated by the data importer based on the LoginDateTime field in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time when the agent logged in. This is calculated by the data importer based on the LoginDateTime field in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the agent logged in. This is calculated by the data importer based on the LoginDateTime and TimeZone field in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time when the agent logged in. This is calculated by the data importer based on the LoginDateTime and TimeZone field in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the agent logged in. The data in this column maps to LoginDateTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'LOGIN_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the timezone offset from GMT for the date and times in the record. The data in this column maps to TimeZone column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_MEDIA_ROUTING_DOMAIN of type IT_MEDIA_ROUTING_DOMAIN corresponding to the media routing domain associated with the record. This is looked up or generated based on MRDomainID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT of type IT_AGENT corresponding to the agent associated with the record. This is looked up or generated based on SkillTargetID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT_TEAM corresponding to an item of type IT_AGENT_TEAM. This corresponds to the first agent team, which the agent belonged to at the time when the record was written into the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERSON corresponding to an item of type IT_PERSON. This corresponds to the person associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_REASON_CODE of type IT_REASON_CODE corresponding to the event reason code associated with the record. This is looked up based on ReasonCode column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_REASON_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND of type IT_TIMEBAND corresponding to the duration associated with the record. This is looked up based on Duration column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration associated with the record. The data in this column maps to Duration column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the event transition that occured. The data in this column maps to Event column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'EVENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in Cisco ICM/IPCC', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the supervisor agent of the team where the agent in the record is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_CLASS. This corresponds to the media class associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_CLASS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_EVENT', 'COLUMN', N'MEDIA_CLASS_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_EVENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_AGENT_EVENT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_EVENT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_AGENT_EVENT] SET (LOCK_ESCALATION = TABLE)
GO
