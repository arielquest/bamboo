SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_GADGET_SET] (
		[GADGET_SET_ID]           [uniqueidentifier] NOT NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[NAME]                    [varchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[LATEST]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[GADGET_SET_JSON]         [varchar](max) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_GADGET_SET_ID]
		PRIMARY KEY
		CLUSTERED
		([GADGET_SET_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_GADGET_SET_ID]
	DEFAULT (newid()) FOR [GADGET_SET_ID]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_SET_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_SET_TB_SEC_FOLDER_FOLDER_ID]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET_SET]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_SET_TB_SEC_FOLDER_FOLDER_ID]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_ADM_GADGET_SET_FOLDER_ID_NAME]
	ON [dbo].[TB_ADM_GADGET_SET] ([FOLDER_ID], [NAME])
	WHERE (([DELETED]=(0)))
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_SET_CREATED_BY_ID]
	ON [dbo].[TB_ADM_GADGET_SET] ([CREATED_BY_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_SET_FOLDER_ID]
	ON [dbo].[TB_ADM_GADGET_SET] ([FOLDER_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_SET_MODIFIED_BY_ID]
	ON [dbo].[TB_ADM_GADGET_SET] ([MODIFIED_BY_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains gadget set definitions', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'GADGET_SET_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Location of the gadget set, foreign key on TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the gadget set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'JSON data for the gadget set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'GADGET_SET_JSON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_SET', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_GADGET_SET]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_GADGET_SET]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_GADGET_SET]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_GADGET_SET]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_SET] SET (LOCK_ESCALATION = TABLE)
GO
