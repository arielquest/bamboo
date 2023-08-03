SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] (
		[PARTITION_TIDEMARK_ID]        [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FACT_PARTITION_ID]            [uniqueidentifier] NOT NULL,
		[HIGH_WATER_BEFORE]            [int] NOT NULL,
		[HIGH_WATER_AFTER]             [int] NOT NULL,
		[IMPORT_COMPLETE_DATE]         [smalldatetime] NOT NULL,
		[CLUSTER_RESOURCE_ID]          [uniqueidentifier] NULL,
		[MIN_GLOBAL_PARTITION_URN]     [bigint] NOT NULL,
		[MAX_GLOBAL_PARTITION_URN]     [bigint] NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_IMP_FCT_PARTITION_TIDEMARK]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_TIDEMARK_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_PARTITION_TIDEMARK_ID]
	DEFAULT (newid()) FOR [PARTITION_TIDEMARK_ID]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_HIGH_WATER_BEFORE]
	DEFAULT ((0)) FOR [HIGH_WATER_BEFORE]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_HIGH_WATER_AFTER]
	DEFAULT ((0)) FOR [HIGH_WATER_AFTER]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_IMPORT_COMPLETE_DATE]
	DEFAULT (getutcdate()) FOR [IMPORT_COMPLETE_DATE]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_MIN_GLOBAL_PARTITION_URN]
	DEFAULT ((0)) FOR [MIN_GLOBAL_PARTITION_URN]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_MAX_GLOBAL_PARTITION_URN]
	DEFAULT ((0)) FOR [MAX_GLOBAL_PARTITION_URN]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_TIDEMARK_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TIDEMARK_TB_IMP_FCT_PARTITION]
	FOREIGN KEY ([FACT_PARTITION_ID]) REFERENCES [dbo].[TB_IMP_FCT_PARTITION] ([FACT_PARTITION_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TIDEMARK_TB_IMP_FCT_PARTITION]

GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TIDEMARK_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TIDEMARK_TB_CLU_RESOURCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_PARTITION_TIDEMARK_FACT_PARTITION_ID_PARTITION_TIDEMARK_ID]
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] ([FACT_PARTITION_ID], [PARTITION_TIDEMARK_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_PARTITION_TIDEMARK_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] ([CLUSTER_RESOURCE_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the tidemark information about the fact and summary partitions into which data has been imported by the data importer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'PARTITION_TIDEMARK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the partition from TB_IMP_FCT_PARTITION corresponding to the current tidemark. This is a foreign key to TB_IMP_FCT_PARTITION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'FACT_PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the starting tidemark value for the data when it was inserted into the corresponding partition table in the current batch. This is the URN in the underlying partition table for the partition defined by column FACT_PARTITION_ID in TB_IMP_FCT_PARTITION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'HIGH_WATER_BEFORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ending tidemark value for the data when it was inserted into the corresponding partition table in the current batch. This is the URN in the underlying partition table for the partition defined by column FACT_PARTITION_ID in TB_IMP_FCT_PARTITION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'HIGH_WATER_AFTER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'When the data between the low and high water mark was inserted into the partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'IMPORT_COMPLETE_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_CLU_RESOURCE indicating the source resource from which the chunk for data was imported from.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minimum global partition urn used in the partition table for the referenced cluster ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'MIN_GLOBAL_PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum global partition urn used in the partition table for the referenced cluster ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'MAX_GLOBAL_PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION_TIDEMARK', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] SET (LOCK_ESCALATION = TABLE)
GO
