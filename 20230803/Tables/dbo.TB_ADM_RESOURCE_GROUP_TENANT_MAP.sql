SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[RESOURCE_GROUP_ID]       [uniqueidentifier] NOT NULL,
		[TENANT_ID]               [uniqueidentifier] NOT NULL,
		[BROWSE_ENABLED]          [bit] NOT NULL,
		[MANAGE_ENABLED]          [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_RESOURCE_GROUP_TENANT_MAP]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_TENANT_MAP_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TENANT_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TENANT_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TENANT_MAP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TENANT_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TB_ADM_RESOURCE_GROUP_RESOURCE_GROUP_ID]
	FOREIGN KEY ([RESOURCE_GROUP_ID]) REFERENCES [dbo].[TB_ADM_RESOURCE_GROUP] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TB_ADM_RESOURCE_GROUP_RESOURCE_GROUP_ID]

GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TB_SEC_FOLDER_TENANT_ID]
	FOREIGN KEY ([TENANT_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_GROUP_TENANT_MAP_TB_SEC_FOLDER_TENANT_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains an entry mapping a Resource Group (or groups) to 0 or more tenants. Where an entry exists in this table, it indicates that this group is enabled for the specified tenant.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for this mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_RESOURCE_GROUP defining the resource group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', 'COLUMN', N'RESOURCE_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a tenant folder in TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', 'COLUMN', N'TENANT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this resource group and resources attached to it can be browsed by users in the specified tenant.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', 'COLUMN', N'BROWSE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this resource group and resources attached to it can be managed by users in the specified tenant.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', 'COLUMN', N'MANAGE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP_TENANT_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP_TENANT_MAP] SET (LOCK_ESCALATION = TABLE)
GO
