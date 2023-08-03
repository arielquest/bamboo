SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT] (
		[DASHBOARD_LAYOUT_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[DASHBOARD_LAYOUT_STYLE_ID]     [uniqueidentifier] NOT NULL,
		[FOLDER_ID]                     [uniqueidentifier] NOT NULL,
		[NAME]                          [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                   [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[LAYOUT_WIDTH]                  [int] NOT NULL,
		[LAYOUT_HEIGHT]                 [int] NOT NULL,
		[CREATED_DATE]                  [datetime] NOT NULL,
		[CREATED_BY_ID]                 [uniqueidentifier] NOT NULL,
		[CREATED_BY_NAME]               [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAST_MODIFIED_DATE]            [datetime] NULL,
		[LAST_MODIFIED_BY_ID]           [uniqueidentifier] NULL,
		[LAST_MODIFIED_BY_NAME]         [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_DASHBOARD_LAYOUT_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_DASHBOARD_LAYOUT]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_LAYOUT_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_DASHBOARD_LAYOUT_ID]
	DEFAULT (newid()) FOR [DASHBOARD_LAYOUT_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_TB_REP_DASHBOARD_LAYOUT_STYLE]
	FOREIGN KEY ([DASHBOARD_LAYOUT_STYLE_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE] ([DASHBOARD_LAYOUT_STYLE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_TB_REP_DASHBOARD_LAYOUT_STYLE]

GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_TB_SEC_FOLDER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_LAYOUT_DASHBOARD_LAYOUT_STYLE_ID]
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT] ([DASHBOARD_LAYOUT_STYLE_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_LAYOUT_FOLDER_ID]
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT] ([FOLDER_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the basic infomation for a dashboard layout. Dashboard layouts are the base for creating dashboard. These represent the basic look and feel of a dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'DASHBOARD_LAYOUT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_DASHBOARD_LAYOUT_STYLE representing the dashboard layout style associated with the dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'DASHBOARD_LAYOUT_STYLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER representing the location of the dashboard layout in the security tree.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the dashboard layout. This should be unique.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an optional brief description for the dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a value indicating the total width of the dashboard layout. This value is in pixels.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'LAYOUT_WIDTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a value indicating the total heioght of the dashboard layout. This value is in pixels.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'LAYOUT_HEIGHT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the dashboard layout was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'CREATED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER indicating the user who created the dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name of the user who created the dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'CREATED_BY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the dashboard layout was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'LAST_MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER indicating the most recent user who modified the dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'LAST_MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name of the most recent user who modified the dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'LAST_MODIFIED_BY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT] SET (LOCK_ESCALATION = TABLE)
GO
