SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_TABLE] (
		[TABLE_ID]                [uniqueidentifier] NOT NULL,
		[SYSOBJECT_NAME]          [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[REPLICATED]              [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[RESEED]                  [bit] NOT NULL,
		[RETAIN_DAYS]             [int] NOT NULL,
		[PURGE_DATE_KEY]          [nvarchar](128) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_TABLE_SYSOBJECT_NAME]
		UNIQUE
		NONCLUSTERED
		([SYSOBJECT_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_TABLE]
		PRIMARY KEY
		CLUSTERED
		([TABLE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_TABLE]
	ADD
	CONSTRAINT [DF_TB_ADM_TABLE_TABLE_ID]
	DEFAULT (newid()) FOR [TABLE_ID]
GO
ALTER TABLE [dbo].[TB_ADM_TABLE]
	ADD
	CONSTRAINT [DF_TB_ADM_TABLE_RETAIN_DAYS]
	DEFAULT ((-1)) FOR [RETAIN_DAYS]
GO
ALTER TABLE [dbo].[TB_ADM_TABLE]
	ADD
	CONSTRAINT [DF_TB_ADM_TABLE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds configruation information about all the relevant schema objects in the database. These configuration settings are for example, replication type, purge period and so on. The data in this table should not be modified unless specified otherwise.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'TABLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the schema object. This is ideally the name of the object in syobject system table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'SYSOBJECT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charator flag indicating whether the object is replicated and if it is, then which publication it belongs to. Possible values are B: Base Subscriber Wins publication; P: Base Publisher Wins publication; F: Fact publication; S: NonQueued publication; Z: Not replicated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'REPLICATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the object needs reseeding or not. This is used during replication and is valid for tables only. Value 1 indicates reseed required.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'RESEED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an integer corresponding to the number of days that the data has be retained in the object before they are purged. This is valid only for tables. Value -1 indicates data is not purged.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'RETAIN_DAYS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is string indicating the column name in the table based on which the data is purged from the table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'PURGE_DATE_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TABLE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_ADM_TABLE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_ADM_TABLE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_TABLE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_ADM_TABLE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_TABLE] SET (LOCK_ESCALATION = TABLE)
GO
