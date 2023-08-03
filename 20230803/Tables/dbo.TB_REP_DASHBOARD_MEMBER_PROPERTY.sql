SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY] (
		[DASHBOARD_MEMBER_PROPERTY_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[DASHBOARD_MEMBER_ID]              [uniqueidentifier] NOT NULL,
		[PROPERTY_KEY]                     [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[PROPERTY_VALUE]                   [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]              [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_DASHBOARD_MEMBER_PROPERTY]
		UNIQUE
		NONCLUSTERED
		([DASHBOARD_MEMBER_ID], [PROPERTY_KEY])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_DASHBOARD_MEMBER_PROPERTY]
		PRIMARY KEY
		CLUSTERED
		([DASHBOARD_MEMBER_PROPERTY_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_MEMBER_PROPERTY_DASHBOARD_MEMBER_PROPERTY_ID]
	DEFAULT (newid()) FOR [DASHBOARD_MEMBER_PROPERTY_ID]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_REP_DASHBOARD_MEMBER_PROPERTY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_PROPERTY_TB_REP_DASHBOARD_MEMBER]
	FOREIGN KEY ([DASHBOARD_MEMBER_ID]) REFERENCES [dbo].[TB_REP_DASHBOARD_MEMBER] ([DASHBOARD_MEMBER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	CHECK CONSTRAINT [FK_TB_REP_DASHBOARD_MEMBER_PROPERTY_TB_REP_DASHBOARD_MEMBER]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds various key value pairs (properties) associated with the respective dashboard memberships. These can be any custom properties that are required to should a report on a dashboard in a particular panel in the dashboard''s layout.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER_PROPERTY', 'COLUMN', N'DASHBOARD_MEMBER_PROPERTY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_DASHBOARD_MEMBER indicating the dashboard membership for which the property is being defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER_PROPERTY', 'COLUMN', N'DASHBOARD_MEMBER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the key for the dashboard member property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER_PROPERTY', 'COLUMN', N'PROPERTY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the value associated with the key for the dashboard member property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER_PROPERTY', 'COLUMN', N'PROPERTY_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_DASHBOARD_MEMBER_PROPERTY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_DASHBOARD_MEMBER_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
