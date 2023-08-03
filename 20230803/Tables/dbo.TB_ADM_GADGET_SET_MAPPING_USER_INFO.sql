SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO] (
		[GADGET_SET_MAPPING_USER_INFO_ID]       [uniqueidentifier] NOT NULL,
		[GADGET_SET_MAPPING_ID]                 [uniqueidentifier] NOT NULL,
		[USER_ID]                               [uniqueidentifier] NULL,
		[GADGET_SET_MAPPING_USER_INFO_JSON]     [varchar](max) COLLATE Latin1_General_CI_AS NULL,
		[DELETED]                               [bit] NOT NULL,
		[HIDDEN]                                [bit] NOT NULL,
		[SYSTEM]                                [bit] NOT NULL,
		[LATEST]                                [bit] NOT NULL,
		[CREATED_BY_ID]                         [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                        [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                         [datetime] NOT NULL,
		[MODIFIED_DATE]                         [datetime] NOT NULL,
		[CHANGE_STAMP]                          [int] NOT NULL,
		[msrepl_tran_version]                   [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_GADGET_SET_MAPPING_USER_INFO_GADGET_SET_MAPPING_ID_USER_ID]
		UNIQUE
		NONCLUSTERED
		([GADGET_SET_MAPPING_ID], [USER_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_GADGET_SET_MAPPING_USER_INFO]
		PRIMARY KEY
		CLUSTERED
		([GADGET_SET_MAPPING_USER_INFO_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_ID]
	DEFAULT (newid()) FOR [GADGET_SET_MAPPING_USER_INFO_ID]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MAPPING_USER_INFO_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_SET_MAPPING_USER_INFO_TB_ADM_GADGET_SET_MAPPING_GADGET_SET_MAPPING_ID]
	FOREIGN KEY ([GADGET_SET_MAPPING_ID]) REFERENCES [dbo].[TB_ADM_GADGET_SET_MAPPING] ([GADGET_SET_MAPPING_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_SET_MAPPING_USER_INFO_TB_ADM_GADGET_SET_MAPPING_GADGET_SET_MAPPING_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_SET_MAPPING_USER_INFO_CREATED_BY_ID]
	ON [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO] ([CREATED_BY_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_SET_MAPPING_USER_INFO_MODIFIED_BY_ID]
	ON [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO] ([MODIFIED_BY_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains gadget set mapping to user mappings.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'GADGET_SET_MAPPING_USER_INFO_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key on TB_ADM_GADGET_SET_MAPPING.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'GADGET_SET_MAPPING_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key on TB_SEC_USER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'JSON definition of the gadget set mapping user info.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'GADGET_SET_MAPPING_USER_INFO_JSON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET_MAPPING_USER_INFO', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET_MAPPING_USER_INFO] SET (LOCK_ESCALATION = TABLE)
GO
