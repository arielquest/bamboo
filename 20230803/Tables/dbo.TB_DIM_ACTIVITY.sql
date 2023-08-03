SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_ACTIVITY] (
		[ITEM_URN]                      [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]                  [int] NOT NULL,
		[TENANT_BIZ_URN]                [int] NOT NULL,
		[CASE_BIZ_URN]                  [int] NOT NULL,
		[ACTIVITY_TYPE_BIZ_URN]         [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_BIZ_URN]     [int] NOT NULL,
		[CREATION_DATE]                 [datetime] NOT NULL,
		[MODIFIED_DATE]                 [datetime] NOT NULL,
		[EFFECTIVE_FROM]                [datetime] NOT NULL,
		[EFFECTIVE_TO]                  [datetime] NOT NULL,
		[DELETED]                       [bit] NOT NULL,
		[LATEST]                        [bit] NOT NULL,
		[NAME]                          [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[CUSTOM_XML_DATA]               [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_ACTIVITY]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_ITEM_BIZ_URN]
	DEFAULT ((-2)) FOR [ITEM_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_CASE_BIZ_URN]
	DEFAULT ((-1)) FOR [CASE_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_ACTIVITY_TYPE_BIZ_URN]
	DEFAULT ((-1)) FOR [ACTIVITY_TYPE_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_ACTIVITY_SUB_TYPE_BIZ_URN]
	DEFAULT ((-1)) FOR [ACTIVITY_SUB_TYPE_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	ADD
	CONSTRAINT [DF_TB_DIM_ACTIVITY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_TENANT_TENANT_BIZ_URN]
	FOREIGN KEY ([TENANT_BIZ_URN]) REFERENCES [dbo].[TB_DIM_TENANT] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	CHECK CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_TENANT_TENANT_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_CASE_CASE_BIZ_URN]
	FOREIGN KEY ([CASE_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CASE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	CHECK CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_CASE_CASE_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_CODE_ACTIVITY_TYPE_BIZ_URN]
	FOREIGN KEY ([ACTIVITY_TYPE_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	CHECK CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_CODE_ACTIVITY_TYPE_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_SUB_CODE_ACTIVITY_SUB_TYPE_BIZ_URN]
	FOREIGN KEY ([ACTIVITY_SUB_TYPE_BIZ_URN]) REFERENCES [dbo].[TB_DIM_SUB_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	CHECK CONSTRAINT [FK_TB_DIM_ACTIVITY_TB_DIM_SUB_CODE_ACTIVITY_SUB_TYPE_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ACTIVITY_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_ACTIVITY] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ACTIVITY]
	CHECK CONSTRAINT [FK_TB_DIM_ACTIVITY_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ACTIVITY_ACTIVITY_SUB_TYPE_BIZ_URN]
	ON [dbo].[TB_DIM_ACTIVITY] ([ACTIVITY_SUB_TYPE_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ACTIVITY_ACTIVITY_TYPE_BIZ_URN]
	ON [dbo].[TB_DIM_ACTIVITY] ([ACTIVITY_TYPE_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ACTIVITY_CASE_BIZ_URN]
	ON [dbo].[TB_DIM_ACTIVITY] ([CASE_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ACTIVITY_TENANT_BIZ_URN]
	ON [dbo].[TB_DIM_ACTIVITY] ([TENANT_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ACTIVITY_ITEM_BIZ_URN]
	ON [dbo].[TB_DIM_ACTIVITY] ([ITEM_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ACTIVITY_EFFECTIVE_FROM]
	ON [dbo].[TB_DIM_ACTIVITY] ([EFFECTIVE_FROM])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores base information of all the Activities in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated case in TB_DIM_CASE', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'CASE_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated activity type in TB_DIM_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'ACTIVITY_TYPE_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated activity sub type in TB_DIM_SUB_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'ACTIVITY_SUB_TYPE_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for custom attributes (client defined) for this item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ACTIVITY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portal_default_mediator_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_ACTIVITY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_ACTIVITY] SET (LOCK_ESCALATION = TABLE)
GO
