SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_XML_DEFAULTS] (
		[XML_DEFAULTS_URN]             [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_TYPE_ID]                 [uniqueidentifier] NULL,
		[MEMBER_TYPE_ID]               [uniqueidentifier] NULL,
		[CLUSTER_RESOURCE_TYPE_ID]     [uniqueidentifier] NULL,
		[TYPE_CHARACTER]               [char](1) COLLATE Latin1_General_CI_AS NULL,
		[TABLE_NAME]                   [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[DEFAULT_XML]                  [xml] NULL,
		[CUSTOM]                       [bit] NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TYPE_ID_CLUSTER_RESOURCE_TYPE_TABLE_CUSTOM]
		UNIQUE
		NONCLUSTERED
		([ITEM_TYPE_ID], [MEMBER_TYPE_ID], [CLUSTER_RESOURCE_TYPE_ID], [TYPE_CHARACTER], [TABLE_NAME], [CUSTOM])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_XML_DEFAULTS]
		PRIMARY KEY
		CLUSTERED
		([XML_DEFAULTS_URN])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	ADD
	CONSTRAINT [DF_TB_ADM_XML_DEFAULTS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_XML_DEFAULTS_TE_DIM_MEMBER_TYPE]
	FOREIGN KEY ([MEMBER_TYPE_ID]) REFERENCES [dbo].[TE_DIM_MEMBER_TYPE] ([MEMBER_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	CHECK CONSTRAINT [FK_TB_ADM_XML_DEFAULTS_TE_DIM_MEMBER_TYPE]

GO
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_XML_DEFAULTS_TE_ADM_CLUSTER_RESOURCE_TYPE]
	FOREIGN KEY ([CLUSTER_RESOURCE_TYPE_ID]) REFERENCES [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] ([CLUSTER_RESOURCE_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	CHECK CONSTRAINT [FK_TB_ADM_XML_DEFAULTS_TE_ADM_CLUSTER_RESOURCE_TYPE]

GO
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_XML_DEFAULTS_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS]
	CHECK CONSTRAINT [FK_TB_ADM_XML_DEFAULTS_TE_DIM_ITEM_TYPE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_XML_DEFAULTS_CLUSTER_RESOURCE_TYPE_ID]
	ON [dbo].[TB_ADM_XML_DEFAULTS] ([CLUSTER_RESOURCE_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_XML_DEFAULTS_MEMBER_TYPE_ID]
	ON [dbo].[TB_ADM_XML_DEFAULTS] ([MEMBER_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains default xml definitions', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'XML_DEFAULTS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The item type this xml relates to (if applicable)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The member type this xml relates to (if applicable)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'MEMBER_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The cluster resource type this xml relates to (if applicable)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'CLUSTER_RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type this xml related to (if applicable)', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'TYPE_CHARACTER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates which table this xml targets', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The default xml data', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'DEFAULT_XML'
GO
EXEC sp_addextendedproperty N'MS_Description', N'IS CUSTOM XML TEMPLATE OR NOT', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'CUSTOM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_XML_DEFAULTS', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_ADM_XML_DEFAULTS]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_ADM_XML_DEFAULTS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_XML_DEFAULTS]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_ADM_XML_DEFAULTS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_XML_DEFAULTS] SET (LOCK_ESCALATION = TABLE)
GO
