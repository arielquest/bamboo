SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING] (
		[MAPPING_ID]                     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]                      [uniqueidentifier] NOT NULL,
		[RESOURCE_ID]                    [uniqueidentifier] NOT NULL,
		[DEFAULT_IMPORT_LOCATION]        [bit] NOT NULL,
		[REMOTE_TENANT_BUSINESS_URN]     [int] NULL,
		[MAPPING_TYPE]                   [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[XML_DATA]                       [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_CLU_RESOURCE_FOLDER_MAPPING]
		PRIMARY KEY
		CLUSTERED
		([MAPPING_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	ADD
	CONSTRAINT [CK_TB_CLU_RESOURCE_FOLDER_MAPPING_MAPPING_TYPE]
	CHECK
	([MAPPING_TYPE]='R' OR [MAPPING_TYPE]='I')
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
CHECK CONSTRAINT [CK_TB_CLU_RESOURCE_FOLDER_MAPPING_MAPPING_TYPE]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_FOLDER_MAPPING_MAPPING_ID]
	DEFAULT (newid()) FOR [MAPPING_ID]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_FOLDER_MAPPING_DEFAULT_IMPORT_LOCATION]
	DEFAULT ((0)) FOR [DEFAULT_IMPORT_LOCATION]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_FOLDER_MAPPING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_FOLDER_MAPPING_TB_CLU_RESOURCE]
	FOREIGN KEY ([RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_FOLDER_MAPPING_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_FOLDER_MAPPING_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_FOLDER_MAPPING_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_FOLDER_MAPPING_TB_DIM_TENANT]
	FOREIGN KEY ([REMOTE_TENANT_BUSINESS_URN]) REFERENCES [dbo].[TB_DIM_TENANT] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_FOLDER_MAPPING_TB_DIM_TENANT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_FOLDER_MAPPING_FOLDER_ID]
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING] ([FOLDER_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_FOLDER_MAPPING_REMOTE_TENANT_BUSINESS_URN]
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING] ([REMOTE_TENANT_BUSINESS_URN])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_FOLDER_MAPPING_RESOURCE_ID]
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING] ([RESOURCE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores mappings between tenants/folders and cluster resources. It is used by the importer to determine the default location for newly imported dimension data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'MAPPING_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_SEC_FOLDER indicating the tenant or folder that this mapping relates to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_CLU_RESOURCE indicating the resource that this mapping relates to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating that this folder is the default import location for dimensions on this cluster.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'DEFAULT_IMPORT_LOCATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'When set, indicates that all data mapping to the specified tenant dimension (for ICM a customer definition) should be imported to the specified folder. This lookup is evaluated before evaluating the DEFAULT_IMPORT_LOCATION flag.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'REMOTE_TENANT_BUSINESS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type of resource folder mapping. I = Import Rule, R = Resource Management Web Service', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'MAPPING_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this item', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_FOLDER_MAPPING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_FOLDER_MAPPING] SET (LOCK_ESCALATION = TABLE)
GO
