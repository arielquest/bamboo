SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CASE] (
		[ITEM_URN]                [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]            [int] NOT NULL,
		[TENANT_BIZ_URN]          [int] NOT NULL,
		[NAME]                    [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[CLOSED]                  [bit] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[EFFECTIVE_FROM]          [datetime] NOT NULL,
		[EFFECTIVE_TO]            [datetime] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[LATEST]                  [bit] NOT NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CASE]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_ITEM_BIZ_URN]
	DEFAULT ((-2)) FOR [ITEM_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_CLOSED]
	DEFAULT ((0)) FOR [CLOSED]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	ADD
	CONSTRAINT [DF_TB_DIM_CASE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CASE_TB_DIM_TENANT_TENANT_BIZ_URN]
	FOREIGN KEY ([TENANT_BIZ_URN]) REFERENCES [dbo].[TB_DIM_TENANT] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CASE]
	CHECK CONSTRAINT [FK_TB_DIM_CASE_TB_DIM_TENANT_TENANT_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_CASE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CASE_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CASE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CASE]
	CHECK CONSTRAINT [FK_TB_DIM_CASE_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CASE_TENANT_BIZ_URN]
	ON [dbo].[TB_DIM_CASE] ([TENANT_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CASE_ITEM_BIZ_URN]
	ON [dbo].[TB_DIM_CASE] ([ITEM_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CASE_EFFECTIVE_FROM]
	ON [dbo].[TB_DIM_CASE] ([EFFECTIVE_FROM])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores base information of all the Cases in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This boolean reprents whether or not the case has been closed on the equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'CLOSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for custom attributes (client defined) for this item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CASE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CASE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CASE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CASE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CASE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CASE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CASE]
	TO [portal_default_mediator_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CASE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_CASE] SET (LOCK_ESCALATION = TABLE)
GO
