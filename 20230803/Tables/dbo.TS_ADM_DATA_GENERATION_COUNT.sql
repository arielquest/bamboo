SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT] (
		[TABLE_GENERATION_COUNT_URN]     [int] NOT NULL,
		[GUID_KEY]                       [uniqueidentifier] NULL,
		[INT_KEY]                        [int] NULL,
		[GENERATION_COUNT]               [bigint] NOT NULL,
		[CREATE_GENERATION_COUNT]        [bigint] NOT NULL,
		[LAST_OPERATION]                 [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATION_DATE]                  [datetime] NOT NULL,
		[MODIFIED_DATE]                  [datetime] NOT NULL
) ON [STGGROUP]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	ADD
	CONSTRAINT [CK_TS_ADM_DATA_GENERATION_COUNT]
	CHECK
	([LAST_OPERATION]='D' OR [LAST_OPERATION]='U' OR [LAST_OPERATION]='I')
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
CHECK CONSTRAINT [CK_TS_ADM_DATA_GENERATION_COUNT]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_DATA_GENERATION_COUNT_GENERATION_COUNT]
	DEFAULT ((0)) FOR [GENERATION_COUNT]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_DATA_GENERATION_COUNT_CREATE_GENERATION_COUNT]
	DEFAULT ((0)) FOR [CREATE_GENERATION_COUNT]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_DATA_GENERATION_COUNT_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	ADD
	CONSTRAINT [DF_TS_ADM_DATA_GENERATION_COUNT_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TS_ADM_DATA_GENERATION_COUNT_TS_ADM_TABLE_GENERATION_COUNT]
	FOREIGN KEY ([TABLE_GENERATION_COUNT_URN]) REFERENCES [dbo].[TS_ADM_TABLE_GENERATION_COUNT] ([TABLE_GENERATION_COUNT_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	CHECK CONSTRAINT [FK_TS_ADM_DATA_GENERATION_COUNT_TS_ADM_TABLE_GENERATION_COUNT]

GO
CREATE CLUSTERED INDEX [PK_TS_ADM_DATA_GENERATION_COUNT]
	ON [dbo].[TS_ADM_DATA_GENERATION_COUNT] ([GUID_KEY], [INT_KEY])
	ON [STGGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TS_ADM_DATA_GENERATION_COUNT_INT_KEY]
	ON [dbo].[TS_ADM_DATA_GENERATION_COUNT] ([TABLE_GENERATION_COUNT_URN], [INT_KEY])
	INCLUDE ([GENERATION_COUNT], [LAST_OPERATION])
	ON [STGGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TS_ADM_DATA_GENERATION_COUNT_GUID_KEY]
	ON [dbo].[TS_ADM_DATA_GENERATION_COUNT] ([TABLE_GENERATION_COUNT_URN], [GUID_KEY])
	INCLUDE ([GENERATION_COUNT], [LAST_OPERATION])
	ON [STGGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the generation count data for all records in the relevant tables in the database. This is used by the application search service to decide what records in any specific table in the database have changed. This table is not replicated. The data in this tables are inserted, updated or deleted by various triggers on the relevant database tables.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TS_ADM_TABLE_GENERATION_COUNT corresponding to the table associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'TABLE_GENERATION_COUNT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If specified, this is the primary key value of type uniqueidentifier of the record in the corresponding table that has changed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'GUID_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If specified, this is the primary key value of type integer of the record in the corresponding table that has changed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'INT_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an auto incrementing number corresponding to the number of times the specific record in the corresponding table has changed. ', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'GENERATION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an auto incrementing number corresponding to the generation count the specific record in the corresponding table had when it was created.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'CREATE_GENERATION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charator flag indicating the last operation that that was executed against the specific record in the corresponding table. Possible values are I: Insert, U: Update; D: Delete.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'LAST_OPERATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_DATA_GENERATION_COUNT', 'COLUMN', N'MODIFIED_DATE'
GO
GRANT SELECT
	ON [dbo].[TS_ADM_DATA_GENERATION_COUNT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_ADM_DATA_GENERATION_COUNT] SET (LOCK_ESCALATION = TABLE)
GO
