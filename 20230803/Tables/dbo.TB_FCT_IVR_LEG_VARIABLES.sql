SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IVR_LEG_VARIABLES] (
		[PARTITION_URN]            [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[IVR_LEG_URN]              [bigint] NOT NULL,
		[DATE_TIME]                [datetime] NOT NULL,
		[SEQUENCE_NUMBER]          [tinyint] NOT NULL,
		[CV1]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV2]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV3]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV4]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV5]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV6]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV7]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV8]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV9]                      [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CV10]                     [varchar](40) COLLATE Latin1_General_CI_AS NULL,
		[CED]                      [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[PATH]                     [varchar](1000) COLLATE Latin1_General_CI_AS NULL,
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
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_LEG_VARIABLES_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_LEG_VARIABLES] ([DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'INDEX', N'IX_FCT_IVR_LEG_VARIABLES_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical IVR leg variables data. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_LEG_VARIABLES_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_LEG_VARIABLES view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identity column for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique number for the current partition table. This will be the same for all records in a single partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a values that is globally unique accross all partition tables. This is calculated based on the PARTITION_URN and PARTITION_ID columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the PARTITION_URN in the corresponding IVR leg partition table based on PARTITION_ID. This corresponds to the IVR leg associated with the variables.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'IVR_LEG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the date time associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Call Variable 10', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CV10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the caller entered digits if present.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the complete path of all the nodes associated with the IVR leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'PATH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_LEG_VARIABLES', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_LEG_VARIABLES]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_LEG_VARIABLES]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_LEG_VARIABLES]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_LEG_VARIABLES] SET (LOCK_ESCALATION = TABLE)
GO
