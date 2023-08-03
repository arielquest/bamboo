SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CHANNEL_CONCURRENT_USAGE] (
		[PARTITION_URN]                     [int] NOT NULL,
		[PARTITION_ID]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]              [bigint] NOT NULL,
		[DATE_TIME_UTC]                     [datetime] NOT NULL,
		[DATE_UTC_URN]                      [int] NOT NULL,
		[TIME_UTC_URN]                      [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]              [int] NOT NULL,
		[CATEGORY_URN]                      [int] NOT NULL,
		[CHANNEL_TYPE]                      [tinyint] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_0_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_1_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_2_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_3_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_4_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_5_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_6_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_7_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_8_CNTR]     [int] NOT NULL,
		[CONCURRENT_AGENTS_TYPE_9_CNTR]     [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                [int] NOT NULL,
		[CUSTOM_MEASURE_0]                  [int] NULL,
		[CUSTOM_MEASURE_1]                  [int] NULL,
		[CUSTOM_MEASURE_2]                  [int] NULL,
		[CUSTOM_MEASURE_3]                  [int] NULL,
		[CUSTOM_MEASURE_4]                  [int] NULL,
		[CUSTOM_MEASURE_5]                  [int] NULL,
		[CUSTOM_MEASURE_6]                  [int] NULL,
		[CUSTOM_MEASURE_7]                  [int] NULL,
		[CUSTOM_MEASURE_8]                  [int] NULL,
		[CUSTOM_MEASURE_9]                  [int] NULL,
		CONSTRAINT [PK_FCT_CHANNEL_CONCURRENT_USAGE]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This partition tables holds concurrent usage data for voice and digital channels. The concurrent usage data will be recorded every time an agent logs in or logs out of the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC when a concurrent usage was recorded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CATEGORY.ITEM_URN and refers to the Category for which the concurrent usage is recorded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This identifies the channel type for the concurrent usage. Possible values are 1:UCCE,2:eGain', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CHANNEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 0 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_0_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 1 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_1_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 2 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_2_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_3_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_4_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_5_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_6_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_7_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_8_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the concurrent agent count on the recorded date and time for agents with product count type 3 at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CONCURRENT_AGENTS_TYPE_9_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHANNEL_CONCURRENT_USAGE', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHANNEL_CONCURRENT_USAGE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CHANNEL_CONCURRENT_USAGE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHANNEL_CONCURRENT_USAGE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CHANNEL_CONCURRENT_USAGE] SET (LOCK_ESCALATION = TABLE)
GO
