SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_RESOURCE_GROUP] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[PARENT_ID]               [uniqueidentifier] NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[DISPLAY_NAME]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[PATH]                    [nvarchar](2020) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_RESOURCE_GROUP]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	ADD
	CONSTRAINT [DF_TB_ADM_RESOURCE_GROUP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_RESOURCE_GROUP_TB_ADM_RESOURCE_GROUP_PARENT_ID]
	FOREIGN KEY ([PARENT_ID]) REFERENCES [dbo].[TB_ADM_RESOURCE_GROUP] ([ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP]
	CHECK CONSTRAINT [FK_TB_ADM_RESOURCE_GROUP_TB_ADM_RESOURCE_GROUP_PARENT_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a hierarchical table which allows for a deep list of groupings to be created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for this group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to this table defining the parent group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'PARENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Textual identifier for this group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Display name for this group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'DISPLAY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The path of the resource group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'PATH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_RESOURCE_GROUP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_RESOURCE_GROUP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_RESOURCE_GROUP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_RESOURCE_GROUP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_RESOURCE_GROUP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_RESOURCE_GROUP] SET (LOCK_ESCALATION = TABLE)
GO
