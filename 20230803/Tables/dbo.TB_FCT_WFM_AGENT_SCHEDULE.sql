SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_WFM_AGENT_SCHEDULE] (
		[PARTITION_URN]                [int] IDENTITY(1, 1) NOT NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[PARTITION_GLOBAL_URN]         [bigint] NOT NULL,
		[DATE_URN]                     [int] NOT NULL,
		[TIME_URN]                     [smallint] NOT NULL,
		[DATE_UTC_URN]                 [int] NOT NULL,
		[TIME_UTC_URN]                 [smallint] NOT NULL,
		[DATE_TIME]                    [datetime] NOT NULL,
		[UTC_TIMEZONE]                 [int] NOT NULL,
		[AGENT_URN]                    [int] NOT NULL,
		[MEDIA_ROUTING_DOMAIN_URN]     [int] NOT NULL,
		[DURATION]                     [int] NOT NULL,
		[SCHEDULED_SIGN_ON_TIME]       [int] NULL,
		[SCHEDULED_AVAIL_TIME]         [int] NULL,
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
) ON [FCTWFMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_WFM_AGENT_SCHEDULE_DATE_URN]
	ON [dbo].[TB_FCT_WFM_AGENT_SCHEDULE] ([DATE_URN])
	ON [FCTWFMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'INDEX', N'IX_FCT_WFM_AGENT_SCHEDULE_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_WFM_AGENT_SCHEDULE_AGENT_URN]
	ON [dbo].[TB_FCT_WFM_AGENT_SCHEDULE] ([AGENT_URN])
	ON [FCTWFMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'INDEX', N'IX_FCT_WFM_AGENT_SCHEDULE_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the agent schedule information for third party workflow management systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_WFM_AGENT_SCHEDULE_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_WFM_AGENT_SCHEDULE view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are source from a third party data store.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated based on the date time corresponding to the start of the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated based on the date time corresponding to the start of the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated based on the date time corresponding to the start of the schedule and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated based on the date time corresponding to the start of the schedule and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time indicating the start of the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT for an item of type IT_AGENT indicating agent for which the schedule information associates to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN for an item of type IT_MEDIA_ROUTING_DOMAIN indicating the MR Domain for the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total duration of the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total duration for which the agent should be logged in. This can be less than or equal to the total duration of the schedule.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'SCHEDULED_SIGN_ON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total duration when the agent should be available to take calls when the agent is logged in. This can be less than or equal to the total signed on duration.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'SCHEDULED_AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_AGENT_SCHEDULE', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_WFM_AGENT_SCHEDULE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_WFM_AGENT_SCHEDULE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_WFM_AGENT_SCHEDULE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_WFM_AGENT_SCHEDULE] SET (LOCK_ESCALATION = TABLE)
GO
