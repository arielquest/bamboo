SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_REGION] (
		[ITEM_URN]                 [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]             [int] NOT NULL,
		[FOLDER_ID]                [uniqueidentifier] NOT NULL,
		[OWNER_ID]                 [uniqueidentifier] NULL,
		[ITEM_SUBTYPE_ID]          [uniqueidentifier] NOT NULL,
		[NAME]                     [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[DESCRIPTION]              [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[EFFECTIVE_FROM]           [datetime] NOT NULL,
		[EFFECTIVE_TO]             [datetime] NOT NULL,
		[DELETED]                  [bit] NOT NULL,
		[HIDDEN]                   [bit] NOT NULL,
		[SYSTEM]                   [bit] NOT NULL,
		[LATEST]                   [bit] NOT NULL,
		[SKIP_LEVEL]               [int] NULL,
		[TIME_ZONE_URN]            [int] NOT NULL,
		[TENANT_BIZ_URN]           [int] NOT NULL,
		[HIERARCHY_PARENT_URN]     [int] NULL,
		[CREATED_BY_ID]            [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]           [uniqueidentifier] NOT NULL,
		[CREATION_DATE]            [datetime] NOT NULL,
		[MODIFIED_DATE]            [datetime] NOT NULL,
		[CHANGE_STAMP]             [int] NOT NULL,
		[XML_DATA]                 [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]          [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_REGION]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_ITEM_BIZ_URN]
	DEFAULT ((-2)) FOR [ITEM_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_ITEM_SUBTYPE_ID]
	DEFAULT ('{00000000-0000-0000-0000-000000000010}') FOR [ITEM_SUBTYPE_ID]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	ADD
	CONSTRAINT [DF_TB_DIM_REGION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_REGION] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_ITEM_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_HIERARCHY_PARENT_URN]
	FOREIGN KEY ([HIERARCHY_PARENT_URN]) REFERENCES [dbo].[TB_DIM_REGION] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_HIERARCHY_PARENT_URN]

GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_TENANT_BIZ_URN]
	FOREIGN KEY ([TENANT_BIZ_URN]) REFERENCES [dbo].[TB_DIM_TENANT] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_TENANT_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_TB_SEC_FOLDER_FOLDER_ID]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_TB_SEC_FOLDER_FOLDER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_TB_SEC_FOLDER_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_TB_SEC_FOLDER_OWNER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_TE_DIM_ITEM_SUBTYPE_ID]
	FOREIGN KEY ([ITEM_SUBTYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_SUBTYPE] ([ITEM_SUBTYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_TE_DIM_ITEM_SUBTYPE_ID]

GO
ALTER TABLE [dbo].[TB_DIM_REGION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_REGION_TE_ADM_TIME_ZONE]
	FOREIGN KEY ([TIME_ZONE_URN]) REFERENCES [dbo].[TE_ADM_TIME_ZONE] ([TIME_ZONE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_REGION]
	CHECK CONSTRAINT [FK_TB_DIM_REGION_TE_ADM_TIME_ZONE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_FOLDER_ID]
	ON [dbo].[TB_DIM_REGION] ([FOLDER_ID], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_OWNER_ID]
	ON [dbo].[TB_DIM_REGION] ([OWNER_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_BIZ]
	ON [dbo].[TB_DIM_REGION] ([ITEM_BIZ_URN], [LATEST])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_HIERARCHY_PARENT]
	ON [dbo].[TB_DIM_REGION] ([HIERARCHY_PARENT_URN], [FOLDER_ID], [EFFECTIVE_FROM], [EFFECTIVE_TO], [ITEM_BIZ_URN], [ITEM_SUBTYPE_ID], [LATEST])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_ITEM_SUBTYPE_ID]
	ON [dbo].[TB_DIM_REGION] ([ITEM_SUBTYPE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_TENANT_BIZ_URN]
	ON [dbo].[TB_DIM_REGION] ([TENANT_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_REGION_TIME_ZONE_URN]
	ON [dbo].[TB_DIM_REGION] ([TIME_ZONE_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores base information of all the Regions in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the place holder for the item in the security folder hierarchy. This is a foreign key to TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the tenant folder that is the root for the place holder folder as in FOLDER_ID. This is a foreign key to TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_SUBTYPE corresponding to the subtype for the item. This is a foreign key to TE_DIM_ITEM_SUBTYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'ITEM_SUBTYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used. This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'SKIP_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TE_ADM_TIME_ZONE, that corresponds to the wall clock time zone associated with the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'TIME_ZONE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from the same table indicating the hierarchical parent of the current item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'HIERARCHY_PARENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this item', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for custom attributes (client defined) for this item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_REGION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_REGION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_REGION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_REGION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_REGION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_REGION]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_DIM_REGION] SET (LOCK_ESCALATION = TABLE)
GO
