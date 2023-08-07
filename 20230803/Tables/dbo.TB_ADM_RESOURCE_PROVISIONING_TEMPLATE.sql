SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[RESOURCE_TYPE_ID]        [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[DELETED]                 [bit] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_PROVISIONING_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_PROVISIONING_TEMPLATE_TB_SEC_USER_MODIFIED_BY_ID]

GO
GRANT DELETE
	ON [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_PROVISIONING_TEMPLATE] SET (LOCK_ESCALATION = TABLE)
GO