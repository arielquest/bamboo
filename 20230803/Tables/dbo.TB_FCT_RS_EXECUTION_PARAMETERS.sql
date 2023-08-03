SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_RS_EXECUTION_PARAMETERS] (
		[EXECUTION_PARAMETERS_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[EXECUTION_LOG_URN]            [int] NOT NULL,
		[NAME]                         [nvarchar](1467) COLLATE Latin1_General_CI_AS NULL,
		[VALUE]                        [nvarchar](1467) COLLATE Latin1_General_CI_AS NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[DATE_TIME]                    [datetime] NOT NULL,
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
		[CUSTOM_MEASURE_9]             [int] NULL,
		CONSTRAINT [PK_EXECUTION_PARAMETERS_URN]
		PRIMARY KEY
		CLUSTERED
		([EXECUTION_PARAMETERS_URN])
	ON [FCTGROUP]
) ON [FCTGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_RS_EXECUTION_PARAMETERS_DATE_TIME]
	ON [dbo].[TB_FCT_RS_EXECUTION_PARAMETERS] ([DATE_TIME])
	ON [FCTIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'INDEX', N'IX_FCT_RS_EXECUTION_PARAMETERS_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the storing the various parameters associated with the report execution in SQL server reporting services 2000 database. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_RS_EXECUTION_PARAMETERS_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_RS_EXECUTION_PARAMETERS view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are imported from ExecutionLog table in SQL Server reporting services database. These are stored as name value pairs for each parameter associated with the report execution log. The data in these partition tables correspond to the data in the Paramters column in the ExecutionLog table. The data in these partitioned tables are tied to the corresponding report exection log record based on EXECUTION_LOG_URN and PARTITION_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'EXECUTION_PARAMETERS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN in the partition table for TB_FCT_RS_EXECUTION_LOG corresponding the partition defined by PARTITION_ID column. This corresponds to the report execution record associated with the parameter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'EXECUTION_LOG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the parameter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the value of the parameter at the time of execution of the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_PARAMETERS', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_RS_EXECUTION_PARAMETERS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_RS_EXECUTION_PARAMETERS]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_RS_EXECUTION_PARAMETERS]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_RS_EXECUTION_PARAMETERS] SET (LOCK_ESCALATION = TABLE)
GO
