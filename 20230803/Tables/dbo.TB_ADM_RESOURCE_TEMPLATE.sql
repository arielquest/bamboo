SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[RESOURCE_TYPE_ID]        [uniqueidentifier] NOT NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[TEMPLATE_DATA]           [xml](DOCUMENT [dbo].[ResourceTemplate]) NOT NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_RESOURCE_TEMPLATE]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [CK_TB_ADM_RESOURCE_TEMPLATE_NAME]
	CHECK
	(NOT [NAME] like '%[<>:"/\|?*]%' AND rtrim(ltrim([NAME]))<>'')
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
CHECK CONSTRAINT [CK_TB_ADM_RESOURCE_TEMPLATE_NAME]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_TEMPLATE_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_TEMPLATE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_TEMPLATE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_TEMPLATE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_TEMPLATE_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_TEMPLATE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_SEC_FOLDER_FOLDER_ID]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_SEC_FOLDER_FOLDER_ID]

GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_CLU_RESOURCE_CLUSTER_RESOURCE_ID]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_CLU_RESOURCE_CLUSTER_RESOURCE_ID]

GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_TEMPLATE_TB_SEC_USER_MODIFIED_BY_ID]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_ADM_RESOURCE_TEMPLATE_NAME_FOLDER_ID]
	ON [dbo].[TB_ADM_RESOURCE_TEMPLATE] ([NAME], [FOLDER_ID])
	WHERE (([DELETED]=(0)))
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains templates for use when creating resources. Templates contain additional fields that should be set when creating the resource on remote equipment but are not stored in the Analytics DB.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for this template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Location of the template, foreign key on TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identifier for the resource type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Optional foreign key to TB_CLU_RESOURCE defining the cluster that this template can be used for.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Description for the template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_SEC_USER defining the user who created the tenplate.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_SEC_USER defining the user who last mnodified the tenplate.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'UTC date time stamp indicating when the tenplate was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'UTC date time stamp indicating when the tenplate was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether the tenplate has been deleted. A value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Incrementing umber indicating the change stamp for the template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The actual template definition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'TEMPLATE_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Custom attributes for this template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_TEMPLATE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_RESOURCE_TEMPLATE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_TEMPLATE] SET (LOCK_ESCALATION = TABLE)
GO
