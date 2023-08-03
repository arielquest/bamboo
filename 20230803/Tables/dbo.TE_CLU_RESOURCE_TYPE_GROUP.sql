SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP] (
		[RESOURCE_TYPE_GROUP_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                       [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]              [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[SYSTEM]                     [bit] NOT NULL,
		[DELETED]                    [bit] NOT NULL,
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_CLU_RESOURCE_TYPE_GROUP]
		PRIMARY KEY
		CLUSTERED
		([RESOURCE_TYPE_GROUP_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	ADD
	CONSTRAINT [DF_TE_CLU_RESOURCE_TYPE_GROUP_RESOURCE_TYPE_GROUP_ID]
	DEFAULT (newid()) FOR [RESOURCE_TYPE_GROUP_ID]
GO
ALTER TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	ADD
	CONSTRAINT [DF_TE_CLU_RESOURCE_TYPE_GROUP_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	ADD
	CONSTRAINT [DF_TE_CLU_RESOURCE_TYPE_GROUP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	ADD
	CONSTRAINT [DF_TE_CLU_RESOURCE_TYPE_GROUP_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	ADD
	CONSTRAINT [DF_TE_CLU_RESOURCE_TYPE_GROUP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the groups for cluster resources in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'RESOURCE_TYPE_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the cluster resource type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the cluster resource type. This is unique. This name is prefixed with CRT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the cluster resource type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates that this item was created by the installer.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this item is deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_CLU_RESOURCE_TYPE_GROUP', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TE_CLU_RESOURCE_TYPE_GROUP]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TE_CLU_RESOURCE_TYPE_GROUP] SET (LOCK_ESCALATION = TABLE)
GO
