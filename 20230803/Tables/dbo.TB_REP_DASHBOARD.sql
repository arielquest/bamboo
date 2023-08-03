SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD] (
		[DASHBOARD_ID]              [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[DASHBOARD_LAYOUT_ID]       [uniqueidentifier] NOT NULL,
		[FOLDER_ID]                 [uniqueidentifier] NOT NULL,
		[NAME]                      [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]               [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[CREATED_DATE]              [datetime] NOT NULL,
		[CREATED_BY_ID]             [uniqueidentifier] NOT NULL,
		[CREATED_BY_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAST_MODIFIED_DATE]        [datetime] NULL,
		[LAST_MODIFIED_BY_ID]       [uniqueidentifier] NULL,
		[LAST_MODIFIED_BY_NAME]     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ENABLED]                   [bit] NOT NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_DASHBOARD_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_DASHBOARD]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_DASHBOARD_ID]
	DEFAULT (newid()) FOR [DASHBOARD_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_TB_REP_DASHBOARD_LAYOUT]
	FOREIGN KEY ([DASHBOARD_LAYOUT_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD_LAYOUT] ([DASHBOARD_LAYOUT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_TB_REP_DASHBOARD_LAYOUT]

GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_TB_SEC_FOLDER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_DASHBOARD_LAYOUT_ID]
	ON [dbo].[TB_REP_DASHBOARD] ([DASHBOARD_LAYOUT_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_FOLDER_ID]
	ON [dbo].[TB_REP_DASHBOARD] ([FOLDER_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the basic infomation for a dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'DASHBOARD_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as TB_REP_DASHBOARD_LAYOUT indicating the layout used by the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'DASHBOARD_LAYOUT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER representing the location of the dashboard in the security tree.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the dashboard. This should be unique.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an optional brief description for the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the dashboard was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'CREATED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER indicating the user who created the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name of the user who created the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'CREATED_BY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the dashboard was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'LAST_MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER indicating the most recent user who modified the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'LAST_MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name of the most recent user who modified the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'LAST_MODIFIED_BY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is boolean flag indicating whether the dashboard is enabled or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD] SET (LOCK_ESCALATION = TABLE)
GO
