SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_AGENT_LOGOUT] (
		[AGENT_LOGOUT_URN]             [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[STARTDATE_URN]                [int] NOT NULL,
		[STARTTIME_URN]                [smallint] NOT NULL,
		[STARTDATE_UTC_URN]            [int] NOT NULL,
		[STARTTIME_UTC_URN]            [smallint] NOT NULL,
		[START_DATE_TIME]              [datetime] NOT NULL,
		[START_UTC_TIMEZONE]           [int] NOT NULL,
		[AGENT_URN]                    [int] NOT NULL,
		[AGENT_TEAM_URN]               [int] NOT NULL,
		[PERIPHERAL_URN]               [int] NOT NULL,
		[LOGOUT_REASON_URN]            [int] NOT NULL,
		[RATING_PERIOD_URN]            [int] NOT NULL,
		[DURATION_TIMEBAND_URN]        [int] NOT NULL,
		[LOGIN_DURATION]               [int] NOT NULL,
		[LOGOUT_REASON]                [int] NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[RECOVERY_KEY]                 [float] NULL,
		[PERSON_URN]                   [int] NULL,
		[MEDIA_ROUTING_DOMAIN_URN]     [int] NULL,
		[EXTENSION]                    [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[PHONE_TYPE_CODE_URN]          [int] NULL,
		[REMOTE_PHONE_NUMBER]          [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[SUPERVISOR_AGENT_URN]         [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]         [int] NOT NULL,
		[START_DATE_TIME_UTC]          [datetime] NOT NULL,
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
		[CUSTOM_MEASURE_9]             [int] NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_LOGOUT_AGENT_URN]
	ON [dbo].[TB_FCT_AGENT_LOGOUT] ([AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'INDEX', N'IX_FCT_AGENT_LOGOUT_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_LOGOUT_STARTDATE_URN]
	ON [dbo].[TB_FCT_AGENT_LOGOUT] ([STARTDATE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'INDEX', N'IX_FCT_AGENT_LOGOUT_STARTDATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_LOGOUT_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_AGENT_LOGOUT] ([AGENT_TEAM_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'INDEX', N'IX_FCT_AGENT_LOGOUT_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_LOGOUT_PERIPHERAL_URN]
	ON [dbo].[TB_FCT_AGENT_LOGOUT] ([PERIPHERAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'INDEX', N'IX_FCT_AGENT_LOGOUT_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_LOGOUT_PERSON_URN]
	ON [dbo].[TB_FCT_AGENT_LOGOUT] ([PERSON_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'INDEX', N'IX_FCT_AGENT_LOGOUT_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics for agent logout events. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_AGENT_LOGOUT_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_AGENT_LOGOUT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Agent_Logout table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'AGENT_LOGOUT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when the agent logged in. In case of Cisco ICM/IPCC this is calculated based on the LogoutDateTime and LoginDuration columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the date when the agent logged in. In case of Cisco ICM/IPCC this is calculated based on the LogoutDateTime and LoginDuration columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the agent logged in. In case of Cisco ICM/IPCC this is calculated based on the LogoutDateTime,  LoginDuration and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of the UTC date when the agent logged in. In case of Cisco ICM/IPCC this is calculated based on the LogoutDateTime, LoginDuration and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the agent logged in. In case of Cisco ICM/IPCC this is calculated based on LogoutDateTime and LoginDuration columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC corresponding to the record. In case of Cisco ICM/IPCC this maps to the TimeZone column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'START_UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT of type IT_AGENT corresponding to the agent associated with the record. This is looked up or generated based on SkillTargetID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT_TEAM corresponding to an item of type IT_AGENT_TEAM. This corresponds to the first agent team, which the agent belonged to at the time when the record was written into the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to PERIPHERAL_CODE_URN column as in VW_DIM_PERIPHERAL_LOGOUT_REASON corresponding the agents logout reason. In case of Cisco ICM/IPCC this is looked up or generated based on the ReasonCode column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_REASON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_RATING_PERIOD corresponding to an item of type IT_RATING_PERIOD. This corresponds to the rating period associated with the record. In case of Cisco ICM/IPCC this is calculated based on LogoutDateTime.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_RATING_PERIOD', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND corresponding to an item of type IT_TIMEBAND. This corresponds to the timband corresponding to the LOGIN_DURATION. In case of Cisco ICM/IPCC this is calculated based on LoginDuration.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the actual duration for which the agent was logged in. This maps to the LoginDuration column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'LOGIN_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is code that defines the logged out reason for the agent. This maps to the ReasonCode column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_REASON'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERSON corresponding to an item of type IT_PERSON. This corresponds to the person associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_MEDIA_ROUTING_DOMAIN of type IT_MEDIA_ROUTING_DOMAIN corresponding to the media routing domain associated with the record. This is looked up or generated based on MRDomainID column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the Extension column in the t_Agent_Logout table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'EXTENSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the PhoneType column in the t_Agent_Logout table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PHONE_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'PHONE_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the RemotePhoneNumber column in the t_Agent_Logout table in Cisco ICM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'REMOTE_PHONE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the supervisor agent of the team where the agent in the record is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time when the agent logged in. In case of Cisco ICM/IPCC this is calculated based on LogoutDateTime, LoginDuration and TimeZone columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_LOGOUT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_AGENT_LOGOUT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_LOGOUT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_AGENT_LOGOUT] SET (LOCK_ESCALATION = TABLE)
GO
