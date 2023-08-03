SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE] (
		[PARTITION_TIDEMARK_SLICE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[PARTITION_TIDEMARK_ID]           [uniqueidentifier] NOT NULL,
		[SLICE_COLUMN]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[SLICE_KEYS]                      [nvarchar](2856) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]             [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
		UNIQUE
		NONCLUSTERED
		([PARTITION_TIDEMARK_ID], [SLICE_COLUMN])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_TIDEMARK_SLICE_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_SLICE_PARTITION_TIDEMARK_SLICE_ID]
	DEFAULT (newid()) FOR [PARTITION_TIDEMARK_SLICE_ID]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_SLICE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TIDEMARK_SLICE_TB_IMP_FCT_PARTITION_TIDEMARK]
	FOREIGN KEY ([PARTITION_TIDEMARK_ID]) REFERENCES [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] ([PARTITION_TIDEMARK_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TIDEMARK_SLICE_TB_IMP_FCT_PARTITION_TIDEMARK]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the slice information for each of the tidemarks for the fact and summary partitions into which data has been imported by the data importer. This is used by the OLAP processor for processing data from RDBMS into OLAP. The slice information is generally a column name and a set of URNs corresponding to the column name. For example, for a partition fact, the slice column can be a field called DATE_URN and the slice keys can be a set of Date URNs separated by commas.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK_SLICE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK_SLICE', 'COLUMN', N'PARTITION_TIDEMARK_SLICE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the partition tidemark from TB_IMP_FCT_PARTITON_TIDEMARK corresponding to the slice information. This is a foreign key to TB_IMP_FCT_PARTITON_TIDEMARK.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK_SLICE', 'COLUMN', N'PARTITION_TIDEMARK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the column in the fact table partition correponding to the current slice.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK_SLICE', 'COLUMN', N'SLICE_COLUMN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a comma separated values corresponding to SLICE_COLUMN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK_SLICE', 'COLUMN', N'SLICE_KEYS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK_SLICE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE] SET (LOCK_ESCALATION = TABLE)
GO
