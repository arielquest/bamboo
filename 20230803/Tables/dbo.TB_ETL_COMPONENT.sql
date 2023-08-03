SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_COMPONENT] (
		[COMPONENT_ID]                            [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[COMPONENT_TYPE]                          [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PIPELINE_TYPE]                           [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[MASTER_SCRIPT_ID]                        [uniqueidentifier] NOT NULL,
		[RESOURCE_INSTANCE_COMPONENT_TYPE_ID]     [uniqueidentifier] NULL,
		[MIN_CLUSTER_RESOURCE_VERSION]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[MAX_CLUSTER_RESOURCE_VERSION]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ENABLED]                                 [bit] NOT NULL,
		[RESOURCE_NAME_REGEX]                     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[AUDITENABLED]                            [bit] NOT NULL,
		[SYSTEM]                                  [bit] NOT NULL,
		[msrepl_tran_version]                     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ETL_COMPONENT_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ETL_COMPONENT]
		PRIMARY KEY
		CLUSTERED
		([COMPONENT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_ETL_COMPONENT_PIPELINE_TYPE]
	CHECK
	NOT FOR REPLICATION
	([PIPELINE_TYPE]='D' OR [PIPELINE_TYPE]='T' OR [PIPELINE_TYPE]='S')
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
CHECK CONSTRAINT [CK_TB_ETL_COMPONENT_PIPELINE_TYPE]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_COMPONENT_ID]
	DEFAULT (newid()) FOR [COMPONENT_ID]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_AUDITENABLED]
	DEFAULT ((0)) FOR [AUDITENABLED]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE]
	FOREIGN KEY ([RESOURCE_INSTANCE_COMPONENT_TYPE_ID]) REFERENCES [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] ([COMPONENT_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE]

GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_TB_ETL_MASTER_SCRIPT]
	FOREIGN KEY ([MASTER_SCRIPT_ID]) REFERENCES [dbo].[TB_ETL_MASTER_SCRIPT] ([MASTER_SCRIPT_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_TB_ETL_MASTER_SCRIPT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_COMPONENT_MASTER_SCRIPT_ID]
	ON [dbo].[TB_ETL_COMPONENT] ([MASTER_SCRIPT_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_COMPONENT_RESOURCE_INSTANCE_COMPONENT_TYPE_ID]
	ON [dbo].[TB_ETL_COMPONENT] ([RESOURCE_INSTANCE_COMPONENT_TYPE_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the various ETL components configured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the ETL component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A brief description about the ETL component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string defining the ETL component type. This is used to determine what dynamic variables should be passed to the ETL component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'COMPONENT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a character flag indicating the pipeline type of the ETL component. Possible values are: S = Source Component, T = Data Transform Component, D = Destination Component', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'PIPELINE_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ETL_MASTER_SCRIPT defining the dtsx file to run for this component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'MASTER_SCRIPT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Defines the cluster resource component type that a Pipeline Source Component targets. Used by the service to determine what scripts need to be run.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'RESOURCE_INSTANCE_COMPONENT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Defines the minimum version of the cluster that a Pipeline Source Component targets. Used by the service to determine what scripts need to be run.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'MIN_CLUSTER_RESOURCE_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Defines the maximum version of the cluster that a Pipeline Source Component targets. Used by the service to determine what scripts need to be run.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'MAX_CLUSTER_RESOURCE_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the ETL component is enabled or not. If not enabled, the component will not take part in any ETL operations.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Regular expression used for checking which resources a resource type based component should be executed against. Ignored if NULL or empty.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'RESOURCE_NAME_REGEX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether auditing for the ETL component is enabled or not. If not enabled, the component will not produce audit records', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'AUDITENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating if this is a standard component which is shipped with the product.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT] SET (LOCK_ESCALATION = TABLE)
GO
