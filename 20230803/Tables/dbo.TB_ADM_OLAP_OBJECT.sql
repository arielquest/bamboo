SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_OLAP_OBJECT] (
		[OLAP_OBJECT_URN]             [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PARENT_OLAP_OBJECT_NAME]     [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[OLAP_OBJECT_NAME]            [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[OLAP_OBJECT_TYPE]            [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[PRIMARY_TABLE]               [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[CHECK_MEASURE]               [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARTITION_MAP]               [varchar](750) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_DIMENSION]             [int] NULL,
		[SLICE_LEVEL_1]               [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_LEVEL_2]               [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_LEVEL_3]               [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_LEVEL_4]               [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_FACT_KEY]              [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_DIMENSION_KEY]         [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_COLUMN_1]              [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_COLUMN_2]              [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_COLUMN_3]              [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_COLUMN_4]              [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[PROCESS_CHUNK]               [int] NOT NULL,
		[RELATED_OLAP_OBJECT_URN]     [int] NOT NULL,
		[msrepl_tran_version]         [uniqueidentifier] NOT NULL,
		CONSTRAINT [UQ_ADM_PARENT_OLAP_OBJECT_NAME_OLAP_OBJECT_NAME]
		UNIQUE
		NONCLUSTERED
		([OLAP_OBJECT_NAME], [PARENT_OLAP_OBJECT_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_OLAP_OBJECT]
		PRIMARY KEY
		CLUSTERED
		([OLAP_OBJECT_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [CK_TB_ADM_OLAP_OBJECT_TYPE]
	CHECK
	([OLAP_OBJECT_TYPE]='D' OR [OLAP_OBJECT_TYPE]='C' OR [OLAP_OBJECT_TYPE]='M')
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
CHECK CONSTRAINT [CK_TB_ADM_OLAP_OBJECT_TYPE]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_PARENT_OLAP_OBJECT_NAME]
	DEFAULT (N'') FOR [PARENT_OLAP_OBJECT_NAME]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_CHECK_MEASURE]
	DEFAULT ('') FOR [CHECK_MEASURE]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_PARTITION_MAP]
	DEFAULT ('') FOR [PARTITION_MAP]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_LEVEL_1]
	DEFAULT ('') FOR [SLICE_LEVEL_1]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_LEVEL_2]
	DEFAULT ('') FOR [SLICE_LEVEL_2]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_LEVEL_3]
	DEFAULT ('') FOR [SLICE_LEVEL_3]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_LEVEL_4]
	DEFAULT ('') FOR [SLICE_LEVEL_4]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_FACT_KEY]
	DEFAULT ('') FOR [SLICE_FACT_KEY]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_DIMENSION_KEY]
	DEFAULT ('') FOR [SLICE_DIMENSION_KEY]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_COLUMN_1]
	DEFAULT ('') FOR [SLICE_COLUMN_1]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_COLUMN_2]
	DEFAULT ('') FOR [SLICE_COLUMN_2]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_COLUMN_3]
	DEFAULT ('') FOR [SLICE_COLUMN_3]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_SLICE_COLUMN_4]
	DEFAULT ('') FOR [SLICE_COLUMN_4]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_PROCESS_CHUNK]
	DEFAULT ((5000000)) FOR [PROCESS_CHUNK]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_RELATED_OLAP_OBJECT_URN]
	DEFAULT ((-1)) FOR [RELATED_OLAP_OBJECT_URN]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information various analysis services database objects.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the name of the parent olap object the OLAP_OBJECT_NAME fall under. For example Cube can be PARENT_OLAP_OBJECT_NAME and Measure Groups can be OLAP_OBJECT_NAME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'PARENT_OLAP_OBJECT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the name of the OLAP object.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'OLAP_OBJECT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the type of the OLAP object. Takes values D indicating Dimensions and C indicating Cubes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'OLAP_OBJECT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the name of the table or view in the RDBMS database, which is the primary or the base table for the OLAP object.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'PRIMARY_TABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The main measure used to know the count of rows in a particular OLAP object. This only used for objects of type Cubes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'CHECK_MEASURE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'PARTITION_MAP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field corresponds to the date object that is used to create partitions for the cube. This field usually hold the OLAP_OBJECT_URN of the date dimension from the same table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_DIMENSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the Level of the dimension based on which partitions are created for the cube if any.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_LEVEL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the Level of the dimension based on which partitions are created for the cube if any.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_LEVEL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the Level of the dimension based on which partitions are created for the cube if any.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_LEVEL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the Level of the dimension based on which partitions are created for the cube if any.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_LEVEL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the field in the PRIMARY_TABLE (Fact table) for the olap object, based on which the parition are created for a cube. This usually is the date field from the base fact table of the cube.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_FACT_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the field in the PRIMARY_TABLE of the SLICE_DIMENSION for the olap object, based on which the parition are created for a cube. This usually is the date field from the dimension table under consideration.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_DIMENSION_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value governs the name of the OLAP object parition when it is created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_COLUMN_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value governs the name of the OLAP object parition when it is created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_COLUMN_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value governs the name of the OLAP object parition when it is created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_COLUMN_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value governs the name of the OLAP object parition when it is created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'SLICE_COLUMN_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value represents the number of records to process in one OLAP processing chunk. This is valid only for cube processing.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'PROCESS_CHUNK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the Measure Group to which this Fact Dimension is related to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'RELATED_OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_OLAP_OBJECT]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_OLAP_OBJECT]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_OLAP_OBJECT]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT] SET (LOCK_ESCALATION = TABLE)
GO
