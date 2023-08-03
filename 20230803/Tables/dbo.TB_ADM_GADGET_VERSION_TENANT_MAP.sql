SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[GADGET_VERSION_ID]       [uniqueidentifier] NOT NULL,
		[TENANT_ID]               [uniqueidentifier] NOT NULL,
		[BROWSE_ENABLED]          [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_GADGET_VERSION_TENANT_MAP]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_TENANT_MAP_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_TENANT_MAP_BROWSE_ENABLED]
	DEFAULT ((1)) FOR [BROWSE_ENABLED]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_TENANT_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_TENANT_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_TENANT_MAP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_TENANT_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_VERSION_TENANT_MAP_TB_ADM_GADGET_VERSION_GADGET_VERSION_ID]
	FOREIGN KEY ([GADGET_VERSION_ID]) REFERENCES [dbo].[TB_ADM_GADGET_VERSION] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_VERSION_TENANT_MAP_TB_ADM_GADGET_VERSION_GADGET_VERSION_ID]

GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_VERSION_TENANT_MAP_TB_SEC_FOLDER_TENANT_ID]
	FOREIGN KEY ([TENANT_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_VERSION_TENANT_MAP_TB_SEC_FOLDER_TENANT_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table provides a mapping between a gadget version and the tenants that version is enabled for (licensing).', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for this mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_GADGET_VERSION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'GADGET_VERSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a tenant folder in TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'TENANT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if the specified tenant can browse this gadget version.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'BROWSE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the mapping was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the mapping was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION_TENANT_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION_TENANT_MAP] SET (LOCK_ESCALATION = TABLE)
GO
