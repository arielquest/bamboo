SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY] (
		[DASHBOARD_LAYOUT_STYLE_PROPERTY_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[DASHBOARD_LAYOUT_STYLE_ID]              [uniqueidentifier] NOT NULL,
		[PROPERTY_KEY]                           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PROPERTY_VALUE]                         [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]                    [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
		UNIQUE
		NONCLUSTERED
		([DASHBOARD_LAYOUT_STYLE_ID], [PROPERTY_KEY])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_LAYOUT_STYLE_PROPERTY_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY_DASHBOARD_LAYOUT_STYLE_PROPERTY_ID]
	DEFAULT (newid()) FOR [DASHBOARD_LAYOUT_STYLE_PROPERTY_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY_DASHBOARD_LAYOUT_STYLE_ID]
	FOREIGN KEY ([DASHBOARD_LAYOUT_STYLE_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE] ([DASHBOARD_LAYOUT_STYLE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY_DASHBOARD_LAYOUT_STYLE_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds various key value pairs (properties) associated with the respective dashboard layout styles.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY', 'COLUMN', N'DASHBOARD_LAYOUT_STYLE_PROPERTY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_DASHBOARD_LAYOUT_STYLE representing the dashboard layout style associated with the property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY', 'COLUMN', N'DASHBOARD_LAYOUT_STYLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the key for the dashboard layout style property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY', 'COLUMN', N'PROPERTY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the value associated with the key for the dashboard layout style property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY', 'COLUMN', N'PROPERTY_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_LAYOUT_STYLE_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
