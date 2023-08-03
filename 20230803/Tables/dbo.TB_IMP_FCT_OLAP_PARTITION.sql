SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION] (
		[OLAP_PARTITION_ID]        [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[RESOURCE_INSTANCE_ID]     [uniqueidentifier] NOT NULL,
		[OLAP_OBJECT_URN]          [int] NOT NULL,
		[OLAP_PARTITION_NAME]      [nvarchar](250) COLLATE Latin1_General_CI_AS NOT NULL,
		[STATUS]                   [int] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_FCT_OLAP_PARTITION]
		UNIQUE
		NONCLUSTERED
		([RESOURCE_INSTANCE_ID], [OLAP_OBJECT_URN], [OLAP_PARTITION_NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_IMP_FCT_OLAP_PARTITION]
		PRIMARY KEY
		CLUSTERED
		([OLAP_PARTITION_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	ADD
	CONSTRAINT [CK_TB_IMP_FCT_OLAP_PARTITION]
	CHECK
	([STATUS]=(3) OR [STATUS]=(2) OR [STATUS]=(1) OR [STATUS]=(0))
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
CHECK CONSTRAINT [CK_TB_IMP_FCT_OLAP_PARTITION]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_OLAP_PARTITION_OLAP_PARTITION_ID]
	DEFAULT (newid()) FOR [OLAP_PARTITION_ID]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_OLAP_PARTITION_STATUS]
	DEFAULT ((0)) FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_OLAP_PARTITION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_TB_ADM_OLAP_OBJECT]
	FOREIGN KEY ([OLAP_OBJECT_URN]) REFERENCES [dbo].[TB_ADM_OLAP_OBJECT] ([OLAP_OBJECT_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_TB_ADM_OLAP_OBJECT]

GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_TB_CLU_RESOURCE_INSTANCE]
	FOREIGN KEY ([RESOURCE_INSTANCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE] ([RESOURCE_INSTANCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_OLAP_PARTITION_TB_CLU_RESOURCE_INSTANCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_OLAP_PARTITION_OLAP_OBJECT_URN]
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION] ([OLAP_OBJECT_URN])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about data partitions held in OLAP. This table is populated and updated by the OLAP data processor.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', 'COLUMN', N'OLAP_PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID of the related cluster resource instance of the OLAP server that owns this partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', 'COLUMN', N'RESOURCE_INSTANCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN of the OLAP object from TB_ADM_OLAP_OBJECT into which the data is processed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', 'COLUMN', N'OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the partition in the OLAP database corresponding to the data in the fact or summary partition tables.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', 'COLUMN', N'OLAP_PARTITION_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is and integer flag indicating the current status of the data processing in the OLAP database. This is updated by the OLAP processor. Value 0 indicates Ready; Value 1 indicates About to process; 2 indicates Processed (this is only used in TS_IMP_SUMMARIZED where Legacy methods and stored procedures are used); 3 indicates Reset required (if RDBMS fact data has been updated).', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_OLAP_PARTITION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_OLAP_PARTITION]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_OLAP_PARTITION] SET (LOCK_ESCALATION = TABLE)
GO
