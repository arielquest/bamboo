SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA] (
		[FACT_PARTITION_METADATA_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARTITION_TYPE]                 [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[TEMPLATE_TABLE_NAME]            [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[VIEW_NAME]                      [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[CUBE_VIEW_NAME]                 [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[IDENTITY_FIELD]                 [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARTITIONING_FIELD]             [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARTITION_SELECTOR_FIELD]       [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[GLOBAL_IDENTITY_FIELD]          [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[VIEW_PLAN_AHEAD]                [int] NOT NULL,
		[TIME_TO_KEEP]                   [int] NOT NULL,
		[PLAN_AHEAD]                     [int] NOT NULL,
		[PARTITION_COUNT]                [int] NOT NULL,
		[MAXIMUM_PARTITIONS]             [int] NOT NULL,
		[FILE_GROUP]                     [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[XML_DATA]                       [xml](DOCUMENT [dbo].[ColumnCollection]) NOT NULL,
		[ENABLED]                        [bit] NOT NULL,
		[NEXT_AVAILABLE_IDENTITY]        [bigint] NOT NULL,
		[HIERARCHY_UPDATE_ENABLED]       [bit] NOT NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_FCT_PARTITION_METADATA_VIEW_NAME]
		UNIQUE
		NONCLUSTERED
		([VIEW_NAME])
		ON [PRIMARY],
		CONSTRAINT [UN_TB_IMP_FCT_PARTITION_METADATA_TEMPLATE_TABLE_NAME]
		UNIQUE
		NONCLUSTERED
		([TEMPLATE_TABLE_NAME])
		ON [PRIMARY],
		CONSTRAINT [UN_TB_IMP_FCT_PARTITION_METADATA_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_IMP_FCT_PARTITION_METADATA]
		PRIMARY KEY
		CLUSTERED
		([FACT_PARTITION_METADATA_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_NEXT_AVAILABLE_IDENTITY]
	DEFAULT ((1)) FOR [NEXT_AVAILABLE_IDENTITY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_HIERARCHY_UPDATE_ENABLED]
	DEFAULT ((1)) FOR [HIERARCHY_UPDATE_ENABLED]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_FACT_PARTITION_METADATA_ID]
	DEFAULT (newid()) FOR [FACT_PARTITION_METADATA_ID]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_VIEW_PLAN_AHEAD]
	DEFAULT ((1)) FOR [VIEW_PLAN_AHEAD]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_TIME_TO_KEEP]
	DEFAULT ((4)) FOR [TIME_TO_KEEP]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_PLAN_AHEAD]
	DEFAULT ((2)) FOR [PLAN_AHEAD]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_PARTITION_COUNT]
	DEFAULT ((78)) FOR [PARTITION_COUNT]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_MAXIMUM_PARTITIONS]
	DEFAULT ((256)) FOR [MAXIMUM_PARTITIONS]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_METADATA_PARTITIONING_FIELD]
	DEFAULT ('PARTITION_ID') FOR [PARTITIONING_FIELD]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the meta data relating to individual partition types.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'FACT_PARTITION_METADATA_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique name for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type fo partition e.g. Week, Month, Day.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'PARTITION_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'NAme of the template table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'TEMPLATE_TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the partitioned view for this partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'VIEW_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the primary key field for this partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'IDENTITY_FIELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Partition identifier column name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'PARTITIONING_FIELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Field used to select the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'PARTITION_SELECTOR_FIELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Global partition id field', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'GLOBAL_IDENTITY_FIELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of future partitions to keep in the partitioned view.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'VIEW_PLAN_AHEAD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of partitions to keep in the past (once dropped from the view).', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'TIME_TO_KEEP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of future partitions to create (for early arriving data).', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'PLAN_AHEAD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of active partitions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'PARTITION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Maximum supported partitions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'MAXIMUM_PARTITIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The file group on which the partition tables woulc be created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'FILE_GROUP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Custom xml data specific to the partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this partition type is enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next available global identity value for the partition type accross all partition tables.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'NEXT_AVAILABLE_IDENTITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this partition type is enabled for hierarchy related updates.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'HIERARCHY_UPDATE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_METADATA', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_default_mediator_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_METADATA] SET (LOCK_ESCALATION = TABLE)
GO
