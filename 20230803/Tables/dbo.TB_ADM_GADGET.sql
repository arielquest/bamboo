SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_GADGET] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[RESOURCE_GROUP_ID]       [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_NAME]            [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[IMAGE]                   [varbinary](1) NULL,
		[PRIORITY]                [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_GADGET]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [CK_TB_ADM_GADGET_NAME]
	CHECK
	(NOT [NAME] like '%[<>:"/\|?*]%' AND rtrim(ltrim([NAME]))<>'')
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
CHECK CONSTRAINT [CK_TB_ADM_GADGET_NAME]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_PRIORITY]
	DEFAULT ((0)) FOR [PRIORITY]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_TB_SEC_USER_CREATED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_TB_SEC_USER_MODIFIED_BY_ID]

GO
ALTER TABLE [dbo].[TB_ADM_GADGET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_TB_ADM_RESOURCE_GROUP_RESOURCE_GROUP_ID]
	FOREIGN KEY ([RESOURCE_GROUP_ID]) REFERENCES [dbo].[TB_ADM_RESOURCE_GROUP] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_TB_ADM_RESOURCE_GROUP_RESOURCE_GROUP_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_CREATED_BY_ID]
	ON [dbo].[TB_ADM_GADGET] ([CREATED_BY_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_MODIFIED_BY_ID]
	ON [dbo].[TB_ADM_GADGET] ([MODIFIED_BY_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_GADGET_RESOURCE_GROUP_ID]
	ON [dbo].[TB_ADM_GADGET] ([RESOURCE_GROUP_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains gadget definitions', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_RESOURCE_GROUP defining the resource group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'RESOURCE_GROUP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Display name for this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'DISPLAY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Description for this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Screenshot image for the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'IMAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UI priority ordering position of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'PRIORITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_GADGET]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_GADGET]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_GADGET]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_GADGET]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET] SET (LOCK_ESCALATION = TABLE)
GO
