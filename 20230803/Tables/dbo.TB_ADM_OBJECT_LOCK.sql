SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_OBJECT_LOCK] (
		[OBJECT_LOCK_ID]          [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[OBJECT_NAME]             [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[LOCKED_AT]               [datetime] NOT NULL,
		[SESSION_ID]              [uniqueidentifier] NOT NULL,
		[NESTED_LOCK_COUNT]       [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_OBJECT_LOCK]
		UNIQUE
		NONCLUSTERED
		([OBJECT_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_OBJECT_LOCK]
		PRIMARY KEY
		CLUSTERED
		([OBJECT_LOCK_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_OBJECT_LOCK]
	ADD
	CONSTRAINT [DF_TB_ADM_OBJECT_LOCK_OBJECT_LOCK_ID]
	DEFAULT (newid()) FOR [OBJECT_LOCK_ID]
GO
ALTER TABLE [dbo].[TB_ADM_OBJECT_LOCK]
	ADD
	CONSTRAINT [DF_TB_ADM_OBJECT_LOCK_NESTED_LOCK_COUNT]
	DEFAULT ((0)) FOR [NESTED_LOCK_COUNT]
GO
ALTER TABLE [dbo].[TB_ADM_OBJECT_LOCK]
	ADD
	CONSTRAINT [DF_TB_ADM_OBJECT_LOCK_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_OBJECT_LOCK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_OBJECT_LOCK_TB_ADM_SESSION]
	FOREIGN KEY ([SESSION_ID]) REFERENCES [dbo].[TB_ADM_SESSION] ([SESSION_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_OBJECT_LOCK]
	CHECK CONSTRAINT [FK_TB_ADM_OBJECT_LOCK_TB_ADM_SESSION]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_OBJECT_LOCK_SESSION_ID]
	ON [dbo].[TB_ADM_OBJECT_LOCK] ([SESSION_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the processing locks acquired by the data importer or OLAP processor on various database tables or views.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Primary key for this table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', 'COLUMN', N'OBJECT_LOCK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the name of the object that the lock applies to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', 'COLUMN', N'OBJECT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the date time when the lock was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', 'COLUMN', N'LOCKED_AT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This session in which this lock was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times this lock has been acquired and not released', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', 'COLUMN', N'NESTED_LOCK_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OBJECT_LOCK', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_OBJECT_LOCK]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_OBJECT_LOCK]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OBJECT_LOCK]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_OBJECT_LOCK]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_OBJECT_LOCK] SET (LOCK_ESCALATION = TABLE)
GO
