SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_IVR_LEG_NODE_PATH] (
		[PARTITION_URN]            [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[DATE_TIME]                [datetime] NOT NULL,
		[UTC_TIMEZONE]             [int] NOT NULL,
		[DATE_URN]                 [int] NOT NULL,
		[TIME_URN]                 [smallint] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DIALED_NUMBER_URN]        [int] NOT NULL,
		[IVR_SCRIPT_NODE_URN]      [int] NOT NULL,
		[SEQUENCE]                 [int] NOT NULL,
		[PERIOD]                   [smallint] NOT NULL,
		[DEFLECTION]               [bit] NOT NULL,
		[BARGED_IN]                [bit] NOT NULL,
		[IVR_LEG_STAGE_URN]        [bigint] NULL,
		[CLUSTER_RESOURCE_ID]      [uniqueidentifier] NULL,
		[CUSTOM_DIMENSION_0]       [int] NOT NULL,
		[CUSTOM_DIMENSION_1]       [int] NOT NULL,
		[CUSTOM_DIMENSION_2]       [int] NOT NULL,
		[CUSTOM_DIMENSION_3]       [int] NOT NULL,
		[CUSTOM_DIMENSION_4]       [int] NOT NULL,
		[CUSTOM_DIMENSION_5]       [int] NOT NULL,
		[CUSTOM_DIMENSION_6]       [int] NOT NULL,
		[CUSTOM_DIMENSION_7]       [int] NOT NULL,
		[CUSTOM_DIMENSION_8]       [int] NOT NULL,
		[CUSTOM_DIMENSION_9]       [int] NOT NULL,
		[CUSTOM_MEASURE_0]         [int] NULL,
		[CUSTOM_MEASURE_1]         [int] NULL,
		[CUSTOM_MEASURE_2]         [int] NULL,
		[CUSTOM_MEASURE_3]         [int] NULL,
		[CUSTOM_MEASURE_4]         [int] NULL,
		[CUSTOM_MEASURE_5]         [int] NULL,
		[CUSTOM_MEASURE_6]         [int] NULL,
		[CUSTOM_MEASURE_7]         [int] NULL,
		[CUSTOM_MEASURE_8]         [int] NULL,
		[CUSTOM_MEASURE_9]         [int] NULL
) ON [FCTIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_NODE_PATH_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_LEG_NODE_PATH] ([DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'INDEX', N'IX_FCT_IVR_LEG_NODE_PATH_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_NODE_PATH_DATE_URN]
	ON [dbo].[TB_FCT_IVR_LEG_NODE_PATH] ([DATE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'INDEX', N'IX_FCT_IVR_LEG_NODE_PATH_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_NODE_PATH_DIALED_NUMBER_URN]
	ON [dbo].[TB_FCT_IVR_LEG_NODE_PATH] ([DIALED_NUMBER_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'INDEX', N'IX_FCT_IVR_LEG_NODE_PATH_DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical IVR node path data. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_LEG_NODE_PATH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_LEG_NODE_PATH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identity column for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique number for the current partition table. This will be the same for all records in a single partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a values that is globally unique accross all partition tables. This is calculated based on the PARTITION_URN and PARTITION_ID columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC corresponding to the date time associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the wall clock date associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the wall clock time associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER of type IT_DIALED_NUMBER. This corresponds to the dialed number associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE of type IT_IVR_SCRIPT_NODE. This corresponds to the initial ivr script node associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the sequence order position when the current node path was passed in the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'PERIOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is boolean flag indicating whether the current node in the IVR leg was a deflection point or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'DEFLECTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the current node of the IVR leg was barged in or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'BARGED_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the key identifying the IVR leg on the source equipment to which the current IVR leg node path maps to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'IVR_LEG_STAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is ID as in TB_CLU_RESOURCE identifying the source equipment that the IVR leg node path record maps to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_NODE_PATH', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_LEG_NODE_PATH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_LEG_NODE_PATH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_LEG_NODE_PATH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_LEG_NODE_PATH] SET (LOCK_ESCALATION = TABLE)
GO
