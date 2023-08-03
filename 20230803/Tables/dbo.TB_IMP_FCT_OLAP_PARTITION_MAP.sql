SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] (
		[OLAP_PARTITION_MAP_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FACT_PARTITION_ID]         [uniqueidentifier] NOT NULL,
		[LAST_HIGH_WATER]           [int] NOT NULL,
		[OLAP_PARTITION_ID]         [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_FCT_OLAP_PARTITION_MAP]
		UNIQUE
		NONCLUSTERED
		([FACT_PARTITION_ID], [OLAP_PARTITION_ID])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_IMP_FCT_OLAP_PARTITION_MAP]
		PRIMARY KEY
		CLUSTERED
		([OLAP_PARTITION_MAP_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_OLAP_PARTITION_MAP_OLAP_PARTITION_MAP_ID]
	DEFAULT (newid()) FOR [OLAP_PARTITION_MAP_ID]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_OLAP_PARTITION_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_MAP_TB_IMP_FCT_PARTITION]
	FOREIGN KEY ([FACT_PARTITION_ID]) REFERENCES [dbo].[TB_IMP_FCT_PARTITION] ([FACT_PARTITION_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_MAP_TB_IMP_FCT_PARTITION]

GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_MAP_TB_IMP_FCT_OLAP_PARTITION]
	FOREIGN KEY ([OLAP_PARTITION_ID]) REFERENCES [dbo].[TB_IMP_FCT_OLAP_PARTITION] ([OLAP_PARTITION_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_MAP_TB_IMP_FCT_OLAP_PARTITION]

GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_OLAP_PARTITION_MAP_OLAP_PARTITION_ID]
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] ([OLAP_PARTITION_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the fact or summary data that have been imported into the RDBMS and how much has been processed into OLAP. This table is populated and updated by the OLAP data processor.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION_MAP', 'COLUMN', N'OLAP_PARTITION_MAP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from TB_IMP_FCT_PARTITION corresponding to the RDBMS fact or summary partition that has been processed into OLAP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION_MAP', 'COLUMN', N'FACT_PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the tidemark corresponding to the data in the fact or summary partition tables that have been processed into the OLAP database. This corresponds to the highest URN from the fact or summary partition table up to which the data is processed in the current partition of the current OLAP object.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION_MAP', 'COLUMN', N'LAST_HIGH_WATER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the identity of the OLAP Partition maintained in TB_IMP_OLAP_PARTITION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION_MAP', 'COLUMN', N'OLAP_PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] SET (LOCK_ESCALATION = TABLE)
GO
