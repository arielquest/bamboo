SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_WFM_FORECAST] (
		[PARTITION_URN]                    [int] IDENTITY(1, 1) NOT NULL,
		[PARTITION_ID]                     [int] NOT NULL,
		[PARTITION_GLOBAL_URN]             [bigint] NOT NULL,
		[DATE_URN]                         [int] NOT NULL,
		[TIME_URN]                         [smallint] NOT NULL,
		[DATE_UTC_URN]                     [int] NOT NULL,
		[TIME_UTC_URN]                     [smallint] NOT NULL,
		[DATE_TIME]                        [datetime] NOT NULL,
		[UTC_TIMEZONE]                     [int] NOT NULL,
		[ITEM_URN]                         [int] NOT NULL,
		[FORECAST_CALLS_OFFERED_SHORT]     [int] NULL,
		[FORECAST_CALLS_OFFERED_MED]       [int] NULL,
		[FORECAST_CALLS_OFFERED_LONG]      [int] NULL,
		[FORECAST_ASA_SHORT]               [int] NULL,
		[FORECAST_ASA_MED]                 [int] NULL,
		[FORECAST_ASA_LONG]                [int] NULL,
		[FORECAST_FTE_SHORT]               [float] NULL,
		[FORECAST_FTE_MED]                 [float] NULL,
		[FORECAST_FTE_LONG]                [float] NULL,
		[FORECAST_SERVICE_LEVEL_SHORT]     [float] NULL,
		[FORECAST_SERVICE_LEVEL_MED]       [float] NULL,
		[FORECAST_SERVICE_LEVEL_LONG]      [float] NULL,
		[FORECAST_AHT_SHORT]               [int] NULL,
		[FORECAST_AHT_MED]                 [int] NULL,
		[FORECAST_AHT_LONG]                [int] NULL,
		[FORECAST_HANDLED_SHORT]           [int] NULL,
		[FORECAST_HANDLED_MED]             [int] NULL,
		[FORECAST_HANDLED_LONG]            [int] NULL,
		[CHANGE_COUNT]                     [smallint] NULL,
		[CUSTOM_DIMENSION_0]               [int] NOT NULL,
		[CUSTOM_DIMENSION_1]               [int] NOT NULL,
		[CUSTOM_DIMENSION_2]               [int] NOT NULL,
		[CUSTOM_DIMENSION_3]               [int] NOT NULL,
		[CUSTOM_DIMENSION_4]               [int] NOT NULL,
		[CUSTOM_DIMENSION_5]               [int] NOT NULL,
		[CUSTOM_DIMENSION_6]               [int] NOT NULL,
		[CUSTOM_DIMENSION_7]               [int] NOT NULL,
		[CUSTOM_DIMENSION_8]               [int] NOT NULL,
		[CUSTOM_DIMENSION_9]               [int] NOT NULL,
		[CUSTOM_MEASURE_0]                 [int] NULL,
		[CUSTOM_MEASURE_1]                 [int] NULL,
		[CUSTOM_MEASURE_2]                 [int] NULL,
		[CUSTOM_MEASURE_3]                 [int] NULL,
		[CUSTOM_MEASURE_4]                 [int] NULL,
		[CUSTOM_MEASURE_5]                 [int] NULL,
		[CUSTOM_MEASURE_6]                 [int] NULL,
		[CUSTOM_MEASURE_7]                 [int] NULL,
		[CUSTOM_MEASURE_8]                 [int] NULL,
		[CUSTOM_MEASURE_9]                 [int] NULL
) ON [FCTWFMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_WFM_FORECAST_DATE_URN]
	ON [dbo].[TB_FCT_WFM_FORECAST] ([DATE_URN])
	ON [FCTWFMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'INDEX', N'IX_FCT_WFM_FORECAST_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the forecast statistics for third party workflow management systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_WFM_FORECAST_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_WFM_FORECAST view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are source from a third party data store.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated based on the date time corresponding to the start of the forecast period.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated based on the date time corresponding to the start of the forecast period.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated based on the date time corresponding to the start of the forecast period and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated based on the date time corresponding to the start of the forecast period and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time indicating to the start of the forecast period.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from VW_DIM_ITEM of a specific type indicating the item for which the forecast is targeted for.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the short range forecast for the number of call offered to the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_CALLS_OFFERED_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the medium range forecast for the number of call offered to the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_CALLS_OFFERED_MED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the long range forecast for the number of call offered to the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_CALLS_OFFERED_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the short range forecast for Average Speed of Answer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_ASA_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the medium range forecast for Average Speed of Answer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_ASA_MED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the long range forecast for Average Speed of Answer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_ASA_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the short range forecast for the number of Full Time Equivalents.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_FTE_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the medium range forecast for the number of Full Time Equivalents.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_FTE_MED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the long range forecast for the number of Full Time Equivalents.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_FTE_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the short range forecast for service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_SERVICE_LEVEL_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the medium range forecast for service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_SERVICE_LEVEL_MED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the long range forecast for service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_SERVICE_LEVEL_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the short range forecast for Average Handled Time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_AHT_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the medium range forecast for Average Handled Time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_AHT_MED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the long range forecast for Average Handled Time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_AHT_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the short range forecast for total handled calls.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_HANDLED_SHORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the medium range forecast for total handled calls.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_HANDLED_MED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the long range forecast for total handled calls.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'FORECAST_HANDLED_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a count indicating how many time the forecast has changed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CHANGE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_WFM_FORECAST', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_WFM_FORECAST]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_WFM_FORECAST]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_WFM_FORECAST]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_WFM_FORECAST] SET (LOCK_ESCALATION = TABLE)
GO
