SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_INDEX_STATE] (
		[OBJECT_ID]                      [int] NOT NULL,
		[INDEX_ID]                       [int] NOT NULL,
		[PARTITION]                      [int] NOT NULL,
		[FRAGMENTATION]                  [float] NOT NULL,
		[DENSITY]                        [float] NULL,
		[PAGES]                          [bigint] NOT NULL,
		[FILLFACTOR]                     [tinyint] NULL,
		[BLOB_DATA_TYPE]                 [tinyint] NOT NULL,
		[INDEX_NAME]                     [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SCHEMA_NAME]                    [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[DATABASE_NAME]                  [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[OBJECT_NAME]                    [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[RUN_DATE]                       [smalldatetime] NULL,
		[SCAN_DATE_START]                [smalldatetime] NULL,
		[SCAN_DATE_END]                  [smalldatetime] NULL,
		[STATISTICS_DATE_START]          [smalldatetime] NULL,
		[STATISTICS_DATE_END]            [smalldatetime] NULL,
		[DEFRAG_DATE_START]              [smalldatetime] NULL,
		[DEFRAG_DATE_END]                [smalldatetime] NULL,
		[LAST_EXECUTED_STATEMENT]        [varchar](max) COLLATE Latin1_General_CI_AS NULL,
		[CURRENT_EXECUTED_STATEMENT]     [varchar](max) COLLATE Latin1_General_CI_AS NULL,
		[EXECUTION_MASK]                 [tinyint] NOT NULL,
		CONSTRAINT [PK_TB_ADM_INDEX_STATE]
		PRIMARY KEY
		CLUSTERED
		([OBJECT_ID], [INDEX_ID], [PARTITION])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
	ADD
	CONSTRAINT [CK_TB_ADM_INDEX_STATE_FILLFACTOR]
	CHECK
	([FILLFACTOR] IS NULL OR [FILLFACTOR]>=(1) AND [FILLFACTOR]<=(99))
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
CHECK CONSTRAINT [CK_TB_ADM_INDEX_STATE_FILLFACTOR]
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
	ADD
	CONSTRAINT [CK_TB_ADM_INDEX_STATE_BLOB_DATA_TYPE]
	CHECK
	([BLOB_DATA_TYPE]=(1) OR [BLOB_DATA_TYPE]=(0))
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
CHECK CONSTRAINT [CK_TB_ADM_INDEX_STATE_BLOB_DATA_TYPE]
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
	ADD
	CONSTRAINT [CK_TB_ADM_INDEX_STATE_EXECUTION_MASK]
	CHECK
	([EXECUTION_MASK]>=(1) AND [EXECUTION_MASK]<=(127))
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
CHECK CONSTRAINT [CK_TB_ADM_INDEX_STATE_EXECUTION_MASK]
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
	ADD
	CONSTRAINT [DF_TB_ADM_INDEX_STATE_BLOB_DATA_TYPE]
	DEFAULT ((0)) FOR [BLOB_DATA_TYPE]
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE]
	ADD
	CONSTRAINT [DF_TB_ADM_INDEX_STATE_EXECUTION_MASK]
	DEFAULT ((127)) FOR [EXECUTION_MASK]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains index information', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of the composite primary key identifier for the record.  The object identifier (see sys.objects).', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'OBJECT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of the composite primary key identifier for the record.  The index identifier (see sys.indexes).', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'INDEX_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of the composite primary key identifier for the record.  The partition number of the index (see sys.partitions).', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'PARTITION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The current fragmentation of the index.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'FRAGMENTATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The current page density of the index.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'DENSITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of pages in the index.  This affects how long it takes to run a defragmentation on an index.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'PAGES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The fillfactor for this index.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'FILLFACTOR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A flag determining whether or not this index contains a blob data type.  This is a tinyint with a constraint rather than a bit to make it easier to perform analytic queries on this table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'BLOB_DATA_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the index.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'INDEX_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The schema name that this index belongs to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'SCHEMA_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The database name that this index belongs to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'DATABASE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The object name that this index belongs to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'OBJECT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Bit mask determining which day of the week the defrag and scan should run.  1 = Sunday, 2 = Monday, 4 = Tuesday, 8 = Wednesday, 16 = Thursday, 32 = Friday, 64 = Saturday', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_INDEX_STATE', 'COLUMN', N'EXECUTION_MASK'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_INDEX_STATE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_INDEX_STATE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_INDEX_STATE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_INDEX_STATE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_INDEX_STATE] SET (LOCK_ESCALATION = TABLE)
GO
