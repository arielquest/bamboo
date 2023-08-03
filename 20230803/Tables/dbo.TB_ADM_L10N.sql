SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_L10N] (
		[L10N_URN]                [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[L10N_KEY_URN]            [int] NOT NULL,
		[CULTURE_URN]             [int] NOT NULL,
		[LOCALIZED_VALUE]         [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_L10N]
		PRIMARY KEY
		CLUSTERED
		([L10N_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_L10N]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_L10N]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_L10N]
	ADD
	CONSTRAINT [DF_TB_ADM_L10N_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_L10N]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_L10N_TB_ADM_L10N_KEY_URN]
	FOREIGN KEY ([L10N_KEY_URN]) REFERENCES [dbo].[TB_ADM_L10N_KEY] ([L10N_KEY_URN])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_L10N]
	CHECK CONSTRAINT [FK_TB_ADM_L10N_TB_ADM_L10N_KEY_URN]

GO
ALTER TABLE [dbo].[TB_ADM_L10N]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_L10N_TE_ADM_CULTURE_CULTURE_URN]
	FOREIGN KEY ([CULTURE_URN]) REFERENCES [dbo].[TE_ADM_CULTURE] ([CULTURE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_L10N]
	CHECK CONSTRAINT [FK_TB_ADM_L10N_TE_ADM_CULTURE_CULTURE_URN]

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_ADM_L10N_L10N_KEY_URN_CULTURE_URN]
	ON [dbo].[TB_ADM_L10N] ([L10N_KEY_URN], [CULTURE_URN])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_L10N_CULTURE_URN]
	ON [dbo].[TB_ADM_L10N] ([CULTURE_URN])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains localized data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'L10N_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_L10N_KEY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'L10N_KEY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_CULTURE', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'CULTURE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The value to display for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'LOCALIZED_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_L10N', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_L10N]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_L10N]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_L10N]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_L10N]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_L10N]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_ADM_L10N] SET (LOCK_ESCALATION = TABLE)
GO
