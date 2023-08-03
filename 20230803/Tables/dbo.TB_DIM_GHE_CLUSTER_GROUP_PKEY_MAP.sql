SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] (
		[PKEY_MAP_URN]            [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PKEY_MAP_BIZ_URN]        [int] NULL,
		[ITEM_BIZ_URN]            [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]     [uniqueidentifier] NOT NULL,
		[STATUS]                  [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[PKEY1]                   [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[PKEY2]                   [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[SOURCE_CHANGE_STAMP]     [int] NULL,
		[EFFECTIVE_FROM]          [datetime] NOT NULL,
		[EFFECTIVE_TO]            [datetime] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[PURGED]                  [bit] NOT NULL,
		[LATEST]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[PKEY_1_HASH]             AS (CONVERT([varbinary](64),hashbytes('SHA2_512',[PKEY1]))) PERSISTED,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
		PRIMARY KEY
		CLUSTERED
		([PKEY_MAP_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_DELETE_CONSISTENCEY]
	CHECK
	(case when [STATUS]='D' AND [EFFECTIVE_TO]>getutcdate() then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_DELETE_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_PURGE_CONSISTENCEY]
	CHECK
	(case when [STATUS]<>'D' AND [PURGED]=(1) then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_PURGE_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_LATEST_CONSISTENCEY]
	CHECK
	(case when [LATEST]=(0) AND ([STATUS]<>'D' OR [PURGED]=(0) OR [EFFECTIVE_TO]>getutcdate()) then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_LATEST_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_STATUS]
	DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_PURGED]
	DEFAULT ((0)) FOR [PURGED]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_PKEY_MAP_BIZ_URN]
	FOREIGN KEY ([PKEY_MAP_BIZ_URN]) REFERENCES [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] ([PKEY_MAP_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_PKEY_MAP_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_GHE_CLUSTER_GROUP] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_ITEM_CLUSTER_RESOURCE]
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] ([ITEM_BIZ_URN], [LATEST], [CLUSTER_RESOURCE_ID], [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	INCLUDE ([PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_CLUSTER_RESOURCE_PKEY]
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] ([CLUSTER_RESOURCE_ID], [PKEY_1_HASH], [PKEY2])
	INCLUDE ([PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_CLUSTER_RESOURCE_STATUS]
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] ([CLUSTER_RESOURCE_ID], [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	INCLUDE ([ITEM_BIZ_URN], [LATEST], [PURGED])
	ON [DIMINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_PKEY1_PKEY2_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] ([PKEY_1_HASH], [PKEY2], [CLUSTER_RESOURCE_ID])
	WHERE (([PKEY1] IS NOT NULL AND [PURGED]=(0)))
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the mappings for Ghe Cluster Groups in TB_DIM_GHE_CLUSTER_GROUP corresponding to the items on various sources for the application. This sources can be CICMs, NAMs, WMS, IVRs etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'PKEY_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'PKEY_MAP_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_GHE_CLUSTER_GROUP corresponding to the item for which the mapping is defined. This is unique for a given source specified by the column CLUSTER_RESOURCE_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the a charactor flag indicating the status of the item on the specified equipment. Possible values are; R: Ready, S: Pending Active, P: Pending Delete, D: Delete confirmed, E: Error, N: Not applicable.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier of the item on the specified source. This has to be unique on the specified source. For example, this can be a primary key value on any source database table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'PKEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the secondary identifier of the item on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'PKEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If specified this is the change stamp of the item on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'SOURCE_CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item becomes active on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item ceases to exist on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the item has been purged (ie. row physically removed) from the equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'PURGED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 pkey map change this value is set to 0 for parent pkey maps.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who created the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who last modified the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the record was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the change stamp for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Custom XML data block', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Used by targetted index for cluster duplicate check', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'PKEY_1_HASH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP] SET (LOCK_ESCALATION = TABLE)
GO
