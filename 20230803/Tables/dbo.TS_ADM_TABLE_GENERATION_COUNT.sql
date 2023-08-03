SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_ADM_TABLE_GENERATION_COUNT] (
		[TABLE_GENERATION_COUNT_URN]     [int] IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
		[TABLE_NAME]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[GENERATION_COUNT]               [bigint] NOT NULL,
		[CREATION_DATE]                  [datetime] NOT NULL,
		[MODIFIED_DATE]                  [datetime] NOT NULL,
		CONSTRAINT [UN_TS_ADM_TABLE_GENERATION_COUNT]
		UNIQUE
		CLUSTERED
		([TABLE_NAME])
		ON [STGINDEXGROUP],
		CONSTRAINT [PK_TS_ADM_TABLE_GENERATION_COUNT]
		PRIMARY KEY
		NONCLUSTERED
		([TABLE_GENERATION_COUNT_URN])
	ON [STGGROUP]
) ON [STGINDEXGROUP]
GO
ALTER TABLE [dbo].[TS_ADM_TABLE_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_TABLE_GENERATION_COUNT_GENERATION_COUNT]
	DEFAULT ((0)) FOR [GENERATION_COUNT]
GO
ALTER TABLE [dbo].[TS_ADM_TABLE_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_TABLE_GENERATION_COUNT_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TS_ADM_TABLE_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_TABLE_GENERATION_COUNT_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the generation count data for all the relevant tables in the database. This is used by the application search service to decide what tables in the database have changed with respect to the data within the table. This table is not replicated. The data in this tables are inserted, updated or deleted by various triggers on the relevant database tables.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TABLE_GENERATION_COUNT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TABLE_GENERATION_COUNT', 'COLUMN', N'TABLE_GENERATION_COUNT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the database table for which generation count is created.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TABLE_GENERATION_COUNT', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an auto incrementing number corresponding to the number of times the data in the corresponding table has changed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TABLE_GENERATION_COUNT', 'COLUMN', N'GENERATION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TABLE_GENERATION_COUNT', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TABLE_GENERATION_COUNT', 'COLUMN', N'MODIFIED_DATE'
GO
GRANT SELECT
	ON [dbo].[TS_ADM_TABLE_GENERATION_COUNT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_ADM_TABLE_GENERATION_COUNT] SET (LOCK_ESCALATION = TABLE)
GO
