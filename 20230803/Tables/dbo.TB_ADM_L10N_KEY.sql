SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_L10N_KEY] (
		[L10N_KEY_URN]            [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[L10N_KEY]                [varchar](900) COLLATE Latin1_General_CI_AS NOT NULL,
		[DEFAULT_VALUE]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[LATEST]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_L10N_KEY]
		PRIMARY KEY
		CLUSTERED
		([L10N_KEY_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_KEY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_ADM_L10N_KEY]
	ON [dbo].[TB_ADM_L10N_KEY] ([L10N_KEY])
	WHERE (([DELETED]=(0)))
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains a link to localized values.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'L10N_KEY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Alternate string identifier for the record.  Unique where record not deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'L10N_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The default value to use for the localization where none is found.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'DEFAULT_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N_KEY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_L10N_KEY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_L10N_KEY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_L10N_KEY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_L10N_KEY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_L10N_KEY]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_ADM_L10N_KEY] SET (LOCK_ESCALATION = TABLE)
GO
