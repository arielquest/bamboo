SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL] (
		[DASHBOARD_LAYOUT_PANEL_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[DASHBOARD_LAYOUT_ID]           [uniqueidentifier] NOT NULL,
		[PANEL_TOP]                     [int] NOT NULL,
		[PANEL_LEFT]                    [int] NOT NULL,
		[PANEL_WIDTH]                   [int] NOT NULL,
		[PANEL_HEIGHT]                  [int] NOT NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_DASHBOARD_LAYOUT_PANEL]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_LAYOUT_PANEL_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_PANEL_DASHBOARD_LAYOUT_PANEL_ID]
	DEFAULT (newid()) FOR [DASHBOARD_LAYOUT_PANEL_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_PANEL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_PANEL_TB_REP_DASHBOARD_LAYOUT]
	FOREIGN KEY ([DASHBOARD_LAYOUT_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD_LAYOUT] ([DASHBOARD_LAYOUT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_PANEL_TB_REP_DASHBOARD_LAYOUT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_DASHBOARD_LAYOUT_PANEL_DASHBOARD_LAYOUT_ID]
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL] ([DASHBOARD_LAYOUT_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds information about the individual panels in any dashboard layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'DASHBOARD_LAYOUT_PANEL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_DASHBOARD_LAYOUT indicating the dashboard layout to which the panel is associated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'DASHBOARD_LAYOUT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the vertical position of the top left corner the panel in the dashboard layout. This value is in pixels.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'PANEL_TOP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the horizontal position of the top left corner the panel in the dashboard layout. This value is in pixels.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'PANEL_LEFT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the total width of the panel. This value is in pixels.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'PANEL_WIDTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the total height of the panel. This value is in pixels.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'PANEL_HEIGHT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_PANEL', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_PANEL] SET (LOCK_ESCALATION = TABLE)
GO
