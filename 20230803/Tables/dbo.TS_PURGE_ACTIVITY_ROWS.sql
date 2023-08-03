SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TS_PURGE_ACTIVITY_ROWS] (
		[URN]     [int] NOT NULL
) ON [STGGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to help determine activities that are no being referenced in any fact data.', 'SCHEMA', N'dbo', 'TABLE', N'TS_PURGE_ACTIVITY_ROWS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an URN as in the Activity dimension.', 'SCHEMA', N'dbo', 'TABLE', N'TS_PURGE_ACTIVITY_ROWS', 'COLUMN', N'URN'
GO
GRANT ALTER
	ON [dbo].[TS_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TS_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TS_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TS_PURGE_ACTIVITY_ROWS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_PURGE_ACTIVITY_ROWS] SET (LOCK_ESCALATION = TABLE)
GO
