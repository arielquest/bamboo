SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE] (
		[RESOURCE_INSTANCE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[RESOURCE_ID]              [uniqueidentifier] NOT NULL,
		[IS_PUBLISHER]             [bit] NOT NULL,
		[SYSTEM]                   [bit] NOT NULL,
		[XML_DATA]                 [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[NAME]                     [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_CLU_RESOURCE_INSTANCE_RESOURCE_ID_NAME]
		UNIQUE
		NONCLUSTERED
		([RESOURCE_ID], [NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_CLU_RESOURCE_INSTANCE]
		PRIMARY KEY
		CLUSTERED
		([RESOURCE_INSTANCE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_INSTANCE_RESOURCE_INSTANCE_ID]
	DEFAULT (newid()) FOR [RESOURCE_INSTANCE_ID]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_INSTANCE_IS_PUBLISHER]
	DEFAULT ((0)) FOR [IS_PUBLISHER]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_INSTANCE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_INSTANCE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_INSTANCE_TB_CLU_RESOURCE]
	FOREIGN KEY ([RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_INSTANCE_TB_CLU_RESOURCE]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the physical resources configured under cluster management. A logical resource on a phyical server makes a physical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'RESOURCE_INSTANCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resource. This is a foreign key to TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the current physical resource is the primary for the logical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'IS_PUBLISHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the physical resource is owned by system or not. Value of 1 indicates system owned physical resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this item', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Display name for this resource instance', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_INSTANCE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_INSTANCE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_INSTANCE] SET (LOCK_ESCALATION = TABLE)
GO
