SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE] (
		[DASHBOARD_LAYOUT_STYLE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                          [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                   [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_DASHBOARD_LAYOUT_STYLE_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_DASHBOARD_LAYOUT_STYLE]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_LAYOUT_STYLE_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_STYLE_DASHBOARD_LAYOUT_STYLE_ID]
	DEFAULT (newid()) FOR [DASHBOARD_LAYOUT_STYLE_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_STYLE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the basic information about the various dashboard layout styles.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE', 'COLUMN', N'DASHBOARD_LAYOUT_STYLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the dashboard layout style.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief descriptin for the dashboard layout style.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE] SET (LOCK_ESCALATION = TABLE)
GO
