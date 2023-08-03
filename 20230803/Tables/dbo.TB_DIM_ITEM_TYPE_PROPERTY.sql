SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY] (
		[ITEM_TYPE_PROPERTY_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[OWNER_ID]                  [uniqueidentifier] NULL,
		[ITEM_TYPE_ID]              [uniqueidentifier] NOT NULL,
		[ITEM_SUBTYPE_ID]           [uniqueidentifier] NOT NULL,
		[CLUSTER_RESOURCE_ID]       [uniqueidentifier] NULL,
		[PROPERTY_KEY]              [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[STRING_VAL]                [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[BIGINT_VAL]                [bigint] NULL,
		[INT_VAL]                   [int] NULL,
		[FLOAT_VAL]                 [float] NULL,
		[TIME_VAL]                  [datetime] NULL,
		[BINARY_VAL]                [varbinary](1000) NULL,
		[GUID_VAL]                  [uniqueidentifier] NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [UK_TB_DIM_ITEM_TYPE_PROPERTY]
		UNIQUE
		NONCLUSTERED
		([OWNER_ID], [ITEM_TYPE_ID], [ITEM_SUBTYPE_ID], [CLUSTER_RESOURCE_ID], [PROPERTY_KEY])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_ITEM_TYPE_PROPERTY]
		PRIMARY KEY
		CLUSTERED
		([ITEM_TYPE_PROPERTY_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_TYPE_PROPERTY_ID]
	DEFAULT (newid()) FOR [ITEM_TYPE_PROPERTY_ID]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_SUBTYPE_ID]
	DEFAULT ('{00000000-0000-0000-0000-000000000010}') FOR [ITEM_SUBTYPE_ID]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_DIM_ITEM_TYPE_PROPERTY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	CHECK CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_OWNER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_TYPE_ID]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	CHECK CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_TYPE_ID]

GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_SUBTYPE_ID]
	FOREIGN KEY ([ITEM_SUBTYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_SUBTYPE] ([ITEM_SUBTYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	CHECK CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_SUBTYPE_ID]

GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_CLUSTER_RESOURCE_ID]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	CHECK CONSTRAINT [FK_TB_DIM_ITEM_TYPE_PROPERTY_CLUSTER_RESOURCE_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ITEM_TYPE_PROPERTY_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY] ([CLUSTER_RESOURCE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_SUBTYPE_ID]
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY] ([ITEM_SUBTYPE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ITEM_TYPE_PROPERTY_ITEM_TYPE_ID]
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY] ([ITEM_TYPE_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores any generic properties specific to any item type. These properties can be set for item types as a whole or for item types on specific remote sources.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'ITEM_TYPE_PROPERTY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the folder as in TB_SEC_FOLDER of type tenant for which the property is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_TYPE corresponding to the item type for which the property is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_SUBTYPE corresponding to the item sub-type for which the property is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'ITEM_SUBTYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE corresponding to the logical resource of the remote source on which the property is for the specified item type is valid.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the key for the property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'PROPERTY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'STRING_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a 64 bit integer value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'BIGINT_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a 32 bit integer value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'INT_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a float value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'FLOAT_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a datetime value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'TIME_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a binary value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'BINARY_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a GUID value for the property is specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'GUID_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_TYPE_PROPERTY', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_ITEM_TYPE_PROPERTY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_TYPE_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
