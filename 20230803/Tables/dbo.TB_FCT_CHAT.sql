SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CHAT] (
		[PARTITION_URN]                 [int] IDENTITY(1, 1) NOT NULL,
		[PARTITION_ID]                  [int] NOT NULL,
		[PARTITION_GLOBAL_URN]          [bigint] NOT NULL,
		[START_DATE_URN]                [int] NOT NULL,
		[START_TIME_URN]                [smallint] NOT NULL,
		[START_DATE_UTC_URN]            [int] NOT NULL,
		[START_TIME_UTC_URN]            [smallint] NOT NULL,
		[START_DATE_TIME]               [datetime] NOT NULL,
		[START_UTC_TIMEZONE]            [int] NOT NULL,
		[AGENT_URN]                     [int] NOT NULL,
		[SKILLGROUP_URN]                [int] NOT NULL,
		[AGENT_TEAM_URN]                [int] NOT NULL,
		[CHAT_DISPOSITION_CODE_URN]     [int] NOT NULL,
		[DURATION_TIMEBAND_URN]         [int] NULL,
		[DURATION]                      [int] NULL,
		[CLUSTER_RESOURCE_URN]          [int] NOT NULL,
		[CUSTOM_DIMENSION_0]            [int] NOT NULL,
		[CUSTOM_DIMENSION_1]            [int] NOT NULL,
		[CUSTOM_DIMENSION_2]            [int] NOT NULL,
		[CUSTOM_DIMENSION_3]            [int] NOT NULL,
		[CUSTOM_DIMENSION_4]            [int] NOT NULL,
		[CUSTOM_DIMENSION_5]            [int] NOT NULL,
		[CUSTOM_DIMENSION_6]            [int] NOT NULL,
		[CUSTOM_DIMENSION_7]            [int] NOT NULL,
		[CUSTOM_DIMENSION_8]            [int] NOT NULL,
		[CUSTOM_DIMENSION_9]            [int] NOT NULL,
		[CUSTOM_MEASURE_0]              [int] NULL,
		[CUSTOM_MEASURE_1]              [int] NULL,
		[CUSTOM_MEASURE_2]              [int] NULL,
		[CUSTOM_MEASURE_3]              [int] NULL,
		[CUSTOM_MEASURE_4]              [int] NULL,
		[CUSTOM_MEASURE_5]              [int] NULL,
		[CUSTOM_MEASURE_6]              [int] NULL,
		[CUSTOM_MEASURE_7]              [int] NULL,
		[CUSTOM_MEASURE_8]              [int] NULL,
		[CUSTOM_MEASURE_9]              [int] NULL
) ON [FCTMMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_START_DATE_URN]
	ON [dbo].[TB_FCT_CHAT] ([START_DATE_URN])
	ON [FCTMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'INDEX', N'IX_FCT_CHAT_START_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_AGENT_URN]
	ON [dbo].[TB_FCT_CHAT] ([AGENT_URN])
	ON [FCTMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'INDEX', N'IX_FCT_CHAT_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_CHAT] ([SKILLGROUP_URN])
	ON [FCTMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'INDEX', N'IX_FCT_CHAT_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CHAT] ([AGENT_TEAM_URN])
	ON [FCTMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'INDEX', N'IX_FCT_CHAT_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics for all the chats occured in a third party application. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_CHAT_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_CHAT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are source from a third party data store.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the chat and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the chat and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time indicating when the chat started.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'START_UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is URN from TB_DIM_AGENT for an item of type IT_AGENT indicating the agent handling the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP indicating the skillgroup associated with the agent handling the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT_TEAM for an item of type IT_AGENT_TEAM indicating the team associated with the agent handling the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from VW_DIM_CHAT_DISPOSITION_CODE indicating the chat disposition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CHAT_DISPOSITION_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CHAT_DISPOSITION_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_TIMEBAND for an item of type IT_TIMEBAND indicating the duration time band. This is calculated based on the duration of the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'DURATION_TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total duration of the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHAT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CHAT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHAT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CHAT] SET (LOCK_ESCALATION = TABLE)
GO
