SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_RELEASE_INFO] (
		[ID]                         [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PRODUCT_NAME]               [nvarchar](40) COLLATE Latin1_General_CI_AS NOT NULL,
		[COMPONENT_ID]               [uniqueidentifier] NULL,
		[COMPONENT_NAME]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[COMPONENT_SERVER_NAME]      [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[REGISTERED_DATE]            [datetime] NOT NULL,
		[RELEASE_NAME]               [nvarchar](20) COLLATE Latin1_General_CI_AS NOT NULL,
		[RELEASE_DESCRIPTION]        [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[RELEASE_MAJOR_VERSION]      [int] NOT NULL,
		[RELEASE_MINOR_VERSION]      [int] NULL,
		[RELEASE_HOTFIX_NUMBER]      [int] NULL,
		[RELEASE_ONE_OFF_NUMBER]     [int] NULL,
		[MAJOR_VERSION]              [int] NOT NULL,
		[MINOR_VERSION]              [int] NULL,
		[BUILD_VERSION]              [int] NULL,
		[REVISION_NUMBER]            [int] NULL,
		[RELEASE_VERSION]            AS (concat([RELEASE_MAJOR_VERSION],'.',isnull([RELEASE_MINOR_VERSION],(0)),'.',isnull([RELEASE_HOTFIX_NUMBER],(0)),'.',isnull([RELEASE_ONE_OFF_NUMBER],(0)))),
		[BUILD]                      AS (concat([MAJOR_VERSION],'.',isnull([MINOR_VERSION],(0)),'.',isnull([BUILD_VERSION],(0)),'.',isnull([REVISION_NUMBER],(0)))),
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_RELEASE_INFO]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO]
	ADD
	CONSTRAINT [CK_TB_ADM_RELEASE_INFO_COMPONENT]
	CHECK
	([COMPONENT_ID] IS NOT NULL AND [COMPONENT_NAME] IS NULL AND [COMPONENT_SERVER_NAME] IS NULL OR [COMPONENT_ID] IS NULL AND [COMPONENT_NAME] IS NOT NULL AND [COMPONENT_SERVER_NAME] IS NOT NULL)
GO
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO]
CHECK CONSTRAINT [CK_TB_ADM_RELEASE_INFO_COMPONENT]
GO
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_RELEASE_INFO_REGISTERED_DATE]
	DEFAULT (getutcdate()) FOR [REGISTERED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_RELEASE_INFO_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RELEASE_INFO_TB_CLU_RESOURCE_INSTANCE_COMPONENT_ID]
	FOREIGN KEY ([COMPONENT_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] ([COMPONENT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO]
	CHECK CONSTRAINT [FK_TB_ADM_RELEASE_INFO_TB_CLU_RESOURCE_INSTANCE_COMPONENT_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_RELEASE_INFO_RELEASE_COMPONENT_ID]
	ON [dbo].[TB_ADM_RELEASE_INFO] ([COMPONENT_ID])
	INCLUDE ([RELEASE_MAJOR_VERSION], [RELEASE_MINOR_VERSION], [RELEASE_HOTFIX_NUMBER], [RELEASE_ONE_OFF_NUMBER], [MAJOR_VERSION], [MINOR_VERSION], [BUILD_VERSION], [REVISION_NUMBER])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_RELEASE_INFO_RELEASE_COMPONENT_NAME_SERVER]
	ON [dbo].[TB_ADM_RELEASE_INFO] ([COMPONENT_NAME], [COMPONENT_SERVER_NAME])
	INCLUDE ([RELEASE_MAJOR_VERSION], [RELEASE_MINOR_VERSION], [RELEASE_HOTFIX_NUMBER], [RELEASE_ONE_OFF_NUMBER], [MAJOR_VERSION], [MINOR_VERSION], [BUILD_VERSION], [REVISION_NUMBER])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to store version information about the installed components.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the product that the referenced component has been installed against.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'PRODUCT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE_INSTANCE_COMPONENT corresponding to the component that has registered. This must not be NULL unless COMPONENT_NAME and COMPONENT_SERVER_NAME are NOT NULL.  This is a foreign key to TB_CLU_RESOURCE_INSTANCE_COMPONENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the component that has been registered.   This must not be NULL unless COMPONENT_ID is NOT NULL.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'COMPONENT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the server name where the registered component resides.   This must not be NULL unless COMPONENT_ID is NOT NULL.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'COMPONENT_SERVER_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time that the component registered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'REGISTERED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the release that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the description of the release that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the major version of the release that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_MAJOR_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minor version of the release that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_MINOR_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the hotfix number of the release that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_HOTFIX_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the one-off number of the release that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_ONE_OFF_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the major version of the build that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'MAJOR_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minor version of the build that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'MINOR_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the build version of the build that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'BUILD_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the revision number of the build that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'REVISION_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This computed column represents the release version that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'RELEASE_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This computed column represents the build version that contained this version of the registered component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'BUILD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RELEASE_INFO', 'COLUMN', N'msrepl_tran_version'
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portalrs_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portalreporting_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portalreporting_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portal_default_mediator_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portal_default_partitioning_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RELEASE_INFO]
	TO [portal_default_partitioning_role]
GO
ALTER TABLE [dbo].[TB_ADM_RELEASE_INFO] SET (LOCK_ESCALATION = TABLE)
GO
