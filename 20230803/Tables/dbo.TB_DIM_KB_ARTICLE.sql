SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_KB_ARTICLE] (
		[ITEM_URN]                                   [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]                               [int] NOT NULL,
		[FOLDER_ID]                                  [uniqueidentifier] NOT NULL,
		[OWNER_ID]                                   [uniqueidentifier] NULL,
		[ITEM_SUBTYPE_ID]                            [uniqueidentifier] NOT NULL,
		[NAME]                                       [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[DESCRIPTION]                                [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[ARTICLE_CREATION_CULTURE_URN]               [int] NOT NULL,
		[ARTICLE_COMMIT_STATE]                       [smallint] NOT NULL,
		[ARTICLE_PUBLISH_STATE]                      [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[ARTICLE_OWNER_AGENT_BIZ_URN]                [int] NOT NULL,
		[ARTICLE_CREATED_BY_AGENT_BIZ_URN]           [int] NOT NULL,
		[ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN]     [int] NOT NULL,
		[ARTICLE_CREATION_DATE_TIME]                 [datetime] NOT NULL,
		[ARTICLE_LAST_MODIFIED_DATE_TIME]            [datetime] NOT NULL,
		[ARTICLE_VERSION]                            [int] NOT NULL,
		[ARTICLE_AVAILABLE_FROM]                     [datetime] NOT NULL,
		[ARTICLE_EXPIRES_ON]                         [datetime] NOT NULL,
		[KB_FOLDER_BIZ_URN]                          [int] NOT NULL,
		[EFFECTIVE_FROM]                             [datetime] NOT NULL,
		[EFFECTIVE_TO]                               [datetime] NOT NULL,
		[DELETED]                                    [bit] NOT NULL,
		[HIDDEN]                                     [bit] NOT NULL,
		[SYSTEM]                                     [bit] NOT NULL,
		[LATEST]                                     [bit] NOT NULL,
		[SKIP_LEVEL]                                 [int] NULL,
		[TIME_ZONE_URN]                              [int] NOT NULL,
		[TENANT_BIZ_URN]                             [int] NOT NULL,
		[HIERARCHY_PARENT_URN]                       [int] NULL,
		[CREATED_BY_ID]                              [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                             [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                              [datetime] NOT NULL,
		[MODIFIED_DATE]                              [datetime] NOT NULL,
		[CHANGE_STAMP]                               [int] NOT NULL,
		[XML_DATA]                                   [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]                            [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]                        [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_KB_ARTICLE]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [CK_TB_DIM_KB_ARTICLE_ARTICLE_PUBLISH_STATE]
	CHECK
	([ARTICLE_PUBLISH_STATE]='^' OR [ARTICLE_PUBLISH_STATE]='A' OR [ARTICLE_PUBLISH_STATE]='D' OR [ARTICLE_PUBLISH_STATE]='T' OR [ARTICLE_PUBLISH_STATE]='P')
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
CHECK CONSTRAINT [CK_TB_DIM_KB_ARTICLE_ARTICLE_PUBLISH_STATE]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [CK_TB_DIM_KB_ARTICLE_ARTICLE_COMMIT_STATE]
	CHECK
	([ARTICLE_COMMIT_STATE]=(5) OR [ARTICLE_COMMIT_STATE]=(4) OR [ARTICLE_COMMIT_STATE]=(3) OR [ARTICLE_COMMIT_STATE]=(2) OR [ARTICLE_COMMIT_STATE]=(1) OR [ARTICLE_COMMIT_STATE]=(0))
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
CHECK CONSTRAINT [CK_TB_DIM_KB_ARTICLE_ARTICLE_COMMIT_STATE]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_CREATED_BY_AGENT_BIZ_URN]
	DEFAULT ((0)) FOR [ARTICLE_CREATED_BY_AGENT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN]
	DEFAULT ((-1)) FOR [ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_CREATION_DATE_TIME]
	DEFAULT ('1900-01-01') FOR [ARTICLE_CREATION_DATE_TIME]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_LAST_MODIFIED_DATE_TIME]
	DEFAULT ('1900-01-01') FOR [ARTICLE_LAST_MODIFIED_DATE_TIME]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_VERSION]
	DEFAULT ((-1)) FOR [ARTICLE_VERSION]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_AVAILABLE_FROM]
	DEFAULT ('1900-01-01') FOR [ARTICLE_AVAILABLE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_EXPIRES_ON]
	DEFAULT ('9999-12-31 23:59:59.997') FOR [ARTICLE_EXPIRES_ON]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_KB_FOLDER_BIZ_URN]
	DEFAULT ((-1)) FOR [KB_FOLDER_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ITEM_BIZ_URN]
	DEFAULT ((-2)) FOR [ITEM_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ITEM_SUBTYPE_ID]
	DEFAULT ('{00000000-0000-0000-0000-000000000010}') FOR [ITEM_SUBTYPE_ID]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_CREATION_CULTURE_URN]
	DEFAULT ((-1)) FOR [ARTICLE_CREATION_CULTURE_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_COMMIT_STATE]
	DEFAULT ((1)) FOR [ARTICLE_COMMIT_STATE]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_PUBLISH_STATE]
	DEFAULT ('^') FOR [ARTICLE_PUBLISH_STATE]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_ARTICLE_ARTICLE_OWNER_AGENT_BIZ_URN]
	DEFAULT ((-1)) FOR [ARTICLE_OWNER_AGENT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_KB_ARTICLE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_ITEM_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_HIERARCHY_PARENT_URN]
	FOREIGN KEY ([HIERARCHY_PARENT_URN]) REFERENCES [dbo].[TB_DIM_KB_ARTICLE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_HIERARCHY_PARENT_URN]

GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TENANT_BIZ_URN]
	FOREIGN KEY ([TENANT_BIZ_URN]) REFERENCES [dbo].[TB_DIM_TENANT] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TENANT_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TB_SEC_FOLDER_FOLDER_ID]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TB_SEC_FOLDER_FOLDER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TB_SEC_FOLDER_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TB_SEC_FOLDER_OWNER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TE_DIM_ITEM_SUBTYPE_ID]
	FOREIGN KEY ([ITEM_SUBTYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_SUBTYPE] ([ITEM_SUBTYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TE_DIM_ITEM_SUBTYPE_ID]

GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TE_ADM_TIME_ZONE]
	FOREIGN KEY ([TIME_ZONE_URN]) REFERENCES [dbo].[TE_ADM_TIME_ZONE] ([TIME_ZONE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE]
	CHECK CONSTRAINT [FK_TB_DIM_KB_ARTICLE_TE_ADM_TIME_ZONE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_FOLDER_ID]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([FOLDER_ID], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_OWNER_ID]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([OWNER_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_BIZ]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([ITEM_BIZ_URN], [LATEST])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_HIERARCHY_PARENT]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([HIERARCHY_PARENT_URN], [FOLDER_ID], [EFFECTIVE_FROM], [EFFECTIVE_TO], [ITEM_BIZ_URN], [ITEM_SUBTYPE_ID], [LATEST])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_ITEM_SUBTYPE_ID]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([ITEM_SUBTYPE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_TENANT_BIZ_URN]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([TENANT_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_ARTICLE_TIME_ZONE_URN]
	ON [dbo].[TB_DIM_KB_ARTICLE] ([TIME_ZONE_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores base information of all the KB Articles in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the place holder for the item in the security folder hierarchy. This is a foreign key to TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the tenant folder that is the root for the place holder folder as in FOLDER_ID. This is a foreign key to TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_SUBTYPE corresponding to the subtype for the item. This is a foreign key to TE_DIM_ITEM_SUBTYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ITEM_SUBTYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the foreign key to TE_ADM_CULTURE identifying the creation language of the article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_CREATION_CULTURE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The article commit state. 0: Suggested by agent, 1: Approved by author, 2: To be modified by agent, 3: Rejected by author, 4: Created by author, 5: Created in personal folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_COMMIT_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the publish state of the article, P: Published, T: Checked out, D: Checked in, A = Abandoned state, ^: Unknown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_PUBLISH_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the agent identifier representing the current author of the article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_OWNER_AGENT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the agent identifier representing the current author of the article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_CREATED_BY_AGENT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the agent identifier indicating who last modified the article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_LAST_MODIFIED_BY_AGENT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date and time when the article was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_CREATION_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date and time when the article was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_LAST_MODIFIED_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the current version of the article.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time in UTC when the current version of the article will be available in the Knowledge base.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_AVAILABLE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time in UTC when the current version of the article expires.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'ARTICLE_EXPIRES_ON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the KB folder identifier indicating the location of the article in the KB tree. This maps to the business key in TB_DIM_KB_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'KB_FOLDER_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used. This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'SKIP_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TE_ADM_TIME_ZONE, that corresponds to the wall clock time zone associated with the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'TIME_ZONE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from the same table indicating the hierarchical parent of the current item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'HIERARCHY_PARENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this item', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for custom attributes (client defined) for this item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_ARTICLE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_KB_ARTICLE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_KB_ARTICLE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_KB_ARTICLE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_KB_ARTICLE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_KB_ARTICLE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_DIM_KB_ARTICLE] SET (LOCK_ESCALATION = TABLE)
GO
