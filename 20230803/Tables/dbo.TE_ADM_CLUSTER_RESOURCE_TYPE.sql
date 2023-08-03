SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] (
		[CLUSTER_RESOURCE_TYPE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                         [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]                [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                  [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[RESOURCE_TYPE_GROUP_ID]       [uniqueidentifier] NULL,
		[SYSTEM]                       [bit] NOT NULL,
		[DELETED]                      [bit] NOT NULL,
		[MIN_RESOURCES]                [int] NOT NULL,
		[MAX_RESOURCES]                [int] NULL,
		[MIN_RESOURCE_INSTANCES]       [int] NOT NULL,
		[MAX_RESOURCE_INSTANCES]       [int] NULL,
		[IMPORT_SUPPORTED]             [bit] NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_ADM_CLUSTER_RESOURCE_TYPE]
		PRIMARY KEY
		CLUSTERED
		([CLUSTER_RESOURCE_TYPE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_CLUSTER_RESOURCE_TYPE_ID]
	DEFAULT (newid()) FOR [CLUSTER_RESOURCE_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_IMPORT_MIN_RESOURCES]
	DEFAULT ((0)) FOR [MIN_RESOURCES]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_IMPORT_MIN_RESOURCE_INSTANCES]
	DEFAULT ((0)) FOR [MIN_RESOURCE_INSTANCES]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_IMPORT_SUPPORTED]
	DEFAULT ((0)) FOR [IMPORT_SUPPORTED]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	ADD
	CONSTRAINT [DF_TE_ADM_CLUSTER_RESOURCE_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_ADM_CLUSTER_RESOURCE_TYPE_RESOURCE_TYPE_GROUP_ID]
	FOREIGN KEY ([RESOURCE_TYPE_GROUP_ID]) REFERENCES [dbo].[TE_CLU_RESOURCE_TYPE_GROUP] ([RESOURCE_TYPE_GROUP_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	CHECK CONSTRAINT [FK_TE_ADM_CLUSTER_RESOURCE_TYPE_RESOURCE_TYPE_GROUP_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CLUSTER_RESOURCE_TYPE_RESOURCE_TYPE_GROUP_ID]
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] ([RESOURCE_TYPE_GROUP_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the possible cluster resource types for resources (in TB_CLU_RESOURCE) in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'CLUSTER_RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the cluster resource type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the cluster resource type. This is unique. This name is prefixed with CRT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the cluster resource type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates the group (if any) that this resource type is linked to in TE_CLU_RESOURCE_TYPE_GROUP.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'RESOURCE_TYPE_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates that this item was created by the installer.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this item is deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The minimum number of resources of this type that should exist in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'MIN_RESOURCES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of resources of this type that should exist in the system. A null value means unlimited.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'MAX_RESOURCES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The minimum number of resource instances of this type that should exist in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'MIN_RESOURCE_INSTANCES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of resource instances of this type that should exist in the system. A null value means unlimited.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'MAX_RESOURCE_INSTANCES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if we support importing data from this resource type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'IMPORT_SUPPORTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CLUSTER_RESOURCE_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
