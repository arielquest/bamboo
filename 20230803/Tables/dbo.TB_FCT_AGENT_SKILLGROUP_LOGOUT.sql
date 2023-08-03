SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] (
		[PARTITION_URN]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]      [bigint] NOT NULL,
		[PARTITION_ID]              [int] NOT NULL,
		[LOGOUT_DATE_TIME]          [datetime] NOT NULL,
		[LOGOUT_DATE_URN]           [int] NOT NULL,
		[LOGOUT_TIME_URN]           [smallint] NOT NULL,
		[LOGOUT_DATE_UTC_URN]       [int] NOT NULL,
		[LOGOUT_TIME_UTC_URN]       [smallint] NOT NULL,
		[LOGOUT_UTC_TIMEZONE]       [int] NOT NULL,
		[AGENT_URN]                 [int] NOT NULL,
		[AGENT_TEAM_URN]            [int] NOT NULL,
		[PERIPHERAL_URN]            [int] NOT NULL,
		[SKILLGROUP_URN]            [int] NOT NULL,
		[PERSON_URN]                [int] NOT NULL,
		[REASON_CODE_URN]           [int] NOT NULL,
		[RATING_PERIOD_URN]         [int] NOT NULL,
		[DURATION_TIMEBAND_URN]     [int] NOT NULL,
		[LOGIN_DURATION]            [int] NOT NULL,
		[LOGOUT_REASON]             [int] NULL,
		[RECOVERY_KEY]              [float] NOT NULL,
		[SUPERVISOR_AGENT_URN]      [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]      [int] NOT NULL,
		[CUSTOM_DIMENSION_0]        [int] NOT NULL,
		[CUSTOM_DIMENSION_1]        [int] NOT NULL,
		[CUSTOM_DIMENSION_2]        [int] NOT NULL,
		[CUSTOM_DIMENSION_3]        [int] NOT NULL,
		[CUSTOM_DIMENSION_4]        [int] NOT NULL,
		[CUSTOM_DIMENSION_5]        [int] NOT NULL,
		[CUSTOM_DIMENSION_6]        [int] NOT NULL,
		[CUSTOM_DIMENSION_7]        [int] NOT NULL,
		[CUSTOM_DIMENSION_8]        [int] NOT NULL,
		[CUSTOM_DIMENSION_9]        [int] NOT NULL,
		[CUSTOM_MEASURE_0]          [int] NULL,
		[CUSTOM_MEASURE_1]          [int] NULL,
		[CUSTOM_MEASURE_2]          [int] NULL,
		[CUSTOM_MEASURE_3]          [int] NULL,
		[CUSTOM_MEASURE_4]          [int] NULL,
		[CUSTOM_MEASURE_5]          [int] NULL,
		[CUSTOM_MEASURE_6]          [int] NULL,
		[CUSTOM_MEASURE_7]          [int] NULL,
		[CUSTOM_MEASURE_8]          [int] NULL,
		[CUSTOM_MEASURE_9]          [int] NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SKILLGROUP_LOGOUT_AGENT_URN]
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] ([AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'INDEX', N'IX_FCT_AGENT_SKILLGROUP_LOGOUT_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SKILLGROUP_LOGOUT_LOGOUT_DATE_URN]
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] ([LOGOUT_DATE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'INDEX', N'IX_FCT_AGENT_SKILLGROUP_LOGOUT_LOGOUT_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SKILLGROUP_LOGOUT_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] ([SKILLGROUP_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'INDEX', N'IX_FCT_AGENT_SKILLGROUP_LOGOUT_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SKILLGROUP_LOGOUT_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] ([AGENT_TEAM_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'INDEX', N'IX_FCT_AGENT_SKILLGROUP_LOGOUT_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SKILLGROUP_LOGOUT_PERIPHERAL_URN]
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] ([PERIPHERAL_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'INDEX', N'IX_FCT_AGENT_SKILLGROUP_LOGOUT_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SKILLGROUP_LOGOUT_PERSON_URN]
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] ([PERSON_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'INDEX', N'IX_FCT_AGENT_SKILLGROUP_LOGOUT_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical login statistics of agents on one or more skillgroups. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_AGENT_SKILLGROUP_LOGOUT_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_AGENT_SKILLGROUP_LOGOUT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Agent_Skill_Group_Logout table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the agent logged out of the skill group. This maps to the LogoutDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when the agent logged out. This is calcuated based on LogoutDateTime value in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the time on the date when the agent logged out. This is calcuated based on LogoutDateTime value in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the agent logged out. This is calcuated based on LogoutDateTime and TimeZone values in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC time on the UTC date when the agent logged out. This is calcuated based on LogoutDateTime and TimeZone values in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the logout date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT of type IT_AGENT corresponding to the agent associated with the record. This corresponds to the agent associated with the record. This is mapped based on SkillTargetID column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT_TEAM of type IT_AGENT_TEAM corresponding to the agent associated with the record. This corresponds to the agent team to which the agent is associated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_PERIPHERAL of type IT_PERIPHERAL corresponding to the agent associated with the record. This corresponds to the peripheral to which the agent is associated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SKILLGROUP of type IT_SKILLGROUP corresponding to the agent associated with the record. This corresponds to the skillgroup associated with the record. This is mapped based on SkillGroupSkillTargetID column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_PERSON of type IT_PERSON corresponding to the agent associated with the record. This corresponds to the person mapped to the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_REASON_CODE of type IT_REASON_CODE corresponding to the agent associated with the record. This is looked up or created based on ReasonCode.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_RATING_PERIOD', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'RATING_PERIOD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIMEBAND of type IT_TIMEBAND corresponding to the agent associated with the record. This corresponds to the timeband for the login duration.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of seconds the agent was logged in to the skill group. This maps to LoginDuration in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGIN_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is code that defines the logged out reason for the agent. This maps to the ReasonCode column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'LOGOUT_REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the supervisor agent of the team where the agent in the record is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SKILLGROUP_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_AGENT_SKILLGROUP_LOGOUT] SET (LOCK_ESCALATION = TABLE)
GO
