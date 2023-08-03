SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING] (
		[ID]                             [uniqueidentifier] NOT NULL,
		[CLUSTER_RESOURCE_ID]            [uniqueidentifier] NOT NULL,
		[ENTITY_TYPE_ID]                 [uniqueidentifier] NOT NULL,
		[IMPORT_ENABLED]                 [bit] NOT NULL,
		[PROVISIONING_ENABLED]           [bit] NOT NULL,
		[CACHE_ENABLED]                  [bit] NOT NULL,
		[SOURCE_CLUSTER_RESOURCE_ID]     [uniqueidentifier] NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
		UNIQUE
		CLUSTERED
		([CLUSTER_RESOURCE_ID], [ENTITY_TYPE_ID], [SOURCE_CLUSTER_RESOURCE_ID])
		ON [ADMGROUP],
		CONSTRAINT [PK_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
		PRIMARY KEY
		NONCLUSTERED
		([ID])
	ON [ADMINDEXGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_PROVISIONING_ENABLED]
	DEFAULT ((1)) FOR [PROVISIONING_ENABLED]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_CACHE_ENABLED]
	DEFAULT ((1)) FOR [CACHE_ENABLED]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_IMPORT_ENABLED]
	DEFAULT ((1)) FOR [IMPORT_ENABLED]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_TB_CLU_RESOURCE_SOURCE]
	FOREIGN KEY ([SOURCE_CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_TB_CLU_RESOURCE_SOURCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_ENTITY_TYPE_ID]
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING] ([ENTITY_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING_SOURCE_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING] ([SOURCE_CLUSTER_RESOURCE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores information about various settings between a resource item type, exony service and source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is a foreign key to table TB_CLU_RESOURCE indicating the exony service associated with the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is a foreign key to table TE_DIM_ITEM_TYPE indicating the resource item type associated with the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'ENTITY_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether items of the specified resource item type is enabled for import from the mapped equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'IMPORT_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a flag indicating whether items of the specified resource item type is enabled for provisioning to the mapped equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'PROVISIONING_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether items of the specified resource item type are loaded into the associated exony service''s data cache.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'CACHE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is a foreign key to table TB_CLU_RESOURCE indicating the remote equipment associated with the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'SOURCE_CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING] SET (LOCK_ESCALATION = TABLE)
GO
