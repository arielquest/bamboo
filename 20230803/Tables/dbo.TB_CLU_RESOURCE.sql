SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CLU_RESOURCE] (
		[RESOURCE_ID]             [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[RESOURCE_TYPE_ID]        [uniqueidentifier] NOT NULL,
		[VERSION]                 [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CREATED_DATE]            [smalldatetime] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[PROVISIONABLE]           [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[RESOURCE_URN]            [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_CLU_RESOURCE_RESOURCE_URN]
		UNIQUE
		NONCLUSTERED
		([RESOURCE_URN])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_CLU_RESOURCE]
		PRIMARY KEY
		CLUSTERED
		([RESOURCE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_RESOURCE_ID]
	DEFAULT (newid()) FOR [RESOURCE_ID]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_CREATED_DATE]
	DEFAULT (getutcdate()) FOR [CREATED_DATE]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_PROVISIONABLE]
	DEFAULT ((0)) FOR [PROVISIONABLE]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_TE_ADM_RESOURCE_TYPE]
	FOREIGN KEY ([RESOURCE_TYPE_ID]) REFERENCES [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] ([CLUSTER_RESOURCE_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_TE_ADM_RESOURCE_TYPE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_RESOURCE_TYPE_ID]
	ON [dbo].[TB_CLU_RESOURCE] ([RESOURCE_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the logical resources configured under cluster management.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the type of the logical resource. This is a foreign key to TE_ADM_CLUSTER_RESOURCE_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the version of the logical resource if applies.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the logical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the logical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC datetime representing when the logical resource was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'CREATED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the logical resource has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether provisioning operations can be performed on the logical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'PROVISIONABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the logical resource is owned by system or not. Value of 1 indicates system owned logical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this item', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Alternate Key identifier for the record. May be used to stamp fact/summary data with the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE] SET (LOCK_ESCALATION = TABLE)
GO
