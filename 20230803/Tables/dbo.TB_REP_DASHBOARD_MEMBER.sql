SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD_MEMBER] (
		[DASHBOARD_MEMBER_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[DASHBOARD_ID]                  [uniqueidentifier] NOT NULL,
		[REPORT_ID]                     [uniqueidentifier] NOT NULL,
		[DASHBOARD_LAYOUT_PANEL_ID]     [uniqueidentifier] NOT NULL,
		[USE_RDL_STYLE]                 [bit] NOT NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_DASHBOARD_MEMBER]
		UNIQUE
		NONCLUSTERED
		([DASHBOARD_ID], [REPORT_ID], [DASHBOARD_LAYOUT_PANEL_ID])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_DASHBOARD_MEMBER]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_MEMBER_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_MEMBER_DASHBOARD_MEMBER_ID]
	DEFAULT (newid()) FOR [DASHBOARD_MEMBER_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_MEMBER_USE_RDL_STYLE]
	DEFAULT ((0)) FOR [USE_RDL_STYLE]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_MEMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_TB_REP_DASHBOARD]
	FOREIGN KEY ([DASHBOARD_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD] ([DASHBOARD_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_TB_REP_DASHBOARD]

GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_TB_REP_REPORT]
	FOREIGN KEY ([REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_TB_REP_REPORT]

GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_TB_REP_DASHBOARD_LAYOUT_PANEL]
	FOREIGN KEY ([DASHBOARD_LAYOUT_PANEL_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL] ([DASHBOARD_LAYOUT_PANEL_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_TB_REP_DASHBOARD_LAYOUT_PANEL]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_MEMBER_DASHBOARD_LAYOUT_PANEL_ID]
	ON [dbo].[TB_REP_DASHBOARD_MEMBER] ([DASHBOARD_LAYOUT_PANEL_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_MEMBER_REPORT_ID]
	ON [dbo].[TB_REP_DASHBOARD_MEMBER] ([REPORT_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds information that links the various reports on a dashbord and the panels in which they appear in the dashboard''s layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', 'COLUMN', N'DASHBOARD_MEMBER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_DASHBOARD indicating the dashboard associated with the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', 'COLUMN', N'DASHBOARD_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_REPORT indicating the report that is linked to the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_DASHBOARD_LAYOUT_PANEL indicating the panel in the dashboard''s layout where the reports are placed. Note that the Dasboards layout and the Panels parent layout should be the same.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', 'COLUMN', N'DASHBOARD_LAYOUT_PANEL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether to use the RDL style for dashboard or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', 'COLUMN', N'USE_RDL_STYLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD_MEMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD_MEMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD_MEMBER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER] SET (LOCK_ESCALATION = TABLE)
GO
