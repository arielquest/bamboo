SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] (
		[CUSTOM_ATTRIBUTE_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_ID]      [uniqueidentifier] NOT NULL,
		[OWNER_ID]                 [uniqueidentifier] NULL,
		[ATTRIBUTE_TYPE]           [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[OBJ_TYPE]                 [nvarchar](250) COLLATE Latin1_General_CI_AS NOT NULL,
		[OBJ_INDEX]                [smallint] NOT NULL,
		[SOURCE_OBJ_NAME]          [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[SOURCE_ATT_NAME]          [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[SOURCE_ATT_DATA_TYPE]     [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[IS_ENUMERATED]            [bit] NOT NULL,
		[CREATED_BY_ID]            [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]           [uniqueidentifier] NOT NULL,
		[CREATION_DATE]            [datetime] NOT NULL,
		[MODIFIED_DATE]            [datetime] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_CUSTOM_ATTRIBUTE]
		PRIMARY KEY
		CLUSTERED
		([CUSTOM_ATTRIBUTE_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	ADD
	CONSTRAINT [CK_TB_ADM_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE]
	CHECK
	([ATTRIBUTE_TYPE]='F' OR [ATTRIBUTE_TYPE]='Z' OR [ATTRIBUTE_TYPE]='D')
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
CHECK CONSTRAINT [CK_TB_ADM_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	ADD
	CONSTRAINT [CK_TB_ADM_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_OBJ_INDEX]
	CHECK
	(case when [ATTRIBUTE_TYPE]='D' AND [OBJ_INDEX]=(-1) then (1) when ([ATTRIBUTE_TYPE]='D' OR [ATTRIBUTE_TYPE]='Z' OR [ATTRIBUTE_TYPE]='F') AND [OBJ_INDEX]>=(0) AND [OBJ_INDEX]<=(9) then (1) else (0) end=(1))
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
CHECK CONSTRAINT [CK_TB_ADM_CUSTOM_ATTRIBUTE_ATTRIBUTE_TYPE_OBJ_INDEX]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	ADD
	CONSTRAINT [DF_TB_ADM_CUSTOM_ATTRIBUTE_IS_ENUMERATED]
	DEFAULT ((0)) FOR [IS_ENUMERATED]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	ADD
	CONSTRAINT [DF_TB_ADM_CUSTOM_ATTRIBUTE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	ADD
	CONSTRAINT [DF_TB_ADM_CUSTOM_ATTRIBUTE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	ADD
	CONSTRAINT [DF_TB_ADM_CUSTOM_ATTRIBUTE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	CHECK CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	CHECK CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_SEC_USER_MODIFIED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_CLU_RESOURCE_CLUSTER_RESOURCE_ID]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	CHECK CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_CLU_RESOURCE_CLUSTER_RESOURCE_ID]

GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_SEC_FOLDER_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	CHECK CONSTRAINT [FK_TB_ADM_CUSTOM_ATTRIBUTE_TB_SEC_FOLDER_OWNER_ID]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_ADM_CUSTOM_ATTRIBUTE_OBJ_INDEX_OBJ_TYPE]
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] ([CLUSTER_RESOURCE_ID], [OBJ_INDEX], [OBJ_TYPE], [ATTRIBUTE_TYPE], [SOURCE_OBJ_NAME])
	WHERE (([ATTRIBUTE_TYPE] IN ('F', 'Z')))
	ON [ADMINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_ADM_CUSTOM_ATTRIBUTE_CLUSTER_RESOURCE_ID_ATTRIBUTE_TYPE]
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] ([CLUSTER_RESOURCE_ID], [ATTRIBUTE_TYPE], [OBJ_TYPE], [OBJ_INDEX])
	WHERE (([ATTRIBUTE_TYPE]='D' AND [OBJ_INDEX]>(-1)))
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CUSTOM_ATTRIBUTE_CREATED_BY_ID]
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] ([CREATED_BY_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CUSTOM_ATTRIBUTE_MODIFIED_BY_ID]
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] ([MODIFIED_BY_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CUSTOM_ATTRIBUTE_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] ([CLUSTER_RESOURCE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CUSTOM_ATTRIBUTE_OWNER_ID]
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] ([OWNER_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the custom attributes defined for the supported fact and dimensions', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'CUSTOM_ATTRIBUTE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_CLU_RESOURCE identifying the source equipment where the custom attribute metadata was imported from.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_SEC_FOLDER identifying the tenant to which the custom attribute associates to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the custom attribute is dimension based or fact based. Possible values are D: Dimension attribute, F: Fact Measure, Z: Fact Dimension.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'ATTRIBUTE_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the type of for the custom attribute. For Dimension based this will be the item type internal name, for member based this will be member type internal name and for fact based this will be the base table name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'OBJ_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is only relevant for fact based attribute types. Indicates the slot where the custom attribute is defined for the fact. A maximum of 10 slots are available per object type for fact based attributes. Defaults to -1 for other attribute types.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'OBJ_INDEX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'OBJ_NAME value from EGPL_CUSTOM_ATTRIBUTES.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'SOURCE_OBJ_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'INTERNAL_NAME value from EGPL_CUSTOM_ATTRIBUTES.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'SOURCE_ATT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the data type of the custom attribute as defined at source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'SOURCE_ATT_DATA_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Boolean flag indicating whether the custom attribute is defined as an enumeration at source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'IS_ENUMERATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CUSTOM_ATTRIBUTE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ADM_CUSTOM_ATTRIBUTE] SET (LOCK_ESCALATION = TABLE)
GO
