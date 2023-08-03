SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_FCT_PARTITION] (
		[FACT_PARTITION_ID]              [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[RESOURCE_INSTANCE_ID]           [uniqueidentifier] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[PARTITION_TABLE_NAME]           [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[START_DATE_TIME]                [datetime] NULL,
		[END_DATE_TIME]                  [datetime] NULL,
		[CREATION_DATE]                  [datetime] NOT NULL,
		[ONLINE_DATE]                    [datetime] NULL,
		[OFFLINE_DATE]                   [datetime] NULL,
		[DROP_DATE]                      [datetime] NULL,
		[NEXT_AVAILABLE_IDENTITY]        [int] NOT NULL,
		[FACT_PARTITION_METADATA_ID]     [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_IMP_FCT_PARTITION]
		UNIQUE
		NONCLUSTERED
		([RESOURCE_INSTANCE_ID], [FACT_PARTITION_METADATA_ID], [PARTITION_ID])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_IMP_FCT_PARTITION]
		PRIMARY KEY
		CLUSTERED
		([FACT_PARTITION_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_FACT_FACT_PARTITION_ID]
	DEFAULT (newid()) FOR [FACT_PARTITION_ID]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_NEXT_AVAILABLE_IDENTITY]
	DEFAULT ((1)) FOR [NEXT_AVAILABLE_IDENTITY]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	ADD
	CONSTRAINT [DF_TB_IMP_FCT_PARTITION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TB_CLU_RESOURCE_INSTANCE]
	FOREIGN KEY ([RESOURCE_INSTANCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE] ([RESOURCE_INSTANCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TB_CLU_RESOURCE_INSTANCE]

GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TB_IMP_FCT_PARTITION_METADATA]
	FOREIGN KEY ([FACT_PARTITION_METADATA_ID]) REFERENCES [dbo].[TB_IMP_FCT_PARTITION_METADATA] ([FACT_PARTITION_METADATA_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION]
	CHECK CONSTRAINT [FK_TB_IMP_FCT_PARTITION_TB_IMP_FCT_PARTITION_METADATA]

GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_PARTITION_FACT_PARTITION_METADATA_ID_RESOURCE_INSTANCE_ID_DROP_DATE]
	ON [dbo].[TB_IMP_FCT_PARTITION] ([FACT_PARTITION_METADATA_ID], [RESOURCE_INSTANCE_ID], [DROP_DATE])
	INCLUDE ([PARTITION_ID], [NEXT_AVAILABLE_IDENTITY])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_PARTITION_PARTITION_TABLE_NAME_RESOURCE_INSTANCE_ID]
	ON [dbo].[TB_IMP_FCT_PARTITION] ([PARTITION_TABLE_NAME], [RESOURCE_INSTANCE_ID])
	INCLUDE ([FACT_PARTITION_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_PARTITION_RESOURCE_INSTANCE_ID_EXTENDED_1]
	ON [dbo].[TB_IMP_FCT_PARTITION] ([RESOURCE_INSTANCE_ID], [START_DATE_TIME], [FACT_PARTITION_METADATA_ID], [PARTITION_ID])
	INCLUDE ([END_DATE_TIME])
	ON [ADMINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_FCT_PARTITION_AUDIT_ARCHIVE_SUPPPORT]
	ON [dbo].[TB_IMP_FCT_PARTITION] ([FACT_PARTITION_METADATA_ID], [RESOURCE_INSTANCE_ID], [PARTITION_TABLE_NAME], [START_DATE_TIME], [END_DATE_TIME])
	WHERE (([DROP_DATE] IS NULL))
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the information about the fact and summary data objects into which data has been imported by the data importer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'FACT_PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the source from TB_CLU_RESOURCE from which the data has been imported.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'RESOURCE_INSTANCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the partition number of the underlying parition table for the fact or summary data into which data has been imported.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the full name of the partition table in the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'PARTITION_TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minimum datetime for the table selector field in this partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum datetime for the table selector field in this partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the partition was first created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the partition was moved into the partitioned view.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'ONLINE_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the partition was moved out of the partitioned view.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'OFFLINE_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the partition was dropped from the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'DROP_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an integer value that indicates the next available identity value for the partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'NEXT_AVAILABLE_IDENTITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Id of the metadata definition from TB_IMP_FCT_PARTITION_METADATA that this partition derives from.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'FACT_PARTITION_METADATA_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_FCT_PARTITION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_IMP_FCT_PARTITION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_IMP_FCT_PARTITION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_IMP_FCT_PARTITION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_IMP_FCT_PARTITION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_IMP_FCT_PARTITION] SET (LOCK_ESCALATION = TABLE)
GO
