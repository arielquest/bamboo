SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_ANALYZER_VIEW] (
		[ANALYZER_VIEW_URN]       [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ANALYZER_MODEL_URN]      [int] NOT NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAYOUT_STATE]            [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[COLLAPSE_STATE]          [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[DELETED]                 [bit] NOT NULL,
		[DEFAULT_VIEW]            [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_ANALYZER_VIEW]
		PRIMARY KEY
		CLUSTERED
		([ANALYZER_VIEW_URN])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_FOLDER_ID]
	DEFAULT ('00000001-0000-0000-0000-000000000005') FOR [FOLDER_ID]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_DEFAULT_VIEW]
	DEFAULT ((0)) FOR [DEFAULT_VIEW]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_VIEW_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_ANALYZER_VIEW_TB_REP_ANALYZER_MODEL]
	FOREIGN KEY ([ANALYZER_MODEL_URN]) REFERENCES [dbo].[TB_REP_ANALYZER_MODEL] ([ANALYZER_MODEL_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	CHECK CONSTRAINT [FK_TB_REP_ANALYZER_VIEW_TB_REP_ANALYZER_MODEL]

GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_ANALYZER_VIEW_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW]
	CHECK CONSTRAINT [FK_TB_REP_ANALYZER_VIEW_TB_SEC_FOLDER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_ANALYZER_VIEW_ANALYZER_MODEL_URN]
	ON [dbo].[TB_REP_ANALYZER_VIEW] ([ANALYZER_MODEL_URN])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_ANALYZER_VIEW_FOLDER_ID]
	ON [dbo].[TB_REP_ANALYZER_VIEW] ([FOLDER_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains saved views of the analyzer models which specify ', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifie. Referenced by TB_REP_ANALYZER_VIEW', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'ANALYZER_VIEW_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This foreign key references the model in TB_REP_ANALYZER_MODEL upon which this view is based.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'ANALYZER_MODEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the views location in the security folder hierarchy. This is a foreign key to TB_SEC_FOLDER', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the Analyzer View.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A description of the Analyzer View.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A string representation of the saved layout state. This specifies which measures and dimensions were on which axis, in which order and the dimension filters applied.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'LAYOUT_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A string representation of the saved collapse state. ie. drill down information.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'COLLAPSE_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the Analyzer View has been deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the Analyzer View is the default view of its model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'DEFAULT_VIEW'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the Analyzer View is owned by the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_USER indicating the user who created the analyzer view.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_USER indicating the user who last modified the analyzer view.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the analyzer view was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the analyzer view was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_VIEW', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_ANALYZER_VIEW]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_ANALYZER_VIEW]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_ANALYZER_VIEW]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_ANALYZER_VIEW]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_VIEW] SET (LOCK_ESCALATION = TABLE)
GO
