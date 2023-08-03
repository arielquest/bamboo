SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_TABLE_CHECKSUM] (
		[TABLE_CHECKSUM_URN]      [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NOT NULL,
		[IMPORT_NAME]             [nvarchar](215) COLLATE Latin1_General_CI_AS NOT NULL,
		[TABLE_NAME]              [nvarchar](215) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAST_CHECKSUM]           [bigint] NOT NULL,
		[LAST_IMPORT_DATE]        [datetime] NOT NULL,
		[TIDEMARK]                [nvarchar](32) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_TABLE_CHECKSUM]
		UNIQUE
		NONCLUSTERED
		([CLUSTER_RESOURCE_ID], [IMPORT_NAME], [TABLE_NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_IMP_TABLE_CHECKSUM]
		PRIMARY KEY
		CLUSTERED
		([TABLE_CHECKSUM_URN])
	WITH FILLFACTOR=80
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_TABLE_CHECKSUM]
	ADD
	CONSTRAINT [DF_TB_IMP_TABLE_CHECKSUM_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_TABLE_CHECKSUM]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_TABLE_CHECKSUM_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_TABLE_CHECKSUM]
	CHECK CONSTRAINT [FK_TB_IMP_TABLE_CHECKSUM_TB_CLU_RESOURCE]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables stores the checksums for remote tables on a per cluster, per import basis. It is used to determine if a specified import needs to run', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'TABLE_CHECKSUM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Resource id of the database on which the specified table resides.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the import to which this table checksum relates.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'IMPORT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the remote table that this checksum was generated on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Checksum of the table the last time a successful import was run.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'LAST_CHECKSUM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'End date of the last successful import', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'LAST_IMPORT_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Column for storing the current tidemark for this table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'TIDEMARK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_TABLE_CHECKSUM', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_TABLE_CHECKSUM]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_IMP_TABLE_CHECKSUM] SET (LOCK_ESCALATION = TABLE)
GO
